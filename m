Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E633B3A05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhFYALs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhFYAKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7623AC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c22so6271068qtn.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iG8OE2YL93AHo70uxA3LotH7fRVYZCsxjgZkGVOHDLs=;
        b=XRWwenZ4jCzP3qbRv0foN9alEDDPKJ4qjeunrPnKMedVI4l7LFz+pQ15QOVzUscOC+
         HRQpOuu6dbUTSCPUAPBUqnp00GgQ+3UTMrdoKTyZPn1VfTLi9183ROd+jqgoLdB4nxZr
         VzBuKBqR2tRfJQTPtuwNiActgcG8DqXd0VyBPkk1VbHQ7VDn/rvaEHgTRsYX/uJtMStd
         6gNos8ZphDq8N6NqYLff1xiiRoeKJ4Jh9YYlW7UGeVmst8QbOn3GqyJBatmKMnOH6iS5
         +ELifqECCvj3DK+8g7PQeeNubJ2IuB9EDuvd33aFl3Eg4QxoFUBo4/q0IqTDPoZu9jjk
         8R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iG8OE2YL93AHo70uxA3LotH7fRVYZCsxjgZkGVOHDLs=;
        b=OQqtEsQofMit0f5SFK7rTow25iRgzqPLmJoYG+PWy1zocYqGmF9M6ImLm1smixv/Jj
         UfYPwRPNTBUTfqIQiRggfC47n5oVaYatocyzZktZFvT5Kbj6VQoALmis1xqv4No7u+D2
         R4/st70bkO/NKIvfsUkroBwuEpKbYua8ONfiOMls31mcXf3PkwHMx6661ecHX3Axq384
         yrTNnytkc9y2zhZAI0BWVsYchHUOQ5mAssSxlLZb2nJ3ZCjZjt5JT13w331P7+gd9Cca
         smTCpMW7gst9xS4YSMbz3wxCClK1GkWCaL08DO/dK2ZB2xuQCjEVCFV2SOH8njh2s9xu
         VFQw==
X-Gm-Message-State: AOAM530K7By9MfrVBPkq/LAgiy1Add50HYPoHURpHCJ3MjPYcTmMt/XP
        4jnzg4+g+8mnA99dg2pNGQzR5g==
X-Google-Smtp-Source: ABdhPJyxosQipzIQEh0h/nJiJ4n03VESVFxoh8uhwgzOW7YkySb/ZlGgsPWqtknmacGnvWCetbNXvw==
X-Received: by 2002:ac8:5383:: with SMTP id x3mr7047929qtp.278.1624579713673;
        Thu, 24 Jun 2021 17:08:33 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:33 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 22/23] staging: rtl8188eu: remove GlobalDebugLevel variable
Date:   Fri, 25 Jun 2021 01:07:55 +0100
Message-Id: <20210625000756.6313-23-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove GlobalDebugLevel variable and all of its uses, as it is now
no longer used anywhere in this driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/odm.c           | 2 --
 drivers/staging/rtl8188eu/include/rtw_debug.h | 2 --
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 73b63e2ea0ff..ffc5394d5bb9 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -10,8 +10,6 @@
 #include "odm_precomp.h"
 #include "phy.h"
 
-u32 GlobalDebugLevel;
-
 /* avoid to warn in FreeBSD ==> To DO modify */
 static u32 EDCAParam[HT_IOT_PEER_MAX][3] = {
 	/*  UL			DL */
diff --git a/drivers/staging/rtl8188eu/include/rtw_debug.h b/drivers/staging/rtl8188eu/include/rtw_debug.h
index d6b7975e59d6..0de6d7ba5d8b 100644
--- a/drivers/staging/rtl8188eu/include/rtw_debug.h
+++ b/drivers/staging/rtl8188eu/include/rtw_debug.h
@@ -54,6 +54,4 @@
 #define _module_rtl8712_recv_c_		BIT(30)
 #define _module_rtl8712_led_c_		BIT(31)
 
-extern u32 GlobalDebugLevel;
-
 #endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 950d70978856..da372936a64c 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -140,8 +140,6 @@ static void loadparam(struct adapter *padapter)
 {
 	struct registry_priv *registry_par = &padapter->registrypriv;
 
-	GlobalDebugLevel = rtw_debug;
-
 	memcpy(registry_par->ssid.ssid, "ANY", 3);
 	registry_par->ssid.ssid_length = 3;
 
-- 
2.31.1

