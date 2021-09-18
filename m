Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F55410816
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhIRSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbhIRSUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA80DC0613C1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v22so38704849edd.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVr0STWCT0vadAEVLvK4H+2tlmiDZVUwHL67IoyY9r8=;
        b=VCVmtb0TFnWO/1falwfaUyiXlF6Pt3ZHyAg4J6uo/+MfGvsiAwL+w+O14gIOSsnTyG
         P53tFl7clW7GLp8mhzYdia0xJOobVYqslIStgF0sC+aJbZDKuY+m68ebEy6oU7Kzykx9
         z9Uik929H+OZR3wq7xrZKDT9OBnrHXbd1dJ0zm+wvwqE3le8gs2fnauzsmhFXArtdgkz
         L9m+AW9CFP79zg2qLcCRMm81GHULRcXzOjArO7dKDDYzHohHXXGrp/aAyrmbr0LXMjFc
         4g+9u6vp2sC/s+SaKJ65w1hDRhNPH7GuwNR84LbV5d9AEJptGTIYhuQ6l1HP8orvvRiX
         bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVr0STWCT0vadAEVLvK4H+2tlmiDZVUwHL67IoyY9r8=;
        b=FNBGEpyWnBMQbDWSsYeTE1wJ/iJ94fXWwApF91/2WMZMxibtON/NpKrv40N8ykIZm3
         61+yhEwthLBlt68TZNOEwQpUPZgtU0XMuZPuSbD6QyDtV8Y3QUlj+ph1T1JQxecYpC6p
         dQ7ZFIibzBvsGAuuSEBHVmhLDR0c16EEm7d1RXu8Y6TDSXmAqDH/hoKRpYMwMQSWnh0e
         hF+IAdX6FAJP5KFZ0qmA3L//nEISHtGMmKJxL8Shs+pnUVWGVa+dEGZQ6XWuK8MVYpTL
         1OC2/zWEbs+dmAOEdlfScjqenlDF797oDC+drhpRF/8WJG3Z5m/RGxlmbCXm0ekRWK2p
         bjnA==
X-Gm-Message-State: AOAM530TyFh8tWKNyGhG7YOPXiiIqgRXb6A8+R6qass5JjmlswVbEmHT
        9s5fTdZWo/rpnrIylJhLl0o=
X-Google-Smtp-Source: ABdhPJx3MB7iexYfdqJsglrWc0ydXqxqBGCPW8g1IUjSMTHga8hn7ZU2aTNxgM4+krbMFjiJ4jD5lw==
X-Received: by 2002:aa7:db17:: with SMTP id t23mr20410178eds.387.1631989169320;
        Sat, 18 Sep 2021 11:19:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 11/14] staging: r8188eu: remove macros ODM_IC_11{N,AC}_SERIES
Date:   Sat, 18 Sep 2021 20:19:01 +0200
Message-Id: <20210918181904.12000-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros ODM_IC_11N_SERIES and ODM_IC_11AC_SERIES are unused now.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 265583a43494..0d85e4fff6be 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -460,11 +460,6 @@ enum odm_ic_type {
 	ODM_RTL8821	=	BIT(6),
 };
 
-#define ODM_IC_11N_SERIES						\
-	(ODM_RTL8192S | ODM_RTL8192C | ODM_RTL8192D |			\
-	 ODM_RTL8723A | ODM_RTL8188E)
-#define ODM_IC_11AC_SERIES		(ODM_RTL8812)
-
 /* ODM_CMNINFO_CUT_VER */
 enum odm_cut_version {
 	ODM_CUT_A	=	1,
-- 
2.33.0

