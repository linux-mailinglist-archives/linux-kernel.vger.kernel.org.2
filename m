Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2934B33F7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhCQSBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhCQSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:01:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Cr9fPafVtZmLkwhizdfsYcidk4N7PSIymYUeNb5Ej1U=; b=KNc68Q7thVlVC9mnMd/C7+9ehu
        Kla/IaQ3jfjmklC0Ub/ridF+ohvETYDK1mlEpP4lmb+Mm2aBZ4I57F26EbANfvKObQefbTLbYwupL
        agTG6j0r8gC1P7g78oTkc0S8jkkA2RbYzkjA1yeMg6cPf53tsENv7nTzz+KfosPKR7RPt2aPG+yq3
        pq3C4LKzI5djQaQXz2lmnm9EGgt/h2BfS1vnsXZ/+rQS5ruN2BPf34HeKHSDOiIabvgq9KnVj/ROM
        msrfWkTfnAFzR8QfSsxqElq9vy4R6a0a31Y4tEHOob262F88f9Z3bY3GIQSod0iZcxFVEmo8BhgBs
        jQ2f3vug==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaTl-001fjG-CS; Wed, 17 Mar 2021 18:01:09 +0000
Subject: Re: [PATCH] kernel: cpu: resctrl: Minor typo fix in the file
 pseudo_lock.c
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <20210317084016.3787380-1-unixbhaskar@gmail.com>
 <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <99a7e1fc-0a05-9222-f913-b2d85141a08a@infradead.org>
Date:   Wed, 17 Mar 2021 11:01:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 10:54 AM, Reinette Chatre wrote:
> Hi Bhaskar,
> 
> Thank you very much for catching this typo.
> 
> My feedback [1] to a previous patch from you applies here also. The prefix should be "x86/resctrl:" for contributions to this area.

Bhaskar,
Pretty much all of your patches need to have improved Subject: lines.
The file name that is being modified should not be at the end of the Subject.

> 
> [1] https://lore.kernel.org/lkml/7e3a5c13-db5c-7399-2b80-f1284786ea77@intel.com/
> 
> On 3/17/2021 1:40 AM, Bhaskar Chowdhury wrote:
>>
>> s/derefence/dereference/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> index e916646adc69..43990a882b36 100644
>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> @@ -1307,7 +1307,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>>            * If the thread does not get on the CPU for whatever
>>            * reason and the process which sets up the region is
>>            * interrupted then this will leave the thread in runnable
>> -         * state and once it gets on the CPU it will derefence
>> +         * state and once it gets on the CPU it will dereference
>>            * the cleared, but not freed, plr struct resulting in an
>>            * empty pseudo-locking loop.
>>            */
>> -- 
>> 2.30.2
>>
> 
> Reinette


-- 
~Randy

