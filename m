Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B871145B747
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbhKXJXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:23:07 -0500
Received: from mail-4319.protonmail.ch ([185.70.43.19]:35309 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbhKXJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:23:05 -0500
Date:   Wed, 24 Nov 2021 09:19:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1637745594;
        bh=bFCpzY8osbgUUc0JFsxmKOAK3Y6JCfqhKV8rP3S9k+o=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=hUgLjliUN9MHYqvqxHprzBsh+8UiB+oj0SOiOJoZGnaOylMs01pU5KjJDaBd5hb9c
         H2Jonx9mEfMBSQxiYMrw1NGClYX/JF7ERm+8VZM9eT/e+KUo1CrJ0R+zklsLXmGsMR
         bFY3PBI8wvlUy3vwj48fzWkkpm+r3Vpl+r7mshWk=
To:     andriy.shevchenko@linux.intel.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCHv2] mfd: intel-lpss-pci: fix clock speed for 38a8 UART
Message-ID: <20211124091846.11114-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is found in the MacBookPro16,2, and as the MacBookPro16,1 is
from the same generation of MacBooks and has a UART with bxt_uart_info,
it was incorrectly assumed that the MacBookPro16,2's UART would have the
same info.

This led to the wrong clock speed being used, and the Bluetooth
controller exposed by the UART receiving and sending random data, which
was incorrectly assumed to be an issue with the Bluetooth stuff, not an
error with the UART side of things.

Changing the info to spt_uart_info changes the clock speed and makes it
send and receive data correctly.

Fixes: ddb1ada416fd ("mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N=
 UART")
Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1 -> v2: Remove blank line in tag block, add Reviewed-by.
 drivers/mfd/intel-lpss-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index a872b4485eac..f70464ce8e3d 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -254,7 +254,7 @@ static const struct pci_device_id intel_lpss_pci_ids[] =
=3D {
 =09{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
 =09{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
 =09/* ICL-N */
-=09{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&bxt_uart_info },
+=09{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&spt_uart_info },
 =09/* TGL-H */
 =09{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
 =09{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
--=20
2.34.0


