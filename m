Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F737798D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEJAsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 20:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEJAsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 20:48:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B39C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 17:47:41 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso12938794otb.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 17:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gxLqOJA08hNu54aM4rIjzavEm9ERKA+Pdl/tjQ9tgjQ=;
        b=XdxILQVzwmVOvN8pBkOU/WkF2PLJGawLg/rwCpZq8PjrLQNdU5AxP6Ge3KH4stD8ZF
         AGnur+oU71+eO9RNS7J8vemWw28MQMQ6VluK9q0P1C279jjga6kH6mI8b/s5mAo+II6a
         HEStBvGsIMuB0T93p5qnGqjdaKNFDkjVSlXZ7mXLlf+mD36/Q8gXaTh0ZnHJLghllTHn
         sxuzVSUHR7P9Jt6NyfNft/laDqz5Y5UX0tWoNPfPFAi5PWcwZFriO24ArAmCtOHgpBwc
         z0/igfcjVj8yPDc2lSVsXxZvVEM9EITbAQ9d2tXM79B138bUgABKsvyi1FD+XWIPYfjW
         Ap6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxLqOJA08hNu54aM4rIjzavEm9ERKA+Pdl/tjQ9tgjQ=;
        b=oru8KHrpJqqIPryBC9Rp2bKPkHwt8cewpZDieHntzo4WIwHN1wx0aCt+rZfOhcVSh5
         q2pcgQjsOf6M1euAoaZBxQMr3iab4ebLNworDWTW5t6sVGxUrqOtSxUbpmjqLkZ747Zh
         GA8/nnI5kH48h3qOFyIdTV0ZA6CBmlRKS9rE7CQtd65dNQEHgMyVApoYxIfWc1UTnBjP
         9s7gs7S7pvJHpI5G1I+s/g4U/KAi8xvEOymD/bwEcQyDEePbzKRv2oAcZIySa7EiK9dk
         4zHbRiduc0/M8weS83mY7cV9S37D+XusXeZWWF1vqwnawuNh+j1hHPKTUmTO+gBwvrti
         Pj7g==
X-Gm-Message-State: AOAM532ecwm9GkeImljRj/4knPUNIUYCRYJkzsMy70VDSK9K1uld88u5
        +kgPof+vHG/ivjUnpCWxJlhAbZSDyt0=
X-Google-Smtp-Source: ABdhPJwyHw0Dcn9odixq+xdSRCBgCbRViSs51kLGnOJbNOMAtaPbLU9tMsVmqAOD5R2YVp4wnCm9jQ==
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr10598913otq.66.1620607660502;
        Sun, 09 May 2021 17:47:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm2380506oos.16.2021.05.09.17.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 17:47:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [git pull] drm fixes round two for 5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9twAN82gkzrfc2CGQopjkjEdWtBKMF2DgBOtw+6RsZ++fw@mail.gmail.com>
 <CAHk-=wgf+kHeSZbpkZumWcTXUD7ordqTMvPRNL6aQVG1DSBDnQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4747c9a9-1b2e-bea2-e92b-2a922d465edb@roeck-us.net>
Date:   Sun, 9 May 2021 17:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgf+kHeSZbpkZumWcTXUD7ordqTMvPRNL6aQVG1DSBDnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/21 2:08 PM, Linus Torvalds wrote:
> On Sun, May 9, 2021 at 11:16 AM Dave Airlie <airlied@gmail.com> wrote:
>>
>> Bit later than usual, I queued them all up on Friday then promptly
>> forgot to write the pull request email. This is mainly amdgpu fixes,
>> with some radeon/msm/fbdev and one i915 gvt fix thrown in.
> 
> Hmm. Gcc seems ok with this, but clang complains:
> 

Yeah, sorry, that was supposed to fix a problem, not replace it with
another one. And, as you noticed, gcc didn't complain, so I didn't
realize that I created a mess (and don't ask me why I put that
__maybe_unused after 'struct' - no idea).

Guenter

>     drivers/video/fbdev/core/fbmem.c:736:21: warning: attribute
> declaration must precede definition [-Wignored-attributes]
>     static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
>                         ^
> 
> but I noticed it only after I had already pushed out the pull.
> 
> I'm actually surprised that gcc accepted that horrid mess: putting
> "__maybe_unused" between the "struct" and the struct name is very very
> wrong.
> 
> I fixed it up after the merge due to not noticing earlier..
> 
> Maybe the drm test robots should start testing with clang too?
> 
>             Linus
> 

