Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310D2344FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhCVTZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCVTZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:25:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B1DC061574;
        Mon, 22 Mar 2021 12:25:19 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lOQAv-00060F-Hz; Mon, 22 Mar 2021 20:25:17 +0100
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: RFC: create mailing list "linux-issues" focussed on issues/bugs
 and regressions
Message-ID: <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
Date:   Mon, 22 Mar 2021 20:25:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616441120;4b7f5377;
X-HE-SMSGID: 1lOQAv-00060F-Hz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.21 19:32, Linus Torvalds wrote:
> On Mon, Mar 22, 2021 at 8:18 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>>     I even requested a
>> "linux-regressions@vger.kernel.org" a while later, but didn't hear
>> anything back; and, sadly, about the same time I started having trouble
>> finding spare time for working on regression tracking. :-/
>
> Honestly, I'd much prefer the name 'linux-regressions' as being much
> more targeted than 'linux-issues'.

That only solves one of the two problem I'm trying to solve (albeit the
one that is more important to me). That way users still have no easy way
to query for reports about issues that are no regressions – say
something is broken and they have no idea if it once worked or never
worked at all.

> Make it clear that the list is only
> for regressions that people can describe some way, rather than some
> general "I have issues with xyz".
> 
> The more clear-cut the list is, the better, I think.

I agree to the last point and yeah, maybe regressions are the more
important problem we should work on – at least from the perspective of
kernel development.  But from the users perspective (and
reporting-issues.rst is written for that perspective) it feel a bit
unsatisfying to not have a solution to query for existing report,
regressions or not. Hmmmm...

Ciao, Thorsten
