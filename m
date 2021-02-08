Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE155313FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhBHT6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhBHSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:18:51 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02501C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:18:11 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id v3so11015285qtw.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BzmmFsaTMZkHk1HskuOi9uYCOrXj1VKQVzVAXC5g14=;
        b=0PBYDksszvsQCXddca838R0KfhJXtEkC6CLImS0vdl4nkSOzo0ex6n85guzuy5rGTK
         C3E/Fv1irgQ1txOVrsxwGqbQVN6ZvKQBvVhOZmp0w2zs0L2CsbE4fShbLgV1riPke7Dh
         5cFlExFY+3q/vo4s6Tbz/0QfMutdc4TTKtRwO3z9+IXd702zXwLpQeg+RlIcW90nDiox
         O4d2cv6/iP8Snq0lZXu9V/MVS8JVs8jFcddEvNaW0XZDfWW1WBCtqz5o/uqU6rtTWSYx
         LT5658SWCKYw166Htcq0eO+RDKQqrhkAcdRv6BdAfrOILAFw6sW99e1VMeEhZr37oTa7
         c/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BzmmFsaTMZkHk1HskuOi9uYCOrXj1VKQVzVAXC5g14=;
        b=GZoVTq20w18gvW9Qs2ytR5E+iuzRcqqMIa91NjbVhFT++C0ZerbJ5yZrV3rD+fEFsc
         1lz9xhVLbJnHKEawSitdNRI76d0vwMdqld6xTgrntK076s35HrvN6Ujdw0U/Di3zKIrQ
         Pyf5iNfbhfgLsOYqTr1kvDiJbkWO+19alNOO7qCqDRhtdhtTv91UfhtxYAniGew17s6z
         JiRnHgt94jvEXqNbDR1GZ7c8SYUdDpdQe8njM/Chgko2yi7FnBNoPmvaSwAZWH6h/5bA
         x8UVT0YhEugG79LQxuqV4nmPVhnxOP5P+NEbx4+znCV1MYJ6Ke8sq+YyOh2rbRNQV2L5
         mFUg==
X-Gm-Message-State: AOAM530Vwneecp/GQTVaAWeQ33mTYH0Mk4Zv5mwGchScXVwRR1KRnEKx
        4Ao1ZkYlcWUyfe5ihajvGx7dQw==
X-Google-Smtp-Source: ABdhPJwIh2bE6nTGjfzbRot9Flwud7yTE4rmnKbuiCezaj55sSCa7m0cSrbC6Rd09JWYmPHKR9pXaQ==
X-Received: by 2002:a05:622a:303:: with SMTP id q3mr15848196qtw.235.1612808290286;
        Mon, 08 Feb 2021 10:18:10 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id n35sm6330828qte.19.2021.02.08.10.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:18:09 -0800 (PST)
Date:   Mon, 8 Feb 2021 13:18:08 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] psi: Add PSI_CPU_FULL state
Message-ID: <YCGAYEiyTKCO71E3@cmpxchg.org>
References: <20210207072402.67532-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207072402.67532-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 03:24:02PM +0800, Chengming Zhou wrote:
> The FULL state doesn't exist for the CPU resource at the system level,
> but exist at the cgroup level, means all non-idle tasks in a cgroup are
> delayed on the CPU resource which used by others outside of the cgroup.
> 
> Co-developed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

That metric's come up in our production environment recently as well,
it makes a lot of sense.

In addition to outside competition, this also applies to downtimes
enforced by cpu.max - another cgroup usecase that is worth mentioning
in the changelog & code comment.

Thanks
