Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E1F352E68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhDBRbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbhDBRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:31:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48FC061794
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:31:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so5319556wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4NOQ40eCPg8Q1I8p5bQHujhK6KmyMiT4frAX1MUQD8=;
        b=HZN/9/DZYsG6zjpWQCoPqvBmoZ4KmMdeGa8DFpBMAGiwKf3TpAJW12Ejftnrks3Tvg
         NriT2pw+Mr56vsDj7/joHpQ+M7ye4S73x3B0+J4mfhB7P5u8wkVDqKwwqsXI7NvlLpaL
         ifxKAxI6eoOk7QQDmwGvhHAs5uxnrL4I2e0BcI3aCJbCKsvhtB0ZO35iZL9Zq5ZTDIAZ
         6eCQfLzQ9fKAvP2uBUDeGqUV8+MqiHGHViDJb3PcIrbRz8Tyk5JHPoFKmZssMJsjlUfv
         uVRhKhFD/tgyEfrahh8CPZ46mej4jD6miMtrMgD8ocw910dqHKyKa/vqplpHNhXE8FF9
         4Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4NOQ40eCPg8Q1I8p5bQHujhK6KmyMiT4frAX1MUQD8=;
        b=LK6t3ZQ/oiXfrN3v9fvrTyGeux5Y2mR/NlxckxCxPWB1UkWX1OtovSJEbsdsd67fPq
         ADP7nZIqBOKkiS4Xuq2pl3RAafXl/tWwPjbbFUV8HWJqKWfWe72UcQ0ubON9AVLZ3rlI
         HBxVA/ko/NLPQPrzIe6GLAskeNL81pXrLcG6882RAxYBmX+oeLQ8hJC4+UQQtojq98GL
         H53nE+huTy2hqY+2Z7rSxEHzKMxinTsc01innD9tdLlXSOXLOif7JPOUP63LDMuXDfkO
         Q87tUw3OkftUYasEcMMEnCaoQWd0iIze7SqacLQQmN09WT7t5g/onP3fzxIkYqkDtHIH
         Rzqw==
X-Gm-Message-State: AOAM530WoScI/TIElKYldAUL1fxxMPwpjKJNPxOTRuQa2LA966hAiuB7
        2surNTxDo0tJGlBywmxV6+3DL57EGsrAFQ==
X-Google-Smtp-Source: ABdhPJyHBteSMSS1GvLMoC6NMmXrYImukKgkkVPK4nB0tfGzSEqODUKQcj6Uuf/dohSelfvk7kRH4w==
X-Received: by 2002:adf:8b5b:: with SMTP id v27mr16264402wra.153.1617384659544;
        Fri, 02 Apr 2021 10:30:59 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id h8sm15260375wrt.94.2021.04.02.10.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 26/30] staging: rtl8723bs: place constant on the right side of the test
Date:   Fri,  2 Apr 2021 19:30:08 +0200
Message-Id: <39a8bed986ba0e6ff1968d5c77214e627323af36.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix posst-commit checkpatch issues:

WARNING: Comparisons should place the constant on the right
side of the test
40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:71:
+			if (_SUCCESS != ret)

WARNING: Comparisons should place the constant on the right
side of the test
69: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:122:
+					if (_SUCCESS != ret)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index d4920d7d2452..f8c7dcb7ab7d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -68,7 +68,7 @@ u8 rtw_do_join(struct adapter *padapter)
 		) {
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-			if (_SUCCESS != ret)
+			if (ret != _SUCCESS)
 				pmlmepriv->to_join = false;
 
 		} else {
@@ -119,7 +119,7 @@ u8 rtw_do_join(struct adapter *padapter)
 				) {
 					/* DBG_871X("rtw_do_join() when   no desired bss in scanning queue\n"); */
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-					if (_SUCCESS != ret)
+					if (ret != _SUCCESS)
 						pmlmepriv->to_join = false;
 
 				} else {
-- 
2.20.1

