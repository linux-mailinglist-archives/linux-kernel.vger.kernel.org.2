Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65043EF286
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhHQTNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQTNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:13:04 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:12:31 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Gq0yz67fVzQk2q;
        Tue, 17 Aug 2021 21:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1629227541; bh=+c0Z0NbjURdzYfK/ylnJpFrnwdTZXE41jfSWAT1AMLU=; b=n
        9hMp1TZIJF5lq1afU+H6GugCaELeOAoUC0guTLLiMymtGdSVgJEsS0EqbIqaPiZ2
        JtEDrLnIRi0bogGgKyLrJSOeFjqDWpes0HWPUcSSkwtmz1Phi+Nc+Pp6Ag+b5UqC
        lYmqB0zTe7w85qf0ra3JPfzmR3S3uGVfVtbRDFkT0He8xYGrD2Oo9E0xEKjs+efs
        hfC3UIhP0WNH187NweV6MNcJl0T6QFGbnyXvonWbnV6/diPmwXaD/tlDqcPjL/Nk
        YIzTOW7dr1jJAGasejUnLq6gwRvrD9W/X2UuCX+r+Nlo/78QnGpvszYj1GxV7p9j
        fEQfjIF0JgV4xgrEeQgHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629227545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxTyFKdy0aUJpHYltMttpgWdJiw5Yr5ibSehg0Pendo=;
        b=b/AkNhdljKo4L356FgWCOECrLJcYDPApm6ZWkZkjL1g+kBeXyomg6OXwXZMZl1eyHgrXQT
        2CXdI945y5D3g0RfPl9efvfYcMRrKM7qrpL9ntaQS2amstPAtgMe9n+Csws1nrjBSILXd7
        1J09kfy69cnonP8YWjDyNyy17Wi/QPqJL51QzvPxuvL90G7pjRapj38dg4VdCriOy0Y/Of
        GG5O8l9PNxav89QBVQCsRRZd0Ko3n5wUi2wmo/f8JX8urQZrQttpvHXNKp/YRQloo8YGrr
        MwKg0iE/G51K+GPJ4k5Wfz56O5DSrIn/8QfjBD22c7SlUk0xNNVbL+DyG5wovw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id AcoYWNv3GZdF; Tue, 17 Aug 2021 21:12:21 +0200 (CEST)
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
To:     Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <YRwBs89eogLJEiRn@zn.tnic>
From:   Tor Vic <torvic9@mailbox.org>
Message-ID: <197255a8-5973-9b53-2405-d5180538580f@mailbox.org>
Date:   Tue, 17 Aug 2021 19:12:20 +0000
MIME-Version: 1.0
In-Reply-To: <YRwBs89eogLJEiRn@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BEE0218BF
X-Rspamd-UID: 4e851b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.08.21 18:36, Borislav Petkov wrote:
> On Tue, Aug 17, 2021 at 04:24:48PM +0200, torvic9@mailbox.org wrote:
>> Add new generic x86-64 CPU tunings introduced with recent versions of
>> gcc and clang, as documented in x86-64-psABI [1].
>>
>> This is taken straight from graysky's CPU optimization patch with minor
>> modifications [2].
>>
>> [1] https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9a6b9396884b67c7c
>> [2] https://github.com/graysky2/kernel_compiler_patch
>>
>> Signed-off-by: Tor Vic <torvic9@mailbox.org>
>> ---
>>  arch/x86/Kconfig.cpu  | 26 +++++++++++++++++++++++++-
>>  arch/x86/Makefile.cpu |  6 ++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
>> index 814fe0d349b0..a2c872aa5a0b 100644
>> --- a/arch/x86/Kconfig.cpu
>> +++ b/arch/x86/Kconfig.cpu
>> @@ -294,6 +294,30 @@ config GENERIC_CPU
>>  	  Generic x86-64 CPU.
>>  	  Run equally well on all x86-64 CPUs.
>>  
>> +config GENERIC_CPU_V2
>> +	bool "Generic-x86-64-v2"
>> +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
>> +	depends on X86_64
>> +	help
>> +	  Generic x86-64 CPU.
>> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v2.
>> +
>> +config GENERIC_CPU_V3
>> +	bool "Generic-x86-64-v3"
>> +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
>> +	depends on X86_64
>> +	help
>> +	  Generic x86-64-v3 CPU with v3 instructions.
>> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v3.
>> +
>> +config GENERIC_CPU_V4
>> +	bool "Generic-x86-64-v4"
>> +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
>> +	depends on X86_64
>> +	help
>> +	  Generic x86-64 CPU with v4 instructions.
>> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v4.
> 
> Every once in a while, patches like that pop up without any real numbers
> advocating for the additional and perhaps unnecessary complexity.
> 
> If those -march switches don't bring any measureable improvements - and
> I highly doubt they do - you shouldn't waste time with submitting them.

In other words, I should back up these additions with benchmarks?
I have some slight doubts too, but I'll gladly do so and provide
some results with a v2.

> 
> Thx.
> 
