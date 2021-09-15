Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8340BE79
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhIODws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhIODwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:52:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383DC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mi6-20020a17090b4b4600b00199280a31cbso3377147pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8ZkYRXsRtqqRT59vuj6cpuh5P+Fz32RUnsmAVG+0rA=;
        b=d47HmhJh2i+XqKgtsSAM5hqHs4cdiowd47Bg50QX1YDkQZhjYs5Evh1xhZATOYtrIp
         wC2RJZyW4qmMUleIV0GNp++Sy84TRrOdt+/ieV6HOKE3Ip34xfF0tAnaKnEflVwXGK2W
         tc+Sm4apj7S3KWcTADy5vO3s7SR9Or04aNHQResNB7GNUNASnsqHqniO9uxUlfGrvTfz
         qnUOjPHIe40xuhzKTmrKy83y2ZcFOj1swXFR/S1hke5s6dVBYby47OFL7MyazHy6C8Og
         u5MyO6IwCRaTNQR7fCZDLnZbahiyxkCZ9k44t6nMFIKauRkwBUvfpyp4U8uTjfhNfLvf
         fYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8ZkYRXsRtqqRT59vuj6cpuh5P+Fz32RUnsmAVG+0rA=;
        b=wFUDLjqG5BELzuj+FDfwFFvdUivTzDb0Gzjs+lBPuxzyLjSulsawAKgh4sdjIHaUvz
         Wk4n3qn1sIsb3MJyG1D/D8NalTn0JK3T7JZj8Ldebtu8c0q4Y5Q2F9F8W6ggEw+5/KpE
         wL+mtXztkCvFQF7Qop342XIk8fHFINkZuKtUYzLi7ASEtTz1OXIrdgSdoxNdB5KVUAiv
         D8OYymH3u41gCpT2zwMn9JJjdHhljhutvzNN7qWp6KH+Y377JBCc2vUZ+FLANEG3gp7v
         nmpc2p9CuLbdv7VNQ5Wws92WwsVb29jZTLnkJmJA6Qp/xlYNIMEuQKeCRQEv5sAuTBtM
         kmbg==
X-Gm-Message-State: AOAM533OQEWXCpDGMkMntlOVsTx3ca/LDacSLYt0cXDroeEyV0ZrRPvg
        YtGq8MvyEdLidTpl70oepKyu/jvf/g==
X-Google-Smtp-Source: ABdhPJyv4AQmjJA2thsDzuHJOhX/obOa910VjelhhPA6OliCpDKGoOTDXwqeaSRu3nUOVs5QIglWIw==
X-Received: by 2002:a17:90b:3a8c:: with SMTP id om12mr6041949pjb.137.1631677885292;
        Tue, 14 Sep 2021 20:51:25 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x13sm8602357pfp.133.2021.09.14.20.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 20:51:25 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 1/5] kernel/watchdog: remove useless WATCHDOG_DEFAULT
Date:   Wed, 15 Sep 2021 11:50:59 +0800
Message-Id: <20210915035103.15586-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915035103.15586-1-kernelfans@gmail.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since no reference to WATCHDOG_DEFAULT, remove it.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
To: linux-kernel@vger.kernel.org
---
 kernel/watchdog.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ad912511a0c0..e2a9e3331416 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -30,10 +30,8 @@
 static DEFINE_MUTEX(watchdog_mutex);
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
-# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED | NMI_WATCHDOG_ENABLED)
 # define NMI_WATCHDOG_DEFAULT	1
 #else
-# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED)
 # define NMI_WATCHDOG_DEFAULT	0
 #endif
 
-- 
2.31.1

