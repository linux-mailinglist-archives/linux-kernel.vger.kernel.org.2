Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8041E934
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352787AbhJAIxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:53:39 -0400
Received: from mail-4319.protonmail.ch ([185.70.43.19]:47525 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhJAIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:53:37 -0400
Date:   Fri, 01 Oct 2021 08:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633078309;
        bh=hVVQvf/RTNnxE8jmEe0cunnlVp2WTO4uuOUaOBl9ux0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=G5KmcYohfnVYfjs4YK+rJWJSKUX4im7Vt8rI3dgBgDc1B2wK4uetI8vWmIubfTMVl
         8OcP5Q4LEsnIFi6zpNWMG4THSh6KG7NroKC0IOQoaWgcOAN6I9CBPmUqOppePLfAjy
         NiFM2U0M/ou6OdPW9fiDTNzxUffiN0iWsTxQpG2s=
To:     andriy.shevchenko@linux.intel.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH] mfd: intel-lpss: Add support for MacBookPro16,2 UART
Message-ID: <20211001084905.4133-1-redecorating@protonmail.com>
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

The MacBookPro16,2 has a UART controller with pci id 8086:38a8. Added
this device to the intel_lpss_pci driver. This allows access to its
Bluetooth controller.

The name of this device is not known, however as it appears to only be
found on the one model (MacBookPro16,2), labelling it with that
model's name should be sufficient to identify it. (Unless some folks
from Intel know what to call it and what its section should be called.)

Records here indicate that this device is only present on the one model:
https://linux-hardware.org/?id=3Dpci:8086-38a8-8086-7270

Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
---
 drivers/mfd/intel-lpss-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index c54d19fb184c..e02bb7026520 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -253,6 +253,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] =
=3D {
 =09{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
 =09{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
 =09{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
+=09/* MacBookPro16,2 */
+=09{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&bxt_uart_info },
 =09/* TGL-H */
 =09{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
 =09{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
--=20
2.33.0


