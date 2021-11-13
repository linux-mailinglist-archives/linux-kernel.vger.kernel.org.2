Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2437A44F53D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 21:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhKMUYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 15:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKMUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 15:24:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC5C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:21:40 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c3so15776880iob.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRtrotC7yQ1PrBoDQpI8uzdE+jeqJk3Tru6SSc7SL9c=;
        b=ndr+MYiHDHZEcgKWy0JRyuQ4KGUZYN6+9Yq2CxuQUusQq3Kg9wDqx1fMW391Q8/KFP
         021v9u+yUJaJxBqo6UOrbp5lesyDiLfrIhAMLb08yU3WId4DDLf3jaxtlWFO/QONf6ms
         MySdKXUBI3ijksFRYHluXhbZPmSQJHdLcZpOLIAivOrbbmZJhndHOjod2i0MY6annzXU
         wK3AWoOc6/zpgd9PbU7ap5VwCHnTL/rExlv9wYRKS6FJH6u2x4iMJ9imlr6LSfVNqrVx
         TWX2Ek3IFF902S06lAzCg2B/CJu9tttHBBGnol2BObV2OVcVLRpJWTCrFZQumZ2awtyz
         0pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRtrotC7yQ1PrBoDQpI8uzdE+jeqJk3Tru6SSc7SL9c=;
        b=K+Yr7CTD/qmD6J2FNSoecmsRQq4PgMpuKqUFEOgP74WMVm3qyGOvbXIAmoJsAkgN+8
         VgmvhOVOA/p+saguN2sVAN3fD/4Zrt+pQCJj/lop69e+4hgV7HqZGjjWS18Awv2ebWQ8
         t4JDUpCuE3zNRGozGzTPbKsGoQqgChA4NTsO4Ouvovui3W3kgtxwEfWsBuJ+uKKUPjqm
         fAHOWDdqAunYrtPT2nU2Rpa/bkG2Mdyx4wY5Uz7tWWCTWAbeSEuQArf1hZ6j907qJZx+
         gZxeK1eYTOJ43APgF3cnS05Oyd3P0OUqpF+YRaMSdaKLXVL8Gshf4p7em4eKLolbiLIf
         52Pw==
X-Gm-Message-State: AOAM533tLiV729f2XuzVsZTBI3MGnTxraw5CrGvbX4KIhz5uH3XIrzhN
        bqHqiholO0Y80b/z8VZhCqpdapm5vDd9In9O
X-Google-Smtp-Source: ABdhPJyO3pxnCczbmt6f4j4mtMF0RPmDjqusCGzdmPW0XBJEkrtZLZdc1Ztkn9g6r0dRij4PslR8JQ==
X-Received: by 2002:a05:6602:2585:: with SMTP id p5mr11745011ioo.65.1636834900217;
        Sat, 13 Nov 2021 12:21:40 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g10sm7114831ila.34.2021.11.13.12.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 12:21:39 -0800 (PST)
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Yang Shi <shy828301@gmail.com>
Cc:     Ajay Garg <ajaygargnsit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211111084617.6746-1-ajaygargnsit@gmail.com>
 <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
 <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk>
 <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
 <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e2ad5ac-020f-7e2b-4e15-c875b4634546@kernel.dk>
Date:   Sat, 13 Nov 2021 13:21:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/21 1:16 PM, Linus Torvalds wrote:
> On Sat, Nov 13, 2021 at 9:21 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Maybe Andrew is out - Linus, if you follow this thread, there are two
>> proposed fixes for this. It'd be nice to have one of them in -rc1.
> 
> Neither of the fixes were sent to me, and honestly, I think the real
> issue is that the original commit is just too broken for words.
> 
> The error handling in that commit is just entirely lacking.
> 
> I've reverted the commit rather than try to fix up the breakage.
> 
> Because at some point it's just better to say "that was broken" rather
> than try to fix it up. And that original commit was too broken to be
> worth fixing up. It already had one fix for uninitialized variables
> before it even hit my tree, and then caused problems and had obvious
> broken error handling.

Thanks, that obviously fixes the problem as far as I'm concerned as well.

-- 
Jens Axboe

