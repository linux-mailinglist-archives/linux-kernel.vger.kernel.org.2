Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB27430001
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 06:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhJPELJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 00:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhJPELI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 00:11:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9CFC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 21:09:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v8so5903248pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AmJMDRGOyH+fqnNRiyjPHTdUOQyCmK7sTJq/pQhTPLA=;
        b=Lzrw2L+VNuk5wO1LPV6c0b41WOy5OueI56NvfGxxuFdsaskOQcoFX6AH4J6eRlFndg
         21XzyMbIaKr1FA1PXhJb4On0K40sKsIIRHD5gd2b1lHZI8bnVyVY1+DJuPvr/RQPrvKC
         qK+Wyzvj8gB9zm71pUOffXzu9yO91kQY9tcQyLl4oS24ub3D5SbIvo+Dgm+HhCI4qstr
         IkSbbem4lTFoc7PUij0W45L8jB9LIHdda+v2OKP67CSpFLk6HMIujB1q22wDlDmMrheF
         vSpI+/p9kalK2lSMYGnN1FzlabLn9D1ZPQEtXWS/H3VQD+Q/XrQAu+aextF6dyTK2ZLV
         D+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AmJMDRGOyH+fqnNRiyjPHTdUOQyCmK7sTJq/pQhTPLA=;
        b=V4By3JQRy28l0D66FZAW+thBrwtbxAlGkwwqXvMqbaSU0YWBXnpZBj0IKf3CHhTZp+
         d/fFU6KF0ma+n035Z+ClgmoJCqKQeTBlAEi8LgbegIGlXv9gREu4AwRRCZrOblpd/OBq
         cy16C7o9+IepCubfU5jHTjWFFH5X2vyg51bBl9F8CiwN2mDQPBRiJU7/eYYCLhEtxWud
         g+z+RBPkHRTbkvIjW81LuFUAmWy0kCQCFGuCtSBOg0StrMQLWTKuvfb4VQKZ3RouW5rT
         1+BRhGEtJrzLhtXg6PrvbAXXu45AvAww4POYlUKRplsL12rr1odQoLgMsvN7J5xCVu3z
         t1vw==
X-Gm-Message-State: AOAM5305JZa3h9q4MwoQcAFavFX4kZftyIIUM0JZoKaqwOwuvhzMffL2
        t6BXNG2cADuscwlVOw37BwsGMBc9rbFR5+VC
X-Google-Smtp-Source: ABdhPJym1EwLJyZG/4GWTYYxL7JH89wCDqlQ+yvHT7aXPc3kj+2GlWc64BEnZsdN6bhQZF8mVRlnVw==
X-Received: by 2002:a63:ea58:: with SMTP id l24mr12282226pgk.334.1634357340418;
        Fri, 15 Oct 2021 21:09:00 -0700 (PDT)
Received: from ?IPV6:2601:645:8400:1:ffb7:9e6f:baa:dfce? ([2601:645:8400:1:ffb7:9e6f:baa:dfce])
        by smtp.gmail.com with ESMTPSA id l4sm142231pfc.121.2021.10.15.21.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 21:09:00 -0700 (PDT)
Message-ID: <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
Date:   Fri, 15 Oct 2021 21:08:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Performance regression: thread wakeup time (latency) increased up
 to 3x
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
 <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
 <20211015100401.45833169@gandalf.local.home>
From:   Norbert <nbrtt01@gmail.com>
In-Reply-To: <20211015100401.45833169@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 07:04, Steven Rostedt wrote:
> On Fri, 15 Oct 2021 02:36:03 -0700
> Norbert <nbrtt01@gmail.com> wrote:
> 
>> On 10/15/21 01:52, Peter Zijlstra wrote:
>>> On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
>>>> Performance regression: thread wakeup time (latency) increased up to 3x.
>>>>
>>>> Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.
>>>
>>> Could you git-bisect this?
>>>    
>>
>> So far I haven't built a kernel yet, I'm quite new to Linux in that way,
>> so it may take me some time to figure it all out, but yes.
> 
> If you do test a kernel you build yourself, you may want to use
> "localmodconfig". Which will look at all the modules that are loaded on the
> local system and turn off the configs for modules that are not loaded. This
> will save a lot of time compiling the kernel. Especially if your basing off
> of a distro config.
> 
>    $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>    $ cd linux
>    $ cp /boot/config-[whatever your kernel is] .config
>    $ yes '' | make localmodconfig
> 
> Then build your kernel.
> 
>    $ make -j10
>    $ sudo make modules_install install
> 
>>
>> (By the way, of course I meant that throughput *de*creases, not increases.)
> 
> of course ;-)
> 
> -- Steve
> 

Thank you, localmodconfig is an enormous timesaver. Once I got some 
local build problems/modules out of the way, this method worked very well.

So git-bisect finally identified the following commit.
The performance difference came in a single step. Times were consistent 
with my first post either the slow time or the fast time,
as far as I could tell during the bisection.

It is a bit unfortunate that this comes from an attempt to reduce OS noise.

-----------------------------------------------------
commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
Author: Yunfeng Ye <yeyunfeng@huawei.com>
Date:   Thu May 13 01:29:16 2021 +0200

     tick/nohz: Conditionally restart tick on idle exit

     In nohz_full mode, switching from idle to a task will unconditionally
     issue a tick restart. If the task is alone in the runqueue or is the
     highest priority, the tick will fire once then eventually stop. But 
that
     alone is still undesired noise.

     Therefore, only restart the tick on idle exit when it's strictly
     necessary.

     Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
     Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Acked-by: Peter Zijlstra <peterz@infradead.org>
     Link: 
https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org
-----------------------------------------------------

Is there anything else to do to complete this report?
