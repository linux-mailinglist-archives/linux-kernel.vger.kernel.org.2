Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3B32D5A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhCDOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCDOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:44:42 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793CCC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 06:44:02 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id h22so27449126otr.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LI2p/if8xEFXIC8BcXuJlVrjYr1uk8YfFxNJskajiE=;
        b=Y27+nz8+7m6FES5wuRgWNG0nv6IRv3Eix99tmmWj3xp4+43vzTLb8DNAxDLB234MJp
         JgQKSFvih+h0sZ5myoRQe6FB7vot2lhznHWToJXVnPvKLeGQh13gblTUyqTQZ/yGlxhc
         I0PKipuaygtO0jBPxoaLuN/vuiOdig2O/IBFSxw/oVTtv00lQHxA0Xve+lESaZJEQIdA
         yeuEYUAvcpL7OP/W2qsvFHvXmmwGSVSyJwjNxM76ZEtxj2flCyoIfxAnjcsSIvOdrjlD
         KZlW27cJqH4bqs1x5+TA+RrGM2JL1J4wbzXF0Tsrg1UnTl2nKxACmlyHpMqM5QgAjagg
         f8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LI2p/if8xEFXIC8BcXuJlVrjYr1uk8YfFxNJskajiE=;
        b=ouQYfDQn858+9jfTsXOpO4zUbU0RBxsGB02+d6DTUbg03go8K3E4X+N6ZRdpF9bjbT
         OMG7zdiCQOHINY96AXaawCqvmIU2eBNyiOKr4jAnu2kmrXDVeRC//EpDJ9QcdtX7ETut
         DQWbhsPnxRrMJE0YcgSHhTXPbB3ez9B6drVPyh60X9whEiiR+QWQpvYw5IiQ9+dyVEv8
         U4HzrRe4Xzkp0znQxaGLA1VM03aBUAPIMJIdTDfljVzINi6k11rnPXO1xjWHe+my+XmV
         2oNCsjvTOOtJnDCkIdOr/QYfWf6M1XBa7uEEuUePc7TTvGpVv3BeTKGz/pJUk4kDIm6+
         Ly7Q==
X-Gm-Message-State: AOAM530R2h4FVyhVyAHqcROIdDr9t8+vzBMBWBtOlyXDaR4GuycDNV2F
        L3paOuVZqWJWbm+cX6io5gI6vRwIW8soVd7BdGGO3g==
X-Google-Smtp-Source: ABdhPJxCoKckS+rsy3ruKeYC7JqXWHLV7iqz0I6evg332s1WWzD6lmUs6y553eUO989wFVPaFhQAjRGyKP4vshh7tiY=
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr3742038otq.17.1614869041680;
 Thu, 04 Mar 2021 06:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20210304144000.1148590-1-elver@google.com>
In-Reply-To: <20210304144000.1148590-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Mar 2021 15:43:50 +0100
Message-ID: <CANpmjNPk0GYuiz1YZddJ1GjZuUXUrXFVZujoaH0UKDknpc-vgQ@mail.gmail.com>
Subject: Re: [PATCH mm] kfence: fix reports if constant function prefixes exist
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 at 15:40, Marco Elver <elver@google.com> wrote:
> Some architectures prefix all functions with a constant string ('.' on
> ppc64). Add ARCH_FUNC_PREFIX, which may optionally be defined in
> <asm/kfence.h>, so that get_stack_skipnr() can work properly.
>
> Link: https://lkml.kernel.org/r/f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Marco Elver <elver@google.com>
> ---

For further context, the corresponding ppc64-enablement patch is was
just sent by Christophe:

  https://lkml.kernel.org/r/afaec81a551ef15345cb7d7563b3fac3d7041c3a.1614868445.git.christophe.leroy@csgroup.eu

But there is no strict dependency between the patches, only that the
stack traces that KFENCE prints aren't as pretty without the
ARCH_FUNC_PREFIX patch.

So it should be fine to take them through different trees, as long as
they both make the next merge window.

Thanks,
-- Marco
