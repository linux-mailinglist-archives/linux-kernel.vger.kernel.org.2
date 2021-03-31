Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F134F832
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 06:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhCaE67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 00:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhCaE6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 00:58:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C6DC061574;
        Tue, 30 Mar 2021 21:58:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ha17so8892159pjb.2;
        Tue, 30 Mar 2021 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M9IEZCF3Kb5rzDpus85iH1dAL2w2ZrIdfYygwHVDvMs=;
        b=QOx+xP0OZ9SwBGZAcMXCuioMLzdjTff51PtRLVQmxuiKezcDEiMqpJNi0HnkZQmHNx
         4CX6FTDHqn0bNK3YpNvch7/LCc5iekuFtAiyJ1ZCDw29+RCFssk777mEBiO7JKMSTqe7
         FWmZfiLQC1Tb/Fk03vbxBZeUOmV6PwErF//XkcSl/RTjdjN7d2JWXP3F/xZBakHuvir+
         2HfVjTCQVYGFTCZIdG+s+0kBGsY6BLTwjmV1RTciFZSNbSq1k6u5I0Eqy3pIU2lj/aK1
         +j1GEYDcGl1oqj26f/FcqQv/1SwPJYKQhLmWdJS33+5pLbf3SRSlXRWCtoBPBNQjWsX/
         VWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M9IEZCF3Kb5rzDpus85iH1dAL2w2ZrIdfYygwHVDvMs=;
        b=R034iGVx+eUEqFXpvUbsrz4YFUS+AsgdgNdCeiKeeByxDz+F3kuZzx/eKXbEixeuRp
         xoPBTs+YX1p/jh427QAoLuYaWAgtOZrvJByqMHPyqDugLB6Zcslu8SqO4/Y7dd9i2956
         squfW8Hhk36m9GSisAi7UBbK3PaeHwVpwyhntrx95c+h93RMTiY45BElZhEhNZ4HGOGH
         rT1F4efpNvfrfZNNSb1q5cv+C8aW+MkTotPNckRKjVCNy9xDFvtmmOsdLLG/9BiS7VPg
         Qc0yRpNXzsTdg3Jxe4czllPcF6zEeWgbZi28hZz5Ih/NU3nqIBi68HW0+IwrzZW0MQrf
         OZvg==
X-Gm-Message-State: AOAM532SyFN59V4Gep6LGlPB4Hgwk6rq7s+Zqhj4TOMsJJXkIXcfq7FI
        nZssmewADDLM+akj08ju3s0=
X-Google-Smtp-Source: ABdhPJxCQskMGUM7pUf8tLPCPJKZG1Bkr8uITpKSbc8zP5PBHshTADmqpzQJd1Y+m/V/iFE4MN9CAw==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr1695746pjx.194.1617166725244;
        Tue, 30 Mar 2021 21:58:45 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a70sm587054pfa.202.2021.03.30.21.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 21:58:44 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tao Ren <taoren@fb.com>
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] usb: gadget: aspeed: fix dma map failure
Date:   Tue, 30 Mar 2021 21:58:31 -0700
Message-Id: <20210331045831.28700-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Currently the virtual port_dev device is passed to DMA API, and this is
wrong because the device passed to DMA API calls must be the actual
hardware device performing the DMA.

The patch replaces usb_gadget_map_request/usb_gadget_unmap_request APIs
with usb_gadget_map_request_by_dev/usb_gadget_unmap_request_by_dev APIs
so the DMA capable platform device can be passed to the DMA APIs.

The patch fixes below backtrace detected on Facebook AST2500 OpenBMC
platforms:

[<80106550>] show_stack+0x20/0x24
[<80106868>] dump_stack+0x28/0x30
[<80823540>] __warn+0xfc/0x110
[<8011ac30>] warn_slowpath_fmt+0xb0/0xc0
[<8011ad44>] dma_map_page_attrs+0x24c/0x314
[<8016a27c>] usb_gadget_map_request_by_dev+0x100/0x1e4
[<805cedd8>] usb_gadget_map_request+0x1c/0x20
[<805cefbc>] ast_vhub_epn_queue+0xa0/0x1d8
[<7f02f710>] usb_ep_queue+0x48/0xc4
[<805cd3e8>] ecm_do_notify+0xf8/0x248
[<7f145920>] ecm_set_alt+0xc8/0x1d0
[<7f145c34>] composite_setup+0x680/0x1d30
[<7f00deb8>] ast_vhub_ep0_handle_setup+0xa4/0x1bc
[<7f02ee94>] ast_vhub_dev_irq+0x58/0x84
[<7f0309e0>] ast_vhub_irq+0xb0/0x1c8
[<7f02e118>] __handle_irq_event_percpu+0x50/0x19c
[<8015e5bc>] handle_irq_event_percpu+0x38/0x8c
[<8015e758>] handle_irq_event+0x38/0x4c

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 3 ++-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index be7bb64e3594..d11d3d14313f 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -36,6 +36,7 @@ void ast_vhub_done(struct ast_vhub_ep *ep, struct ast_vhub_req *req,
 		   int status)
 {
 	bool internal = req->internal;
+	struct ast_vhub *vhub = ep->vhub;
 
 	EPVDBG(ep, "completing request @%p, status %d\n", req, status);
 
@@ -46,7 +47,7 @@ void ast_vhub_done(struct ast_vhub_ep *ep, struct ast_vhub_req *req,
 
 	if (req->req.dma) {
 		if (!WARN_ON(!ep->dev))
-			usb_gadget_unmap_request(&ep->dev->gadget,
+			usb_gadget_unmap_request_by_dev(&vhub->pdev->dev,
 						 &req->req, ep->epn.is_in);
 		req->req.dma = 0;
 	}
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 02d8bfae58fb..cb164c615e6f 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -376,7 +376,7 @@ static int ast_vhub_epn_queue(struct usb_ep* u_ep, struct usb_request *u_req,
 	if (ep->epn.desc_mode ||
 	    ((((unsigned long)u_req->buf & 7) == 0) &&
 	     (ep->epn.is_in || !(u_req->length & (u_ep->maxpacket - 1))))) {
-		rc = usb_gadget_map_request(&ep->dev->gadget, u_req,
+		rc = usb_gadget_map_request_by_dev(&vhub->pdev->dev, u_req,
 					    ep->epn.is_in);
 		if (rc) {
 			dev_warn(&vhub->pdev->dev,
-- 
2.17.1

