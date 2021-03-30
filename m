Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF334E2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhC3IGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhC3IG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:06:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009B8C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:06:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v10so6266711pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omYb2z/SxeccNVlBPetfsj1e/P6RhqbnacO8PchLVZY=;
        b=nFTABc/J7yBKCfkL84+8tT1dkIPuXZR3YssrNm/LsQ1ZgHjiz+5CYmQtvoCyKXA69T
         YUtTTw68+mM1DvHyQ9HKL3hU1ZjujV0l8FHLLbcy+/cuVzCcecHTpARqUQB8fh9mWEDs
         9nN/yZMvg33SdK6FrusNp57t0RfZcJoPdGtvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omYb2z/SxeccNVlBPetfsj1e/P6RhqbnacO8PchLVZY=;
        b=Pnpcxf1/xfgqSF3mqk3Tgq0KGS70P/JMDuxLrkyxd/9UR34sVSRHBeyN1RV9xfv1VS
         eaNxrB/JPYpKNJOjrlPfBSJv7SoNQVWD2VAYAJArI/a1SqFzhrkwGzZO18JQ9E8UmfI1
         K8+K9UNnXmSSnWa9N6txoX++V9An3ozH5BgoAsYv3D4+kbs2DqymcTYu5xgpCHsjO4Ve
         3xavJqFXNn+Akb/bgiSiwUTaW2X8gxY4rh3sckYdiCytWQAspCLis0oGfm5P5JAkiH8R
         50jR0R79NNOtB3H8Ua11oggRuy6fo7Zc7syAJc3qoRZiWWYw3TMB4j2o7ID7bf8Mq1nF
         dVrA==
X-Gm-Message-State: AOAM533Q1xYTyd9ruplyQvM80I/yZGhoE2XFE4lRPwGnfBPJaT6ley0r
        XMr6ENZkjif2aD+OnsN7NAYalQ==
X-Google-Smtp-Source: ABdhPJxeGsARwOmu0kpuzHXfaqLI91H5qK/dwMnsn/LcD/lal1cqTKXlS1D5HNZSxQ4+b4mKsMcR/Q==
X-Received: by 2002:aa7:8145:0:b029:20f:58e6:9c17 with SMTP id d5-20020aa781450000b029020f58e69c17mr28921254pfn.52.1617091585565;
        Tue, 30 Mar 2021 01:06:25 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:49fb:d79d:bee6:d970])
        by smtp.gmail.com with ESMTPSA id f23sm19118913pfa.85.2021.03.30.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:06:25 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] usb: xhci-mtk: remove unnecessary assignments in periodic TT scheduler
Date:   Tue, 30 Mar 2021 16:06:16 +0800
Message-Id: <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330080617.3746932-1-ikjn@chromium.org>
References: <20210330080617.3746932-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variables in check_sch_bw().
No functional changes, just for better readability.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/usb/host/xhci-mtk-sch.c | 52 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index a59d1f6d4744..0cb41007ec65 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -479,6 +479,9 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 	u32 start_cs, last_cs;
 	int i;
 
+	if (!sch_ep->sch_tt)
+		return 0;
+
 	start_ss = offset % 8;
 
 	if (sch_ep->ep_type == ISOC_OUT_EP) {
@@ -606,54 +609,41 @@ static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
 static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
 			struct mu3h_sch_ep_info *sch_ep)
 {
-	u32 offset;
-	u32 min_bw;
-	u32 min_index;
-	u32 worst_bw;
-	u32 bw_boundary;
-	u32 esit_boundary;
-	u32 min_num_budget;
-	u32 min_cs_count;
-	int ret = 0;
+	int i, found = -1;
+	const u32 esit_boundary = get_esit_boundary(sch_ep);
+	const u32 bw_boundary = get_bw_boundary(sch_ep->speed);
+	u32 min_bw = ~0;
 
 	/*
 	 * Search through all possible schedule microframes.
 	 * and find a microframe where its worst bandwidth is minimum.
 	 */
-	min_bw = ~0;
-	min_index = 0;
-	min_cs_count = sch_ep->cs_count;
-	min_num_budget = sch_ep->num_budget_microframes;
-	esit_boundary = get_esit_boundary(sch_ep);
-	for (offset = 0; offset < sch_ep->esit; offset++) {
-		if (sch_ep->sch_tt) {
-			ret = check_sch_tt(sch_ep, offset);
-			if (ret)
-				continue;
-		}
+	for (i = 0; i < sch_ep->esit; i++) {
+		u32 worst_bw;
 
-		if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
+		if ((i + sch_ep->num_budget_microframes) > esit_boundary)
 			break;
 
-		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
+		if (check_sch_tt(sch_ep, i))
+			continue;
+
+		worst_bw = get_max_bw(sch_bw, sch_ep, i);
+		if (worst_bw > bw_boundary)
+			continue;
+
 		if (min_bw > worst_bw) {
 			min_bw = worst_bw;
-			min_index = offset;
-			min_cs_count = sch_ep->cs_count;
-			min_num_budget = sch_ep->num_budget_microframes;
+			found = i;
 		}
 		if (min_bw == 0)
 			break;
 	}
 
-	bw_boundary = get_bw_boundary(sch_ep->speed);
 	/* check bandwidth */
-	if (min_bw > bw_boundary)
-		return ret ? ret : -ESCH_BW_OVERFLOW;
+	if (found < 0)
+		return -ESCH_BW_OVERFLOW;
 
-	sch_ep->offset = min_index;
-	sch_ep->cs_count = min_cs_count;
-	sch_ep->num_budget_microframes = min_num_budget;
+	sch_ep->offset = found;
 
 	return load_ep_bw(sch_bw, sch_ep, true);
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

