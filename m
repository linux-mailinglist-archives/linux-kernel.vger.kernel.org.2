Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A551F356A55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351554AbhDGKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhDGKv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:51:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787CDC061756;
        Wed,  7 Apr 2021 03:51:47 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lU5mh-00042E-JK; Wed, 07 Apr 2021 12:51:43 +0200
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1617786974.git.linux@leemhuis.info>
 <f959331ed0e1a8ed59be9771fcab64378bd6977d.1617786974.git.linux@leemhuis.info>
 <YG2BxMBLqEt4mkgS@kroah.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/2] MAINTAINERS: add regressions mailing list
Message-ID: <3121a1cd-47c6-b26e-0cb3-71872d5ffc65@leemhuis.info>
Date:   Wed, 7 Apr 2021 12:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG2BxMBLqEt4mkgS@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617792707;81c5ff40;
X-HE-SMSGID: 1lU5mh-00042E-JK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.21 11:56, Greg KH wrote:
> On Wed, Apr 07, 2021 at 11:21:55AM +0200, Thorsten Leemhuis wrote:
>> Add the newly created regression mailing list finally created after it
>> already had been agreed on during the maintainers summit 2017 (see
>> https://lwn.net/Articles/738216/ ). The topic was recently discussed
>> again, where an idea to create a broader list for all issues was
>> discussed, but Linus preferred a more targeted list:
>> https://lkml.kernel.org/r/CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com/
>>
>> Hence, the creation for that list was asked for and granted:
>> https://bugzilla.kernel.org/show_bug.cgi?id=212557
>>
>> In the end it became regressions@lists.linux.dev instead of
>> linux-regressions@lists.linux.dev as 'Linux' is redundant in the latter
>> case.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>> I was a bit unsure how to add that list to MAINTAINERS. I considered
>> adding a 'M:' with my name and email address there as well, but getting
>> CCed on a lot of regression reports might be a bit much. I also left a
>> 'S: supported' out, as that doesn't make much sense in this case afaics;
>> and I checked, there are other entries that don't have those two (but
>> it's rare).
> 
> Put your name there, you are the "maintainer of regressions!"  :)

Okay, will do. :-D

/me wonders why he suddenly feels like entering a self-made trap ;-)

> [...]
>> +REGRESSIONS
>> +L:	regressions@lists.linux.dev
>> +K:	regression
> 
> A bit more information here perhaps?  This will not really help anyone
> out to know what to do.

Did you mean a different headline for the entry?  Or would you suggest
to use a webpage (W:) for that or a Subsystem Profile document (P:)
here? Using either of the two latter was the plan, but for now I'm a bit
unsure what to write there except maybe "Thorsten is working on a
semi-automatic solution for tracking Linux kernel regressions. Details
will follow. For now report regressions as outlined in
reporting-issues.rst; but in case you have any problem or think there is
a regressions not handled appropriately by the maintainers, get him
involved, he'll try to help".

Or did you have something totally different in mind?

Ciao, Thorsten
