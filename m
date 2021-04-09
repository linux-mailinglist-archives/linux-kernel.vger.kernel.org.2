Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4548359E02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhDILzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDILzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:55:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4CC061760;
        Fri,  9 Apr 2021 04:54:47 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lUpio-0006lL-0V; Fri, 09 Apr 2021 13:54:46 +0200
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1617786974.git.linux@leemhuis.info>
 <813fc7b082a4b47ec6d34542971e9bba74fd4a51.1617786974.git.linux@leemhuis.info>
 <87im4wznrx.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 2/2] docs: reporting-issues: make everyone CC the
 regressions list
Message-ID: <0b0df0d0-b1fb-e6e9-8368-bbf1b59f887d@leemhuis.info>
Date:   Fri, 9 Apr 2021 13:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87im4wznrx.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617969287;b9395910;
X-HE-SMSGID: 1lUpio-0006lL-0V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.21 19:31, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> +In case you performed a successful bisection, use the title of the change that
>> +introduced the regression as the second part of your subject. Make the report
>> +also mention the commit id of the culprit. For tracking purposes, add a line
>> +like the following that contains both pieces of information, but with the
>> +commit id shortened to 12 characters::
>> +
>> +    #regzb introduced: 94a632d91ad1 ("usc: xhbi-foo: check bar_params earlier")
>> +
>> +In case of an unsuccessful bisection, make your report mention the latest tested
>> +version that's working fine (say 5.7) and the oldest where the issue occurs (say
>> +5.8-rc1). For tracking purposes add a line expressing it like this::
>> +
>> +    #regzb introduced: v5.7..v5.8-rc1
> 
> I kind of share Greg's concern that people aren't going to want to do
> this; [...]

Yeah, I might have done a little too far and should have written it a
bit more relaxed (like "if you want to help, add a tag like this...").
Looking back at it I got a bit bold and went farther then initially
planned due to the ```Make it clear that the list is only for
regressions that people can describe some way, rather than some general
"I have issues with xyz".``` from Linus here:
https://lore.kernel.org/ksummit/CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com/

> [...]
> Also, though, as I understand it the system that will interpret these
> lines does not yet exist.  Experience tells me that, as this system
> comes into existence, you will have a good chance of deciding that you
> want the syntax to look different anyway.  So I would personally hold
> off on telling people to include directives like this until you have
> something that works with them.
> 
> But that's just me... if this is the way it's going to work then the
> docs should of course reflect that.

Yeah, but let's wait how things evolve before adding this then. :-D

FWIW, just sent v2 with the problematic bits dropped and the MAINTAINERS
entry Greg outlined.

Ciao, Thorsten
