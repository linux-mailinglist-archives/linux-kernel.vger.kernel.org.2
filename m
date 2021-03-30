Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB28A34E360
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhC3Ilv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhC3Ilb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:41:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB3C061762;
        Tue, 30 Mar 2021 01:41:31 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lR9w8-0005Lf-Ss; Tue, 30 Mar 2021 10:41:20 +0200
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
 <6a220d2c-568e-2e41-53a4-0800e206d0a6@leemhuis.info>
 <14d9b8a3-94ce-00a6-a17b-934ffd999697@leemhuis.info>
 <87r1jxpol6.fsf@meer.lwn.net> <YGK+M66FWJOMC8ky@kroah.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [1/5] reporting-issues: header and TLDR
Message-ID: <f32b5e5b-ed6b-cad5-08f6-b7923c621b74@leemhuis.info>
Date:   Tue, 30 Mar 2021 10:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YGK+M66FWJOMC8ky@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617093691;81938066;
X-HE-SMSGID: 1lR9w8-0005Lf-Ss
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.21 07:59, Greg KH wrote:
> On Mon, Mar 29, 2021 at 04:44:21PM -0600, Jonathan Corbet wrote:
>> Thorsten Leemhuis <linux@leemhuis.info> writes:
>>
>>> FWIW, on another channel someone mentioned the process in the TLDR is
>>> quite complicated when it comes to regressions in stable and longterm
>>> kernels. I looked at the text and it seemed like a valid complaint, esp.
>>> as those regressions are something we really care about.
>>>
>>> To solve this properly I sadly had to shake up the text in this section
>>> completely and rewrite parts of it. Find the result below. I'm quite
>>> happy with it, as it afaics is more straight forward and easier to
>>> understand. And it matches the step-by-step guide better. And the best
>>> thing: it's a bit shorter than the old TLDR.
>>
>> I think this is much improved - concise is good! :)

Yeah, I was kinda unhappy with the old version myself and glad that
something made be revisit this...

>>  I really just have one little comment...

Great!

>>> I'll wait a day or two and then will send it through the regular review
>>> together with a few small other fixes that piled up for the text, just
>>> wanted to add it here for completeness.
>>>
>>> ---
>>> The short guide (aka TL;DR)
>>> ===========================
>>>
>>> Are you facing a regression with vanilla kernels from the same stable or
>>> longterm series? One still supported? Then search the `LKML
>>> <https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
>>> <https://lore.kernel.org/stable/>_` archives for matching reports to
>>> join. If you don't find any, install `the latest release from that
>>> series <https://kernel.org/>`_. If it still shows the issue, report it
>>> to the stable mailing list and the stable maintainers.
>>
>> If we really want this to be a short guide that gets people to the
>> answer quickly, we might as well put the addresses to report to right
>> here rather than making people search for them.
> 
> "stable@vger.kernel.org" is good to use here, no need to also cc: any
> individuals for this type of thing.

Ahh, good to know, will change this accordingly. Will also change other
places in the text where this comes up.

Thx for the feedback! Ciao, Thorsten
