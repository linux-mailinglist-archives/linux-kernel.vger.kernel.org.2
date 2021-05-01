Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755C53707A0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhEAPEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 11:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhEAPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 11:04:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36020C06138B;
        Sat,  1 May 2021 08:03:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6D2142DD;
        Sat,  1 May 2021 15:03:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D2142DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619881405; bh=xiUPjVQBLypVmmHFGUuNCDr9cDHqM/YBFlPvHnb84os=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jN8i5S4IfYqrKNIICU2CvnzCY5G5LyjU0vt55s+ZZ5mSUzYdfMoHfHbMpXgJUP/RU
         rM2KAJr0tewI8typMBOclpKHDZHlbSrCg8doaIv7NcRUFQ9igy7hlUAufeMClhrH0y
         Vik6XynVb/wNTKJ/875tPSTqWLeg7LVCxkYOww5eA0Q1r6LzVyWvnlOPACjM9uQboR
         YYTL5Js/aF3rgFJHD6YNVHkbvjLMeTgAWuLAZM18EkGXy3Wkm7gaBLPqepRMc2JaN1
         QbumUeC1fE0+e3FKmmQL6K9N69jk/LX031jh3MfCoAq8XmGpdFcgo3W5UcT6edO6jx
         SWdTq8NSWh8CQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3] scripts: kernel-doc: reduce repeated regex expressions
 into variables
In-Reply-To: <99186604-8ed6-ff72-0308-9ca788db3a51@gmail.com>
References: <20210427165633.GA235567@casper.infradead.org>
 <20210429063729.8144-1-yashsri421@gmail.com> <8735v8d5ja.fsf@meer.lwn.net>
 <99186604-8ed6-ff72-0308-9ca788db3a51@gmail.com>
Date:   Sat, 01 May 2021 09:03:24 -0600
Message-ID: <87bl9ujy2r.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> On 30/4/21 5:09 am, Jonathan Corbet wrote:
>> Aditya Srivastava <yashsri421@gmail.com> writes:
>> 
>>> There are some regex expressions in the kernel-doc script, which are used
>>> repeatedly in the script.
>>>
>>> Reduce such expressions into variables, which can be used everywhere.
>>>
>>> A quick manual check found that no errors and warnings were added/removed
>>> in this process.
>>>
>>> Suggested-by: Jonathan Corbet <corbet@lwn.net>
>>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>>> ---
>>> Changes in v3:
>>> - Remove variables for separate qualifiers in "sub dump_struct"
>>> - Make a common variable for all the qualifiers
>>> - Make $attribute global variable to use it at "sub check_sections" as well
>>>
>>> Changes in v2:
>>> - Rename $pointer_function to $function_pointer
>>> - Combine elsif-block expressions at "sub dump_function" into lesser regex expressions
>>> - Combine $prototype_end1,$prototype_end2 expressions into a common $prototype_end
>>>
>>>  scripts/kernel-doc | 71 ++++++++++++++++++++++------------------------
>>>  1 file changed, 34 insertions(+), 37 deletions(-)
>> 
>> So this looks good but ... it adds a warning to the build:
>> 
>> /stuff/k/git/kernel/Documentation/driver-api/media/v4l2-controls:823: ./include/media/v4l2-ctrls.h:964: WARNING: Invalid C declaration: Expected identifier in nested name. [error at 6]
>>   const * v4l2_ctrl_get_menu (u32 id)
>>   ------^
>> 
>> So it looks like something isn't being parsed quite identically?
>>
>
> Hi Jonathan!
> I could not reproduce this error..
> Can you suggest me how can I reproduce this error?
> I ran kernel-doc -none {$file} over the tree.
>
> Probably, this is not a kernel-doc error

It's a Sphinx error; run "make htmldocs" to see it.  That said, the
error itself should be enough to point at where the problem is.

Thanks,

jon
