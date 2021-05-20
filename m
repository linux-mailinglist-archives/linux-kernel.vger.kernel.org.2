Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CFD38AEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbhETMoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241501AbhETMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88401C05648A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r12so17402417wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78IZFmK5jsA34hqJO0M2qv8hujM84El09YurAWZwzJM=;
        b=C3JKjuJQ/+v/Ste8TDqUSd4/bIawR7HpQPO4KJjFthaE/uBvkhh4qP6g2l5yuS0pwx
         iNnrjxChg/Yt3beNIYy+LBnkLUHs8jePy9TlojGGjsFsL6sPzdc4J9ynGCM/tuFlIKNt
         cs+xIFK5prHwgSpGNLUzj9B5hW40fM6R/psgmFycgziUAAExNQbKnRQR63SfqJIEB2Pn
         eGljaSNS9P2K/kuxjjU9yGQNRx6BO9BpNKXCtjCvNJFM9LBGGQI4eHizABCNlimVW2Ix
         hL028sHfiqtvLELAFZTHn6CowpRzuK/KmcqFE4aTjj0teNVZTlGDufkdnGo2jjusUFMn
         EQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78IZFmK5jsA34hqJO0M2qv8hujM84El09YurAWZwzJM=;
        b=EpP0IyZxNSTA6Y5P2VDxB3/olcyBy6LemovqEvAxTJ4fMLCd7/dzhzuS8ra18T4szf
         0DlOufuP97g/x69AcXc53qUjjh6n4KDeuFNlrGj9LtnNWdDL5FigEqO+nNvnRMrv9MzT
         yzbuRAr8+mi0bnvXwjOTFGUqQSxlR1VnyAULaCMZhF15VE7jHgbCDhmZ3EppJI+guLtV
         dG5eA3k4cJoJg/GudEscwDbeyDdCevlEG5DNPgBp6eezStp7F5gRVP0cF/iSnlmItbY5
         rbFQY+f1TAlWvWHqhdQnnxfOMoy3HeOxALFSZJbDsD1hX8G+NiUjOIQjW+nDE8MsLjg9
         ZYKg==
X-Gm-Message-State: AOAM53063Q/vWN0X3pRuzF6EXx+OJGQZKD8qEb68ghEdN40u8WZZ3XO7
        UBHSodQ9G96UpAeFO/h9xjerww==
X-Google-Smtp-Source: ABdhPJyjfJJwF+BNH0YP0v8lGpULEjGckiTSXpzTJVGakyu6jwlqugBIAGeCfvDjLTMGMM31/ZxzOw==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr3884135wro.295.1621512178168;
        Thu, 20 May 2021 05:02:58 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:02:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/38] drm/sti/sti_hdmi_tx3g4c28phy: Provide function names for kernel-doc headers
Date:   Thu, 20 May 2021 13:02:16 +0100
Message-Id: <20210520120248.3464013-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c:77: warning: expecting prototype for Start hdmi phy macro cell tx3g4c28(). Prototype was for sti_hdmi_tx3g4c28phy_start() instead
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c:187: warning: expecting prototype for Stop hdmi phy macro cell tx3g4c28(). Prototype was for sti_hdmi_tx3g4c28phy_stop() instead

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
index d5f94dca0d323..d25ecd4f4b673 100644
--- a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
+++ b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
@@ -67,7 +67,7 @@ static struct hdmi_phy_config hdmiphy_config[NB_HDMI_PHY_CONFIG] = {
 };
 
 /**
- * Start hdmi phy macro cell tx3g4c28
+ * sti_hdmi_tx3g4c28phy_start - Start hdmi phy macro cell tx3g4c28
  *
  * @hdmi: pointer on the hdmi internal structure
  *
@@ -179,7 +179,7 @@ static bool sti_hdmi_tx3g4c28phy_start(struct sti_hdmi *hdmi)
 }
 
 /**
- * Stop hdmi phy macro cell tx3g4c28
+ * sti_hdmi_tx3g4c28phy_stop - Stop hdmi phy macro cell tx3g4c28
  *
  * @hdmi: pointer on the hdmi internal structure
  */
-- 
2.31.1

