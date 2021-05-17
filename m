Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9543138251A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhEQHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhEQHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:12:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C027C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:11:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so5516092edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWyJokz4bieElImfwurmiJOl8vOUBld5Swkb1bhKswc=;
        b=Dmrhbzy0x2SMKqESiOBZjHxgUn61zc6Xsh2TIaAznGX4WLXegX/aY7uoN2EHbwSCg4
         3V3gw/vyIaN1ZdhKpXHTepT9CDpwZW4oT5HMHtbzxPsZLjnZe5PzjSkyNKd3ilyRCgts
         RwR6loIsMMua/WgUv5aHK6UFobOQinzdYxNpAeDGPxK94n9K4RY7fNNYT514ko7No83e
         0eCYxqrGc70W0xa7iUb7JIKRVxJrUWx4Yr43snORpt/mh8gxMbE7geStNiecbZ76i0Tg
         LkR5r4/Gm9fN2G4iZW2Gkar9uR/6ZZR4hYC+P42YSW/TA6wQSiyafFieH5+U+P8gaZBf
         nF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EWyJokz4bieElImfwurmiJOl8vOUBld5Swkb1bhKswc=;
        b=R/1BDV6BqPq647e3FpBrpxVXynTaH0aM2AufxYuKJPGL06lEmzvUSE1o+l+9nTM9pi
         sGmrXmnXIN2DIXvY3pdPHp6TY905gtZTs5zBjVGN3l8Jfl5VwkXBh31Rvq6bH2eYtoj2
         RM2BH2F7/fJfIyI0wywjy+yfWgWT8OKjPkGQdnl9X42CyMmTbXcpnm8VnbfZmYY5iBdE
         yhrFeeYhQ+VuzGO4xMVN+jA+BmTGeBeD9NBXPJx9JRj2NE0/yfm5bh1X+drvW2PLswxf
         NC5CqKyjf4Kgl8Tc/QhOFKlk3mzLFA6gShpSAcXdzWuBM9waFJGcbgxyWxF+eiCX+47D
         Gifg==
X-Gm-Message-State: AOAM533HddoLk7ZsPl2VqECLDiUWlMWE4WJv9jPnaYk+rZ9eDNjNh2TC
        kgpkHh+YEultHfapLWr1mU8=
X-Google-Smtp-Source: ABdhPJzCqZLbZtnV+6tg2tCpMw92i8y05K4hoi7xXk1jfNwVIAZNEmmoLefUEbbcNUZW37L7mZdH8A==
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr8054972edr.181.1621235464732;
        Mon, 17 May 2021 00:11:04 -0700 (PDT)
Received: from gmail.com (563BBFD3.dsl.pool.telekom.hu. [86.59.191.211])
        by smtp.gmail.com with ESMTPSA id d15sm5917572eds.68.2021.05.17.00.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 00:11:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 17 May 2021 09:11:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
Message-ID: <YKIXBpxyvhzdb1uv@gmail.com>
References: <20210517034430.9569-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517034430.9569-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> Both arch/um/ and arch/xtensa/ cause a Kconfig warning for LOCKDEP.
> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
> of the arch-es that LOCKDEP depends on.
> 
> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
> intend to have LOCKDEP support, replace the awkward list of
> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
> 
> Fixes this kconfig warning: (for both um and xtensa)
> 
> WARNING: unmet direct dependencies detected for LOCKDEP
>   Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>   Selected by [y]:
>   - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>   - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>   - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> ---
>  lib/Kconfig.debug |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210514.orig/lib/Kconfig.debug
> +++ linux-next-20210514/lib/Kconfig.debug
> @@ -1383,7 +1383,7 @@ config LOCKDEP
>  	bool
>  	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>  	select STACKTRACE
> -	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
> +	depends on FRAME_POINTER || LOCKDEP_SUPPORT

Ok - the FRAME_POINTER bit is weird. Are there any architectures that have 
FRAME_POINTER defined but no LOCKDEP_SUPPORT?

Thanks,

	Ingo
