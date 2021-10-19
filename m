Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD647433C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhJSQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhJSQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:34:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3828AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:32:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t16so15101831eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xUa4jDp8wEq2+KyjYLUoyDAf9haNG/CAH7QLO3lCFg=;
        b=Rk3hPiN1Cgn4j+zmGpM0dENIhRnzhwt3kwrJw0dXrtwRIVtz33CBjd1xw9nFoz4Y54
         orSrK+/3veW61o8sx5I9LiM2oX+VL9+WV8tNCkfSFeACCFxjFpO8cuGdJWAtcl/R/iyd
         JSllRqHrbTYt0SodjJZCokHVxZoY+roP3verKxSMGZha5nDo8UundCHVvMKz1yLlLX+A
         Yv2x2RPOb7INYdlisfjqVAAnylzMCH1JejmnWqjvrI9KZfd5Z+AdFC3UQVR1xC3YrEtN
         +oo8OMgQVykkiHbVa0UEw91IZP1jygwfZXxmIv3yzPWsmS4pbb1XvJ2GC/68Aw6XihBt
         Rcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xUa4jDp8wEq2+KyjYLUoyDAf9haNG/CAH7QLO3lCFg=;
        b=sYonrBA/sj/s/NAjtJNoSXAWqZ2CZ0j0GrasyLf1ntX01tnzgS33mgIememtcu+gg7
         720jVsT03R2qyfn+RwHzoseGwSv6/vcRhKKZ/iPhhyl2i1n0ewdCtCXwiNRJJ2Sq/zLR
         c6WtCpRKpYPnte5svfnXVvaVGQOUb5oFkyOl9C5dnKtuJu2m5jZni5LeUcKQtRmdigGC
         IFNoQ5aFQfQo4gUrj6gA7/y27xNsl1qxnkka2wGD+pbw0ToKtmm8Ej9bOnUd89yuUR5O
         GXveckeDxBjxFabCh4Joy4ma3XPOKADUTOKyAQrp3ljuM97N5xE76KTqjPP318XDCpNt
         5jIw==
X-Gm-Message-State: AOAM533+zhQIo88TEDhlGWo+RKyOvWv/sfaOMy5b61opLlgkFBwiSc0m
        4sYs/cv7wfRY5rId+rKzlXOhyvHl7P26n6CpLSlY
X-Google-Smtp-Source: ABdhPJx2DygXOAUIL+ZmjqAeaXSLbDoYpIDmg/VlX8my35/hQmEKkmgE44G+Jhusz2tWvG+Y9ihUjD2QYXGPH0taDhY=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr55776304edb.209.1634660962615;
 Tue, 19 Oct 2021 09:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuY3BJ9osvhwg0-YG=L+etgCBfCq0koC9BEkvK8-GR3ew@mail.gmail.com>
 <20211019131049.GE28644@breakpoint.cc>
In-Reply-To: <20211019131049.GE28644@breakpoint.cc>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Oct 2021 12:29:11 -0400
Message-ID: <CAHC9VhTobH9ExRt5fLx+S9ibRipeA4pj8yFhjDKb0Buq6naD5A@mail.gmail.com>
Subject: Re: [next] BUG: kernel NULL pointer dereference, address:: selinux_ip_postroute_compat
To:     Florian Westphal <fw@strlen.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 9:10 AM Florian Westphal <fw@strlen.de> wrote:
>
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > Following kernel crash noticed on linux next 20211019 tag.
> > on x86, i386 and other architectures.
>
> Paul, this might be caused by
> 1d1e1ded13568be81a0e19d228e310a48997bec8
> ("selinux: make better use of the nf_hook_state passed to the NF
>  hooks"), in particular this hunk here:
>
> -       if (sk == NULL)
> +       if (state->sk == NULL)
>                 return NF_ACCEPT;
> +       sk = skb_to_full_sk(skb);
>         sksec = sk->sk_security;
>
> state->sk might not be related to skb->sk.
> I suspect that this should instead be:
>
> +       sk = skb_to_full_sk(skb);
>         if (sk == NULL)
>
> See 7026b1ddb6b8d4e6ee33dc2bd06c0ca8746fa7ab for the origin of this
> additional socket pointer.

Sure, I'll patch that up now.

-- 
paul moore
www.paul-moore.com
