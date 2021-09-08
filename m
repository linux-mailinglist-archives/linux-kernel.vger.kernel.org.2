Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FB04035EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347940AbhIHIPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:15:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:60890 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234696AbhIHIPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=CeScSv+s7BSqIK9uY5ud+2JBnsA+UWpUIbdCkE+zAn8=; b=hAzvfg1I+6w8SLn+h
        Pxc9YbrLcuWRE34mv08Aq2hkPB62/iKjPt2K2QqilgmKjDPfh0+bHLEmopo6iSPMekhbnqyzjVM28
        /uXImnnF1X23v3vpV7MCQidA258vlZp5KZvvr7L3LafDLmq9URUblA8Vr94Jla3pnccYnpk/a7/28
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mNsiU-001Dt8-7g; Wed, 08 Sep 2021 11:13:58 +0300
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
To:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
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
 <YTeh1WkseQtyboM9@carbon.dhcp.thefacebook.com>
 <CALvZod4=uY=5Zp_GCzjjMzCbs16856dR85SBWv-dpNc4kBrO+Q@mail.gmail.com>
 <YTfAiaIbxM0CqEnj@carbon.dhcp.thefacebook.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <85da8df9-d6ae-5a06-a561-13eaf11344d7@virtuozzo.com>
Date:   Wed, 8 Sep 2021 11:13:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTfAiaIbxM0CqEnj@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 10:42 PM, Roman Gushchin wrote:
> On Tue, Sep 07, 2021 at 10:48:06AM -0700, Shakeel Butt wrote:
>> On Tue, Sep 7, 2021 at 10:31 AM Roman Gushchin <guro@fb.com> wrote:
>>>
>>> On Tue, Sep 07, 2021 at 07:14:45AM -1000, Tejun Heo wrote:
>>>> Hello,
>>>>
>>>> On Tue, Sep 07, 2021 at 10:11:21AM -0700, Roman Gushchin wrote:
>>>>> There are two polar cases:
>>>>> 1) a big number of relatively short-living allocations, which lifetime is well
>>>>>    bounded (e.g. by a lifetime of a task),
>>>>> 2) a relatively small number of long-living allocations, which lifetime
>>>>>    is potentially indefinite (e.g. struct mount).
>>>>>
>>>>> We can't use the same approach for both cases, otherwise we'll run into either
>>>>> performance or garbage collection problems (which also lead to performance
>>>>> problems, but delayed).
>>>>
>>>> Wouldn't a front cache which expires after some seconds catch both cases?
>>>
>>> I'm not sure. For the second case we need to pack allocations from different
>>> tasks/cgroups into a small number of shared pages. It means the front cache
>>> should be really small/non-existing. For the first case we likely need a
>>> substantial cache. Maybe we can do something really smart with scattering
>>> the cache over multiple pages, but I really doubt.
>>
>> I think we need to prototype this to sensibly evaluate. Let me know if
>> you want to take a stab at this otherwise I can try.
> 
> If you have time and are ready to jump in, please, go on. Otherwise I can start
> working on it in few weeks. In any case, I'm happy to help with discussions, code
> reviews & whatever else I can do.

(Quite looking at the dubious achievement "my upstream patch was returned personally by Linus")
Please keep me informed about these tasks too. Unfortunately I cannot help right now,
however perhaps we will need to backport these patches to OpenVz kernels.  

Thank you,
	Vasily Averin
