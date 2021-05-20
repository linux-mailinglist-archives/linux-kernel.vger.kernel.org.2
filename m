Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D2138AD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbhETLw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbhETLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:48:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004CC06138C;
        Thu, 20 May 2021 03:15:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z13so23688287lft.1;
        Thu, 20 May 2021 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aih/d9855v20nIT+U7ZGnplm0nKULD9g48GJ8t3Fc4=;
        b=XpCvTFvkUZMZKmbL0+fpxbM24MMpjQGwQ07dN2rzc30AXj0c5XvZ1pBV9QSbA8JqcI
         gwkWFlIv1LIZPKaMNrRqARFzk1OmiqW5eepN9euCwKdEE7qxc+pI7Vigf6EHLp4zmQEq
         WX4rYZZrZF3hM0Oze7xDsFHR0eXL/E1XJmzgJh0JCLS5I+cVheSdk7xTuXs4gQt5/jc3
         JH7W895ElWhxzggpWUs7DavKkRoY0s2X7F1kQzwCoYgTQnW9n2231qsmOH+2H9Zj4ntR
         865bwangq/WyEnQmb3UM4S2bgAIZmZymg9vfin94XCNryEASAnWtMGrWvFOuw/nsjHLr
         Ihmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aih/d9855v20nIT+U7ZGnplm0nKULD9g48GJ8t3Fc4=;
        b=V+hi0qKBy1kvR2rfnLAGjOOiKZa4SIP8CjzNDatDwnPaHRk3jowUAKI4T1wxvm96CG
         lSU909MHnK1Rurfu6iqNpEZt7RajcZlp7VRWo0qiR+DOFpVesH4fbhNrSjIAemEM2lGR
         tV2ojfhCtAk3tE+ugTkT3N19VYVZr8ZMy0Ni33Q7WA6E/+ckFnDTK91QYkp7HDexC620
         CCIrqxjniDHOfQBkJslLArN79Stvi+iqi23Z8j/GzeyFpsTmOqs2TQEC4gS1wgGDfZ9K
         MR5evEt9qxTsPUGhcQ+zUkOjP/djnxoKsTUgRGc3R83198dQCF1heBvbIUHX5B75xs03
         yT4w==
X-Gm-Message-State: AOAM53068GF4wCbum/7Ghd/MQvVA0bVIFEYCOnl5GjOZnsEAGHbXEbQY
        ZM6IB2r+/Iz05pWJ2YJuEsIGKoXtyyVgOu8Eg3I=
X-Google-Smtp-Source: ABdhPJw1AXKmS8ULiIJu5WsnA6PZ5Cp6w5T/JRJQQHu8DK50jRaoxHpKcGlftGbj8SyvryF8zRNtnr7NI6fXZEuYJpQ=
X-Received: by 2002:ac2:4ed9:: with SMTP id p25mr2856096lfr.576.1621505733022;
 Thu, 20 May 2021 03:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210520093949.511471-1-andrew@aj.id.au>
In-Reply-To: <20210520093949.511471-1-andrew@aj.id.au>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 20 May 2021 15:45:20 +0530
Message-ID: <CABJPP5DHgq2gA7K-PiWK6UTx7t8zLaFuz1LCt9eNZPBs3u+hKQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: checkpatch: Tweak BIT() macro include
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 3:10 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").
>
> Since that commit BIT() has moved again into include/vdso/bits.h via
> commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
>
> I think the move to the vDSO header can be considered an implementation
> detail, so for now update the checkpatch documentation to recommend use
> of include/linux/bits.h.
>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Acked-by: Jiri Slaby <jirislaby@kernel.org>

Looks good to me. Thanks.

Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/dev-tools/checkpatch.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index 51fed1bd72ec..59fcc9f627ea 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -472,7 +472,7 @@ Macros, Attributes and Symbols
>
>    **BIT_MACRO**
>      Defines like: 1 << <digit> could be BIT(digit).
> -    The BIT() macro is defined in include/linux/bitops.h::
> +    The BIT() macro is defined via include/linux/bits.h::
>
>        #define BIT(nr)         (1UL << (nr))
>
> --
> 2.30.2
>
