Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81334BD37
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhC1QQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhC1QQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 12:16:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D96C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=GJZppRAaG51+5xCQGxJDbiT+rib+B0Hn9tDagEpn2g4=; b=nfARpzp6MFeIeyjK6VX/SKjb1K
        SCm2OQ1w8xXfQtSJZYj63yUky7+187ES2bZZ8kaG1wqr1y7PlMwJNP29JIBrQeLWyflLUxfVj+GQl
        FIIWN/q4mtGlJx076MyjcD0SVyS++WrMANozYfMmFje0ytHOvT3xDc5Zfw50wRn6T2lBy4Lm/Dsga
        SDgOTBFTdEwE8pKbDUW8daxQtJMEpWuLIKBt921npx/fkp3l5jbtoNTPe8SO88Kxiriiozhij1Ihp
        iJoUgomoNYmbALvWbwhMEro8O8NspLU76fCEldik0M9ckS7WurQ68iBKJKk58sobEyL+S0tgICmjY
        LLQQ7ZAQ==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQY5Y-000GDm-30; Sun, 28 Mar 2021 16:16:34 +0000
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
To:     Joe Perches <joe@perches.com>, Mihai Moldovan <ionic@ionic.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210327120155.500-1-ionic@ionic.de>
 <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
 <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
 <362edad0-daea-1f56-bed3-b1df174cbbf1@infradead.org>
 <6caae542c6f295a47b1012738b3b35055cf17cc4.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <027ce5a1-cc48-3f79-fc05-bb587a9e86b1@infradead.org>
Date:   Sun, 28 Mar 2021 09:16:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6caae542c6f295a47b1012738b3b35055cf17cc4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/21 3:32 AM, Joe Perches wrote:
> On Sat, 2021-03-27 at 15:26 -0700, Randy Dunlap wrote:
>> On 3/27/21 3:12 PM, Mihai Moldovan wrote:
>>> * On 3/27/21 4:58 PM, Randy Dunlap wrote:
>>>> On 3/27/21 5:01 AM, Mihai Moldovan wrote:
>>>>> +		if ((-1 == index) && (index == match_start))
>>>>
>>>> checkpatch doesn't complain about this (and I wonder how it's missed), but
>>>> kernel style is (mostly) "constant goes on right hand side of comparison",
>>>> so
>>>> 		if ((index == -1) &&
>>>
>>> I can naturally send a V2 with that swapped.
>>>
>>> To my rationale: I made sure to use checkpatch, saw that it was accepted and
>>> even went for a quick git grep -- '-1 ==', which likewise returned enough
>>> results for me to call this consistent with the current code style.
>>>
>>> Maybe those matches were just frowned-upon, but forgotten-to-be-critized
>>> examples of this pattern being used.
>>
>> There is a test for it in checkpatch.pl but I also used checkpatch.pl
>> without it complaining, so I don't know what it takes to make the script
>> complain.
>>
>> 			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
>> 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
>> 			    WARN("CONSTANT_COMPARISON",
>> 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&
> 
> Negative values aren't parsed well by the silly script as checkpatch
> isn't a real parser.

Yes, I get that.

> Basically, checkpatch only recognizes positive ints as constants.

OK, good to know.

> So it doesn't recognize uses like:
> 
> 	a * -5 > b
> 
> It doesn't parse -5 as a negative constant.
> 
> Though here it does seem the line with
>  			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
> should be
>  			    $to !~ /^(?:$Constant|[A-Z_][A-Z0-9_]*)$/ &&
> 
> You are welcome to try to improve checkpatch, but it seems non-trivial
> and a relatively uncommon use in the kernel, so I won't.

I get that too.

> Most all of the existing uses seem to be in drivers/scsi/pm8001/pm8001_hwi.c

[snip]


thanks.
-- 
~Randy

