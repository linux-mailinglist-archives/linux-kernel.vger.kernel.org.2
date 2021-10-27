Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE843C293
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhJ0GMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhJ0GMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:12:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAFAC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:10:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id r5so1278218pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8oo9KGHDub2uSqp5/5CjzmUkLEVB7cJ3bXQ858Chcg=;
        b=MYctPzW6TBYjYcKSLe+nngQGfKPI/7x0QAjbweVCApB2KB1n0xJLV8OSlf4nzbMTJS
         PzquWNvpCEE0ZdW4MWoy9ngbQUBJ4cwnZS5w3yV3GF3EGN4Fk5f0bzcG3f7PWe5g2YeT
         6xSwJq+QZOg5nVSLLyFviagSqDAaSiVoc1sFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8oo9KGHDub2uSqp5/5CjzmUkLEVB7cJ3bXQ858Chcg=;
        b=JG7GRfxuqwHBlEM3vts8lDTfq9NBtuYbYFLpr1mJOUhui2xtw41dEpMoTaWD1PgZZt
         JUJ2E6kZLjPKrPPO77NLaVqEeElwTe5+WhBZr2dNmBrgUKbf+zRExUL4r0qFdjZdAOmO
         xlWlJx+DinFvrdV3SwqM5N6XtQbe/0s4/yGEvc5WUyr718FF8al0k+2A3ZDDmD2JNMwR
         37xqRkVYt3N2H4v1DcLjOFKDViGC+2IFEppJikKlYLpVe8urXOjFtNCAH4qaWzvtCTlY
         kyOowW/kTOpz9YRcEFQERlTYOYLY1VeseWzsjRHQ7NWLfX6XEK6RiET1jDOYljmKTXWv
         J+8g==
X-Gm-Message-State: AOAM530Y4HK8T2ukuxPiWVq4HwB1R0EgdHa2LTk4xW9IiATQxFGjaXrv
        kSGf05OqAkWqYRaklRmaMDmGbg==
X-Google-Smtp-Source: ABdhPJxiDKcMwMoSVQQPMMbfQkOIhKx/9wCmAHJZN7ZS1NuvwfxkumhXN530jptrCEYKCbYaLKjT1g==
X-Received: by 2002:a17:90a:ac0b:: with SMTP id o11mr3685599pjq.15.1635315007602;
        Tue, 26 Oct 2021 23:10:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gb8sm2870631pjb.14.2021.10.26.23.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 23:10:07 -0700 (PDT)
Date:   Tue, 26 Oct 2021 23:10:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] x86: Various clean-ups in support of FGKASLR
Message-ID: <202110262301.A1C8F597A@keescook>
References: <20211013175742.1197608-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013175742.1197608-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:57:38AM -0700, Kees Cook wrote:
> Hi,
> 
> These are a small set of patches that clean up various things that are
> each stand-alone improvements, but they're also needed for the coming
> FGKASLR series[1]. I thought it best to just get these landed instead
> of having them continue to tag along with FGKASLR, especially the
> early malloc() fix, which is a foot-gun waiting to happen. :)
> 
> Thanks!
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20210831144114.154-1-alexandr.lobakin@intel.com/

Peter, Josh, Boris, can someone please take these through -tip?

They're each stand-alone correctness improvements, and while FGKASLR
depends on them, there is no reason to keep them tied to that series,
especially since anyone using the early-boot malloc or making changes to
text sections is going to trip over one or several of the issues fixed
here.

They've got a bunch of reviews and acks already:
https://patchwork.kernel.org/project/linux-hardening/list/?series=562929

Thanks!

-Kees

> 
> Kees Cook (2):
>   x86/boot: Allow a "silent" kaslr random byte fetch
>   x86/boot/compressed: Avoid duplicate malloc() implementations
> 
> Kristen Carlson Accardi (2):
>   x86/tools/relocs: Support >64K section headers
>   vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext
> 
>  arch/x86/boot/compressed/kaslr.c  |   4 --
>  arch/x86/boot/compressed/misc.c   |   3 +
>  arch/x86/boot/compressed/misc.h   |   2 +
>  arch/x86/lib/kaslr.c              |  18 ++++--
>  arch/x86/tools/relocs.c           | 103 ++++++++++++++++++++++--------
>  include/asm-generic/vmlinux.lds.h |   3 +-
>  include/linux/decompress/mm.h     |  12 +++-
>  7 files changed, 107 insertions(+), 38 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
Kees Cook
