Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D635380FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhENSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhENSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:23:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69C6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:22:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c13so335304pfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:in-reply-to:references:from:mime-version:content-id
         :date:message-id;
        bh=4Aj3Hn/Ab05PL29sTHkKVf9z76S19KL7h4dk2AQuwq8=;
        b=jAL5X6A8XQBSGFtmDTzuws24As6O0mocq82MKaf6rbuWJKOiU2QVhSiOdbUysBOXeQ
         YBS2nlE9udGS2YLJ/dImfKJh8y9Wu0TH+vx/cQOp+c91ySTtx4UaGB29BbM1ZoKiFb0Z
         iIkYBAhRludCW6E6cN8Zibj6qCm8o1wkLSWQQp1RaBCdo5JVJKhoMAUGyk9rI6Hr2DrD
         yQBE3LRijDJADZWx8SlZ1Lzf8EuB9P0yxwOamj2LiIPgUz0DWXt51+0MhJeaqEG7Oxta
         hkPoYtazZWY47/JRfyikrXVqH9g2IAjChte67fn67woJMRsukYqgANonlbQuSLYa1QMd
         Zw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:in-reply-to:references:from
         :mime-version:content-id:date:message-id;
        bh=4Aj3Hn/Ab05PL29sTHkKVf9z76S19KL7h4dk2AQuwq8=;
        b=dtfLG84CYVQ5VP42svBrE/dYhs+uclSy3GI5G+ICoq8UKIeI5ouW/9QDhqzhQuUcAk
         jgOtCa6Ye+vtr2FNDpI25tB3JvHBacGMXBsZPjTk7dl26Tc19dhSZy8f7mLQXIA+C0IP
         GP2wUtKX+gjBAH4jZKTACMwTQnG7QLxjpJ54ymbxdUOrl3gM4OK0eNaKcnwKpTKvTLoA
         MIdIf8MdoJofm0k2O1aoVTLHcdHFNP2OFmTfg4wgXiho4ZDMNmAO4mO+VVsBMjEL7hQE
         hIQ1aSDXfHgQVrqGAhKemG5X0pbI/9OUA53gBQ7lSx0bPIUVscn+ywUZRkdhgoowZdww
         dNYg==
X-Gm-Message-State: AOAM533Kaxgv48LPNJigSsjFRovL8Kr0B22zU33cXFeq7EIxSvZ3ByeJ
        HGnZDICPt4bfgm2JFHiGIdsW4Y96h3Y=
X-Google-Smtp-Source: ABdhPJwtF3QDVFdaE2eNna/7mOJ7c4pj7bLQKwosCJX3DnTvR245E3w91uVG9tTXZSgxPfCPOCMgqQ==
X-Received: by 2002:a63:ff48:: with SMTP id s8mr2290861pgk.132.1621016566357;
        Fri, 14 May 2021 11:22:46 -0700 (PDT)
Received: from jrobl (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id x9sm4610878pfd.66.2021.05.14.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:22:46 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1lhcSS-0005BY-Q8 ; Sat, 15 May 2021 03:22:44 +0900
Subject: PATCH: Re: LOCKDEP customizable numbers upper limit
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <f323397b-dbe7-b655-4624-d243c2f68d81@i-love.sakura.ne.jp>
References: <30795.1620913191@jrobl> <f323397b-dbe7-b655-4624-d243c2f68d81@i-love.sakura.ne.jp>
From:   hooanon05g@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19934.1621016564.1@jrobl>
Date:   Sat, 15 May 2021 03:22:44 +0900
Message-ID: <19935.1621016564@jrobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa:
> Please submit a patch that avoids only BUILD_BUG_ON().

Here it is.

J. R. Okajima

----------------------------------------
commit 43e103e1a5975c61334811d16e207e6d0ac57b77
Author: J. R. Okajima <hooanon05g@gmail.com>
Date:   Sat May 15 03:17:10 2021 +0900

    LOCKDEP: upper limit LOCKDEP_CHAINS_BITS
    
    CONFIG_LOCKDEP_CHAINS_BITS value decides the size of chain_hlocks[] in
    kernel/locking/lockdep.c, and it is checked by add_chain_cache() with
            BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
    This patch is just to silence BUILD_BUG_ON().
    
    See-also: https://marc.info/?l=linux-kernel&m=162091320503900&w=2
    Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: J. R. Okajima <hooanon05g@gmail.com>

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580e..999ed5aa6bcee 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1390,7 +1390,7 @@ config LOCKDEP_BITS
 config LOCKDEP_CHAINS_BITS
 	int "Bitsize for MAX_LOCKDEP_CHAINS"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 21
 	default 16
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
