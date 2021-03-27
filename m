Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2E34B9ED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhC0W1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhC0W0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:26:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2566C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=X6K9dDfiPk2z/NpuiKCPto3h86VCspjXOpVOyrJGiCs=; b=nTb6S/Ek8XQdnkzYBLhAqXSVdQ
        md360J+0TGdSUWhPfHXH4wY1yJWuSsA2Z5elcg1+l7ii87J12TEXlUzLva5gztRYX7R4vIVhTKL7S
        YaRyQXKBvfCaMvBy13jGVxqj5alL8lU1QdVDm0ESBeqmA4Y7Dq4junZKdQrdI6BHan2ihAwfMce+s
        hvgJP7sXJSRCaNyzh2fFAOWLXSQeEP251ZP4xQIrsZUO4ZnVtcFLYmjDNWKcLTZF5Xt3XamJC5oBw
        6KWkqdo+1+yTbtRxkLKyqpGykq2jONAo7rH+bedTEKln21Hb967IGr7Xz2/rCRN7lGBq1NpYWgQqe
        tWOVn54A==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQHOF-00H8UQ-D3; Sat, 27 Mar 2021 22:26:47 +0000
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
To:     Mihai Moldovan <ionic@ionic.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210327120155.500-1-ionic@ionic.de>
 <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
 <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <362edad0-daea-1f56-bed3-b1df174cbbf1@infradead.org>
Date:   Sat, 27 Mar 2021 15:26:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/21 3:12 PM, Mihai Moldovan wrote:
> * On 3/27/21 4:58 PM, Randy Dunlap wrote:
>> On 3/27/21 5:01 AM, Mihai Moldovan wrote:
>>> +		if ((-1 == index) && (index == match_start))
>>
>> checkpatch doesn't complain about this (and I wonder how it's missed), but
>> kernel style is (mostly) "constant goes on right hand side of comparison",
>> so
>> 		if ((index == -1) &&
> 
> I can naturally send a V2 with that swapped.
> 
> To my rationale: I made sure to use checkpatch, saw that it was accepted and
> even went for a quick git grep -- '-1 ==', which likewise returned enough
> results for me to call this consistent with the current code style.
> 
> Maybe those matches were just frowned-upon, but forgotten-to-be-critized
> examples of this pattern being used.

There is a test for it in checkpatch.pl but I also used checkpatch.pl
without it complaining, so I don't know what it takes to make the script
complain.

			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
			    WARN("CONSTANT_COMPARISON",
				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&

cheers.
-- 
~Randy

