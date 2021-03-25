Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C843499EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhCYTBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:01:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:47018 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230133AbhCYTBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:01:16 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF7A531A;
        Thu, 25 Mar 2021 19:01:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF7A531A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616698875; bh=o4zcLbe60+zybZhVxDlbITNaE4I1j5dMPZcE8EhXWH8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=s/G8WXkYwun9KQ/lqF9ctUeT6X2saj9V3UIY45LqbJFI/bcNdLeJQm5qSRMjWZUcD
         Tv7CBjsyY3pgiufoffRg4qvPzCWZmpNVriswBNtEM8MHkU1hsJoTLoBhGEGXTbGClf
         mcems0M5V9psxQLbmTDdUnqY+1H8k2hI6ax3Uscu4mHi7ekwpsMO5qn5s1r1tKduQ5
         J1OsFfZNh6YM2/VvuJCHAuUCupEUDb2uq+ATIPmc4SYxkBMfHTiI2XKtJmruZlxzt2
         ZNQpf+H1SycKgpibRVkMpj8SQ3CjOknaEmNijhr3bRkjGvQNu08P5SwiEBnTKhrrkD
         inuys9c3YQHCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 0/7] Fix some issues at get_abi.pl script
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
Date:   Thu, 25 Mar 2021 13:01:14 -0600
Message-ID: <87lfabys5h.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series replace this patch:
> 	https://lore.kernel.org/linux-doc/20210324191722.08d352e4@coco.lan/T/#t
>
> It turns that there were multiple bugs at the get_abi.pl code that
> create cross-references.
>
> Patches 1 to 6 fix those issues, and should apply cleanly on the top of
> the docs tree (although I tested against next-20210323).
>
> Patch 7 is optional, and independent from the other patches. It is meant
> to be applied against akpm's tree.  It makes the description (IMHO) 
> clearer, while producing cross references for the two mentioned symbols.

So perhaps this is the best solution to the problem, but I must confess
to not being entirely happy with it.  get_abi.pl is becoming another
unreadable perlpile like kerneldoc, and this makes it worse.  Doing RST
parsing there seems particularly unwelcome.

Should the cross-reference generation, it now occurs to me, be done in
the automarkup module instead?  Then there's no need to interpret RST,
and we'd get cross-references throughout the kernel docs rather than in
just the ABI stuff.  Am I completely out to lunch here?

Thanks,

jon
