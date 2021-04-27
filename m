Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6742736CA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhD0RgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbhD0RgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:36:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC31FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:35:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i12so29250026qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+QGPYbxobfeQxK0jn98WrOMoiBnvgireYHZ1wTCSPlU=;
        b=ew//Gw7SvG6ErOdFWXsbq7SxdH8ASHh+AfW8JJ+gF9kql7r/7iv69z9xV2QvHwPsf8
         J8YLZNIFDpzvp0odYKELiPyhUxn4FLglqkkl3Wwo98j7wV2kWYwqW+AmIJ7rLbXHZDM1
         kiNtwDZfRlvlTly3/rS7AdSdMKr9Jk+AcSP/Cne5lANEdpV7+n+j74FOvDUOOi+Z7sWA
         ekOtzx9Y997/31kmMr/TLDUxEGXM8GmoMudqlPacNNEidQZt+tmMqeLjqgTobcksYbaL
         ao1feNFpelb1guT3jSvStcf0OnMVWyLh2+S8KeuEkk+xq4/JHfc4p4Mi5WZE3aL32oFW
         tAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QGPYbxobfeQxK0jn98WrOMoiBnvgireYHZ1wTCSPlU=;
        b=AvWXP+WdN5vOp7yU1ib74zqnpGCGWnM7hn7OcXljm2bS5FHUZXho90cdw6VoBsJ4cI
         2ZNtEaXqp1j9Uli2Fr0A30bAvY/JY9BFf1sQkMx8nxqKC7oPPYxukeuiqG1EZvmjru2l
         nbdIl0IRLnmiph74IjOlLV0Jiy93FVQbNo30CIgPT9AfUXa9HBliDhwjV0Ab3JM7YFtJ
         9z7G41JKUVEbehN+zdFLB6ORHUGxveT/tV2YZ5kqjhFO1QHzj5fkgNGjNzhhB6NsJH1i
         hl4P0axrACqjWMRQUFTpDwx4XGQ2zvPkHDXnZJkRspx7DBOjS6FDY0aNwowqOZVLk2NV
         Eu6Q==
X-Gm-Message-State: AOAM533Uie4wJPX82tMvhzrPdDPha3+n4a9aAGNq0AeBDqZpk7o0RvPh
        sv2tKLOUx36kv4MZz6sRIoCEGA==
X-Google-Smtp-Source: ABdhPJwEesBhW9IhFF3iTZ9jppuBrmIUNPsDzrM1x3F3bDo1mBDsc+WsvDqo278e08EswGlC/2OznQ==
X-Received: by 2002:a05:620a:579:: with SMTP id p25mr24373136qkp.95.1619544915963;
        Tue, 27 Apr 2021 10:35:15 -0700 (PDT)
Received: from iron-maiden.localnet ([73.251.9.172])
        by smtp.gmail.com with ESMTPSA id h188sm3238952qkd.23.2021.04.27.10.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:35:15 -0700 (PDT)
From:   bilbao@vt.edu
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        dvhart@infradead.org, linux-kernel@vger.kernel.org,
        Carlos Bilbao <bilbao@vt.edu>
Subject: Re: [PATCH] Fix typo in kernel/futex.c, "even though" instead of "even  through"
Date:   Tue, 27 Apr 2021 13:35:14 -0400
Message-ID: <4665728.31r3eYUQgx@iron-maiden>
In-Reply-To: <CACbHsvRwy4UyXnkfUEZqEtY035NnMcCcTA++svC7Pk_kjUAXTA@mail.gmail.com>
References: <CACbHsvRwy4UyXnkfUEZqEtY035NnMcCcTA++svC7Pk_kjUAXTA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I attach changelog and the patch as plain text here.

This patch fixes a typo in a comment of kernel/futex.c, changing 'even through' for 'even though'.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 00febd6dea9c..f8035bb11265 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2851,7 +2851,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	/*
 	 * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
 	 * hold it while doing rt_mutex_start_proxy(), because then it will
-	 * include hb->lock in the blocking chain, even through we'll not in
+	 * include hb->lock in the blocking chain, even though we'll not in
 	 * fact hold it while blocking. This will lead it to report -EDEADLK
 	 * and BUG when futex_unlock_pi() interleaves with this.
 	 *
-- 
2.25.1

On Monday, April 26, 2021 5:11:38 PM EDT Carlos Bilbao wrote:
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> ---
>  kernel/futex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 00febd6dea9c..f8035bb11265 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2851,7 +2851,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned
> int flags,
>   /*
>   * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
>   * hold it while doing rt_mutex_start_proxy(), because then it will
> - * include hb->lock in the blocking chain, even through we'll not in
> + * include hb->lock in the blocking chain, even though we'll not in
>   * fact hold it while blocking. This will lead it to report -EDEADLK
>   * and BUG when futex_unlock_pi() interleaves with this.
>   *




