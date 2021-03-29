Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBD34DC02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhC2WoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhC2WoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:44:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7521C061762;
        Mon, 29 Mar 2021 15:44:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EA6595CC;
        Mon, 29 Mar 2021 22:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EA6595CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617057862; bh=EKvmVbzD//QNEEEuaeTgAwCcHafiUeTm6qRa1v6UhRU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sYOtGao+7Dz0cFmHAFPNFvdh2Yu9lNiRnH7BZooXPXQ03s006cMRFxZ7lELQrk7Ht
         DAuw9DQgpfKLCJcKPcl/aflDdDk61+qlhrkWTImsKVIoekHLDsHtdYhR+5q6wrDnGD
         CsU2AGIQJGF9ao20InPcr+7B2SFMcmjNDCiNSbwhhJjyrvGsUjghj78rdRUa1doXSN
         6nNP4nAY9zrYtndA+Se8wPQqE52twACfVAnlfv/FduafJkEsCab5htgpUXiKPLfKGc
         3un9ieOFYZHYOyaEQ5SH85S7jeuevYTugykM66xQQA7/8o1ecI56g6F63qLmKWfc/O
         1o/bwKaHRjHYw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [1/5] reporting-issues: header and TLDR
In-Reply-To: <14d9b8a3-94ce-00a6-a17b-934ffd999697@leemhuis.info>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
 <6a220d2c-568e-2e41-53a4-0800e206d0a6@leemhuis.info>
 <14d9b8a3-94ce-00a6-a17b-934ffd999697@leemhuis.info>
Date:   Mon, 29 Mar 2021 16:44:21 -0600
Message-ID: <87r1jxpol6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> FWIW, on another channel someone mentioned the process in the TLDR is
> quite complicated when it comes to regressions in stable and longterm
> kernels. I looked at the text and it seemed like a valid complaint, esp.
> as those regressions are something we really care about.
>
> To solve this properly I sadly had to shake up the text in this section
> completely and rewrite parts of it. Find the result below. I'm quite
> happy with it, as it afaics is more straight forward and easier to
> understand. And it matches the step-by-step guide better. And the best
> thing: it's a bit shorter than the old TLDR.

I think this is much improved - concise is good! :)  I really just have
one little comment...

> I'll wait a day or two and then will send it through the regular review
> together with a few small other fixes that piled up for the text, just
> wanted to add it here for completeness.
>
> ---
> The short guide (aka TL;DR)
> ===========================
>
> Are you facing a regression with vanilla kernels from the same stable or
> longterm series? One still supported? Then search the `LKML
> <https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
> <https://lore.kernel.org/stable/>_` archives for matching reports to
> join. If you don't find any, install `the latest release from that
> series <https://kernel.org/>`_. If it still shows the issue, report it
> to the stable mailing list and the stable maintainers.

If we really want this to be a short guide that gets people to the
answer quickly, we might as well put the addresses to report to right
here rather than making people search for them.

Thanks,

jon

