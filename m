Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC442AD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhJLUFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:05:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:53214 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhJLUFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:05:30 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EAD4B867;
        Tue, 12 Oct 2021 20:03:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EAD4B867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634069008; bh=705nhZOSIC+HMMxSXjg7eS0I/Jw0XSH92UQ4FaT0OjE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NZQOn05XVElPb8oU1Hkoxar8WANnSfxgadySI6ANiEAytZaH130WKY3Y2oXIXf9qU
         +a/6dDF6w7ZBT1RbHJHlA75NjQKqWaSBvz8o6JiWf7KeKD3uvlnO4Le2j8qe2QkH3s
         JmHrzGhhDuPtg+KoC6YA67S01bd1idR6hz7Hgk+ZAMPayZCdPn6Ezuq23RD0eu6G1U
         gR3fMlL7ESDf6xnqwyEAIhbznSO4SAwgS/4VEKK9ftSxsU7ZeGAHQAqiWhUjcFM87v
         3tMQBLsQsA4gJOOuSa7gc7hV7MN7msMcI4hSaggFmUOQ3OFCZHW44ptW0LgpbTrFN6
         GEpz3Lt96DuKQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Prefer lore.kernel.org and explain Link: tags
 better
In-Reply-To: <cover.1633593385.git.linux@leemhuis.info>
References: <cover.1633593385.git.linux@leemhuis.info>
Date:   Tue, 12 Oct 2021 14:03:27 -0600
Message-ID: <875yu2ui28.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Lo! The regression tracking bot I'm working on can automatically mark an
> entry as resolved, if the commit message of the fix uses a 'Link' tag to
> the report.  Many developers already place them, but it afaics would
> improve matters to make this more explicit. Especially as I had missed
> the modified section myself at first, as I simply grepped for 'Link:'
> and only found an explanation in configure-git.rst.
>
> Konstantin after posting v1 suggested to use lore.kernel.org instead or
> lkml.kernel.org, which made me add a patch to realize this everywhere in
> the docs.
>
> v2:
> - slightly reword after suggestiones from Konstantin (thx!)
> - make this a patch series with an preparatory patch that does
>   s!lkml.kernel.org!lore.kernel.org! everywhere in the docs
>
> v1: https://lore.kernel.org/r/7dff33afec555fed0bf033c910ca59f9f19f22f1.1633537634.git.linux@leemhuis.info/
> - initial version
>
> Ciao, Thorsten
>
> Thorsten Leemhuis (2):
>   docs: use the lore redirector everywhere

OK, I've applied this one, thanks.

>   docs: submitting-patches: make section about the Link: tag more
>     explicit

There was a comment on this one, so I've not (yet) applied it.

FWIW, I, too, have the Link: tags put in automatically when I apply a
patch, as Jani described; it's a simple hook in
.git/hooks/applypatch-msg.  That seems worth mentioning here more than
instructions on how to construct the link - I doubt many people do it
manually.

Thanks,

jon
