Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0534D406542
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhIJBg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhIJBgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:36:24 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668EFC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:35:14 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z2so446433iln.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 18:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1H/ZwUjSaeato6Vkx2GrUYvC6xSfGX3nvBpu2j9F5vE=;
        b=2IZpuQEXyvFsNXKAivWqPmlOyQoo5m/xmekVdtRUiazGXJsyw592lOTKLK67U0aws3
         ZhjnuhUIptGMV+Q0lZdo9yyCe/TEvfAXum8wMnydBTlZzXWNgHplu6PVa1ljUt9jmzzy
         zZ8v9rVIBoHIFxKRZtPTcd5fPkiWZh+s0AaMVkF8K4VKOaWgFqDvdo5T2GkbcjvMKyKW
         Xi5KE93SlfmI4G6PS0y3JNBFD/Itmd7qHJSkkvZjw3PW+kzotgAi+ViXmK658qiDPkwM
         vVBbXPVcS3/K7BjeIyACubZiPcV8m35bUBEGoSmeH6DUCSlqW7APm+zkv0cz+lSLcvZJ
         c/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1H/ZwUjSaeato6Vkx2GrUYvC6xSfGX3nvBpu2j9F5vE=;
        b=Cnk6FXQLd4KpV94S13jYYMcv8v50xGGGhSNu9vCfilC5y7zgR/f7aAGDkI/rery5RU
         WxKmHIxEJlT9sm/BGJbDNZx5EfF9KoQSrGbB4aNfTpuM/1mLPrq5hLJ8AHOVFxdEUn2w
         qxfi25Y+Nj6+Ioq02YiFhoZUgbDb3Bo4cGhAZUGT47HypJHIWK2IdaI4s607tZgyq7x2
         eHn4NYy+wvvq5NhOg2aeXnbcrSIlYky7afQppx2BkOjiYEbrMdXjDgwMvRKDq7zyfG17
         gIJpiWfqP5er9oxnTIfGLUFImq96sWyYp2MqU88uwEtrpmpqILDmNcbw3ITmvQST/DgY
         cDRQ==
X-Gm-Message-State: AOAM531giIqwIJS/O9bfDhlKoAK82NXCJBb74VbRse+8bP1sgCnDx7sc
        h1SExKZGlPIYTFw520u4rLQKUERqYsRtvg==
X-Google-Smtp-Source: ABdhPJy6oMUoYpPkEpk5+vCExCnrXClCjJGY3EXPkz28VotQxaKGMkBHy8pM+FVNfOeslHtMQdEC9g==
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr4500469ilk.61.1631237713746;
        Thu, 09 Sep 2021 18:35:13 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j5sm1685278ilu.11.2021.09.09.18.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 18:35:13 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
 <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
 <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <88f83037-0842-faba-b68f-1d4574fb45cb@kernel.dk>
Date:   Thu, 9 Sep 2021 19:35:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 4:56 PM, Linus Torvalds wrote:
> On Thu, Sep 9, 2021 at 3:21 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/9/21 3:56 PM, Linus Torvalds wrote:
>>>
>>> IOW, can't we have  that
>>>
>>>         ret = io_iter_do_read(req, iter);
>>>
>>> return partial success - and if XFS does that "update iovec on
>>> failure", I could easily see that same code - or something else -
>>> having done the exact same thing.
>>>
>>> Put another way: if the iovec isn't guaranteed to be coherent when an
>>> actual error occurs, then why would it be guaranteed to be coherent
>>> with a partial success value?
>>>
>>> Because in most cases - I'd argue pretty much all - those "partial
>>> success" cases are *exactly* the same as the error cases, it's just
>>> that we had a loop and one or more iterations succeeded before it hit
>>> the error case.
>>
>> Right, which is why the reset would be nice, but reexpand + revert at
>> least works and accomplishes the same even if it doesn't look as pretty.
> 
> You miss my point.
> 
> The partial success case seems to do the wrong thing.
> 
> Or am I misreading things? Lookie here, in io_read():
> 
>         ret = io_iter_do_read(req, iter);
> 
> let's say that something succeeds partially, does X bytes, and returns
> a positive X.
> 
> The if-statements following it then do not trigger:
> 
>         if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
>   .. not this case ..
>         } else if (ret == -EIOCBQUEUED) {
>   .. nor this ..
>         } else if (ret <= 0 || ret == io_size || !force_nonblock ||
>                    (req->flags & REQ_F_NOWAIT) || !(req->flags & REQ_F_ISREG)) {
>   .. nor this ..
>         }
> 
> so nothing has been done to the iovec at all.
> 
> Then it does
> 
>         ret2 = io_setup_async_rw(req, iovec, inline_vecs, iter, true);
> 
> using that iovec that has *not* been reset, even though it really
> should have been reset to "X bytes read".
> 
> See what I'm trying to say?

Yep ok I follow you now. And yes, if we get a partial one but one that
has more consumed than what was returned, that would not work well. I'm
guessing that a) we've never seen that, or b) we always end up with
either correctly advanced OR fully advanced, and the fully advanced case
would then just return 0 next time and we'd just get a short IO back to
userspace.

The safer way here would likely be to import the iovec again. We're
still in the context of the original submission, and the sqe hasn't been
consumed in the ring yet, so that can be done safely.

-- 
Jens Axboe

