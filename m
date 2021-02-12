Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8031A1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBLPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhBLPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:31:09 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF971C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:30:28 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n201so9658896iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=offNES+WoCXP4r9MqdlrB2PaP4ULhXnwzksUvKn0s9g=;
        b=BImA9WnABOwuvHJuOCLk4IyInjzUNAZ5LAcE7ci12u0pFt1uLrtFyddKgQRViPKs9H
         WHrJYzriNJuu/1JQNkcwPAHm0IoCEX1/CKHtW0U8ho/9+y5Lq20BRKyTpyKzdd7h4+WK
         bFWarq12kN/6KPaLTu11DI3d71MS/bnXOF5R2gpgh6dvQaxzslJqqzlhFAyjEuFUNuE2
         LLkB+Uc1A5l6Q/QXdRduCvqaMjIHx0E3lw5t90V5E+RLu4UXYevUlHJ4zOZix369MBn6
         bOBfn6p++PLnJ493qQC3bV4/GacE8fQoTQIDN9ONDAPpwAivAreqhwyoj8xeIdNI1yrU
         TahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=offNES+WoCXP4r9MqdlrB2PaP4ULhXnwzksUvKn0s9g=;
        b=oTkqMaOeUA7G280z00TGZrF6V0g1SlBjauXw3pyY3eGwk+dzJJ+Y0bVHrcUp0aKMdj
         4qbNkgpBtlqN1Bogv2/4r7vmHWr4MIBulELzV4BPa/d8Sg0bqkMHfjqtagCfqefU3ulk
         UegaGxIeI/b4K8JgMGpZo7TvFFQrZ2zDzePLhlj3fRzrqxTQ3FG+9/Pvj8GYM+sRLGje
         DTrGCy1XSmQlM0DT+UEocG4rkPfLRSBvaOg4zWJ5WCxuCs5tmv8YY+llzspQJHHBgqOi
         87oMZTxYwwPjNA8RlF8MUT7HbvHuytdb1WTDeUFOq52tsDQYP21cZqIO3vDiOkNYh+FW
         XcnQ==
X-Gm-Message-State: AOAM532Qi/wbUSRlrZXkPD22wkKxDemSwAa3cNPfiiHZlndnuY17yLV8
        lm1ecfwOT5YWAmGb97NNd6vJgw==
X-Google-Smtp-Source: ABdhPJzzj7ZF9BLPJJuz3o5a3Kmr/Llvs84MLXqJEMRK8mSLYZxcDqVk1CtRG/bbNTNxUdvqyxnsgw==
X-Received: by 2002:a02:660b:: with SMTP id k11mr3251814jac.120.1613143828470;
        Fri, 12 Feb 2021 07:30:28 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d2sm4593952ilr.66.2021.02.12.07.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 07:30:27 -0800 (PST)
Subject: Re: linux-next: manual merge of the rcu tree with the block tree
To:     Frederic Weisbecker <frederic@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20210211164852.7489b87d@canb.auug.org.au>
 <20210212151853.GC94816@lothringen>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <858e7874-83c9-e4b9-a0a9-31be5a0c853e@kernel.dk>
Date:   Fri, 12 Feb 2021 08:30:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210212151853.GC94816@lothringen>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 8:18 AM, Frederic Weisbecker wrote:
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
>>   14bbd41d5109 ("entry/kvm: Explicitly flush pending rcuog wakeup before last
>>   rescheduling point")
>> from the block tree and commits:
> 
> Isn't it tip:/sched/core instead of block?

It must be, maybe block just got merged first? It's just sched/core in a
topic branch, to satisfy a dependency.

But as mentioned in the previous email, I just need sched/smp to satisfy
that dependency. So I've rebased that small topic branch with that
pulled in instead. Won't solve the sched/core vs rcu tree conflict, but
at least it's out of my hands now :-)

-- 
Jens Axboe

