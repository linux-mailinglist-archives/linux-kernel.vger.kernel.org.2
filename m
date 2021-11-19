Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D181B4576D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 20:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhKSTFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 14:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhKSTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:05:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:02:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z34so47687335lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyZL3RTv0TvPMt4xtflBBfvrXYlylAFPWUcrVRJ4EDs=;
        b=nWw1gsnD9O98jerNZ1sC4DKktH5192XhCwJPKSOZfpv1VOtDSge4Ja05sy1/F8+Avn
         cNlbAxDFBVLpREu9M18VbUSUz3v2gHZhV7m2Lb3+8ZIcfD/1c4eDKFUsmeRlwLpa897Q
         8WaJkkcB0RabbyouUToQ/ZuCVVhP8RFS/AIQ6ETcf/Ne1PJt8ML2LmXsdlLF5Gplz6fJ
         3xjptzyoxwFeKtZaGR4jtmtbt7KX6nPU5FaKUPWNyKqTAbKOrL+qb2YAPzSJglX8ZPM3
         2q2qyAAifOZs72R6WigdAJzy42IhuexhikuRwjMOabqVGsTMJvdDrTY5ii1Cco9Ybn1G
         rp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyZL3RTv0TvPMt4xtflBBfvrXYlylAFPWUcrVRJ4EDs=;
        b=VEaNS9a+/KpdxFvrv/C+jT6A62pC6YjHn/rfeMJ3bgW8n//TUqCPyOpn8Wo+RQYVkO
         Gt20+l+6iJWNdk3pHTC3eK+S4J/PDVpm5VL7aJHUDyvDB/fqtXonYIYRrQOfyNTa1giV
         cPDWG8MMIwGojWMfHx/TMyIqLNGQ9zMiWwaAIRrSHBIOXoPDj0TnJiKEzp/XN/8eBKGl
         5wwuRRv+R22O/4XTz+nDiThrmmGU3WXAiUhX8meAo0VW15+lAILzDDusrofaZ/Q9OB6b
         8e4zt1KwW8KegY3G6h5qkgHFTmgT5DJ7eZjL945qiGJT38HtmspJ7uTRaw6EriiZEq89
         gVqw==
X-Gm-Message-State: AOAM533AZ2tSZzeIptWuoj0fWU+9DtxNxTAcDU0BWwh6IKkOoaVYuXp+
        SBH8qxlKBRrxdmTQ3oXpjL8YgDnXHSzHxVpxo00VTw==
X-Google-Smtp-Source: ABdhPJwY9ByD7EPyR/BRypXRZWP52cbPyvXPOT8z9uoVse36nnaavQAo5B5rBbYe3m+bJeFGzeUM/Zn46pKAQXbTVZ0=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr33923024lfi.82.1637348551242;
 Fri, 19 Nov 2021 11:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20211119165023.249607540@infradead.org> <20211119165630.219152765@infradead.org>
In-Reply-To: <20211119165630.219152765@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Nov 2021 11:02:19 -0800
Message-ID: <CAKwvOdn0+eaV66xuY=hjA=CZCZ=6wt_dEsYf_nUq0TTQKWf2VA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: Move RETPOLINE*_CFLAGS to arch Makefile
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 8:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Currently RETPOLINE*_CFLAGS are defined in the top-level Makefile but
> only x86 makes use of them, move them there. If ever another
> architecture finds the need, we can reconsider.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Makefile          |   11 -----------
>  arch/x86/Makefile |   11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> --- a/Makefile
> +++ b/Makefile
> @@ -688,17 +688,6 @@ ifdef CONFIG_FUNCTION_TRACER
>    CC_FLAGS_FTRACE := -pg
>  endif
>
> -ifdef CONFIG_CC_IS_GCC
> -RETPOLINE_CFLAGS       := $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
> -RETPOLINE_VDSO_CFLAGS  := $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
> -endif
> -ifdef CONFIG_CC_IS_CLANG
> -RETPOLINE_CFLAGS       := -mretpoline-external-thunk
> -RETPOLINE_VDSO_CFLAGS  := -mretpoline
> -endif
> -export RETPOLINE_CFLAGS
> -export RETPOLINE_VDSO_CFLAGS
> -
>  include $(srctree)/arch/$(SRCARCH)/Makefile
>
>  ifdef need-config
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -12,6 +12,17 @@ else
>          KBUILD_DEFCONFIG := $(ARCH)_defconfig
>  endif
>
> +ifdef CONFIG_CC_IS_GCC
> +RETPOLINE_CFLAGS       := $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
> +RETPOLINE_VDSO_CFLAGS  := $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
> +endif
> +ifdef CONFIG_CC_IS_CLANG
> +RETPOLINE_CFLAGS       := -mretpoline-external-thunk
> +RETPOLINE_VDSO_CFLAGS  := -mretpoline
> +endif
> +export RETPOLINE_CFLAGS
> +export RETPOLINE_VDSO_CFLAGS

I appreciate the cleanup.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

If we wanted to be more aggressive here, RETPOLINE_VDSO_CFLAGS is only
used in arch/x86/entry/vdso/Makefile. If the definition of it was
moved there, then we wouldn't need to export it.  Though it is perhaps
descriptive to contrast how the flags used differs between the kernel
and vdso; having them together does demonstrate that clearly and all
in one place.

> +
>  # For gcc stack alignment is specified with -mpreferred-stack-boundary,
>  # clang has the option -mstack-alignment for that purpose.
>  ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
>
>


-- 
Thanks,
~Nick Desaulniers
