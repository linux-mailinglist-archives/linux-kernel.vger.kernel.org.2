Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D860B3187BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhBKKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhBKKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:03:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1E2B64DF5;
        Thu, 11 Feb 2021 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613037740;
        bh=WR8ULKYWrHLG62O5MAIqtAME9jyhSJd7McLNEYk8bIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2UxoYHUZDJs6hPZzfAsotp+U2vRl+ShIyA3/qx1zQIIowuKJwZYCPt74zyCtwO5h
         uUO3Hqh5Vskm5pynn4Ms5FuJ2yruna7V6mWbkzutJJJPBcqNHqTsJNPEdEi7cE7ULP
         RUS+Esqj30U3L6O4a6h698EP/c/coD3u2bIRq7/mR/wHoiqI8YS/VgOMHXSIgyzHSd
         KaDJz0LQJeyQselh/+U1/XpBkst8KEDeTd1ius6bm3Ox3y2JCvGNfhvezTEHTbRE+4
         XIsC/V0rvwrZqDQWWfjtpUBvgXnRWaw4HmVwMBCK2f2Yewg8my12E3Ax7vbvv3XrOc
         J1Z0SDiQUILxg==
Date:   Thu, 11 Feb 2021 10:02:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Joe Perches <joe@perches.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Replace lkml.org links with lore
Message-ID: <20210211100213.GA29813@willie-the-truck>
References: <20210210234438.2554926-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210234438.2554926-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 03:44:38PM -0800, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace lkml.org links with lore to better use a
> single source that's more likely to stay available long-term.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/kernel/hibernate.c   | 2 +-
>  arch/arm64/kernel/hibernate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> index 2373020af965..574fba125018 100644
> --- a/arch/arm/kernel/hibernate.c
> +++ b/arch/arm/kernel/hibernate.c
> @@ -7,7 +7,7 @@
>   * Ubuntu project, hibernation support for mach-dove
>   * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
>   * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
> - *  https://lkml.org/lkml/2010/6/18/4
> + *  https://lore.kernel.org/lkml/AANLkTimmvPMG0GFEXfgFlXgC7V4dIWmW8vEC5gegsKSE@mail.gmail.com
>   *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
>   *  https://patchwork.kernel.org/patch/96442/
>   *
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index b1cef371df2b..d0d75f9c00f6 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -7,7 +7,7 @@
>   * Ubuntu project, hibernation support for mach-dove
>   * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
>   * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
> - *  https://lkml.org/lkml/2010/6/18/4
> + *  https://lore.kernel.org/lkml/AANLkTimmvPMG0GFEXfgFlXgC7V4dIWmW8vEC5gegsKSE@mail.gmail.com
>   *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
>   *  https://patchwork.kernel.org/patch/96442/
>   *

I think we're better off removing these links entirely, at least for arm64,
as I'm not really sure that they're adding anything.

Will
