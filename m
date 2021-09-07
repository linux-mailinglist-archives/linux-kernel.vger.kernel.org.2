Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B4402D91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbhIGRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhIGRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:19:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E54C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:18:25 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a13so13855618iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ygh4GOZWLd5mBSV3Iad8I8xqR7eNAaxHPjU7vNMPOU=;
        b=BdOSnh3Yo+bCUdlO5P/MnpYyvSTXL4z4halCF9yiF5plTwr1RtNNQ374niih80JxoN
         torcbfYXXAiS/H0OZ7gMh46XhOPc7lX6MI7zkh+mFDjd+1EyFwlDD3KoZX1asHNN8uFf
         5mBFHaV/+76OMldtIWUAcUROFSDVcWlpWxnSJuQ53ZkQ+NXg5tyjfc+UsbTXfKJUAd/s
         zQI/uEr2DEG2xzM1jjVHBlo3l3vcACDk+MIURNVPOLBhSdfUUyrUomO5NlkAeGn/8/zs
         aaB+IcFOoko2uCmhSXqsyoXG/kqSeHPYuO7Xa4TZtLKLbEQQc84EcHP0p2tQ56vo+bFc
         BcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ygh4GOZWLd5mBSV3Iad8I8xqR7eNAaxHPjU7vNMPOU=;
        b=F17bItBerkbcuYTay1UN2TwWeUf2Vr9Z9QGhW4AhrUIdW8qB551JqH4KAekVRelGKm
         49h25ExbQ3/+LIj9gPaTZep2dBB+K2VYVFhWba2abuEM5OYaZwKt5aG2DOwuf+mfa5Ne
         ekHL8YryufTx3Xw9tgYUUfWfw7acQm8vFolYFWnch9gX4/GrvEcR+nF0Iplo9nspDoSk
         VTl9AzAaf6i3NRm7lOqtRyJb845u3XWZslMsKbAcuu4wB+Cqp1KQr1OxBAMeYlAv9C3p
         YoS4b19ivXE0e0dZa6MP7uxWcEJmtU3oSfDDQOo+XZXUuX5P5fYHfQjcm/uw0D8p7+md
         QLBw==
X-Gm-Message-State: AOAM533NGyfE9gj8fa1FeC9YFpLEVAmJWy0BHyK5jwnqdsqtDzMR9FME
        hYHDy9TpdkG8ATajcs64tZ/r8g==
X-Google-Smtp-Source: ABdhPJzCexPVkAnrhFFSqcutBOiJyBRcb7YlNfPqe1jvpY3/NwS1F+EOLrfOLaZ0S5whZUtsON5dHQ==
X-Received: by 2002:a6b:f203:: with SMTP id q3mr14797737ioh.32.1631035105204;
        Tue, 07 Sep 2021 10:18:25 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n11sm6479229ilq.21.2021.09.07.10.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:18:24 -0700 (PDT)
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
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
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
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
 <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
 <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
 <YTeeBf64yUwj01Sf@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22a0156e-f74f-51c8-b7fd-9b5a375d7c81@kernel.dk>
Date:   Tue, 7 Sep 2021 11:18:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTeeBf64yUwj01Sf@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 11:14 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 07, 2021 at 10:11:21AM -0700, Roman Gushchin wrote:
>> There are two polar cases:
>> 1) a big number of relatively short-living allocations, which lifetime is well
>>    bounded (e.g. by a lifetime of a task),
>> 2) a relatively small number of long-living allocations, which lifetime
>>    is potentially indefinite (e.g. struct mount).
>>
>> We can't use the same approach for both cases, otherwise we'll run into either
>> performance or garbage collection problems (which also lead to performance
>> problems, but delayed).
> 
> Wouldn't a front cache which expires after some seconds catch both cases?

A purely time based approach might be problematic, as you can allocate a
LOT of data in a short amount of time. Heuristics probably need to be a
hybrid of "time much time has passed" OR "we're over the front cache
threshold in terms of deferred accounting". But yes, I don't see why
we'd necessarily need different approaches for short vs long life times.

-- 
Jens Axboe

