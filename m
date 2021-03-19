Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B272134265F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCSTjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSTjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:39:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B18C06174A;
        Fri, 19 Mar 2021 12:39:22 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lNKxt-00038L-11; Fri, 19 Mar 2021 20:39:21 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1615116592.git.linux@leemhuis.info>
 <148a84de8d109ebbc01a337fb93cb246410c4351.1615116592.git.linux@leemhuis.info>
 <878s6o18kq.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2 2/2] docs: reporting-issues.rst: shortcut for reporting
 stable regressions
Message-ID: <3d8b94a7-42e0-d47d-55a6-155324e10243@leemhuis.info>
Date:   Fri, 19 Mar 2021 20:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <878s6o18kq.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182762;da2fb3e8;
X-HE-SMSGID: 1lNKxt-00038L-11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.21 21:11, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Provide a much shorter and easier process for users that deal with
>> regressions in stable and longterm kernels, as those should be reported
>> quickly.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> CC: Randy Dunlap <rdunlap@infradead.org>
> 
> Seems generally good, but I had a couple of comments...

Thx for your feedback.


> […]
>> + * If you are facing a regression within a stable or longterm version line
>> +   (say something broke when updating from 5.10.4 to 5.10.5), head over to
>> +   'Dealing with regressions within a stable and longterm kernel line'.
> I would s/head over/scroll down/.  Otherwise readers may well wondering
> where to go to find this section.

Good idea. Used this phrase somewhere else also, addressed it there in a
septate patch in the series I just sent:
https://lore.kernel.org/linux-doc/cover.1616181657.git.linux@leemhuis.info/

> [...]
>> + * Make sure it's not the kernel's surroundings that are causing the issue
>> +   you face.
> I can imagine that a lot of readers would have no idea what that means.
> In fact, I'm not entirely sure what that means...

That's why it explained in the reference section. That is a bit hard to
spot just from the patch.

> [...]
>> +Regression in stable or longterm kernel?
>> +----------------------------------------
>> +
>> +    *If you are facing a regression within a stable or longterm version line
>> +    (say something broke when updating from 5.10.4 to 5.10.5), head over to
>> +    'Dealing with regressions within a stable and longterm kernel line'.*
> So you want to send them back upward here?

No, this is just repeating the text from the step-by-step guide, as it's
done everywhere in the reference section. It's hard to see in the diff
and more clear when you look at the document as a whole.

>> +Regression within a stable and longterm kernel version line are something the
>> +Linux developers want to fix badly, as such issues are even more unwanted than
>> +regression in the main development branch, as they can quickly affect a lot of
>> +people. The developers thus want to learn about such issues as quickly as
>> +possible, hence there is a streamlined process to report them. Note,
>> +regressions with newer kernel version line (say something broke when switching
>> +from 5.9.15 to 5.10.5) do not qualify.
> Given the length of this file, I really wonder if there isn't some way
> to cut back on the amount of repeated text?

The latest series addresses this:
https://lore.kernel.org/linux-doc/cover.1616181657.git.linux@leemhuis.info/

To avoid repeated text I had to use this in the end:
``` Perform the first three steps in the section "Reporting issues only
occurring in older kernel version lines" above. ```

Not ideal, but not too bad and works.

Thx again for your suggestions!

Ciao, Thorsten
