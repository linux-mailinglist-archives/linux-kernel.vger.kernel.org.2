Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCE402D09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbhIGQo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbhIGQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:44:55 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1EC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:43:49 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id u7so10740258ilk.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KTSECMQ89sSb/89xBh9CeoozoL34Ed1QNjuTkUfkOs=;
        b=QyXDKfAD8zjNlfoWIRh+yxEfBJgzD+PngynPGAoCY8A8nPq0p2no9hMirpaPNiwbnc
         PvcihJ+Hi64vaSH2hCaf5dtNnWw5cQjUj76CftD8bKAueAtDWzvJ8J1v2dAT7IQWW+vq
         QNgZJUvkw4HjGBs8FScbp+bgS8xRD2XjK0CxjnadreCK9849sXTRTXAtDl46uCGjaPwa
         dKbErC381J6uGS1muBokbVos+X0CU154fURDUgGHgBMLGuXrA+Q+xxsdigj4SYDIK3Lp
         y5GRf+g4CAshcUT/H2lxHThmX+xV0hq8YzWrcEFlEBJBgJBEPCndbUpH8ak9uSFzU3CT
         +jGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KTSECMQ89sSb/89xBh9CeoozoL34Ed1QNjuTkUfkOs=;
        b=F6TypPD5lpo4sNW7SmcwjPL/5DSrIB45MGPvG7f0NDohoY3+6o4NkhHxnZkA5kgY79
         7pgm8CSWPASNFRXuOe/an7O7keigVumblfV/Jh8XEKw0X436PE8beNtCkYRp6m8IsFJw
         sHJBT4uEER0DzcD2gU2T9O+7awc/4ypOnRcOTYKK9dykbInqTeNuVPCUlbLS6Opzu/7S
         rvq5yelNJ5cDHEMLiJN0ZGlSKWnzQizyDAsE++1AL4bHjNTXO4/ttIru6WJc3tQNta6g
         BOShebAInN5YkVhitXa9ji9q9LRDPR9qNKYZmZTTJRHZsabSveNVvdcoI0vNZMa8mx4O
         HZdw==
X-Gm-Message-State: AOAM53077dDS8J/SBaxKqU4SLwLLE9861KcUVEU5EfvR6ENixKqCGJ27
        fm7nJR0oMKpZgb1Ml0ZaUP8evQ==
X-Google-Smtp-Source: ABdhPJydgmex2AVNNZBm6S5H+yBNtfc6E4tKAvdERShRVi5efwE1Gu/s8rPZ/hyTim9QMsb2dR1fvA==
X-Received: by 2002:a92:c5ac:: with SMTP id r12mr12191376ilt.279.1631033028454;
        Tue, 07 Sep 2021 09:43:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c25sm7103722iom.9.2021.09.07.09.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:43:48 -0700 (PDT)
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Roman Gushchin <guro@fb.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
 <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
Date:   Tue, 7 Sep 2021 10:43:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 10:39 AM, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 8:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Are we at all worried about these? There's been a number of them
>> reported, basically for all the accounting enablements that have been
>> done in this merge window.
> 
> We are worried about them. I'm considering reverting several of them
> because I think the problems are
> 
>  (a) big
> 
>  (b) nontrivial
> 
> and the patches clearly weren't ready and people weren't aware of this issue.

I think that is prudent. When I first enabled it for io_uring it was a
bit of a shit show in terms of performance degradations, and some work
had to be done before it could get enabled in a sane fashion.

The accounting needs to be more efficient if we're seeing 30-50%
slowdowns simply by enabling it on a kmem cache.

-- 
Jens Axboe

