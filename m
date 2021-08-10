Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA5A3DA6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhG2Oyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:54:38 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:36065 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229864AbhG2Oyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:54:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5E59B2B011C1;
        Thu, 29 Jul 2021 10:54:33 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 29 Jul 2021 10:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=k76RUZpT+yXq9JfoZ3nl1UjqDvth
        +gVcjMm7CyMdORc=; b=OkSINz24DReO2X8KmP7INsQgu9fu3HV80Q+ubVZ++qYd
        NPi6YmOf+rk0m8f9HkHdOAhsV9/zd8m8pWcsL4Tdehh7wQqbb+jL3Ms0P7FSK005
        A8qdPJjalSWSybrlxEjtxJ2xhphlzjFkQJHETKV0DZrgzWIP48m60Gqz4m2ruG/1
        rzJas31a15CWEjP1NSNNYo/SjIMws19kBBcGZOYrpNXA9bz2Cn/Yfko1CfqBeC5M
        9WBXOzy7FdnnK70GintxZEKq0bUydpAw4V3BsYOhjjpyWTW4n8gwNd3LD+iMfr6J
        eKzBA6yotdjynd4uFFM495rlZGQTdxbvitT6dBumVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=k76RUZ
        pT+yXq9JfoZ3nl1UjqDvth+gVcjMm7CyMdORc=; b=Ea/YojnyJCFCk1RAHynM3s
        gqBC1hSQp3HTeiL/Hoauv1wSyx+JLS+Peaodmxsl8SGD+OFqxy9vzMw7f0y4c/bx
        Z0zHizatOCEotFVw8ht3vELUf56sZn9ydmKJuYtAqaYm2ZjRuGE8D0VCxh9jmF1a
        vZI0GWoR72FX3TMV7EPdAi3RruRix5sHLZBjEBmxuMAFwH9n/6MHUMZKc2qRwpl6
        hi3M48A0X9+TTF+Nm90qDYlMa6Y9utXs7p3Y3BoTSXhahqA4DE6hKXdoQaB5VQ06
        MStU0C68pyysZybZy5ikEy7YPbnUwvJ2FqbWwg6qCTZ/llH+ea+Meq9921Yc72UA
        ==
X-ME-Sender: <xms:J8ECYYObVXxefpjb2_tNOzHCyGRy97CpQIVK5jJkGSC1gpNNHMLuAw>
    <xme:J8ECYe8E5RiYQNgi4MRjrpmH-TD0NLP_D0w-K3wnvQrcO3str08M4OjLF3DWJ6jid
    F9OrJ5VFotJtOwhf1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheefgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfhohhhn
    ucfgrhhitghsohhnfdcuoehlihhsthesjhhohhhnvghrihgtshhonhdrmhgvqeenucggtf
    frrghtthgvrhhnpedvhedtvedtiefhieefleelteehgfduveehteevveelieetheektdei
    keeiheejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlihhsthesjhhohhhnvghrihgtshhonhdrmhgv
X-ME-Proxy: <xmx:J8ECYfQrpiHHfBnPANec00KpFXN7OkXs1t5KoLFSLVvJoVyjVH2DAg>
    <xmx:J8ECYQtbEQEHQhJDdHTrodNIeqY8--WgE6D5Ac4x9Tq8VJAfxxnh0w>
    <xmx:J8ECYQdql8AvZWonkeYwV_3tXGZY2clgMV3eHm3Gc_cN09DXP2cNxg>
    <xmx:KMECYVHOSpoz8M28r1kAtjf1ZmsLg9OTwfM9olgaPtRMYY_Yu5NCHmfG5Ow>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC198FA0AA4; Thu, 29 Jul 2021 10:54:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-545-g7a4eea542e-fm-20210727.001-g7a4eea54
Mime-Version: 1.0
Message-Id: <e048b871-55db-4e7f-96c9-40aabdd076c5@www.fastmail.com>
In-Reply-To: <20210729142415.qovpzky537zkg3dp@wittgenstein>
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
 <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
 <cf07f0732eb94dbfa67c9d56ceba738e@AcuMS.aculab.com>
 <f8457e20-c3cc-6e56-96a4-3090d7da0cb6@JohnEricson.me>
 <20210729142415.qovpzky537zkg3dp@wittgenstein>
Date:   Thu, 29 Jul 2021 10:54:08 -0400
From:   "John Ericson" <list@johnericson.me>
To:     "Christian Brauner" <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Kernel Hardening" <kernel-hardening@lists.openwall.com>,
        "Jann Horn" <jann@thejh.net>,
        "Christian Brauner" <christian.brauner@canonical.com>
Subject: Re: Leveraging pidfs for process creation without fork
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wonderful, looking forward to it reading it then!

John

On Thu, Jul 29, 2021, at 10:24 AM, Christian Brauner wrote:
> On Wed, Jul 28, 2021 at 12:37:57PM -0400, John Cotton Ericson wrote:
> > Hi,
> > 
> > I was excited to learn about about pidfds the other day, precisely in hopes
> > that it would open the door to such a "sane process creation API". I
> > searched the LKML, found this thread, and now hope to rekindle the
> > discussion; my apologies if there has been more discussion since that I
> 
> Yeah, I haven't forgotten this discussion. A proposal is on my todo list
> for this year. So far I've scheduled some time to work on this in the
> fall.
> 
> Thanks!
> Christian
