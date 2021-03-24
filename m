Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32CD3472DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhCXHmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhCXHlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:41:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B2DA61A04;
        Wed, 24 Mar 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616571678;
        bh=qhDVoVq4TNxH6Zz0USkEPKYVSZrzDElMCQ3bD3839kE=;
        h=From:To:Cc:Subject:Date:From;
        b=tRZlGKrubAzByV4wSoRMIMErHjoGZQ1FLuyPs5zrtIPxNz3liFI6ncnv9tZKx3ag9
         z0WwxjX1Ds1ciIuGjktOMt3wc/kWwUOvlbfDyyZgHrLCtwFafe/5jJ91gBxxAI5dHb
         fDN+9xECi7WafA63QoCXrddkOh8JNtW4vEK7uhO+HwqdgdIdO/xAcGKoVIumcofRg+
         4uCqKdwptw66ZRq3B/s/dewFQnjga1olprBW/Xa2FIt8clafkdRWYUz1DIVgH9n4vc
         62U5wYIR+I4+2Jtwzs1UQCNJ0mY55YSMD0V1ytWeTPio/RpeN4n8s1h3J/kmLuEkUa
         lJ3CGGjH+YFHw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lOy8h-000umT-Lu; Wed, 24 Mar 2021 08:41:15 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 0/7] Add support for the other MaxLinear/Exar UARTs
Date:   Wed, 24 Mar 2021 08:41:04 +0100
Message-Id: <cover.1616571453.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of the xr_serial driver handles one one of the several
MaxLinear/Exar UARTs and UART bridges. There are currently 12 such
models. Only one is currently supported.

They were tested only on  XR21B1410 and  XR21B1424 models,
although I'm pretty much confident that the other models will also
work, as they're very close to either one of those.

Patch 1 is just a cleanup for the registers namespace. It removes
the model number from registers that are used on multiple versions
of the chipset.

Patch 2 adds a table to be used to map the register for each specific
variant of this chipset;

Patch 3 adds support for XR21B1412 and XR21B1414. The only
difference on those devices is that they support multiple UART ports.

Patch 4 adds support for  XR21B142X, which uses a mix of data and
control interfaces to setup the line discipline.

Patch 5 adds support for  XR21B1410 variant. This one is identical
to  XR21B1411, except that it uses a different register set;

Patch 6 adds support for XR2280X devices:
	https://www.maxlinear.com/product/interface/bridges/usb-ethernet-bridges/xr22800

Such devices are compound devices that are similar to the USB
UARTs from programming PoV. The only difference is the register
set.

Patch 7 updates the CDC ignore list.

After this series, all MaxLinear USB UARTs described at:
	https://www.maxlinear.com/products/interface/uarts/usb-uarts

Should be supported, except for XR21B1421. This one have just a control
interface, and uses standard HID protocol. No idea how to support it. Also,
I don't have such device to test ;-)

In order to write this patch series, I used the datasheets, plus the Linux
driver source code, available at MaxLinear, and a previous port made by
Patong Yang:

   https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop

---
v2:
  - rebased on the top of next-20210323;
  - free port_priv before calling usb_set_serial_data.

Mauro Carvalho Chehab (7):
  USB: serial: xr: simplify its namespace
  USB: serial: xr: use a table for device-specific settings
  USB: serial: xr: add support for multi-port XR21V141X variants
  USB: serial: xr: add support for XR21B142X devices
  USB: serial: xr: add support for XR21B1411
  USB: serial: xr: add support for XR2280X devices
  USB: cdc-acm: add other non-standard xr_serial models to ignore list

 drivers/usb/class/cdc-acm.c    |  17 +-
 drivers/usb/serial/xr_serial.c | 694 +++++++++++++++++++++++++--------
 2 files changed, 556 insertions(+), 155 deletions(-)

-- 
2.30.2


