Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31A381EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhEPMcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhEPMcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:32:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D4AC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:31:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v14so70378pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0xy6PuUkITlQEfoESlbsWn5gMjHl7FnBihh8mzNu6Y=;
        b=s0wviXk7J29exHWufG/uNNIOdvGY09XnUQ5x82bdMbQp4sekj42F1o5BcwswmDkE/O
         Lfz3MRYdNpAzFBryF0SntQWSEoGmnJ7YD9MDlmjL3J8uTe1Q1iG4qR6wBjRw9JAr4tnZ
         8w6wbNPXMT0HnLQLTJ3jyMbV2J4IlISs9ADKHKY3LBenoy/J3d6jwzJ0aBBX661uD/98
         n1XpSAPvbHt/nQRWJJ55J9k3VLqszrYg+0+PP+XkdNchJh78NjZZeLbCczHHQeHAX/WZ
         luSrsSWQFP/c4Jct0/MVoHZfsKBdwofBw6UB7DfpkHByVHzBRdZHlZKD2N4m8riTgrcA
         qlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0xy6PuUkITlQEfoESlbsWn5gMjHl7FnBihh8mzNu6Y=;
        b=lsS9060DV99gOiW4qlpx9MCMeBe4Xa9DZrQuam/O23N6jCJSH4FIC3J7jT8pkdthdS
         gjGlRmPYjdWM+cC49x6jsdz2PlgtB5+zVSJmOzSqEQc5s61ZxcSlCTWJLl4aJ8DQRLk8
         LDv6zOWprETxI1feQ6UjEwubshZBJuuCa1BN7uT+h4pTNYhNfuTk3tqfVra//f3YGqID
         c4Ka2QNZB2pgWmJIaLv2BMI3bovO0VZmr3wsizTtKAFhjPOGZqhAyPNQjkuTofQXkvEx
         LNrzlFBg1nyCvBTXPSIOGXhXyvyVSYyDiTsLbLzgopt5Ozt4UQnNMvd3TPmuRPcgF/Xl
         wJ2g==
X-Gm-Message-State: AOAM533fPaqBVXGVWnkgL6+0HGU7ukOaag7FTG314pikWZqfSDKf/6f/
        RRiAGkf9tNdGrV4iMCen9VnAa3p5XBkE4Z5qL2KdwA==
X-Google-Smtp-Source: ABdhPJxPq4HzW12Ya8whpnivanq2aAPrdMRCl7um6mnlk7hqM0KMJHtih/MYIonSSJ+A8X1G25nt+w==
X-Received: by 2002:a63:7e46:: with SMTP id o6mr37834009pgn.38.1621168277199;
        Sun, 16 May 2021 05:31:17 -0700 (PDT)
Received: from localhost.localdomain ([111.223.96.126])
        by smtp.gmail.com with ESMTPSA id k186sm8004318pgk.82.2021.05.16.05.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 05:31:16 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 7/7] Staging: rtl8723bs: fix block comment in HalBtc8723b1Ant.c
Date:   Sun, 16 May 2021 08:29:27 -0400
Message-Id: <20210516122927.1132356-8-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
References: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl warning:

WARNING: Block comments use * on subsequent lines
+		/*
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index cc7f558903ac..87156b2cd1f0 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -2511,10 +2511,10 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		CL_PRINTF(cliBuf);
 
 		/*
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \
-			pCoexDm->errorCondition);
-		CL_PRINTF(cliBuf);
-		*/
+		 *CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)",
+		 *	pCoexDm->errorCondition);
+		 *CL_PRINTF(cliBuf);
+		 */
 	}
 
 	/*  Hw setting */
-- 
2.25.1

