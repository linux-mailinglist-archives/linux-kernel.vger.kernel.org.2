Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E241FB14
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhJBLSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:18:24 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:24973 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhJBLSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:18:22 -0400
Date:   Sat, 02 Oct 2021 11:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633173394;
        bh=wKlu6PADgAEzg+4XmY80twGmtK9jh8zSJfgHrBu962g=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=f6zzXKABzOdZnXqWB5sWvPolslJ39+ekVQWq7SfbefmkOTwPJZZgbZ4iqLk07chCz
         6bP7Q1ZZhS93QoMe8gITee79QgI8wScZjGLB/yvtORUC7DzkXCgqZtAWuRq143R05j
         uzeYMgj10lxeD0h4yC2Ph6JqYaF4PbvCR7swW+jE=
To:     redecorating@protonmail.com
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     andriy.shevchenko@linux.intel.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCHv4] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N UART
Message-ID: <20211002111449.12674-1-redecorating@protonmail.com>
In-Reply-To: <20211001084905.4133-1-redecorating@protonmail.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
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

Added 8086:38a8 to the intel_lpss_pci driver. It is an Intel Ice Lake
PCH-N UART controler present on the MacBookPro16,2.

Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3->v4: reviewed-by line
 drivers/mfd/intel-lpss-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index c54d19fb184c..a872b4485eac 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -253,6 +253,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] =
=3D {
 =09{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
 =09{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
 =09{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
+=09/* ICL-N */
+=09{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&bxt_uart_info },
 =09/* TGL-H */
 =09{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
 =09{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
--=20
2.33.0


