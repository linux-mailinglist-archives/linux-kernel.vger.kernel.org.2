Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1FF441B49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhKAMqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhKAMqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:46:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACCFC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 05:44:04 -0700 (PDT)
Received: from [77.23.61.74] (helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mhWfR-0002on-Rk; Mon, 01 Nov 2021 13:44:01 +0100
Message-ID: <da21322a-95e8-40f9-a718-fa1e56eb203f@leemhuis.info>
Date:   Mon, 1 Nov 2021 13:44:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Thorsten is tracking regression again and could need a little
 help (was: Re: Linux 5.15)
Content-Language: en-BS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <a365ffb9-a4d2-b1d7-7cd7-dd9d7039e04e@leemhuis.info>
 <YX/ekB+9F9xvHCB7@kroah.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YX/ekB+9F9xvHCB7@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1635770645;4751c31d;
X-HE-SMSGID: 1mhWfR-0002on-Rk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.21 13:33, Greg KH wrote:
> On Mon, Nov 01, 2021 at 05:49:40AM +0100, Thorsten Leemhuis wrote:
>> example by simply forwarding the mail to regressions@leemhuis.info or
>> CCing that address on a reply. I'll handle everything else then and tell
>> regzbot about it. But if you feel adventurous, you can also skip me as
>> the man-in-the-middle and tell the bot directly. To do that, just send a
>> reply to the report to the regressions mailing list
>> (regressions@lists.linux.dev) either directly or by CCing it on a reply
>> you would have written anyway; when doing so, place something like
>> '#regzbot ^introduced v5.15..' (separated by blank lines) somewhere in
>> the text, as outlined in regzbot's 'getting started guide' or its
>> reference documentation:
>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
>>
>> That's it, regzbot then on its next run will add the report to the list
>> of tracked regression. I'll keep an eye on things and try to fix any
>> problems I notice, as there likely will be a few. But then doesn't need
>> to bother you.
>>
>> There is one thing that would really help: if one or two subsystem
>> maintainers could give regzbot a shot for all the regression reports
>> they get, even for easy fixes, as the bot really needs something to chew
>> on. Any volunteers?
> 
> I'll try it for the USB subsystem this merge cycle. 

That will be a great help, many thx.

> Do you want a bug
> report email redirected to that address or will a simple forward work
> well enough?

Redirecting will make it a little easier for me, but a simple forward is
fine, too.

thx!

Ciao, Thorsten
