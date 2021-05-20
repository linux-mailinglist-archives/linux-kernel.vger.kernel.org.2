Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0B38A31E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhETJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:49:01 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59393 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbhETJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:46:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 50D281CD2;
        Thu, 20 May 2021 05:45:09 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 20 May 2021 05:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=S1wkzhMSInbf7ETtluTNggFSIVXaUzw
        7tTQAjpsfmtM=; b=FoYW0kgpztRaHuqselcFrcYJ2Yb533VqrftzHAiNXQHzXvM
        AzNdPVWS5hflIzIFoV3nqUDJKdA1s1lF5y9k4bvzN6u3vZyrlFUyfyb1kLh4VLho
        ntMMbybteeW3+IGiHU8b3nGpulosot+SQnmdoCHhxbwvowPTwtYnPAmEhGqjg6KL
        C8hlNvcaAXucZZA5m6U1cZDj0/28f6wzJnjTBUpqrkF3T8g3SGWFP2pKJ9h3dXb5
        2LrBHHDwkYCEXO+Dy4Qugy8YqPKk5WLISzl6hcsv4jWbCrWKBkujjbAfiWhiQFpM
        AqI/hJVCXNTEc+n29J2q8WZoGbeCgCbFmoNS6zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=S1wkzh
        MSInbf7ETtluTNggFSIVXaUzw7tTQAjpsfmtM=; b=o8tKZA0hOudNHgGwBIXRf+
        WsZBC1LYRL+/EaoYojHuq1pZH0nvWerdbtk4QhOMQIYG8RCbb27DBM90QyVNGnTm
        MqZJhR27oNpJPaelWEB5vs8A9IQS2NHpJgWnQ715wsBsny414cEt5UtgSjW0zhte
        iF0oM8re9DxWcbkJq2ujiRenBPfyNn2OhVEj72J9UukV9Ngniilhqr5W+KKTwZDM
        BlHsqwI3UGH+VxDwcnxod2slsq/LoLIun+FULMETcEUObxUYZLjhnpg+evdExBO+
        hpG3N+8YP7O32VzyqMWj4yyVaQJR7JgtTQuB6MwVfDORs+5V0xnzFtqhHNJDmDlw
        ==
X-ME-Sender: <xms:pC-mYP0ku-ICvFey5ms_BCiWPoaHpbLAjCxmZfk9iYc6jc4chQzdRA>
    <xme:pC-mYOEpHHTLTYRWlSjCQnUbuJ4MdweVWO33ao50Q3Psw1ApFlkLOI9pe67hb2W-N
    UnccUa0CZlfFsC_yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejuddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepudfftddvveekfffgteffffeuveegjeelgefhffejtdehtdfhlefgkeef
    hfefkeeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:pC-mYP5Sam4a0PLpKA1TavTk6x-jzXXGOdNSet8vb3iPrIoQpbzFvw>
    <xmx:pC-mYE324JS_DNIsISdZN1kDP6ynmD8HsrkuZ05glyOlUxSQlsCLxQ>
    <xmx:pC-mYCHRUZICrDBWpUKAtvS9y1bTrYNTr5-wTAYTAsdkyN3hRAfzTA>
    <xmx:pC-mYPMlnfmzuzOgYOVwmQEyHeMu05Si_-webzUgCXGeHah7AC7Ueg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4ED18A004B5; Thu, 20 May 2021 05:45:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <72ed5aa8-bca5-451d-9458-48735fc17b84@www.fastmail.com>
In-Reply-To: <CABJPP5C7ZokRycaE0aAvUv3BfOJqOvPyqn-P0bbPdyCfnuuESw@mail.gmail.com>
References: <20210520015704.489737-1-andrew@aj.id.au>
 <CAKXUXMxTnz6edBLpBgqOo6uUiSGm8rULH9P8G24xx2OhP_Yb6A@mail.gmail.com>
 <a0d1f44a-c8ff-4108-af34-6455b5683262@www.fastmail.com>
 <CABJPP5C7ZokRycaE0aAvUv3BfOJqOvPyqn-P0bbPdyCfnuuESw@mail.gmail.com>
Date:   Thu, 20 May 2021 19:14:48 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Dwaipayan Ray" <dwaipayanray1@gmail.com>
Cc:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        "Joe Perches" <joe@perches.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, "Jiri Slaby" <jirislaby@kernel.org>
Subject: Re: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 May 2021, at 18:47, Dwaipayan Ray wrote:
> On Thu, May 20, 2021 at 12:55 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Thu, 20 May 2021, at 16:28, Lukas Bulwahn wrote:
> > > On Thu, May 20, 2021 at 3:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > include/linux/bits.h in [1]. Since [1] BIT() has moved again into
> > > > include/vdso/bits.h via [2].
> > > >
> > > > I think the move to the vDSO header can be considered a implementation
> > > > detail, so for now update the checkpatch documentation to recommend use
> > > > of include/linux/bits.h.
> > > >
> > > > [1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
> > > > [2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
> > > >
> > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > >
> > > Looks sound to me.
> > >
> > > I would prefer a bit of word-smithing the commit message by just
> > > removing the references:
> > >
> > > So:
> > >
> > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file"). Since that commit, BIT() has moved again into
> > > > include/vdso/bits.h via commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
> > > >
> > > > I think the move to the vDSO header can be considered a implementation
> > > > detail, so for now update the checkpatch documentation to recommend use
> > > > of include/linux/bits.h.
> > > >
> > >
> > > And then drop references [1] and [2].
> > >
> > > Andrew, what do you think?
> >
> > I mostly did this because initially I wrapped the commit message and
> > checkpatch spat out errors when it failed to properly identify the
> > commit description for [1]. But, leaving the description unwrapped
> > inline in the text feels untidy as it's just a work-around to dodge a
> > shortcoming of checkpatch.
> >
> > With the reference style the long line moves out of the way and
> > checkpatch can identify the commit descriptions, at the expense of
> > complaints about line length instead. But the line length issue was
> > only a warning and so didn't seem quite so critical.
> >
> > While the referencing style is terse I felt it was a reasonable
> > compromise that didn't involve fixing checkpatch to fix the checkpatch
> > documentation :/
> >
> 
> Hey,
> Can you share which wrap around caused the checkpatch errors
> to be emitted? We can try to fix that.
> 
> I was able to wrap it without checkpatch complaining. You might consider
> replacing it with this if you wish?
> 
> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").

This wording works because the commit description is only split across 
two lines. With the wording I had it was split across three, and this 
caused checkpatch to barf. If we do this:

While include/linux/bitops.h brings in the BIT() macro, it was moved to
include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
Move some macros from <linux/bitops.h> to a new <linux/bits.h>
file").

we get:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")'
#7: 
include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:

total: 1 errors, 0 warnings, 8 lines checked

Anyway, I've replaced the commit message with your suggestion:

https://lore.kernel.org/linux-doc/20210520093949.511471-1-andrew@aj.id.au/

Thanks for work-shopping it :)

Andrew
