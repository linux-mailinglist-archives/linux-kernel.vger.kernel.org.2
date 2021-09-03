Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81CC3FFD17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348799AbhICJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348790AbhICJ3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:29:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 018E961057;
        Fri,  3 Sep 2021 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630661319;
        bh=6+JvWjTVgOTDBwrVSObaMWQo2XAQfFNK0dOeMLvKaug=;
        h=From:To:Cc:Subject:Date:From;
        b=Uy3m96MzrGtGwsY89cmOBo2OXjlVL2+xbDQSh0VqEPEyZ9d2ou3zHU4R86iJvOi5m
         Z7BZIctebFT9xzLGcHD0CSjxarAB2veWyspZ3QiHGjpDRTFHfAyy3zaxIZA5eS3cZe
         L3jfESag/MmlrLCZEjwdIcSygpjkS5zqd8BYNdWdELzLRlLw3xi3p8T8+cTWyK0BtE
         EZuXa8ZkHkaLMS1R/L6BHloELPLs7VrkMFn77U2yrS8Tv5INobp/eJOc0MmiQkk41n
         XEDH0caFzJqqbBxKlzsM2VK4WurLc/mNGR0Pl/s2lQ5ZOYKtKnUayELctF708CTOEu
         d2BMLd6Ria0pQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mM5Uy-000zwP-T7; Fri, 03 Sep 2021 11:28:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Make USB ports to work on HiKey960/970
Date:   Fri,  3 Sep 2021 11:28:31 +0200
Message-Id: <cover.1630659949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

It follows the patchset adding a DT schema needed to power on and to
use the integrated USB hub found on HiKey 960 and Hikey 970 boards.

Besides each board use a different chip for the hub,  on both they're
controlled the same way. Such boards come with an integrated 4-port
USB hub on it, set on what it seems to be a non-standard way: on both 
implementations, the USB type-C port is used to detect the USB role.

When in host mode, the 3.3V power supply (VDD33 pins) for the hub
are disabled. That disables the USB I/O on type-A ports.

When USB type-C is on device mode, the OTG is switched via a GPIO pin
to device mode, and the hub is powered on.

A Type-C power supply line is also controlled depending on the role.

-

The entire series  which contains the remaining patches to support
PCI and USB on HiKey970, and USB on HiKey960 is at:

    https://github.com/mchehab/linux/commits/linux-master

The patches needed by the USB on HiKey970 were already merged
upstream. So, the above branch applies on the top of Linux master
branch.

Tested on HiKey 960:

	$ lsusb
	Bus 002 Device 002: ID 0424:5734 Standard Microsystems Corp. 
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 004: ID 0424:2740 Standard Microsystems Corp. 
	Bus 001 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
	Bus 001 Device 002: ID 0424:2734 Standard Microsystems Corp. 
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Tested on HiKey 970:
	
	$ lsusb
	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
	Bus 001 Device 002: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

v4:
  - Improved description at the DT schema;
  - Use just one compatible, as there's no difference between
    HiKey 960 and 970 with regards to how the hub should be
    controlled;
  - parse usb-role-switch property at the driver;
  - make the properties that depends on usb-role-switch optional.

v3:
  - The examples at the dt-bindings were updated to reflect
    the actual DTS content and won't produce any warnings;
  - Added John Stultz SoB to Hikey960 DTS patch;
  - Added a patch for the mux hub driver for it to work with
    the newer schema;

John Stultz (1):
  arm64: dts: hisilicon: Add usb mux hub for hikey960

Mauro Carvalho Chehab (2):
  misc: hisi_hikey_usb: change the DT schema
  arm64: dts: hisilicon: Add usb mux hub for hikey970

Yu Chen (1):
  dt-bindings: misc: add schema for USB hub on Kirin devices

 .../bindings/misc/hisilicon,hikey-usb.yaml    |  87 +++++++++++++
 .../boot/dts/hisilicon/hi3660-hikey960.dts    |  35 +++++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  23 ++++
 drivers/misc/hisi_hikey_usb.c                 | 119 +++++++++---------
 4 files changed, 206 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

-- 
2.31.1


