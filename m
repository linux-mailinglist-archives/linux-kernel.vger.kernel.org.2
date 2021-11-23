Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F92459EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhKWI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhKWI4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:56:46 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05EC061714;
        Tue, 23 Nov 2021 00:53:38 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mpRYV-0004bX-6r; Tue, 23 Nov 2021 09:53:35 +0100
Message-ID: <56d7b2d8-1c35-0365-5e85-e40d242c15f5@leemhuis.info>
Date:   Tue, 23 Nov 2021 09:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211122112916.498810bb@gandalf.local.home>
 <aa158444-4319-a019-1031-095a69105447@leemhuis.info>
 <20211122152426.7c2b3ab4@gandalf.local.home>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
In-Reply-To: <20211122152426.7c2b3ab4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1637657618;ada75402;
X-HE-SMSGID: 1mpRYV-0004bX-6r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.11.21 21:24, Steven Rostedt wrote:
> On Mon, 22 Nov 2021 19:50:35 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
>>> That said, I would like a way to have versions show a link to the last
>>> version that was reviewed.
>>>
>>> v1: has no tags
>>>
>>> v2: has a Reviewed: tag to v1.
>>>
>>> v3: has a Reviewed: tag to v2
>>>
>>> [...]
>>>
>>> Then the final commit could have a "Link" or "Reviewed" tag to v3, even
>>> though there may not be any reviews to v3, but v3 has the link to v2, and
>>> v2 has the link to v1, etc.  
>>
>> Is that really worth it? Isn't it sufficient if the commit links to the
>> last public review posting, as that already should link to all earlier
>> review postings. Sure, not everybody is doing this right now, but maybe
>> just educating people to do so is better than creating something new.
> 
> Isn't "as that already should link to all earlier review postings" what I'm
> suggesting above? I haven't seen many people do that yet.

Yeah, you are right, sorry, my perception was wrong.

Any maybe I got your suggestion wrong, but what you suggested sounded to
me like "each patch should link to the previous submission of the
patch". I just wonder if it's way easier and sufficient if just the
cover letter links to the previous or all earlier submissions of the
series in its revision history (sorry, I didn't should have made this
more obvious in my earlier mail); for patches without a cover letter
this obligation obviously would shift to the patch.

IOW: I have something in mind like in this submission:
https://lore.kernel.org/lkml/cover.1637252610.git.sander@svanheule.net/

Only the cover letter links to the earlier version, not the individual
patches.

But I have no strong feeling here, I don't care much about this.

Ciao, Thorsten
