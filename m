Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590C431A1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhBLP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBLP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:27:38 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:26:58 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f6so9661592ioz.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=onFvP6j6wda1P7gLjn52fbC4J1JLIa0ND92igZnAhqo=;
        b=SmN6rUXtG05Jaq9xEA7sGXXJN73VP1CMy23o3/eIIwUc4CXl7cOKaibLS33quBXsC9
         9pPqFG1+hRVTJiqFQGeu64MLLwZA+1omGGW/ckSMo4jXySwWecWUQKu7ZAv7K3Ow2hKZ
         mZq5i/kywNdufEMh/6Zi++PITsHg467xqIO8eMt+yjVJSIKOlbCJ3TuHMNRdgD1u5+KD
         wf1fIXYX70uSsYYS4pbfMIHvmoXPU0DZ+OAG9H/zwTG/VroiWKCy7vvJdnotTS39wppa
         R7J/gQrIOp2PBXJY21zpaNR5kULka2+gGuyab3LXT2mH00ednNK7FBlp9MtHHwEgSkmS
         569A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=onFvP6j6wda1P7gLjn52fbC4J1JLIa0ND92igZnAhqo=;
        b=B/nKvQdTB/Z4FoVjWP/zP6lCv2iFz7ruZVsRzximaBq3cOup5BxtHzkRq7qQVHbUgf
         qUO+zrwBd0n41/hx0UUpRA8UJCizpkjedMIP6s40Yi+TilRVskNfrOIh2YisY4DNmNbV
         PlF8913j1JWFBriH1qRkUmb2CvxMQCut3gNj8nwFqGG2oCebAWMZ0ro0I3t0DU9vCoAG
         6sdi7eGj9QN2fgzaobvZfTZppYm+2Y6RMd0ZWWK6qAU5ZRECNL66i8D9N5jAel/LZzxe
         i4iRed7E7z+v+0SoIRK2SHztAGCBoKq11xBgjh66rY+mJh5SEccGGLzDaHQYCaQflxv1
         tO4Q==
X-Gm-Message-State: AOAM533KGUdOIAODBY66+9FErPzAmTb7yUdWF9VK2VncwB7sOX4DYWe+
        7/EaTnE1w5kfL9xKoKqWeT/oSA==
X-Google-Smtp-Source: ABdhPJw1k9SHpUvGqgnXAMoAZiizpnwt+C/glLQHRSp3gqyqPpGSifBgkGNxESbbgsKGO1zm7OeESw==
X-Received: by 2002:a02:ccc5:: with SMTP id k5mr3182177jaq.105.1613143618094;
        Fri, 12 Feb 2021 07:26:58 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 4sm4671757ilj.22.2021.02.12.07.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 07:26:57 -0800 (PST)
Subject: Re: linux-next: manual merge of the rcu tree with the block tree
To:     paulmck@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20210211164852.7489b87d@canb.auug.org.au>
 <20210211173802.GM2743@paulmck-ThinkPad-P72>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d4232318-0e44-445d-a7a3-1e2a018c824e@kernel.dk>
Date:   Fri, 12 Feb 2021 08:26:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211173802.GM2743@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 10:38 AM, Paul E. McKenney wrote:
> On Thu, Feb 11, 2021 at 04:48:52PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the rcu tree got conflicts in:
>>
>>   include/linux/rcupdate.h
>>   kernel/rcu/tree.c
>>   kernel/rcu/tree_plugin.h
>>
>> between commits:
>>
>>   3a7b5c87a0b2 ("rcu/nocb: Perform deferred wake up before last idle's need_resched() check")
>>   e4234f21d2ea ("rcu: Pull deferred rcuog wake up to rcu_eqs_enter() callers")
>>   14bbd41d5109 ("entry/kvm: Explicitly flush pending rcuog wakeup before last rescheduling point")
> 
> Frederic had me move these out of the section of the -rcu commits for
> the v5.12 merge window, saying that they were not yet ready.
> 
> Jens, are these needed to prevent failures in the block tree?  If so,
> there were some commits added late in v5.11 that might also get rid
> of your failures.  If those v5.11 commits don't help the block tree,
> let's figure out what we need to do here...  ;-)

I pulled these in from sched/core looks like, because there was a dependency
for 2 block fixes from Sebastian:

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.12/block-ipi

But I think I made a mistake in that it should've been sched/smp instead,
which would likely get rid of this issue too? I'll rebase it, it's just
a single topic branch with just those two patches on top.

-- 
Jens Axboe

