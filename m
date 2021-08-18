Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34E83EFCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbhHRGkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbhHRGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:40:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4633C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:39:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so3619976wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hVrGSTnE7k8RtP/gKm1lkEWkTXogfMVkN4IhNiukPaY=;
        b=RMWvSP/CCip77IYqObqTDQbjxYHSKYdeuvrHx6LMR14xOES9lzquo6R8nZMe7/LxAF
         ULDQoZegBJhMCc2Qfk6vPu1Pk+r/VscbaXHYj1qoMvICOKZjZGT05gp7N1U2ZeAVXdMM
         8ZWmwJAvcEI2u7m2OA+Z3pYWYx4yYt3Bicdehk+VDiIdTSNhUl2ZXsBwGavOva7H2cNy
         e1qnq8Rb72Q0ZtezwK5yvy2hXL2U+Umf4PvwBfX//yXIFw62IMiffDdP8Tp9kcjmAFXB
         nSPGMDcf99RcBCku80aarf4TtNBcZPIrTWLBOJtZafDaTeFB+MsllbNSLm5zkB+nVzrd
         +ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hVrGSTnE7k8RtP/gKm1lkEWkTXogfMVkN4IhNiukPaY=;
        b=dJxwJngnf84WqhVrROjNyIzLcRjjkIQOpDjB9GXA8/DALTUU0D3h300fklxAeQgP2D
         vdoPdl45wbnmL9mu7gP4RGcXf27qx8kaBm5Hpt8Afw0yuoxF2FPCIKKCGrRiGmudPPVU
         nDd6wxXll10PaqtH90019YkQeg/JDDzgO5NlZ2vUmHAdDQtXfIjRP4WvNkxBWU4UBGRF
         xyW0efz18Evuh9jNTNQpWELRkHQ83SuGEHl3DtYG5QjCnWDA9uJ2mrpXwnsEjbYeQxqq
         nVqpPlaR/YhINTyOCyt0HGdI8F8YKxTHkpZJ9I6WJv9q2gexhD12WkRsaMH7+7KYcbOl
         NCfQ==
X-Gm-Message-State: AOAM533/C/WJkQWB3MPtJ+MV7Hf/qbOoytLAKdrFVCeAN3e1/jF3KwMr
        YMZ/Ap55LmATwVK58onSdoek0Y6isKA=
X-Google-Smtp-Source: ABdhPJxbPDWST2qWiACILP3a0c//gDUHnWbbKNjnUac/XUEJIuQ+lRGHXjR6BTipvv1qJ3FmjTVjKw==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr6857397wmn.78.1629268757259;
        Tue, 17 Aug 2021 23:39:17 -0700 (PDT)
Received: from gmail.com (77-234-64-129.pool.digikabel.hu. [77.234.64.129])
        by smtp.gmail.com with ESMTPSA id d9sm4677050wrw.26.2021.08.17.23.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:39:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Aug 2021 08:39:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     elver@google.com, mark.rutland@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL kcsan] KCSAN commits for v5.15
Message-ID: <YRyrEQt52d0kaxQI@gmail.com>
References: <20210812001359.GA404252@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812001359.GA404252@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo,
> 
> This pull request contains updates for the Kernel concurrency sanitizer
> (KCSAN).
> 
> These updates improve comments, introduce CONFIG_KCSAN_STRICT (which RCU
> uses), optimize use of get_ctx() by kcsan_found_watchpoint(), rework
> atomic.h into permissive.h, and add the ability to ignore writes that
> change only one bit of a given data-racy variable.
> 
> These updates have been posted on LKML:
> 
> https://lore.kernel.org/lkml/20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1/
> 
> These changes are based on v5.14-rc2, have been exposed to -next and to
> kbuild test robot, and are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan
> 
> for you to fetch changes up to e04938042d77addc7f41d983aebea125cddbed33:
> 
>   kcsan: Make strict mode imply interruptible watchers (2021-07-20 13:49:44 -0700)
> 
> ----------------------------------------------------------------
> Marco Elver (8):
>       kcsan: Improve some Kconfig comments
>       kcsan: Remove CONFIG_KCSAN_DEBUG
>       kcsan: Introduce CONFIG_KCSAN_STRICT
>       kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
>       kcsan: Rework atomic.h into permissive.h
>       kcsan: Print if strict or non-strict during init
>       kcsan: permissive: Ignore data-racy 1-bit value changes
>       kcsan: Make strict mode imply interruptible watchers
> 
>  Documentation/dev-tools/kcsan.rst | 12 +++++
>  kernel/kcsan/atomic.h             | 23 ----------
>  kernel/kcsan/core.c               | 77 ++++++++++++++++++++------------
>  kernel/kcsan/kcsan_test.c         | 32 +++++++++++++
>  kernel/kcsan/permissive.h         | 94 +++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.kcsan                 | 42 ++++++++++++-----
>  6 files changed, 217 insertions(+), 63 deletions(-)
>  delete mode 100644 kernel/kcsan/atomic.h
>  create mode 100644 kernel/kcsan/permissive.h

Pulled into tip:locking/debug, thanks a lot Paul!

	Ingo
