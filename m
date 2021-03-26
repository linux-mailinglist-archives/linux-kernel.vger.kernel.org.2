Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D934A4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZJtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:49:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE21C0613AA;
        Fri, 26 Mar 2021 02:48:59 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lPj5M-0005ls-Of; Fri, 26 Mar 2021 10:48:56 +0100
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
 <YF2iYFEoc56sfeMx@kroah.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [Ksummit-discuss] FYI & RFC: obsoleting reporting-bugs and making
 reporting-issues official
Message-ID: <10737257-cfb5-b24b-4f37-a53fd791fb73@leemhuis.info>
Date:   Fri, 26 Mar 2021 10:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YF2iYFEoc56sfeMx@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616752139;d35e3131;
X-HE-SMSGID: 1lPj5M-0005ls-Of
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 09:59, Greg KH wrote:
> On Fri, Mar 26, 2021 at 07:13:09AM +0100, Thorsten Leemhuis wrote:
>>
>> Lo! Since a few months mainline in
>> Documentation/admin-guide/reporting-issues.rst contains a text written
>> to obsolete the good old reporting-bugs text. For now, the new document
>> still contains a warning at the top that basically says "this is WIP".
>> But I'd like to remove that warning and delete reporting-bugs.rst in the
>> next merge window to make reporting-issues.rst fully official. With this
>> mail I want to give everyone a chance to take a look at the text and
>> speak up if you don't want me to move ahead for now.
>>
>> For easier review I'll post the text of reporting-issues.rst in reply to
>> this mail. I'll do that in a few chunks, as if this was a cover letter
>> for a patch-set. Note, the version I'll send in some areas looks a bit
>> different from the one currently in mainline. That's because the text
>> I'll send already incorporates a few patches from docs-next that are
>> waiting for the next merge window; I also removed the "WIP" box as well
>> as two remaining "FIXME" notes, as those point to aspects I mention
>> below already.
>>
>> @Greg, @Sasha, I'd be especially glad if at least one of you two could
>> take a look and yell if there is something you really dislike from the
>> perspective of the stable maintainers.
>
> I responded to the specific email, but will again here.  No objection
> from me at all, 

Thx for taking a look!

> this is a great resource, thanks for doing this.

Very glad to hear, thx.

>  If,
> over time, it needs any tweaks to explain things that people commonly
> get wrong, that's easy to do,

Which likely will be the case, but that's life. :-D

> so don't worry about trying to capture
> "everything" right away.

Hah, I'm not worried about that (but yes, I have a tendency in that
direction...). I just feared something along the lines of "ohh, this is
all wrong, who sneaked this into the kernel behind our back". ;-)

Ciao, Thorsten
