Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653DD37FE27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhEMTdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhEMTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:33:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:32:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n2so41416010ejy.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PFEMK3YaHztEuLX/0qHNhPRBEmn2XvXgUGBhkca4xE=;
        b=K25CsnCq077r/r4B1m2yh81D9qgKhQYnf99ghLEffSrrY380rLAFfdixlvEpKlaY5j
         oWn0+BYK8RcQPQiQ/TEgcdTJUspxoafxOK2/prjgh5vpSgzu0pabQYjUdMMHdfoe2QwX
         anfuESWtWPR+nGAI1F2edxjQpghAyY0r7KS6OKQD3Ez4jY6bFBHyzQmP6LJBV+TscYi8
         I64AsH/yHsdcDnFOHIZaE1PRR5sMlZDFr4j/VIPwYLNM8qSH7fpsyQzuzXgowY9pYTLv
         UqYwvySdodmLWy4JyoPMkmYEGtjasdEmyo8z6dKbp7DWWea2GlSM1B+CVHvxBwToisXx
         XP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PFEMK3YaHztEuLX/0qHNhPRBEmn2XvXgUGBhkca4xE=;
        b=UFwvzr5vJa6XyRpukR0WTJi26DQ1D5O4YAqpXLNlPFPFOMRVjuj6ZU2+cbq1dXICPg
         GGYi74fJXO9kbN7Qn7fFPpRN3dd5IzylfoYwC+vb9hVEJmHjzu4zl/WfQ6z9s7mJCJw/
         NjscUBydUdRlkxbkIfmVW4Kr9UkHApwBozLs8wg5x06ho9imZs18B6D7QxvV7tlfYiH2
         U+N8yJxvfpwuwgt9z5O8fMafhT6L8k72HRJ7+bblpUlLqlymTtbRjB9t0KcKYiFuRJ8e
         M+WcI2BvZQbLNSUMh7YN5GzACArtg1007JUUXX1iaZ3obbfKmiyOSHpWVpRtWI8G837H
         phOg==
X-Gm-Message-State: AOAM532KaDm1eni+0c7nnae/qa1mIO6aSkAqkETdjTOWk/Lo8Erns4z9
        0KcUyYdD0miFuZN33LDCXEkFbtlBIf13AZ4SacY=
X-Google-Smtp-Source: ABdhPJxfxbrOoBqYhgwMN1FHd94U/QcMTZqsbypSB9DP59c8nitHkqyv7qIslc0RVVZ1JUKtd5OUx2KRWGCZ6L17hxU=
X-Received: by 2002:a17:906:90d6:: with SMTP id v22mr1608070ejw.98.1620934333317;
 Thu, 13 May 2021 12:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <1620904043-71858-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1620904043-71858-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 13 May 2021 12:32:02 -0700
Message-ID: <CAMo8BfLAsoADU_9G9ZB4PRbw7b98vkRzXpgiB12RkXx1g5aGqA@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Fix duplicate included linux/unaligned/generic.h
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

On Thu, May 13, 2021 at 4:07 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Clean up the following includecheck warning:
>
> ./arch/xtensa/include/asm/unaligned.h: linux/unaligned/generic.h is
> included more than once.
>
> No functional change.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/xtensa/include/asm/unaligned.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

There's a patch series from Arnd Bergman that reworks unaligned
access posted here:
https://lore.kernel.org/lkml/20210507220813.365382-14-arnd@kernel.org/
resulting in removal of this file. I don't think it's worth doing this cleanup
in the meantime.

--
Thanks.
-- Max
