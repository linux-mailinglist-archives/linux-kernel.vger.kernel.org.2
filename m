Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846633FBD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhH3URm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhH3URh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:17:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE75C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:16:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y23so14527621pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Gjmh2khQtTIto6ydtTcLMQuTQMVcLm+SAujgODL3VA=;
        b=UaZfjuIcymN1ROobWl/Af4JyhzjOTdxqDjeIoICTu9HvZvDDpP3iKwj1jJM8+5i4D4
         7AG+wW1u6sruUD0zVcbMr9SHPUqfNCcS/YRiSO9irljKBdLgfyhrRTLU/QNPFA44gp7j
         Xzyyw8BkHLJjSxN5nLG3KlasYTbMU/DV/8aKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Gjmh2khQtTIto6ydtTcLMQuTQMVcLm+SAujgODL3VA=;
        b=qXv9EFl/fr4bd/3EwsdqRReu3YlLRJClDwwMJ61Rnqfe69YlrpzV3BiwY2OCl3XYvJ
         W136H/H4ffMfQRarU45r+eJADLke+GOy7hm9dFbg9ouyYIBcyRnTGmtCg9eWIhFcPShG
         o/F3ow+KfqcFjXHcoFLJSGnkqldY2SgIB2GmF9yLSlFKIQ9OjbVcG3/fpErqNJ3jNLbY
         7jjc13BEwQD7Ll0a3HSepy7vT5UmLSr/4hBfVjNA5VdQoevAQgrHdPe1hSbf+rMaieLT
         gp/MJYZjwFbhu1ZC/Hx9TifF+uJ81w8m9IDBKOpfU+eL8ToITeVKatamVI8N6XR+JNRG
         lXng==
X-Gm-Message-State: AOAM5334Pb9d9IyMCMSdJsjhG64zyq8aAoCJm+SuZSEwol9qk4QKPF5Z
        7qJc618KhVW+7eVjdtl7wwSmSNJAi1Tohg==
X-Google-Smtp-Source: ABdhPJyfyfv0j5SsIb7SF7ruWGzc0JgMsZg+XrtwWeRgwZ1dqSmBiT4CuujRduBedSkB7IpGBLg0uw==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr24825041pff.49.1630354602955;
        Mon, 30 Aug 2021 13:16:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c123sm15588127pfc.50.2021.08.30.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:16:42 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:16:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Message-ID: <202108301314.22B3CB015C@keescook>
References: <20210827163015.3141722-1-keescook@chromium.org>
 <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:44:54AM -0700, Nathan Chancellor wrote:
> arch/powerpc/kernel/signal_32.c:780:2: error: array index 3 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
>         unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Or is this a Clang DCE failure?

#define unsafe_put_compat_sigset(compat, set, label) do {               \
        compat_sigset_t __user *__c = compat;                           \
        const sigset_t *__s = set;                                      \
                                                                        \
        switch (_NSIG_WORDS) {                                          \
        case 4:                                                         \
                unsafe_put_user(__s->sig[3] >> 32, &__c->sig[7], label);        \
                unsafe_put_user(__s->sig[3], &__c->sig[6], label);      \
                fallthrough;                                            \
        case 3:                                                         \
                unsafe_put_user(__s->sig[2] >> 32, &__c->sig[5], label);        \
                unsafe_put_user(__s->sig[2], &__c->sig[4], label);      \
                fallthrough;                                            \
        case 2:                                                         \
                unsafe_put_user(__s->sig[1] >> 32, &__c->sig[3], label);        \
                unsafe_put_user(__s->sig[1], &__c->sig[2], label);      \
                fallthrough;                                            \
        case 1:                                                         \
                unsafe_put_user(__s->sig[0] >> 32, &__c->sig[1], label);        \
                unsafe_put_user(__s->sig[0], &__c->sig[0], label);      \
        }                                                               \
} while (0)

if "set" has only 1 element, then _NSIG_WORDS must be 1. The warnings
are coming from cases 4 and 3. (But why not 2, which would also access
beyond the end?)

-- 
Kees Cook
