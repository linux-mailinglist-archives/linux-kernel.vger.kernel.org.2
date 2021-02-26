Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AF3326353
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBZN33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhBZN3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:29:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4873F64F03;
        Fri, 26 Feb 2021 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614346117;
        bh=kFtDE0hhRB3jqoqlNzIz1b+FRsGJSaHnpl8grjpv4OM=;
        h=From:To:Cc:Subject:Date:From;
        b=G9PLcAvUfrIZyYu9DiM6E3kapgitVkf2Sd932NaAmV793P/IwYcDgEPmMGHf5JxdX
         8qLqD9dLEf57P4/BByUKBjD4NiRXSc9X5A88bVbd/hFgX7LmhtZxIGO49zQXpLv9B7
         nFAY36LiBN8aUUaveSSnKstR8HSkEy9u+mIhYX3B208XdqmhJqwpXmuMpBWKNxywcU
         HAWQEwHCQWT3pqxWfVayeWfYq0dOWlUP/oEnubHzZCZ6j8V8M3MHQ3sQlBt2pCo8G1
         12DEKRZdxfKhwAkgE7AeiBa9yandFEWuBDt1j/55++mh7SZCTazLIYstLV/x0Rmz11
         kMLueMMZW45Kg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lFdAY-002nbo-GZ; Fri, 26 Feb 2021 14:28:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/7] Add support for the other MaxLinear/Exar UARTs
Date:   Fri, 26 Feb 2021 14:28:26 +0100
Message-Id: <cover.1614345081.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of the xr_serial driver handles one one of the several
MaxLinear/Exar UARTs and UART bridges. There are currently 12 such
models. Only one is currently supported.

This series apply on the top of linux-next + the bug fix patch sent
today:
	
	https://lore.kernel.org/lkml/20210226100826.18987-1-johan@kernel.org/

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

Regards,
Mauro

Mauro Carvalho Chehab (7):
  USB: serial: xr: simplify its namespace
  USB: serial: xr: use a table for device-specific settings
  USB: serial: xr: add support for multi-port XR21V141X variants
  USB: serial: xr: add support for XR21B142X devices
  USB: serial: xr: add support for 
  USB: serial: xr: add support for XR2280X devices
  USB: cdc-acm: add other non-standard xr_serial models to ignore list

 drivers/usb/class/cdc-acm.c    |  17 +-
 drivers/usb/serial/xr_serial.c | 694 +++++++++++++++++++++++++--------
 2 files changed, 556 insertions(+), 155 deletions(-)

-- 
2.29.2


