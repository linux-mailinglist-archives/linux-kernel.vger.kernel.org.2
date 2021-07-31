Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2A3DC209
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhGaAjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhGaAjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEE5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c16so13339595wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8H37xNBSGIOnEvnHiZeZ4kxx2fU5DnigwTZak5GvhE=;
        b=NIg5UHvTH6FALDSE3+pA6Qrj0S2z5qaDPCcc0Foli8P6IGIStfxYvLpRGT53osP3Rj
         pHDrPpxHyIEJZdgXXLPwfL1HQgnMGbT9Zj1B2iEkzBr35aqL7Fpvk82Ik/UkOz5Zi7KM
         7Ss8s0nL5+DpaZLLPd/08iGWRN8RZ4o5OXjCF96Kbh39ygRw3B5ycawUosSa6xsK1muN
         EUs2zA/mwrSjbdjDFd6dHoS50TapXqyFcA900uwBtd788nj/fbC1Bym2XL20+5vGxZoV
         Q++Zde0M+bqnSRFobYRN/ETi1oYPafdNALiLdHZ9cKZeUpRwmtF751YeJ6+SG90CcHIv
         ALsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8H37xNBSGIOnEvnHiZeZ4kxx2fU5DnigwTZak5GvhE=;
        b=a9SRYsBHQ0P/AKy47uswlqt8vNI/JRDJMpaNldZElahywJ/+8sAwiqnh7AV8kFKMXG
         YiFZ0OzkYteTkKEnKY8K8OS93acWW4up8WxGUm73148q6rhvuH4GFYiAycPHltT+qfkt
         hNEYQBkFE3Swu36uqgvC9q6rWSJF2wumpl0y6H1C9r4RUNlh7B+62XQWHzUBXpxzqUHf
         7FhSVjvuJWCfJXqBe56H/U9svEAA4tUgk17Pks9pPCp1U+LP+hxsv+7/NTkiGLuUgjKo
         iM5sPE2ZR+7HaWIrJUPvhZjzdQ9zwIs8Ug3SDdQdCf5ev9XmfYWobvBdzf9n08gEEvEt
         ZPig==
X-Gm-Message-State: AOAM5304ssPgwfOXr+zkrxJ17RphgUZB+6dpcNm5lQJv+If9OAOwIYbE
        XbZQxDuUFmQLVRekbOi7aV2Ja8i1mKzLyG6qayE=
X-Google-Smtp-Source: ABdhPJwvBFx2hNfJ6C7GWCkka+1RfZ91xCNoSTZAkI6qG5AhnlQp9V8pzt7hmMf8W35dcR/9m4NYKA==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr5717643wrp.3.1627691982351;
        Fri, 30 Jul 2021 17:39:42 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:41 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14 resent] staging: r8188eu: remove ODM_RT_TRACE_F macro definition
Date:   Sat, 31 Jul 2021 01:39:27 +0100
Message-Id: <20210731003937.68615-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE_F macro definition from include/odm_debug.h, as
it is called from nowhere and is therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index c11d8925952c..ef0d6b84b2d5 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -90,12 +90,6 @@
 		RT_PRINTK fmt;						\
 	}
 
-#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt)			\
-	if (((comp) & pDM_Odm->DebugComponents) &&			\
-	    (level <= pDM_Odm->DebugLevel)) {				\
-		RT_PRINTK fmt;						\
-	}
-
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.31.1

