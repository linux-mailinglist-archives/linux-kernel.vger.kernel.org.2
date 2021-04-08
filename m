Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6760F358B68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhDHRb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:31:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:56784 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231716AbhDHRb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:31:26 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE0D852BA;
        Thu,  8 Apr 2021 17:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE0D852BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617903074; bh=66Am5knCsMXAUCPM0lk6QauZKtVFb00wrB+5laBJ1U0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WdVW59NmkBQ5ljvolEKj2hdKTzVbjsG/1OXko/YM/ujOp2T0r4692OXpPYQsskfZn
         pkwtVm+7Lq0FpvBtlX+oIKAQFo/iW2xD+8M2k3+nsUTRqTSUx1ovbgnMMBrf5J7jD2
         oWhyY8COcIsDLFZN/bvmbsyTOjM8FQFd1iXSzzsHsg1qsWBVppDr0fhfNius3S8AlA
         wmENJWyzzIXrDwQrnZkVNm9B4hKcuWxgRaUfk6/Q4Sv7HxK7twN3HBNfkCMZVHZ8p4
         Q0+KK19FKI7z9nhMONQdmsReoDeD4JzNEFH6Of+qv7gEiyednfbeT78Vr77amKJ1+F
         DdFDmaTUbN+NQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] docs: reporting-issues: make everyone CC the
 regressions list
In-Reply-To: <813fc7b082a4b47ec6d34542971e9bba74fd4a51.1617786974.git.linux@leemhuis.info>
References: <cover.1617786974.git.linux@leemhuis.info>
 <813fc7b082a4b47ec6d34542971e9bba74fd4a51.1617786974.git.linux@leemhuis.info>
Date:   Thu, 08 Apr 2021 11:31:14 -0600
Message-ID: <87im4wznrx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> +In case you performed a successful bisection, use the title of the chang=
e that
> +introduced the regression as the second part of your subject. Make the r=
eport
> +also mention the commit=C2=A0id of the culprit. For tracking purposes, a=
dd a line
> +like the following that contains both pieces of information, but with the
> +commit=C2=A0id shortened to 12 characters::
> +
> +    #regzb introduced: 94a632d91ad1 ("usc: xhbi-foo: check bar_params ea=
rlier")
> +
> +In case of an unsuccessful bisection, make your report mention the lates=
t tested
> +version that's working fine (say 5.7) and the oldest where the issue occ=
urs (say
> +5.8-rc1). For tracking purposes add a line expressing it like this::
> +
> +    #regzb introduced: v5.7..v5.8-rc1

I kind of share Greg's concern that people aren't going to want to do
this; it could even be seen as an impediment to reporting problems in
general.  If you *really* want random users to input this sort of
information, you may well end up creating some sort of web page to step
them through it.

Also, though, as I understand it the system that will interpret these
lines does not yet exist.  Experience tells me that, as this system
comes into existence, you will have a good chance of deciding that you
want the syntax to look different anyway.  So I would personally hold
off on telling people to include directives like this until you have
something that works with them.

But that's just me... if this is the way it's going to work then the
docs should of course reflect that.

Thanks,

jon
