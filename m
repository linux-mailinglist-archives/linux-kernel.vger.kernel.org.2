Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A337041F984
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 05:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhJBDdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 23:33:00 -0400
Received: from mail-4319.protonmail.ch ([185.70.43.19]:17319 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJBDc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 23:32:57 -0400
Date:   Sat, 02 Oct 2021 03:31:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633145471;
        bh=fx0zECbH9vubxyXuTfiL/WOSjs2o3aGJOaS6eB+BJd4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=g3Mrx2jlOsz8PxThAugKDkHRSpAUBc0VsKFXyT37dZfP4YRA79mHh98/o+AasJHhC
         IQFxarWUFmA/3Xef+ckzxM54UPhZMOWunbPz2Wev/5b7bcv1R2ofEEJhqRN9tzPp5O
         gWvuHCkxwVl0fRikICex632QWsJo2FknPeoTq7Gg=
To:     andriy.shevchenko@linux.intel.com
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        redecorating@protonmail.com
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCHv3] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N UART
Message-ID: <20211002032810.3729-1-redecorating@protonmail.com>
In-Reply-To: <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com> <YVbf9J3jgAmBY+ch@smile.fi.intel.com> <YVdP9PwNrjmKxKac@google.com> <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
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
---
v2->v3: Mention "ICL-N" in commit message.
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


