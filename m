Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C931212A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 04:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBGDah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 22:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 22:30:35 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79BC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 19:29:55 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id q14so2824504ljp.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYbm//cUR0InpLPNHSXpOGWXSrCz7B8B5No4bQkGlUo=;
        b=Bv1RNWH2KXDnV/6TdSNNWgMNe/8vr6sFCVNr0fn/62puKpvImwNmMV3vSLqkVUqqk7
         /bS7TKX3i1cakxrRmc80TtfPZez3KhWrWqHwSsExzrHGAz9oLwonjNUcDZmNpaAEqhHi
         YmoPaEeANKEJk7nAXWPqCdQK+WyXg9nlDO82rqjAYH0yF+9/+DSxjYYOj2QOpi0oAbx8
         eJX1rx46wuebCximG1FYFsMe8jk+RzPnEAV5YnghW10zQA3NoWcdwt5md+DL2UTCNND7
         hVamCJhkhTggYsPk511FumXBWu+bOQq8PUVLPC1wH6pTf+rfeGyXYNKvSKLHNFPcryS+
         y9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYbm//cUR0InpLPNHSXpOGWXSrCz7B8B5No4bQkGlUo=;
        b=r8Sz7/Z3zviwNXJS2mRqwDJaNZzvkwkMW6fE47UCHvKXswpoW/QoR0nBfumA5s9jQg
         UimFneJh4s9I5Mx8gJvPi0aQkFDggVecBYKS4S3N4GGeHwcu6NLnVsEAOK4NBoAiuGyD
         rYarN/qomH8iTSYQu4D2wzAeotMYzIkyXDKXfX/JjDvSfSFsnSv3z4Pm/WyJTV9ttnDz
         Cnq6SR+bnPQOdecqVvsfLraALcW1WqpzSw2G5yQDupnVZD6HM9nnnjtDbMlwN6zDyP5x
         V3W3oOfmDR4s0n1ofuukteAM/bafFD5gVoZ8XSDeb0wovz3VU1ZZ4YGzEW3rzL8pte6k
         TWzg==
X-Gm-Message-State: AOAM532DkOFn2TylbmX8Zl23Q5x2XfG0tbty7/LIjfA2iJJOaKEANA7F
        +hyzD516WTdjdqPs4Se8vPseJiqXp4YFFG8ORYo=
X-Google-Smtp-Source: ABdhPJzCihwJlOQzdY8mmeoTi34cYXGUnjiITHknHKZ9tbvuNCXExpakJbdFJ3u3YCP4Y+TACxCe/i1eUQqzwWoPolQ=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr7008504ljh.89.1612668591965;
 Sat, 06 Feb 2021 19:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20210206053109.78205-1-dong.menglong@zte.com.cn> <CAHp75VfMYOz+qexix_TujGfUgFAtUXdbS=ekVdE_4cwRv5W8pw@mail.gmail.com>
In-Reply-To: <CAHp75VfMYOz+qexix_TujGfUgFAtUXdbS=ekVdE_4cwRv5W8pw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Sun, 7 Feb 2021 11:29:40 +0800
Message-ID: <CADxym3bsqAH969H-P8SSam+_gbjgWkxP90Zh-RnzDaOJuwD3ig@mail.gmail.com>
Subject: Re: [PATCH net-next] net: socket: use BIT_MASK for MSG_*
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "dong.menglong@zte.com.cn" <dong.menglong@zte.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Feb 6, 2021 at 4:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Saturday, February 6, 2021, <menglong8.dong@gmail.com> wrote:
>>
>> From: Menglong Dong <dong.menglong@zte.com.cn>
>>
>> The bit mask for MSG_* seems a little confused here. Replace it
>> with BIT_MASK to make it clear to understand.
>
>
> It makes it more confusing if you understand the difference between BIT_MASK() and BIT(). I think you have to use the latter. And note () when referring to the function or macro.
>

I replaced BIT_MASK() with BIT() in the patch of v2, and it looks much
more tidy.
I can't figure out the difference between BIT() and BIT_MASK(), seems
the latter one more safe... isn't it?

Thanks:)
Menglong Dong
