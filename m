Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38F532FA6C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCFMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 07:08:35 -0500
Received: from m12-18.163.com ([220.181.12.18]:59979 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCFMIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 07:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=G1CefTDUOphs/ju8OA
        6vyhQmbezCTp81UWY6mcWD6gQ=; b=mjwnRbe+WDUGtNAbQWTX+J8i/F5lFCJAzp
        N9qSPWCeEFdtZPUPNAsxa240gwQk0ev4bIGpYm1D/7vy1dsNdWSJ00F2WtTeKLMX
        L6yte7D/eDFhnv7ub1GUEFSDPRV36C762BZ4UUHvu4uX/FaRORoROnu+VeasZVnM
        NjQd2Bv1E=
Received: from localhost.localdomain (unknown [36.170.36.204])
        by smtp14 (Coremail) with SMTP id EsCowADX0vB9cENg7OF3XQ--.29206S2;
        Sat, 06 Mar 2021 20:07:26 +0800 (CST)
From:   zhangkun4jr@163.com
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Kun <zhangkun@cdjrlc.com>
Subject: [PATCH] xhci: Remove unused value len from xhci_unmap_temp_buf
Date:   Sat,  6 Mar 2021 20:06:44 +0800
Message-Id: <20210306120644.74406-1-zhangkun4jr@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowADX0vB9cENg7OF3XQ--.29206S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWkZrWxXryUGw4DXryxKrg_yoWDGFc_Cr
        93Ar1kC3yDGw1qvr12yanFv3yqka18Xrs7WFs2vF15ua4Utas8ZF1rAFykXa4rGF48JFsI
        qw15WrW8tr10vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5Ta0JUUUUU==
X-Originating-IP: [36.170.36.204]
X-CM-SenderInfo: x2kd0whnxqkyru6rljoofrz/1tbiqh1NtVr7sWPVMgAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Kun <zhangkun@cdjrlc.com>

The value assigned to len by sg_pcopy_from_buffer() never used for
anything, so remove it.

Signed-off-by: Zhang Kun <zhangkun@cdjrlc.com>
---
 drivers/usb/host/xhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bd27bd670104..6ebda89d476c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1335,7 +1335,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
 
 static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 {
-	unsigned int len;
 	unsigned int buf_len;
 	enum dma_data_direction dir;
 
@@ -1351,7 +1350,7 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 				 dir);
 
 	if (usb_urb_dir_in(urb))
-		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
+		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
 					   urb->transfer_buffer,
 					   buf_len,
 					   0);
-- 
2.17.1


