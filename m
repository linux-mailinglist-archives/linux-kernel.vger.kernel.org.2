Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A59A457C96
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhKTIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 03:37:43 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:46396 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhKTIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 03:37:41 -0500
Date:   Sat, 20 Nov 2021 08:34:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1637397275;
        bh=10as2SSAHWUwNyBVa743Y/q5LEHoDZAyLY8FqhWA2S4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=WyUODtNcN43Aqs3mhTxjnuR31EDlPY6gSjuGpJNiN62xckT62dMBXL8G0iZ2A6YL1
         6f5Rz3WQvLS5mnSBMc44PkBjVlkxjRsK5Baor14trrGn6XGQYyVvrSEuTHftaLjO+9
         TpQKrGuZ7+3VQo6iDIpXWAIYepjW74FEtJyMEXhs=
To:     andriy.shevchenko@linux.intel.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH] mfd: intel-lpss-pci: fix clock speed for 38a8 UART
Message-ID: <20211120083312.41230-1-redecorating@protonmail.com>
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
---
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


