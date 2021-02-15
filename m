Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6C31B54E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 06:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhBOFzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 00:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhBOFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 00:55:47 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74741C061574;
        Sun, 14 Feb 2021 21:55:07 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lBWqe-0006ec-G8; Mon, 15 Feb 2021 06:55:04 +0100
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Damian Tometzki <linux@tometzki.de>
References: <20210210054823.242262-1-linux@leemhuis.info>
 <20210214160009.lxonvxg4qyj6ygbk@e107158-lin.cambridge.arm.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] docs: reporting-issues.rst: explain how to decode stack
 traces
Message-ID: <7f75a923-7aab-5546-102b-a8a6eb882cc9@leemhuis.info>
Date:   Mon, 15 Feb 2021 06:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210214160009.lxonvxg4qyj6ygbk@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1613368507;f7d8888f;
X-HE-SMSGID: 1lBWqe-0006ec-G8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Many thx for looking into this, much appreciated!

Am 14.02.21 um 17:00 schrieb Qais Yousef:
> On 02/10/21 06:48, Thorsten Leemhuis wrote:
>
>> - * If the failure includes a stack dump, like an Oops does, consider decoding
>> -   it to find the offending line of code.
>> + * If your failure involves a 'panic', 'oops', or 'warning', consider decoding
> or 'BUG'? There are similar other places below that could benefit from this
> addition too.

Good point. In fact there are other places in the document where this is
needed as well. Will address those in another patch.

>> +   the kernel log to find the line of code that trigger the error.
>>  
>>   * If your problem is a regression, try to narrow down when the issue was
>>     introduced as much as possible.
>> @@ -869,6 +869,15 @@ pick up the configuration of your current kernel and then tries to adjust it
>>  somewhat for your system. That does not make the resulting kernel any better,
>>  but quicker to compile.
>>  
>> +Note: If you are dealing with a kernel panic, oops, or warning, please make
>> +sure to enable CONFIG_KALLSYMS when configuring your kernel. Additionally,
> 
> s/make sure/try/

I did that, but ignored...

> s/kernel./kernel if you can./

...this. Yes, you have a point with...

> Less demanding wording in case the user doesn't have the capability to rebuild
> or deploy such a kernel where the problem happens. Maybe you can tweak it more
> if you like too :-)

...that, but that section in the document is about building your own
kernel, so I'd say we don't have to be that careful here.

>> +enable CONFIG_DEBUG_KERNEL and CONFIG_DEBUG_INFO, too; the latter is the
>> +relevant one of those two, but can only be reached if you enable the former. Be
>> +aware CONFIG_DEBUG_INFO increases the storage space required to build a kernel
>> +by quite a bit. But that's worth it, as these options will allow you later to
>> +pinpoint the exact line of code that triggers your issue. The section 'Decode
>> +failure messages' below explains this in more detail.
>
> I think worth mentioning too that the user should keep a log of the problem
> when first encountered and then attempt the above. Just in case the problem is
> not reproducible easily so the info is not lost.
> 
> Maybe something like below:
> 
> '''
> Always keep a record of the issue encountered in case it is hard to reproduce.
> Sending undecoded report is better than not sending a report at all.
> '''

Very good point, added.

>> +your kernel. If you did so, consider to decode the information from the
>> +kernel's log. That will make it a lot easier to understand what lead to the
>> +'panic', 'oops', or 'warning', which increases the chances enormously that
>> +someone can provide a fix.
> I suggest removing the word enormously. It helps, but it all depends on the
> particular circumstances. Sometimes it does, others it doesn't.

Done.

> This looks good to me in general. With the above minor nits fixed, feel free to
> add my
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Great, thx, will do!

Ciao, Thorsten
