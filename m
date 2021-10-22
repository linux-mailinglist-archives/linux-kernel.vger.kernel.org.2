Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7940436FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhJVCDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhJVCDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:03:01 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DA5C061764;
        Thu, 21 Oct 2021 19:00:44 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id A2C083F5;
        Thu, 21 Oct 2021 19:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1634868043;
        bh=XDRI9VXF3XUMlk9dBAFOebvTKFOvX1a0hcD6J+beiGI=;
        h=From:To:Cc:Subject:Date:From;
        b=k4bnVBQ2vAkqjjfhOAVZFHNciPr+g7dZimlgQ5PfQyVTDPYhZfE6nK2zxM0pxcdS7
         v7n1RsSbK3OLYgC03sCYSDXOy9BE/bAlRSPE2DA+aJYWKmMpYZlEXRwHVoy0TbQkIx
         ecMEQttwPGrHb8XG6id1cLWBi291qhq79pb9buRg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH 0/5] driver core, of: support for reserved devices
Date:   Thu, 21 Oct 2021 19:00:27 -0700
Message-Id: <20211022020032.26980-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This series is another incarnation of a couple other patchsets I've
posted recently [0, 1], but again different enough in overall
structure that I'm not sure it's exactly a v2 (or v3).

As compared to [1], it abandons the writable binary sysfs files and at
Frank's suggestion returns to an approach more akin to [0], though
without any driver-specific (aspeed-smc) changes, which I figure might
as well be done later in a separate series once appropriate
infrastructure is in place.

The basic idea is to implement support for a status property value
that's documented in the DT spec [2], but thus far not used at all in
the kernel (or anywhere else I'm aware of): "reserved".  According to
the spec (section 2.3.4, Table 2.4), this status:

  Indicates that the device is operational, but should not be used.
  Typically this is used for devices that are controlled by another
  software component, such as platform firmware.

With these changes, devices marked as reserved are (at least in some
cases, more on this later) instantiated, but will not have drivers
bound to them unless and until userspace explicitly requests it by
writing the device's name to the driver's sysfs 'bind' file.  This
enables appropriate handling of hardware arrangements that can arise
in contexts like OpenBMC, where a device may be shared with another
external controller not under the kernel's control (for example, the
flash chip storing the host CPU's firmware, shared by the BMC and the
host CPU and exclusively under the control of the latter by default).
Such a device can be marked as reserved so that the kernel refrains
from touching it until appropriate preparatory steps have been taken
(e.g. BMC userspace coordinating with the host CPU to arbitrate which
processor has control of the firmware flash).

Patches 1-3 provide some basic plumbing for checking the "reserved"
status of a device, patch 4 is the main driver-core change, and patch
5 tweaks the OF platform code to not skip reserved devices so that
they can actually be instantiated.

One shortcoming of this series is that it doesn't automatically apply
universally across all busses and drivers -- patch 5 enables support
for platform devices, but similar changes would be required for
support in other busses (e.g. in of_register_spi_devices(),
of_i2c_register_devices(), etc.) and drivers that instantiate DT
devices.  Since at present a "reserved" status is treated as
equivalent to "disabled" and this series preserves that status quo in
those cases I'd hope this wouldn't be considered a deal-breaker, but
a thing to be aware of at least.

Greg: I know on [1] you had commented nack-ing the addition of boolean
function parameters; patch 4 adds a flags mask instead in an analogous
situation.  I'm not certain how much of an improvement you'd consider
that (hopefully at least slightly better, in that the arguments passed
at the call site are more self-explanatory); if that's still
unsatisfactory I'd welcome any suggested alternatives.


Thanks,
Zev

[0] https://lore.kernel.org/openbmc/20210929115409.21254-1-zev@bewilderbeest.net/
[1] https://lore.kernel.org/openbmc/20211007000954.30621-1-zev@bewilderbeest.net/
[2] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf

Zev Weiss (5):
  of: base: add function to check for status = "reserved"
  device property: add fwnode_device_is_reserved()
  of: property: add support for fwnode_device_is_reserved()
  driver core: inhibit automatic driver binding on reserved devices
  of: platform: instantiate reserved devices

 drivers/base/bus.c            |  2 +-
 drivers/base/dd.c             | 13 ++++++----
 drivers/base/property.c       | 16 +++++++++++++
 drivers/dma/idxd/compat.c     |  3 +--
 drivers/of/base.c             | 56 ++++++++++++++++++++++++++++++++++++-------
 drivers/of/platform.c         |  2 +-
 drivers/of/property.c         |  6 +++++
 drivers/vfio/mdev/mdev_core.c |  2 +-
 include/linux/device.h        | 14 ++++++++++-
 include/linux/fwnode.h        |  2 ++
 include/linux/of.h            |  6 +++++
 include/linux/property.h      |  1 +
 12 files changed, 104 insertions(+), 19 deletions(-)

-- 
2.33.1

