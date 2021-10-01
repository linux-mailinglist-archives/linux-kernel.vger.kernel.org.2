Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1F41EB15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbhJAKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:42:07 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:38848 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352999AbhJAKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:42:05 -0400
Date:   Fri, 01 Oct 2021 10:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633084818;
        bh=B4kAjiXxRT5HF7ZIghnju/BP9j4U7tDErT68DbqxK38=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kx3vtKebPuw7pTb4l852Bb1sYDvvKrf83NR9KrvAXinCtm4tx1NvWUCFzwbEALMqr
         eWiTTM1tsXCPLK3NfrcjCoR/b2a51P/tkJAHtQR3wgbhm93tuenTA8SSaxhFWeFsYf
         JPw2XkYu4uxkKOgNn3iSY88oadCB5mOEq1IfK+8U=
To:     andriy.shevchenko@linux.intel.com
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        redecorating@protonmail.com
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCHv2] mfd: intel-lpss: Add support for MacBookPro16,2 UART
Message-ID: <20211001103845.21976-1-redecorating@protonmail.com>
In-Reply-To: <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com> <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
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

Added 8086:38a8 to the intel_lpss_pci driver. It is a UART controler
present on the MacBookPro16,2.

Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
---
v1->v2: Use "ICL-N" and shorten commit message.
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


