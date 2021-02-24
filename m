Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4792D3244CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBXT5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhBXTzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:55:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD7C061A2E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:52:30 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x129so2023916pfx.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pW2C6NKjGyt6KQ8+k1qyLF2XZOuZgCEPgzOEOX+G/TU=;
        b=jII3h0LfcraMEzGpz++PaDMsso6tQ948UPu5IeTERMD+dQ9KYfarJLK1Y47zo5gHf/
         C9/gwsZG5ztl1s+yJqEpa0utHhZqu0v3wuFHLH3BNlkCjOoRk4QwW4gjiLXUQB/NrgF4
         QtI8hF+cuEhE+AGXx3ybbs7l2v0obeI0jV9x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pW2C6NKjGyt6KQ8+k1qyLF2XZOuZgCEPgzOEOX+G/TU=;
        b=ZpRZd8tIthBzmaIwxaz2VYychW+sfKHnpjnSem01+K13YlN1TYSw/6oEA3+5uT87HH
         MFxDTOPrY8cvN3gOZgCmkCdDB3U4+uqmg9xWReSKCh5sAIaa6lWlSbv6uMYO2kn+o6qW
         UCakAH5hZZr1xkyM1TJzxUPg/9rm4F9MjNUwA2kBL7EV366h0OCLsEibR6mPU2AbM2ad
         +5Rtx7IQoM2MEyxv6eFDfEbF6tnoOensW1h3b/SJVH4jADRbfBisdVM58yWAI3y0DkOM
         4zlhHaKYhsvxATjsAIw3iU5MqW5Y0vAPkRjXqg+SN2zV5fpdEKR4yxrxctMxkQTikBPi
         awkQ==
X-Gm-Message-State: AOAM531sPvidvYbUhNf/x5VQAzItMriR7g29b2vdFHGYyeVtD+s4QNaZ
        JNM/6DyWzJYogr+PZ/e/PvF+hKyXwoZ69A==
X-Google-Smtp-Source: ABdhPJyn1pvDuBlEZKKlKObpB9wbGJvJ+y8ZK/DYNUycR51QmY333M+rJ9PkRqFvrdw8YRitHAEC0g==
X-Received: by 2002:a62:ea08:0:b029:1ec:a029:c04a with SMTP id t8-20020a62ea080000b02901eca029c04amr8908418pfh.40.1614196349914;
        Wed, 24 Feb 2021 11:52:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v126sm3385435pfv.163.2021.02.24.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:29 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:52:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in Linus' tree
Message-ID: <202102241146.97ACF2F@keescook>
References: <20210224113108.4c05915e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224113108.4c05915e@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:31:08AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   b33fff07e3e3 ("x86, build: allow LTO to be selected")
>   d2dcd3e37475 ("x86, cpu: disable LTO for cpu.c")
>   e242db40be27 ("x86, vdso: disable LTO only for vDSO")
>   b1a1a1a09b46 ("kbuild: lto: postpone objtool")
>   41425ebe2024 ("objtool: Split noinstr validation from --vmlinux")
>   6dafca978033 ("x86, build: use objtool mcount")
>   22c8542d7b22 ("tracing: add support for objtool mcount")
>   0e731dbc1824 ("objtool: Don't autodetect vmlinux.o")
>   18a14575ae31 ("objtool: Fix __mcount_loc generation with Clang's assembler")
>   99d0021569c7 ("objtool: Add a pass for generating __mcount_loc")
> 
> are missing a Signed-off-by from their committer.

Ieeeee! Ugh, yes, my bad, entirely. I screwed up when rebuilding the
LTO "part 2" series for the -rc1 window (missed the -s on the cherry-pick).

Since we can't change git history, the best fix I can do is send it here
to the list. Obviously, these should all be considered:

Signed-off-by: Kees Cook <keescook@chromium.org>

Again, apologies. I, too, will add a commit hook to check for this. (Is
there an existing script anyone else is already using?)

-- 
Kees Cook
