Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC9377F79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEJJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhEJJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:38:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DAEC061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:37:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b21so19961436ljf.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcaG0GmT4B++jjY5eIwmc96+jWhlisDKnwVvc2I6woM=;
        b=c7YXWVgbyBcZvROVb48PSKo/2j5k+2aKRYx9Fiz6FF1rb0+sS0HKZwZ4q/pYKHJJM2
         8MysZ42J7qQfS1AaGPL06y6GI+7dQNX2KXdoxIW+vThGB7c0gNm0qHtIrXT1vk38lfDt
         TT2GZMho23oeO5kRg0xP7BxqTU5vxyF+P7XQjy9LIQHAbYlMk8Z99cN/aZ9gg8/2UqBi
         M9dPo8OsEef7WinTvd5CddJ9KRsqkDvw3m99o8JebrqZPdldkc58CjzIMla38vSdtAvt
         1FKAzYzpJEQB0XPTJkPnFVBHJIbtHhc4tNpCGMh62fTJXwOtXJGfcu+LRhkOQ5k7EloK
         NVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcaG0GmT4B++jjY5eIwmc96+jWhlisDKnwVvc2I6woM=;
        b=Ce4LR30Eq4Tk/uLnuaFRogdxozspz9HdmKDxDtCSWvUD0QIJ5cIn9C4NYTZKSqa/yS
         6FZlCRqQ9tGB3yt1OGCTXsatWJn4Ecfbn2FjIgg1dRqis3eQgjHwKH8IYA1n6KmDeYrb
         nEYdqfAbel1UbkQGjzkAVRM/G5/iSyT9K5sQZtDCgiPXoMMJXp2bBnkvJhI240DKHhuf
         jJ5OuL2U0kU8esmXwv1pau/pd2/z8gjwW+xQBVjEmG+fPmwvKgRfAPuLZzVVY3rQwjur
         6dfoIXm8gq5b4XB7tXv+kRWgcz+jqAWBRn3tu2a0dYAazH4RFwd44s3RUXSLqKMmsjpm
         175Q==
X-Gm-Message-State: AOAM532v+futy+bmX0bgg7G3gTFk+8Aoejd0h3Bbe5s4R3u4cIEsOMby
        SdfRILxG1JzAlp/EcjqtHXcldXX9DGP1R15odJ/06A==
X-Google-Smtp-Source: ABdhPJzzR8Bq+uJPCq3kNj0Kl2N0G07wycK7PvUp8MhBy3xa1S2E6qHMsRmJTZwM7lEx/u4FpQIAzzlq7UYI/tcm+Ck=
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr19635907ljp.368.1620639433379;
 Mon, 10 May 2021 02:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210509173029.1653182-1-f.fainelli@gmail.com>
 <CAMj1kXGt1zrRQused3xgXzhQYfDchgH325iRDCZrx+7o1+bUnA@mail.gmail.com>
 <5f8fed97-8c73-73b0-6576-bf3fbcdb1440@gmail.com> <YJjkOLg/Ivo2kMOS@kroah.com>
In-Reply-To: <YJjkOLg/Ivo2kMOS@kroah.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 May 2021 11:37:01 +0200
Message-ID: <CACRpkdb+4OFpsJAPkEjTBBf_+VTUvKkzsDb9xaSOxqhNSWkeeg@mail.gmail.com>
Subject: Re: [PATCH stable 5.10 0/3] ARM FDT relocation backports
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, May 09, 2021 at 06:22:05PM -0700, Florian Fainelli wrote:

> > This does not qualify as a regression in that it has never worked for
> > the specific platform that I have shown above until your 3 commits came
> > in and fixed that particular FDT placement. To me this qualifies as a
> > bug fix, and given that the 3 (now 4) commits applied without hunks, it
> > seems reasonable to me to back port those to stable.
>
> As this isn't a regression, why not just use 5.12 on these platforms?
> Why is 5.4 and 5.10 needed?

Actually I think it *is* a regression, but not a common one. The bug that
Ard is fixing can appear when the kernel grows over a certain size.

If a user compile in a new set of functionality and the kernel size
reach a tripping point so that the DTB ends up just outside the 1:1
lowmem map, disaster strikes.

This has been a long standing mysterious bug for people using
attached device trees.

Yours,
Linus Walleij
