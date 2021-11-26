Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFE45EAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376696AbhKZKDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:03:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376612AbhKZKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:01:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637920675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49M8bqAiitcrdLCSAt3v6iJXu+7TKPvVxqFMpA9m0vw=;
        b=Mtr4J/SkHY97rSZhXGoAxjeWgtN8JcFAj+egoWbWafJORp8cRffQ3GDwApBpeLOzEPNUXM
        qygREfVYO8idzY3g4tOPBOG6pwYDyjGE0mjD2XFtiIeeKXsGgV7oPBVgz/2+Ja9l9Vjnp0
        rBviNoIb9OhD4pXlBXn2/wYFPYHiCwgRyckkn+jMoIq1EDXOeyuOi5ISDVJ7A1Eb3ffvCm
        I/zpGv4wz2izB6lhwr1BiMBF7kFDVDmPE0RMDiXXLyiZGSieeUGi+6P3vCeqZ2rl+Z9bTi
        6xikHYb5k9q0uCzNXZ8EnWQWIiCp83jymCT4xhYEYl6LuDfIU36k6Jr4r+1PHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637920675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49M8bqAiitcrdLCSAt3v6iJXu+7TKPvVxqFMpA9m0vw=;
        b=pB2+0c6OCcn+OJLQ/mV4+s8PF0WuEF+aEST5egDjqNHYTguvGJ/xul+Q0bPqMeJRURi9Te
        ih7v0DZWGjM2lADw==
To:     "taoyi.ty" <escape@linux.alibaba.com>, ira.weiny@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 05/18] x86/pks: Add PKS setup code
In-Reply-To: <020e6b6c-55ba-2079-7720-bd9dbb1bf335@linux.alibaba.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-6-ira.weiny@intel.com> <87ilwgl10a.ffs@tglx>
 <020e6b6c-55ba-2079-7720-bd9dbb1bf335@linux.alibaba.com>
Date:   Fri, 26 Nov 2021 10:57:55 +0100
Message-ID: <87r1b3grx8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26 2021 at 11:11, taoyi ty wrote:
> On 11/25/21 11:15 PM, Thomas Gleixner wrote:
>>> +void setup_pks(void)
>>> +{
>>> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
>>> +		return;
>>> +
>>> +	write_pkrs(pkrs_init_value);
>> 
>> Is the init value set up _before_ this function is invoked for the first
>> time?
>> 
> Setting up for cpu0 is before create_initial_pkrs_value. therefore pkrs 
> value of cpu0 won't be set correctly.
>
> [root@AliYun ~]# rdmsr -a 0x000006E1
> 0
> 55555554
> 55555554
> 55555554
> 55555554
> 55555554
> 55555554
> 55555554
> 55555554
> 55555554
>
> Here are my test results after applying the patches

Thanks for confirming what I assumed from looking at the patches!

       tglx


