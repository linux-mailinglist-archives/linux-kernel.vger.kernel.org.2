Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7030951E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 13:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhA3Mez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 07:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhA3Mey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 07:34:54 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC6C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 04:34:13 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q5so11037456ilc.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 04:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C7cDNKTuTgw0I2CTtx3BBJ3BTnHf7w/oYJgbFlp2Ulg=;
        b=JkmqbLLymBqsef5mgjuVS6CDvWa2Mm/XH6Xnmt5dLFtMJleyERnRaKfghpQNn+AX10
         riQKW8xGp/K0cyTqJE0qAZ4bvDsdJhKMatByqDYmSTGDqK4UNCUroPDDvA66VW78MWFv
         dXewsHBwtdMozL+u4dSDr6AhcA1KGrGFFf4rptz+Ovitbkd6GHnJeLcMFOZUM49ZY6kC
         fABj9WQf62QDk5XSqgWZquWfKMt0TsLmPIbFYIPorTEHTF2J1cgO7WSppOjSbdFWd1Ds
         Yu8n3Xe/d89xWKCc/muWuYlH3RVAZUtN9/mZZ9juYTZM+7DrVw/9uVqbL9bh5CIGgmqy
         bUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C7cDNKTuTgw0I2CTtx3BBJ3BTnHf7w/oYJgbFlp2Ulg=;
        b=RAgp4VqvDVzsXeEdQJas7inXPUpulNDEeT8sR87X/RzqqIe8PPtEp7lr9rO8WGG6rl
         0miAdNaiYUNAK9V5TNcyFf3pbPh9Gwvv9UptC6l7n325ZOz9Jk/nUYSskIia6TpQU/3s
         Om0Raype0KCGWrQaSY2tfZ3yLcWtrQFpeBoXmgbKnffw/cRXCdX1Oqa+/yUTa04karvf
         OCFc8l+akJ28F9qkLbFSApUjeZn383VnBuniPhY6oZHCVJM8GphkaKnHSXVKA8ABxy3e
         o2JDBw7dSIJXxZg9p1vtGb8ruVgp2CI5R0npeOFS/fmrxOk69zuBpStZ6QG7pM9CewB6
         1xpg==
X-Gm-Message-State: AOAM532Vp1Fk4P1XI3cg9/f0poCV9s9QGNHHpLePzhsa1+lIZRIeD3Nz
        bCrZTsy8s7mRXwp234o/Lkw=
X-Google-Smtp-Source: ABdhPJwID2N6KgHnIJzTKMZEvKcXG9pTq70AIKv0+BheRu3F0l+nTV4cYYZad+1hF+fNd+c252xBag==
X-Received: by 2002:a05:6e02:1a2d:: with SMTP id g13mr6528684ile.228.1612010053300;
        Sat, 30 Jan 2021 04:34:13 -0800 (PST)
Received: from llvm-development.us-central1-a.c.llvm-285123.internal (92.190.192.35.bc.googleusercontent.com. [35.192.190.92])
        by smtp.gmail.com with ESMTPSA id 11sm5781105ilq.88.2021.01.30.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 04:34:12 -0800 (PST)
Date:   Sat, 30 Jan 2021 12:34:11 +0000
From:   Vinicius Tinti <viniciustinti@gmail.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/i915: Remove unreachable code
Message-ID: <20210130123411.GB1822@llvm-development.us-central1-a.c.llvm-285123.internal>
References: <20210129181519.69963-1-viniciustinti@gmail.com>
 <161195375417.17568.2762721732398065240@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161195375417.17568.2762721732398065240@build.alporthouse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 08:55:54PM +0000, Chris Wilson wrote:
> Quoting Vinicius Tinti (2021-01-29 18:15:19)
> > By enabling -Wunreachable-code-aggressive on Clang the following code
> > paths are unreachable.
> 
> That code exists as commentary and, especially for sdvo, library
> functions that we may need in future.

I would argue that this code could be removed since it is in git history.
It can be restored when needed.

This will make the code cleaner.

> The ivb-gt1 case => as we now set the gt level for ivb, should we not
> enable the optimisation for ivb unaffected by the w/a? Just no one has
> taken the time to see if it causes a regression.

I don't know. I just found out that the code is unreachable.

> For error state, the question remains whether we should revert to
> uncompressed data if the compressed stream is larger than the original.

I don't know too.

In this last two cases the code could be commented and the decisions
and problems explained in the comment section.

> -Chris
