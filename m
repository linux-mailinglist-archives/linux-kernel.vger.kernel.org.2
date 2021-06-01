Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57699397C53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhFAWUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:20:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:45034 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234740AbhFAWU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:20:29 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 685322CD;
        Tue,  1 Jun 2021 22:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 685322CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622585927; bh=2yabEFKh//VFd2YJCgm8kIdYA7dygVPkzhE0gMUph+g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Jlbp89h1wWR/z2IcJXdvHLvZqr1K4CvjZ0x2CHnKNdYz1j+bk+wiOr70E/iV0aisP
         HiFoIYsY1gnQVc1L6/IUBPJjBSoagHVJBgG9ZeDSbLqVVBBdX04uP3vSvU88fq964R
         /PHmI2zV+xDXLvRc49AFNm8DRmw6d/ZBnFQSqHhNNvy5OtHKmmoyCT5l5ivyIyK6ou
         GXdIvcJJMitrWW93Lu0JEO5cIdRm206bD77WeDFIsWFmBr06+AYXy4hvq/cMxH6qwv
         dTG06h3QGVAFonL+xLsf6ALDiYM09qlUVMRI1EQHXkDFmj90ytT19MmIJOAYP+2JBR
         rLJ0iK5ph50XQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        collins@gene3.ait.iastate.edu
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
In-Reply-To: <20210601220643.uzep2ju2zlcmpa57@begin>
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <875yyxbenm.fsf@meer.lwn.net> <20210601220643.uzep2ju2zlcmpa57@begin>
Date:   Tue, 01 Jun 2021 16:18:46 -0600
Message-ID: <874keh9qk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

> Jonathan Corbet, le mar. 01 juin 2021 12:53:01 -0600, a ecrit:
>> I am concerned about one thing, though: the licensing of this document
>> is not GPL-compatible, which means we can't build it into the rest of
>> the docs.
>
> ? I see various GFDL-1.1-no-invariants-or-later documentation in
> userspace-api/media notably, do they have such build restriction? What
> is actually posing problem in the GFDL licence?

Those media docs are separate from the rest of the kernel
documentation.  Other than that, all FDL in Documentation/ was
dual-licensed, last time I checked.

The problem is that the kernel docs, when built, include a great deal of
code and text taken directly from the kernel source.  The built docs are
thus a derived product of the kernel and the result needs to carry a
GPL-compatible license.  I've spent some time talking with lawyers about
this, and they have confirmed that view of things.

This document should not have entered Documentation/ with that license;
had I known this was happening at the time, I would have raised a fuss.
As a standalone .txt file there is probably no legal problem, but that
changes as soon as you bring it into RST TOC tree.

>> What are the chances that we can get the authors to agree on a change to
>> a GPL-compatible license for this file?
>
> I don't know about Collins' opinion on this, Cc-ing him with the latest
> mail my archives know for him (which dates 2008...)
>
> The copyright "the Speakup Team" is a more complex thing to look for.

Do you have a history of contributors to the file in its previous home?

I'm sorry to be obnoxious; I *really* want to see this document converted
and in with the rest.  But the licensing is something that we need to
get right.

Thanks,

jon
