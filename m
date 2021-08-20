Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF83F320C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhHTRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhHTRMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:12:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200CC061575;
        Fri, 20 Aug 2021 10:12:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 57E685ED5;
        Fri, 20 Aug 2021 17:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 57E685ED5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1629479530; bh=bVa4sxbmQIGDzEI3g5GEfgBmr8tripbw9feo3hwV6b8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Iq9HQ0dQYmIVJSPDd6Ku5jkqE39gCES82p+EAUN4N0IgC9eiqjgGdBLPjvY+qiqEM
         l5toQPIjJPR4sVJwBVcUP1101L7SaeekBJ700CekOq46+fTaIMaEfOzFYrvzogE0fN
         OWIUgo5II34yRavm96VvXs8ZfQrFk+xSzpmYaW8tM/kEsLA4FuIxN3LH1dSAAjoA7k
         EuX+YyYYeHngNjxSBOhXGX6x929AeQzXvq2RON3awwM2WbA7zT4irbeTDQIA2oraMi
         6E/uC1Q/1+lGrUYKLGDISjjR5tLnET+Btdsc6Vc7tPVleEQkqeBl2h2F+8Lf10DlYb
         gJIhUA/acgQaQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Documentation/process/maintainer-pgp-guide: Replace
 broken link to PGP path finder
In-Reply-To: <20210812095030.4704-2-sj38.park@gmail.com>
References: <20210812095030.4704-1-sj38.park@gmail.com>
 <20210812095030.4704-2-sj38.park@gmail.com>
Date:   Fri, 20 Aug 2021 11:12:09 -0600
Message-ID: <87fsv4rqfq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj38.park@gmail.com> writes:

> From: SeongJae Park <sjpark@amazon.de>
>
> PGP pathfinder[1], which is suggested for finding a trust path to
> unknown PGP keys by 'maintainer-pgp-guide.rst', is not working now.
> This commit replaces it with other available tools.
>
> [1] https://pgp.cs.uu.nl/

This looks fine to me, but I'd like Konstantin [CC'd] to have a look and
let me know if he agrees...

Thanks,

jon

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/process/maintainer-pgp-guide.rst | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
> index 8f8f1fee92b8..29e7d7b1cd44 100644
> --- a/Documentation/process/maintainer-pgp-guide.rst
> +++ b/Documentation/process/maintainer-pgp-guide.rst
> @@ -944,12 +944,11 @@ have on your keyring::
>      uid           [ unknown] Linus Torvalds <torvalds@kernel.org>
>      sub   rsa2048 2011-09-20 [E]
>  
> -Next, open the `PGP pathfinder`_. In the "From" field, paste the key
> -fingerprint of Linus Torvalds from the output above. In the "To" field,
> -paste the key-id you found via ``gpg --search`` of the unknown key, and
> -check the results:
> -
> -- `Finding paths to Linus`_
> +Next, find a trust path from Linus Torvalds to the key-id you found via ``gpg
> +--search`` of the unknown key.  For this, you can use several tools including
> +https://github.com/mricon/wotmate,
> +https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/graphs, and
> +https://the.earth.li/~noodles/pathfind.html.
>  
>  If you get a few decent trust paths, then it's a pretty good indication
>  that it is a valid key. You can add it to your keyring from the
> @@ -962,6 +961,3 @@ administrators of the PGP Pathfinder service to not be malicious (in
>  fact, this goes against :ref:`devs_not_infra`). However, if you
>  do not carefully maintain your own web of trust, then it is a marked
>  improvement over blindly trusting keyservers.
> -
> -.. _`PGP pathfinder`: https://pgp.cs.uu.nl/
> -.. _`Finding paths to Linus`: https://pgp.cs.uu.nl/paths/79BE3E4300411886/to/C94035C21B4F2AEB.html
> -- 
> 2.17.1
