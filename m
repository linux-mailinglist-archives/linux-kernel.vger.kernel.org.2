Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A397C416E69
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbhIXJCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244555AbhIXJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:02:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B19C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:01:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so5995189plk.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N33O/jKwx1/k7vQIGoBJU3vb76C/gdsxbsKwqC4sYls=;
        b=YXJldS4amcDjJYuwv2bcpJ7XyOA9FJQqB5WdGnqLDTTA91dcXGPJ2gb5W83qLJJAFu
         /EvWkBl80iVjDd/m+kUnPBHyNxQ3drSIA072GXDPYaPwRDJNVgEW43afoU5IPfbg2cRh
         qujLb0MEJm3qW8LGXLx23WuLDHtfAyhpUXFvR4DRTWsfr/4lXNWH2unArpA6b9240KK9
         MniBHbUzNw+iOG3sncGiYz0clVvmg8knRQzYZRuuU7HyWveLXPh3wNm6CBuugexQIoNW
         wgtX0ar22j0z2OsM25pxuEiP6dlys39H1v3193xFjz4C+gukS5tvJu0q4GyN0OHWcjpT
         28pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N33O/jKwx1/k7vQIGoBJU3vb76C/gdsxbsKwqC4sYls=;
        b=QWWlCozh8/ufc7NWbBJtfruPo7LW+hSDCDVPRhFvw/F7PitVASk7KtlqG2mRzWNxg3
         94tqTVgMDFulnSRuSR9CKvg0xoqo/6r1Tng4X3Mj0qXF8Co8purOY+kl5VRz6jdJ5lqq
         80AnSVGfUUW10ctjmsXXwoDh8Bm08YbcIYVDCSHF6V+IitgdM+f6MpewpRdfTYF9kqWE
         me5JD18Oq+Y+zREFD3deCLXLH5Ozr4YaFAWqFum87nnjByNfZTXdGRfTUtwBBOSqIGkc
         5EP5iEhubO1/TkeQGbIOgHpgx+deu7mDj4Bo2cAGJOpCkAl+KP2zmp9+U2vE0W+FBSIX
         lUeA==
X-Gm-Message-State: AOAM530JA2xIyHeIF2fDuA/7QalTDT5eD5/yO1wkaNrnxfzzbMRocnwZ
        4wMK1HaGuQdJ0qkwV9visDg=
X-Google-Smtp-Source: ABdhPJyaWHESTzqq6ZcM7drgTMPa+u6iLdm9UzjoGLHzNYMAh3mvYNc5WE7b5yo7vsPBH6gHdG+ixQ==
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr937005pju.227.1632474072089;
        Fri, 24 Sep 2021 02:01:12 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b142sm8501848pfb.17.2021.09.24.02.01.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 02:01:11 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pstore: Modify kconfig to align text
Date:   Fri, 24 Sep 2021 16:59:22 +0800
Message-Id: <1632473962-29686-3-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1632473962-29686-1-git-send-email-zhenguo6858@gmail.com>
References: <1632473962-29686-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

Modify kconfig help for text consistency

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 fs/pstore/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 288ed3c..008ce38 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -4,15 +4,15 @@ config PSTORE
 	select CRYPTO if PSTORE_COMPRESS
 	default n
 	help
-	   This option enables generic access to platform level
-	   persistent storage via "pstore" filesystem that can
-	   be mounted as /dev/pstore.  Only useful if you have
-	   a platform level driver that registers with pstore to
-	   provide the data, so you probably should just go say "Y"
-	   (or "M") to a platform specific persistent store driver
-	   (e.g. ACPI_APEI on X86) which will select this for you.
-	   If you don't have a platform persistent store driver,
-	   say N.
+	  This option enables generic access to platform level
+	  persistent storage via "pstore" filesystem that can
+	  be mounted as /dev/pstore.  Only useful if you have
+	  a platform level driver that registers with pstore to
+	  provide the data, so you probably should just go say "Y"
+	  (or "M") to a platform specific persistent store driver
+	  (e.g. ACPI_APEI on X86) which will select this for you.
+	  If you don't have a platform persistent store driver,
+	  say N.
 
 config PSTORE_DEFAULT_KMSG_BYTES
 	int "Default kernel log storage space" if EXPERT
-- 
1.9.1

