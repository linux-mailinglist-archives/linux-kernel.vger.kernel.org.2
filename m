Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46D3AD996
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhFSKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhFSKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E15C061756
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so7282231wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pwu5pM4dbgTBood6EBI5joCOsJM78eFvHusKdHfshs=;
        b=vhu9sWByZXK8kb+zqz3C+BIbUKY/FPpNYY6FDXEolJWaWVEe1JMlquk7fN5nnHLGZe
         vl6PC7kb5n3qIDJdP5DgERpxMUCaL2fYSvwHCy5paxnI3u9JxzK12QSC1fWK1B0/mhWL
         yHyPHY4iBtAL7FBEGHV7yGaccsxoAIB7a2RuTJIQ0pGB5I6KZd6hGtLiu+tjbZmKNsfF
         I9a7ne6BgLmi4RzAuvUhPmI92/ui6dAAUqOnZwlyNe8DONL66ZzcD23JI6PCWTZqSU0z
         3MggFyenClWKsUgdO4uxQNmLbritSCYeXM+fcHpXDDD/QXoY/ebt+gDtlhiJYgC1tDCa
         bJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pwu5pM4dbgTBood6EBI5joCOsJM78eFvHusKdHfshs=;
        b=DQ3x2fGCN1Vaz89+KENbouBnA+SU8rtRHM8nC0GGKlRrkmUAy1z4k9cQi9e6wENIbK
         crcBkEa76Caco2vE0Gfj73Xo6NchrdrJMwfwtQ1XO5p0QdaAwnZx87MBw88a3RtHdoQ3
         zXz8IMmOitT7ypt6Vh8HnskWF+a1dcYGf+tR6DCqj+gdBQAVKz7mc1NFvZamlIYATLVj
         Hf1zt2PPgDpbtT09eDFBt3FwX3bgPu9yqK2a/ocVJMHAT58S7q5dOhKT7VQyTwQq4ib2
         3Pdc1ahbiqMXnjS/xZA5TB2IJKgFztVhRS1WVbpaL5o8rBLQwIEjO2MIJaF9uxPKRlG8
         lZ4Q==
X-Gm-Message-State: AOAM533q4J+1rCF8yI9dgzNmI9XAub2eMjgvfCob7RQ7PCsAKI6CRygI
        frAux4f9BwWQgKQrdCBg4SMDVGkxI6YYUg==
X-Google-Smtp-Source: ABdhPJxN5J84pzXijlVT8WSK7KaHe294q7cpJdO92cn76gaQ1PY9YE2clQRaBBJFzObkrISJSL6JTA==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr15925668wme.66.1624099647418;
        Sat, 19 Jun 2021 03:47:27 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id w9sm5506667wru.3.2021.06.19.03.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] staging: rtl8723bs: remove unused enum items related to channel bonding
Date:   Sat, 19 Jun 2021 12:47:06 +0200
Message-Id: <aee2c78ea50a0bc24c114853500bd44c358745aa.1624099125.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused enum items related to channel bonding.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_rf.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index 98bc274e5e81..550471637315 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -98,14 +98,6 @@ enum {
 	VHT_DATA_SC_DONOT_CARE = 0,
 	VHT_DATA_SC_20_UPPER_OF_80MHZ = 1,
 	VHT_DATA_SC_20_LOWER_OF_80MHZ = 2,
-	VHT_DATA_SC_20_UPPERST_OF_80MHZ = 3,
-	VHT_DATA_SC_20_LOWEST_OF_80MHZ = 4,
-	VHT_DATA_SC_20_RECV1 = 5,
-	VHT_DATA_SC_20_RECV2 = 6,
-	VHT_DATA_SC_20_RECV3 = 7,
-	VHT_DATA_SC_20_RECV4 = 8,
-	VHT_DATA_SC_40_UPPER_OF_80MHZ = 9,
-	VHT_DATA_SC_40_LOWER_OF_80MHZ = 10,
 };
 
 /* 2007/11/15 MH Define different RF type. */
-- 
2.20.1

