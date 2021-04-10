Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72F35AE9B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhDJO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhDJO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:57:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4902C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:56:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so7698403pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0TGpMHgPIfxwquihKnJpBKaC4RMUZ2v7oFEWg7Mcab0=;
        b=Zrx0F0knYCjj6b2nKA8VbMAMpWQta5nUHIvTUZf1ttbj8OeIOQBqtIPvk/xrQdNxsj
         6+Hx8V+YpEI1dehE5kVzX+GJKcmG/haur9hHHCK2Rf/ZKcfKKlNjyUZSyLz8QWkzpBcL
         W8dzf6fq5X3Itg4DqhDnvixq9jNfIsCHsa4/Icgfrb791LtzjGJ4TSYk5WXVJIOuBP5P
         pSViikg0pLSmIf1TeofAgvE+kdqfFa/cdxpFTwnPqjsvshi2613/5ruardWdzuMYRat3
         hReNHAAG63aXMr74unwEZv1pBenROlXLFDPOv/Bu6tWCog5JKW4Em/hvCv/rrdU4o/Sc
         sYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0TGpMHgPIfxwquihKnJpBKaC4RMUZ2v7oFEWg7Mcab0=;
        b=jhEzffh9RMbEsNtTyKM1tMGVywb2KRI8A5sfJv6KEYDoeRqewHK+fOoMhDoP9PUfBl
         vwiHMwwb+AnRvEfg67ToNSgHl7Fqpx4Ejq9QPkjVyeS8IXZNr4xYOY+22VQXSko2TK3V
         NwCAyCaNOJdMmxPfz7LxkzTYCnP2K5HW/uoinIDSjv8MaEVy4Aj43V24XvziObT8ee8a
         u/tUDzv54PLWG/WM/wPbIAWtYpX5ZLAOmvz8OU8CFoGUh6p02Bc6Ksy3/jWzleyT8H3B
         DFw2W9RY/CSo+d5kdCG+H4urr0kcT0L4LJWZAOA5kBahlF2RPJs658XjCdSY5XvMh9rO
         AhKg==
X-Gm-Message-State: AOAM531X0x2R94VpLOMHzvE4wNu8EGTJ6UXC+Ih+Nwaz6ChPTvDiAmc1
        bzWQSsKvMTwkd9nDepVf+64=
X-Google-Smtp-Source: ABdhPJzGBm4qq6eDo/9Bt0Gy82xz5/48yUG3qIXicy6em5pcNXw6xf+fxv+t+UrsBhGYDTwqA7egCg==
X-Received: by 2002:a17:90a:1b4b:: with SMTP id q69mr6854213pjq.188.1618066609328;
        Sat, 10 Apr 2021 07:56:49 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id e9sm5827703pgk.69.2021.04.10.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:56:48 -0700 (PDT)
Date:   Sat, 10 Apr 2021 20:26:40 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4] staging: rtl8192e: fixed pointer error by adding '*'
Message-ID: <YHG8qARLUX2KPWwI@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed pointer error by adding '*' to the function.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
---

Changes from v3:- added reported by tag in proper manner.
Changes from v2:- changed the patch nody to describe changes.
Changes from v1:- added pointer to the function.

 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 4457c1acfbf6..78b5b4eaec5f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -327,7 +327,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	}
 
 	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
-	if (ppTS)
+	if (*ppTS)
 		return true;
 
 	if (!bAddNewTs) {
-- 
2.30.2

