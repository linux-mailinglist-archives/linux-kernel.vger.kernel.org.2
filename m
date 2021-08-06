Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2B3E2A04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbhHFLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhHFLri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:47:38 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B53C061798;
        Fri,  6 Aug 2021 04:47:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f12so8370429qkh.10;
        Fri, 06 Aug 2021 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=BBUaoNE0IbHV53qO+WAxQddu4xQPBbh8BMh0jZwcruA=;
        b=UGYO8XflIKFBzKPQvL5rqM7+axUVT0po1AxTt2C4qGE+KPSHPthDNX6hu8Ywj2b1Fc
         2mTnzrrTVl3qTIWjHz1ICttPxpVRWwuizsKCcH7qmjZokEjezNVgRh7m1SAx2ojSSHDY
         bUNyBMNKY01vnHeWM4jooGkcngDeZMfNRaXYfYgXH08b3NQsSCsguvGuq/vGccKK48z6
         31QO3ZtnS7Jpk8p+xvg6xLbPH1eaHYno2RL5iJPKNZ2RhWsJpPyJIcoH3uzLor6i0C5C
         Riq40Oljh1sn81k4efcTLcXasGU0BAKyADiEq65HiA7oKJVb9ByKDZZIP8eYx0j24Apg
         /iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=BBUaoNE0IbHV53qO+WAxQddu4xQPBbh8BMh0jZwcruA=;
        b=oHEidDrIslUkefgAsuyqLR//rgnBxYkB19zGTgL/0AZmyreM8x0R73r7FcnZ0jC6ar
         uDNaLuc2d4toYntyZNRieh5rFX7LOj+y+ESKBAGfE5bVYxfcSaaheaAy7FOYnuXujozR
         pOBvkqoP8J533Mv+/Oq2KyBmsR0reeZ6Ulu49eQPje42a9Hyku/PFKbso680dLRgNDgP
         O/hsxxgxrd5w+a9qdixGRgXCGWb8Fg3mfmyVk2jtwoh2OOgpICsScX+SIvZ42l3Xd8Ws
         5su/vdf6TvWbQ4/6IXXo2Oa7bg0k6WlXTA3ObV+49xZ7iR3YEj0i/e9ROGtB/US25x74
         jMqw==
X-Gm-Message-State: AOAM531eqU8lNOYpYR9qvc4Pdo0TFFa+Sn3/T6RCPjGWEJ1gw4ckAQ2c
        nG5fbF6vhHPyGZlRVITz6mQ=
X-Google-Smtp-Source: ABdhPJyhv24ae9e6dk5V3IsNxW8zC0bYA3lE8SkGc9QVE5QigRf7J/3V1pQknD4O+oPZgN+H/KUJIw==
X-Received: by 2002:a05:620a:1022:: with SMTP id a2mr9988723qkk.136.1628250440395;
        Fri, 06 Aug 2021 04:47:20 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id n190sm2340521qke.134.2021.08.06.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:47:20 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 07/13] mm/damon: Implement a debugfs-based user space interface
Date:   Fri,  6 Aug 2021 11:47:11 +0000
Message-Id: <20210806114711.6900-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805174316.ff4b6eee629f9f05259058d9@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 5 Aug 2021 17:43:16 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Jul 2021 08:14:43 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > +#define targetid_is_pid(ctx)	\
> > +	(ctx->primitive.target_valid == damon_va_target_valid)
> > +
> 
> I think this can be implemented as a static inline C function?
> 
> --- a/mm/damon/dbgfs.c~mm-damon-implement-a-debugfs-based-user-space-interface-fix-fix
> +++ a/mm/damon/dbgfs.c
> @@ -97,8 +97,10 @@ out:
>  	return ret;
>  }
>  
> -#define targetid_is_pid(ctx)	\
> -	(ctx->primitive.target_valid == damon_va_target_valid)
> +static inline bool targetid_is_pid(const struct damon_ctx *ctx)
> +{
> +	return ctx->primitive.target_valid == damon_va_target_valid;
> +}
>  
>  static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
>  {
> 
> We prefer this because it looks better, provides typechecking and can
> in some situations suppress unused variable warnings.

Agreed, I will keep that preference in my mind.  I also found that you already
nicely made the change in the the -mm tree[1], appreciate!

[1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-damon-implement-a-debugfs-based-user-space-interface-fix-fix.patch


Thanks,
SeongJae Park
