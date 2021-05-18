Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3638816C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbhERUbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhERUbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:31:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4681C061761
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:30:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y9so13017228ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Bk9uyRl39i9BigbgL1GtEM49Gq25V6Tx/nXtBMrKNo=;
        b=mofCgvJkkGJgUFrowNr047mWFYLqxlNiPdenhhnYFLtrf3IQ1CZd62y5f8HADruKDR
         ErriEpbaLgEc+vbv9t1OkBEd0PWXDL6hKOemqw9kCuk+3/aaQaxkzae6Gox9rUrIjhVi
         2f0kkpjbrxoMJljbtRUGtN8kjFneN79IqB8AS/Q2Ig8VCzacCU/+RU6KswmZi6PyiHx/
         xNfmQdsDP4EFnkO2HfDCRycrUn+S3MkOiIoPrFbu9nkhf3FsS9vfyK06XScgBL0DjAXn
         GRr+1RHdh0eWPRDUfOpA8Jh1dE7XpcacP5wG8FqQcOEjWLl3dQS68dqp1R/8Zc36ZRXX
         ICmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Bk9uyRl39i9BigbgL1GtEM49Gq25V6Tx/nXtBMrKNo=;
        b=SQxyGi/yPvmefzk4QXegW6nNoR7X3P9meNG0bSVtFYo3D7j7OXWViKUbGW8UMEjr5x
         X46Oe/hH4hiyM6lY4PBZ0Z4Gxp/GCBNg3mTraz+M1R974alMuGKW4028/Ga0Q5w7/VYw
         67Gm4bGdHNBa07dsIjeQzmyqb9SlWf175ZcKWfBdem2eWCtX/bMgFLhi//LB67As6cx1
         11nAAO1gtgRniiMrK2zZpNxEaiCyvv3TX7mnIeFj6Av6qkutDuBRSDfZh0orYtZV/znE
         hgrlV4LpVZjX5yoOzyTZEDO+ZNjkDYl8ecwyZPx5g9zEyPiq9dkwlWtlof0sp6pGAgFX
         +5ag==
X-Gm-Message-State: AOAM532ctHLbjnOYywd7R8TxSKI0JkoEgrmWvXAJoc0anh0hhE0gJYuG
        v+Jqb9uLoquZ11s7XL+Aur/liEMmWo19QIFeUwkeVA==
X-Google-Smtp-Source: ABdhPJxkfBJNSq22wsmPPI5Rlho3AJN6nyLxBn81iDJNAa2KAlRw1b95RKfh5eHdEPzg2SwiL/2djVUmAg+MuMugAjE=
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr1811072ljm.244.1621369816059;
 Tue, 18 May 2021 13:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210518181247.GA10062@hyeyoo>
In-Reply-To: <20210518181247.GA10062@hyeyoo>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 May 2021 13:30:05 -0700
Message-ID: <CAKwvOdk+BZjNeGNjW3a0_yRoGhonP0=Jr6C7=KxWQphkU_dRkA@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: Fix support for clang 10
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:12 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> Previously in 'commit ff3daafe3fd3 ("mm, slub: change run-time assertion
> in kmalloc_index() to compile-time")', changed kmalloc_index's run-time
> assertion to compile-time assertion.
>
> But clang 10 has a bug misevaluating __builtin_constant_p() as true,
> making it unable to compile. This bug was fixed in clang 11.
>
> To support clang 10, introduce a macro to do run-time assertion if clang
> version is less than 11, even if the size is constant. Might revert this
> commit later if we choose not to support clang 10.
>
> Fixes: ff3daafe3fd3 ("mm, slub: change run-time assertion in kmalloc_index() to compile-time")
> Link: https://lore.kernel.org/r/CA+G9fYvYxqVhUTkertjZjcrUq8LWPnO7qC==Wum3gYCwWF9D6Q@mail.gmail.com/
> Link: https://lkml.org/lkml/2021/5/11/872
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks for the patch; hopefully this isn't too much burden in order to
help us support clang-10 a little bit longer.  We will rip it out when
dropping clang-10 someday; grepping for CLANG_VERSION should turn this
up easily.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9d316aac0aba..8d8dd8571261 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -413,7 +413,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>         if (size <=  16 * 1024 * 1024) return 24;
>         if (size <=  32 * 1024 * 1024) return 25;
>
> -       if (size_is_constant)
> +       if ((IS_ENABLED(CONFIG_CC_IS_GCC) || CONFIG_CLANG_VERSION >= 110000) && size_is_constant)
>                 BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>         else
>                 BUG();
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
