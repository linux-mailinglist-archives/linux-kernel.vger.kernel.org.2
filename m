Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39A23E0DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 07:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhHEFkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 01:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhHEFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 01:40:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D619C061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 22:40:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so12392584pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 22:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51DhxgLLj3oVTgO+Yt93dkTR66UP+XGV38AcifiutDo=;
        b=aZ9gfJt7tWoRAh1e4EZ2vxtE8tdrM3/OkMxB6G+f/d+SsaXKfIKeC+lZJJ4KdaNqXv
         YvRKy7WABqV9WttO1WUR0viz2JPHE/UNqxRlpRKKC6j2SZ381VLtRQ6XvWO/ucbFkAqV
         P1Ghs69qgg4RNDU7X0SJHs/XaDPJe57Wkcecw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51DhxgLLj3oVTgO+Yt93dkTR66UP+XGV38AcifiutDo=;
        b=fH5d2hDpgvqyeCYWrbqntlN3/d+c3Ue75th0+/CeoF6kKWy/D9ruktAlS48uE9RBoS
         9r0NJhWACfljH02TnOn/fM4QlgTbO7wapEsGShHuis1CIuAsQbIqNDQDZ/b4j73ffMh0
         fL0BzQfVkkbmsEs8vOjKpnw78t5dTQav6ElaCmuiPC7ewY6oNZHstoQUE1z+XorG1ynt
         jdP+9JEVMGZZz86E87+qEQ6a6kUaeE7311B+4x2ImaQqeMB8l6de8LFChJ0cg4SlNsL7
         /l6ISZIHteRWaAmAwgV1dGCG9TWldMqSTjqcdVNezCuXmo87ekiHnI3Tvk556M4p21qk
         KU1w==
X-Gm-Message-State: AOAM5303g69elNstNFwc7nH2aGaKHU7L8SBBb1GH2iKTW/oTkIcOfPBm
        0ECndPiXqYRgQLzT/w8QKNcwPm9v51TTHQ==
X-Google-Smtp-Source: ABdhPJyHCuhOyC1Oy4T+eWgglbQq9jy/tHFCTFzoK9gzeT7ihh+02C9vYfXvv+9/aVeXVOSdzr30AA==
X-Received: by 2002:a17:902:7804:b029:12c:de88:7d50 with SMTP id p4-20020a1709027804b029012cde887d50mr2329868pll.27.1628142001763;
        Wed, 04 Aug 2021 22:40:01 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:7a1c:b216:fca0:2cc2])
        by smtp.gmail.com with ESMTPSA id d22sm5448699pgi.73.2021.08.04.22.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:40:01 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] usb: xhci-mtk: relax TT periodic bandwidth allocation
Date:   Thu,  5 Aug 2021 13:39:57 +0800
Message-Id: <20210805133937.1.Ia8174b875bc926c12ce427a5a1415dea31cc35ae@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently xhci-mtk needs software-managed bandwidth allocation for
periodic endpoints, it allocates the microframe index for the first
start-split packet for each endpoint. As this index allocation logic
should avoid the conflicts with other full/low-speed periodic endpoints,
it uses the worst case byte budgets on high-speed bus bandwidth
For example, for an isochronos IN endpoint with 192 bytes budget,
it will consume the whole 4 u-frames(188 * 4) while the actual
full-speed bus budget should be just 192bytes.

This patch changes the low/full-speed bandwidth allocation logic
to use "approximate" best case budget for lower speed bandwidth
management. For the same endpoint from the above example, the
approximate best case budget is now reduced to (188 * 2) bytes.

Without this patch, many usb audio headsets with 3 interfaces
(audio input, audio output, and HID) cannot be configured
on xhci-mtk.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/usb/host/xhci-mtk-sch.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index f9b4d27ce449..46cbf5d54f4f 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -459,16 +459,17 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 	u32 num_esit, tmp;
 	int base;
 	int i, j;
+	u8 uframes = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
 
 	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
+
+	if (sch_ep->ep_type == INT_IN_EP || sch_ep->ep_type == ISOC_IN_EP)
+		offset++;
+
 	for (i = 0; i < num_esit; i++) {
 		base = offset + i * sch_ep->esit;
 
-		/*
-		 * Compared with hs bus, no matter what ep type,
-		 * the hub will always delay one uframe to send data
-		 */
-		for (j = 0; j < sch_ep->cs_count; j++) {
+		for (j = 0; j < uframes; j++) {
 			tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_cost_per_microframe;
 			if (tmp > FS_PAYLOAD_MAX)
 				return -ESCH_BW_OVERFLOW;
@@ -546,6 +547,8 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 	u32 base, num_esit;
 	int bw_updated;
 	int i, j;
+	int offset = sch_ep->offset;
+	u8 uframes = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
 
 	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
 
@@ -554,10 +557,13 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 	else
 		bw_updated = -sch_ep->bw_cost_per_microframe;
 
+	if (sch_ep->ep_type == INT_IN_EP || sch_ep->ep_type == ISOC_IN_EP)
+		offset++;
+
 	for (i = 0; i < num_esit; i++) {
-		base = sch_ep->offset + i * sch_ep->esit;
+		base = offset + i * sch_ep->esit;
 
-		for (j = 0; j < sch_ep->cs_count; j++)
+		for (j = 0; j < uframes; j++)
 			tt->fs_bus_bw[base + j] += bw_updated;
 	}
 
-- 
2.32.0.554.ge1b32706d8-goog

