Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A724594DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbhKVSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhKVSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:43:56 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DECC061574;
        Mon, 22 Nov 2021 10:40:49 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mpEFC-0001wc-QK; Mon, 22 Nov 2021 19:40:46 +0100
Message-ID: <3823dfb9-cc72-57ae-a296-92d506de1531@leemhuis.info>
Date:   Mon, 22 Nov 2021 19:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Steven Rostedt <rostedt@goodmis.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1637566224.git.linux@leemhuis.info>
 <20211122151233.54xtnpwdmnrdj3jf@meerkat.local>
 <20211122120405.7a1e1c9f@gandalf.local.home>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/1] Create 'Reported:' and 'Reviewed:' tags for
 links in commit messages
In-Reply-To: <20211122120405.7a1e1c9f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1637606449;2fd5bd9c;
X-HE-SMSGID: 1mpEFC-0001wc-QK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.11.21 18:04, Steven Rostedt wrote:
> On Mon, 22 Nov 2021 10:12:33 -0500
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> 
>> As an alternative, I can offer that we continue to use Link: trailers with
>> extra data following the hashtag, as is already done for other trailers:
>>
>>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=215101   #report
>>     Link: https://lore.kernel.org/r/fobarbaz.5551212@localhost #review
>>
>> Note, that this merely for completeness, not in opposition to the proposal.

Thx, I'll mention those as a alternative in v2

>> I
>> find the "Link:" trailer to be semantically redundant, since what follows is
>> already clearly a hyperlink. Adding "Link: " in front of it is only necessary
>> for consistency and machine parsing reasons.
> 
> Machine parsing is the main reason for the Link: tag. I have scripts that
> key off of that tag and ignore any other "http" reference.
> 
> Perhaps the above is better, as it means we don't need to update our
> scripts for that parsing.

Hmmm. I'm not opposed, but I wonder if 'Reported:' and 'Reviewed:' are
this tiny bit easier to handle (both for placing and analyzing scripts)
that makes the difference between "nice idea, but fails to be used in
the field" and "after some tradition phase this becomes the new normal"
in the end.

Whatever, will mention that and point to this post in the next round.
Thx for the feedback!

Ciao, Thorsten
