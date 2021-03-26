Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2847349D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCZAIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhCZAIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:08:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A564C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:08:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4751700pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5LQGEV/XotMuyuz1CXyie0Md/UT+OzhAqeM1dUlnYKI=;
        b=VsPVBDjuQY8fE8qqrVaabEcEovyHgIMvvqxl6CPR2Jv+seH7lnMbk6ka/+1nztfM6t
         nk9XKspZQ2ZeJPHMqvBJ7A3CaeMJgj+pE2gCnne4aJTm2upujeTjXupj7G+nqcXWwsVA
         fczFh22c4wdSMLjkOScrpMmjdBe2msOWJzv/1IVjCkqb6tJTvGplcuaeYHsX/6CV22Ao
         LO0R1t1ojWSa+6OB25kB72btSFScwEYkIuvfBGkXEr0FL7DEKYqqKE8wyY9vP8/b5C5j
         WPf75k7U5BOiTIypWXOmZ8KCAOSa4Dtw3ePk2EWvhxn/Ic1LR6WcXpn8UD9C2KKziNjj
         RR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5LQGEV/XotMuyuz1CXyie0Md/UT+OzhAqeM1dUlnYKI=;
        b=HAO8kuZbgyX7iuy1AL1kFlws1IT9EoKmqFppdKK2SsXaBs15dO5PQ0xFDGjTgvTLB+
         zVUJ06UhQdEytllXhX6l8nESR9y9pkOX1RgQbDFEimBBpzcwprQ5ZHDa8uabKsytSWWg
         O8CtTNwzwYUhPW9CcbXPHzCcaBvPJwpQ6kt1AKlxMEFqrsi0hXjILJZnlsW3VtytQO/6
         5HF798cV8XL7e3zTHzc+Nf+FGChef3DpXD+VFz2LAwBwoMc+wGYDlB7IH/ws8c7M3W47
         xnJv8QRv4YTMaNpyknDC/Mkyxe0Q8TbmuUPZtzgYNYfAdIJeTyMy/iuh0WsjDupJQEt+
         ZB2g==
X-Gm-Message-State: AOAM533ExbTEW3Yd73fdyFKDdzhj0yYZhyGIEefCl8ItTogoNzc2u3k9
        as+w2Kte2GwMGII6/r+V75+J2RuY9kcxjA==
X-Google-Smtp-Source: ABdhPJw/v00FeXo67sugquT3tXY6PAH5+15iT+v0wdxvvUxgyzOOVXRKMeoCwTCh8I8OFor7WzGTlg==
X-Received: by 2002:a17:902:7682:b029:e6:2bc5:f005 with SMTP id m2-20020a1709027682b02900e62bc5f005mr12435766pll.32.1616717293113;
        Thu, 25 Mar 2021 17:08:13 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i10sm8251356pgo.75.2021.03.25.17.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 17:08:12 -0700 (PDT)
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
References: <20210325164343.807498-1-axboe@kernel.dk>
 <m1ft0j3u5k.fsf@fess.ebiederm.org>
 <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
 <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
 <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
 <ad21da2b-01ea-e77c-70b2-0401059e322b@kernel.dk>
 <f9bc0bac-2ad9-827e-7360-099e1e310df5@kernel.dk>
 <CAHk-=wgmHRvoYdsA2ZL4aEOYvNx-5c7typsUbFcqq+GmOMcoDQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <003d6524-3852-7ec2-9d60-63ec43c50187@kernel.dk>
Date:   Thu, 25 Mar 2021 18:08:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgmHRvoYdsA2ZL4aEOYvNx-5c7typsUbFcqq+GmOMcoDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 4:37 PM, Linus Torvalds wrote:
> On Thu, Mar 25, 2021 at 2:44 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> In the spirit of "let's just try it", I ran with the below patch. With
>> that, I can gdb attach just fine to a test case that creates an io_uring
>> and a regular thread with pthread_create(). The regular thread uses
>> the ring, so you end up with two iou-mgr threads. Attach:
>>
>> [root@archlinux ~]# gdb -p 360
>> [snip gdb noise]
>> Attaching to process 360
>> [New LWP 361]
>> [New LWP 362]
>> [New LWP 363]
> [..]
> 
> Looks fairly sane to me.
> 
> I think this ends up being the right approach - just the final part
> (famous last words) of "io_uring threads act like normal threads".
> 
> Doing it for VM and FS got rid of all the special cases there, and now
> doing it for signal handling gets rid of all these ptrace etc issues.
> 
> And the fact that a noticeable part of the patch was removing the
> PF_IO_WORKER tests again looks like a very good sign to me.

I agree, and in fact there are more PF_IO_WORKER checks that can go
too. The patch is just the bare minimum.

> In fact, I think you could now remove all the freezer hacks too -
> because get_signal() will now do the proper try_to_freeze(), so all
> those freezer things are stale as well.

Yep

> Yeah, it's still going to be different in that there's no real user
> space return, and so it will never look _entirely_ like a normal
> thread, but on the whole I really like how this does seem to get rid
> of another batch of special cases.

That's what makes me feel better too. I think was so hung up on the
"never take signals" that it just didn't occur to me to go this
route instead.

I'll send out a clean series.

-- 
Jens Axboe

