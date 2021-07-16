Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE0D3CB394
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhGPHyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhGPHy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:54:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6095BC061765
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:51:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c15so4901446pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7y1o6yqtjLQ46xl4Mz29qqqiixnPhzplTd0TzQ94aRg=;
        b=tfpa7GBSViVK2gcM9PCAR1fkgHjvE6HDI85TLLUpapLIJ/DUKYyvZ30xL/g5+HZdSm
         QpcxwO8T1lDn6mRwdsOEBvVpFETyrkMrXIuevBi+wXjK3R4sB3bRcqX149B2IxlEzNcX
         2FH7anYDx/vxVvMXMGsJTPjYKE7+wPpNOzPA3Cu8J72n/3X/muPfkCkmP56nZS+s2zvF
         DItFtkwKjB4rwKAAbI1jMSGK+Fpw2KY/jiWJoV9FKml6PbRN4VIBL3w/CxicA4IkbK9j
         U5FRtoTUVeNwnFnirhTR+ZVHa8jxbragi4URzMLp+qnb+UDKYSv2E8b2s/w32awe0yUz
         Pe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7y1o6yqtjLQ46xl4Mz29qqqiixnPhzplTd0TzQ94aRg=;
        b=thUjM9sAzhkMypQT1xtGCqjwBdLlmOaRsCQ10SCvQoiPQqDCtVjB4swu7jdhEZnwZ9
         J8sNu9MgeWR9OalvleVyY6brtE4SnINQRooiMAERzQQccGWVpZyNBzkGo56FlhP+VQIS
         t+7PIyP55AuegbiTJq5x3Hp+46ROD1D1fpzhZp8HAAnCirsMWVF1aVB/hkwfUS5Wctpn
         gCDlmCRLBNRktiCF1s1YpkbgFI/ieVz9wsPZXWidLBJ2pNmdTkQoPPzZLeCu8yS3+lWh
         xGx5RM7w7gzAa+sF0t5WWFGd5bPe1V1Oh0nv7vVKf/l4mOB87hRcOiuNA29h1/x2E/Ok
         cN/Q==
X-Gm-Message-State: AOAM531x9hpeMvpMhZDal+4vhJAA3sdHa5UsYbM2tUMssg+NfBw8ai6F
        x8wSmPTQ+nOgTrOa0MWUMowG
X-Google-Smtp-Source: ABdhPJzAdJ1prZlca+X3sHqmVx9UevaMHNtfD+6WQz3c0SLZAOVp6FpslGhylnz2JHfDFeQbmHXKaw==
X-Received: by 2002:a17:902:ec06:b029:12b:55c9:3b51 with SMTP id l6-20020a170902ec06b029012b55c93b51mr6444777pld.4.1626421892881;
        Fri, 16 Jul 2021 00:51:32 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.214])
        by smtp.gmail.com with ESMTPSA id 21sm9253357pfp.211.2021.07.16.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 00:51:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 2/3] bus: mhi: core: Validate channel ID when processing command completions
Date:   Fri, 16 Jul 2021 13:21:05 +0530
Message-Id: <20210716075106.49938-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716075106.49938-1-manivannan.sadhasivam@linaro.org>
References: <20210716075106.49938-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

MHI reads the channel ID from the event ring element sent by the
device which can be any value between 0 and 255. In order to
prevent any out of bound accesses, add a check against the maximum
number of channels supported by the controller and those channels
not configured yet so as to skip processing of that event ring
element.

Cc: stable@vger.kernel.org #5.10
Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://lore.kernel.org/r/1624558141-11045-1-git-send-email-bbhatt@codeaurora.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 22acde118bc3..fc9196f11cb7 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -773,11 +773,18 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
 	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
 
 	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
-	mhi_chan = &mhi_cntrl->mhi_chan[chan];
-	write_lock_bh(&mhi_chan->lock);
-	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
-	complete(&mhi_chan->completion);
-	write_unlock_bh(&mhi_chan->lock);
+
+	if (chan < mhi_cntrl->max_chan &&
+	    mhi_cntrl->mhi_chan[chan].configured) {
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		write_lock_bh(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
+		complete(&mhi_chan->completion);
+		write_unlock_bh(&mhi_chan->lock);
+	} else {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Completion packet for invalid channel ID: %d\n", chan);
+	}
 
 	mhi_del_ring_element(mhi_cntrl, mhi_ring);
 }
-- 
2.25.1

