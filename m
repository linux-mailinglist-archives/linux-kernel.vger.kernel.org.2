Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C28423A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhJFJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJFJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:36:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F22C061749;
        Wed,  6 Oct 2021 02:34:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j8so6841292wro.7;
        Wed, 06 Oct 2021 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i03E/waTnML0dSPg5cF+6UnHJ83NBJcxKTyso1VDAUs=;
        b=nHagkutTKcoF6y48vPoHmMe8GHnT495igwU7aipMeHm9D1HXs8KJrJS2JrdO/Oa1um
         e50w8j0ccpipf6JwglmLJfVfcarPxrcBWWPiYaO1WNLVPWnrH1s2LBYaaMWNxrp2YXQW
         IyNPzFFphtGNWFG3LgrKVfFl+NHHTsfVQsc7FEKjEgH7iaO8KUHQgTlEjj1K22jyViuu
         ivEtU41oPUnu7soLmQ5NgQ8JF7NclHkCSYz91RCXeo52ZfM0KswIl+HvHnSwR6m5z0oa
         BB87bXNv3bQv6r/jHstn7M0VgN7qQBPNVL3I4cHrO0nc6D4XvB8o/ptll7PHkaH3oU78
         7S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i03E/waTnML0dSPg5cF+6UnHJ83NBJcxKTyso1VDAUs=;
        b=3hRDTPsi9vrUvfZJ4PddiePXaU6CWBDt6xuekgy9vCCcC/Q4NfTYvWTAIsPoQdPhYm
         1Y3raduz3vs2I4jiTT48WZJgl2nvu1r71bTAW8tk7A6t2WGftUsEMr7oMBdEqHSoaKjH
         zd4nk70nls2MYKNjdkHyKWq+jmSVULKIDCPFXBrcgQDu6WkRFpf4/3amZP8XIkuqocml
         oDgt6GmcXVHQK5pcu4zLqc/zR96+r5Y6Z6z2SlppcMV1SxbknBE1D+zekJ5wFN99KXVF
         yu+t9tYk5QuJQf96dP7bMJks0QdxrOPNIQdCuk804k6fFfJVTOUs6hDEYGReb1Qe5njk
         QOQg==
X-Gm-Message-State: AOAM530E4yc8V9V3TUI+1ILJd2ZJtYXRcaENTxL3Kc59I+2rFsOIxGHD
        Ce6Zj/SzYj3+m1d3XnsEOnw=
X-Google-Smtp-Source: ABdhPJydPqaSBH7H0uNoRaCFS525dc7ctECN6YVxBa6JjZDQonN/MatD592KdWzBZmHK91OPVvJ+mw==
X-Received: by 2002:a5d:664f:: with SMTP id f15mr27416198wrw.143.1633512865679;
        Wed, 06 Oct 2021 02:34:25 -0700 (PDT)
Received: from localhost.localdomain (i577BCBA0.versanet.de. [87.123.203.160])
        by smtp.gmail.com with ESMTPSA id x10sm4725186wmk.42.2021.10.06.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:34:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] async_tx: correct reference to ASYNC_TX_ENABLE_CHANNEL_SWITCH
Date:   Wed,  6 Oct 2021 11:34:16 +0200
Message-Id: <20211006093416.4750-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b802c8410ca9 ("async_tx: deprecate broken support for channel
switching") in 2017 intended to "prevent async_tx from using an offload
engine if the channel switching capability is enabled" by adding a
suitable ifdef on the corresponding config.

The config for determining if  the channel switching capability is
enabled is called CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH, however
the ifdef falsely refers to CONFIG_ASYNC_TX_CHANNEL_SWITCH (note the
missing "ENABLE").

Correct the name of the config to the intended one.

Fixes: b802c8410ca9 ("async_tx: deprecate broken support for channel switching")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/async_tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/async_tx.h b/include/linux/async_tx.h
index 5cc73d7e5b52..8c7b940d9912 100644
--- a/include/linux/async_tx.h
+++ b/include/linux/async_tx.h
@@ -74,7 +74,7 @@ struct async_submit_ctl {
 	void *scribble;
 };
 
-#if defined(CONFIG_DMA_ENGINE) && !defined(CONFIG_ASYNC_TX_CHANNEL_SWITCH)
+#if defined(CONFIG_DMA_ENGINE) && !defined(CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH)
 #define async_tx_issue_pending_all dma_issue_pending_all
 
 /**
-- 
2.26.2

