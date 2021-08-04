Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63EE3E0710
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhHDSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbhHDSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:00:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1234C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:00:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c24so2599946lfi.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+ibMoMQpfUT9bLOurH7tEEZu9XJnKNs+DZk3gP/F/4=;
        b=WBMCSpfhYPpAbDByxBQBKT7VhO4Dg6FM8SOV2bcvsF/lN+kK2bCyTJUZ6jEovWCoX+
         K2skLEM5eAzSTmZCQ03uLRTtHA03PfLmNKxYqktvZC02X2Ya1sC8dc+YsOGIYxp4iX9y
         kJy/1ddRFufWylctzfiGmtZBEhftKzvEdArHZSEvrdjKY4DABPxn0kVc61fhb88Js04X
         /pDP+9/MnqXPvNASm27oaFS2hhRPQ0T1mGDFKF19R7Cln1nV4yViPMKzRKsQh7wGynB1
         E5gkOnb3VfJ9puu+JNUqXTrWVes+qqux+njGwM25Nb0nBnIW157Qotdp5lGmunLUjTVX
         VbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+ibMoMQpfUT9bLOurH7tEEZu9XJnKNs+DZk3gP/F/4=;
        b=RzIVvKk2ojyu7TwLjjpw3HtXL+wgAN1JbLP469Id1rA5IKkyHk4MrJT6RrQL+FIz0k
         ZJS3Pdri+9rxUPn3sLkEaIm8wT62FRwyl3JqbYkzH+9w17H+n5U5o1IxEE9x0N1OO3mq
         33zZtztV28eCiXVYU00jxfWpZseUx3WQT5JLm+AsZwAmtDo0jaPD5IxzCg+pLzhHPP0s
         hLqJke6wOG5nV51/UuIw79A8oKmkxREUIZcS7TupWWId493I0tFS/Djic+Gp35z47Liy
         MtkGWyk5Rm2uc8XwuLcRXKF9tvWEW77dO91WMBfoaEh5SeXg+JACL1IlWPd6mpJVwWKf
         4qcg==
X-Gm-Message-State: AOAM532Yq4qfKKJUZCeOwM2FF5GEOALeueIfYewvL+r5FQcPmSgx2rlC
        t2wbsoTGt/C8UKfVT4b5ugIkCo99DnI2+bANN43m0A==
X-Google-Smtp-Source: ABdhPJziGr2xLP3UUOomtvrTuLXQHTU+gO7hPP5YWfJP0XYZc7u7WOJANuDzqv46+qcs7/sjjnSl6W8p07MqaNXijZc=
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr346634lfb.122.1628100042816;
 Wed, 04 Aug 2021 11:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210720181542.2896262-1-ndesaulniers@google.com>
In-Reply-To: <20210720181542.2896262-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Aug 2021 11:00:31 -0700
Message-ID: <CAKwvOdkdoAadmOt1w2cE4Q5rOM48qPt3_WgkSkhxGVsyVV6U0w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Nick as Reviewer for compiler_attributes.h
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bumping for review EOM

On Tue, Jul 20, 2021 at 11:15 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> $ ./scripts/get_maintainer.pl --rolestats --git-blame -f \
>   include/linux/compiler_attributes.h
> ...
> Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD
> SUPPORT,authored lines:43/331=13%,commits:8/15=53%)
>
> It's also important for me to stay up on which compiler attributes clang
> is missing.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 548783bf6505..fe9b2ab45402 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4658,6 +4658,7 @@ F:        drivers/platform/x86/compal-laptop.c
>
>  COMPILER ATTRIBUTES
>  M:     Miguel Ojeda <ojeda@kernel.org>
> +R:     Nick Desaulniers <ndesaulniers@google.com>
>  S:     Maintained
>  F:     include/linux/compiler_attributes.h
>
> --
> 2.32.0.402.g57bb445576-goog
>


-- 
Thanks,
~Nick Desaulniers
