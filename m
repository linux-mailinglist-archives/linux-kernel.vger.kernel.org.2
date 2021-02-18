Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273C831EFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBRT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhBRSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:40:37 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:38:13 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id b21so1684927pgk.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm3iKJC71AZhcv9cPHX8V7GUbemia6Ju/le2pydValk=;
        b=eu3pg3nf6z6GeVNgi0Ustk+0RI+1yIUJbeRmSSe+MZpypwBmeEZod/SkghwGJrMYys
         2WxB9U/Ag314r8ZG2h4THNZ7ZEX3tCDpqVOXrvJksvTwC5KaDFDug9e0vb1powb4Li8Q
         7BfFv8yDTMeCcOml9aLSBdfn/gTi181dtrvcnu23cXaBoehSyASJOrEr8izIbC114gen
         0s/YgJJcp/LEUxZyh8dDjCaRQCOF21Jei1gyh7KJnRXNPB8HM2Hg/p8dpOnrmGXWmEr+
         WBEQQF+aH1OMHDBZsTYBIKeYJAhixJ/04OS/u9sMPvSJ4GjQJ7pHZyaSX0NNnp6HN4Ff
         JGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm3iKJC71AZhcv9cPHX8V7GUbemia6Ju/le2pydValk=;
        b=WaUIZYmY4gytOKHl9IbBgXMJ/EUxJP9TwIUGqkmcYpEhZ2LmqJ+6tCuyJS1D5GH6NB
         x8n/by0c9wTDjTcqAeES0apqg0UvX54wGCs+TGzF+2gwH3dIB2yCj5NPwP2TPWkADbKR
         9wKKg849FPk9/Gp4rWqNI0pSOqsvjEQCFVXCNQhl1atLH88LLNrcbF66Co6exVT9kbm4
         GD8ZhkKkAWZobR4KESf6D+yuWXwiQ1jqwmRjgYWxxph+/9WKuaWGZDqj0nzxFOVE0DM9
         tElr7+mpuXAjoWKJoIa9K9b3+QTOqQubbBM+No3FnBx8JOBDbx3oz1jdRfSO1OJ8gyKq
         YVDw==
X-Gm-Message-State: AOAM533Zm9SRTVEHBKAZTI04XCtFYejjaHPcdPvqqSJry9Al3OSCD6Qw
        23Fz+CFjjZWTTVeW+F4Yn+o=
X-Google-Smtp-Source: ABdhPJwnr5VExSrM3WtwOAYbaZQZBI3qaxRGPcwS7bL5drTQPqfvzdC/R194Lzguk3ylDED2mgfaaw==
X-Received: by 2002:a62:b516:0:b029:1ea:34a:a70e with SMTP id y22-20020a62b5160000b02901ea034aa70emr5540906pfe.38.1613673493395;
        Thu, 18 Feb 2021 10:38:13 -0800 (PST)
Received: from novachrono.domain.name ([223.235.222.137])
        by smtp.gmail.com with ESMTPSA id f3sm6545240pgh.75.2021.02.18.10.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:38:12 -0800 (PST)
From:   Rajat Asthana <thisisrast7@gmail.com>
To:     gregkh@linuxfoundation.org, jerome.pouiller@silabs.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Rajat Asthana <thisisrast7@gmail.com>
Subject: [PATCH] staging: wfx: Fix alignment style issue in sta.c
Date:   Fri, 19 Feb 2021 00:07:57 +0530
Message-Id: <20210218183757.72995-1-thisisrast7@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch error for "Alignment should match
open parenthesis".

Signed-off-by: Rajat Asthana <thisisrast7@gmail.com>
---
 drivers/staging/wfx/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 5585f9e876e1..8c57338efc71 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -193,7 +193,7 @@ int wfx_update_pm(struct wfx_vif *wvif)
 }
 
 int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		   u16 queue, const struct ieee80211_tx_queue_params *params)
+		u16 queue, const struct ieee80211_tx_queue_params *params)
 {
 	struct wfx_dev *wdev = hw->priv;
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
-- 
2.27.0

