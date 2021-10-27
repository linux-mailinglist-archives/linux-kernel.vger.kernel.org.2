Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3755A43C774
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbhJ0KRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbhJ0KRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:17:44 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F51CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:15:18 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by andre.telenet-ops.be with bizsmtp
        id AyFE260042hfXWm01yFEen; Wed, 27 Oct 2021 12:15:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mffiU-008HRd-LB; Wed, 27 Oct 2021 11:59:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfdzN-00DkK9-St; Wed, 27 Oct 2021 10:08:49 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] usb: gadget: Mark USB_FSL_QE broken on 64-bit
Date:   Wed, 27 Oct 2021 10:08:49 +0200
Message-Id: <20211027080849.3276289-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit:

    drivers/usb/gadget/udc/fsl_qe_udc.c: In function ‘qe_ep0_rx’:
    drivers/usb/gadget/udc/fsl_qe_udc.c:842:13: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
      842 |     vaddr = (u32)phys_to_virt(in_be32(&bd->buf));
	  |             ^
    In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:41:
    drivers/usb/gadget/udc/fsl_qe_udc.c:843:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
      843 |     frame_set_data(pframe, (u8 *)vaddr);
	  |                            ^

The driver assumes physical and virtual addresses are 32-bit, hence it
cannot work on 64-bit platforms.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
One more casualty of CONFIG_WERROR=y.
http://kisskb.ellerman.id.au/kisskb/buildresult/14652936/
---
 drivers/usb/gadget/udc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 8c614bb86c665c77..69394dc1cdfb6436 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -330,6 +330,7 @@ config USB_AMD5536UDC
 config USB_FSL_QE
 	tristate "Freescale QE/CPM USB Device Controller"
 	depends on FSL_SOC && (QUICC_ENGINE || CPM)
+	depends on !64BIT || BROKEN
 	help
 	   Some of Freescale PowerPC processors have a Full Speed
 	   QE/CPM2 USB controller, which support device mode with 4
-- 
2.25.1

