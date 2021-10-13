Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9B42B44B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 06:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhJMEjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 00:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhJMEja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 00:39:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCA8C061570;
        Tue, 12 Oct 2021 21:37:27 -0700 (PDT)
Received: from ip4d14bdef.dynamic.kabel-deutschland.de ([77.20.189.239] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1maW18-0005Va-0a; Wed, 13 Oct 2021 06:37:26 +0200
Message-ID: <63c4f64f-89ba-e9f9-4666-6b6fa6308839@leemhuis.info>
Date:   Wed, 13 Oct 2021 06:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1633593385.git.linux@leemhuis.info>
 <875yu2ui28.fsf@meer.lwn.net>
Content-Language: en-BS
Subject: Re: [PATCH v1 0/2] Prefer lore.kernel.org and explain Link: tags
 better
In-Reply-To: <875yu2ui28.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1634099847;cb9ae380;
X-HE-SMSGID: 1maW18-0005Va-0a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry, once again I have to sent it a second time, as vger rejected it;
thunderbird once again messed for some reason used
"Content-Transfer-Encoding: 7bit" then it should have used 8bit; I tried
to track this down by sending mails to myself, but then it sets 8bit
correctly when needed :-/ ]

On 12.10.21 22:03, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Lo! The regression tracking bot I'm working on can automatically mark an
>> entry as resolved, if the commit message of the fix uses a 'Link' tag to
>> the report.  Many developers already place them, but it afaics would
>> improve matters to make this more explicit. Especially as I had missed
>> the modified section myself at first, as I simply grepped for 'Link:'
>> and only found an explanation in configure-git.rst.
>>
>> Konstantin after posting v1 suggested to use lore.kernel.org instead or
>> lkml.kernel.org, which made me add a patch to realize this everywhere in
>> the docs.
>>
>> v2:
>> - slightly reword after suggestiones from Konstantin (thx!)
>> - make this a patch series with an preparatory patch that does
>>   s!lkml.kernel.org!lore.kernel.org! everywhere in the docs
>>
>> v1: https://lore.kernel.org/r/7dff33afec555fed0bf033c910ca59f9f19f22f1.1633537634.git.linux@leemhuis.info/
>> - initial version
>>
>> Ciao, Thorsten
>>
>> Thorsten Leemhuis (2):
>>   docs: use the lore redirector everywhere
> 
> OK, I've applied this one, thanks.

Thx!

>>   docs: submitting-patches: make section about the Link: tag more
>>     explicit

Yeah, totally fine.

> There was a comment on this one, so I've not (yet) applied it.
> 
> FWIW, I, too, have the Link: tags put in automatically when I apply a
> patch, as Jani described; it's a simple hook in
> .git/hooks/applypatch-msg.  That seems worth mentioning here more than
> instructions on how to construct the link - I doubt many people do it
> manually.

Well, that is already explained in
Documentation/maintainer/configure-git.rst afaics -- which is the better
place afaics, as that is something maintainers should do, and not
something people should do when submitting a patch.

Ciao, Thorsten
