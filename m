Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE4331BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhCIA0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:26:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:44444 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhCIA0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:26:06 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 27FF431A;
        Tue,  9 Mar 2021 00:26:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 27FF431A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615249566; bh=jplColhq3qy2UUm0RSVprSU3TKo4R0sGbR/6E6RHXIw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O9YWNCdjoNzBacpw8ZKmhlHGknK9OA1A4cFBNAFqDjcdLanEJqaYHvV0NCvz5qZdw
         c5PCBK2X+6L2XDc48DGhFhkgcI4Ie9cIMghyRJbUwiRAIy7pE9kg7prKAu0utDPbQ+
         VVGS6eyzoslUTMTIWZIj8eYXFw01W8dyla6O7Gl9eVI3apU0SOrYAdIWggw+kjfvLD
         +QFepTGZxvSUHmC9FRHC9ph68dEvOp3Jwk6gzuwE1Yy/fPCUS5MBmmot0j2M3Vhlbz
         GFVZUBjx+2Sz6ghiFTEzbks0G5RNB6n8kQuWp149ol83glrNhnykx93QWrZNM8x5MN
         IavGMv6GR6l+w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, jpoimboe@redhat.com,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com, live-patching@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH V2] docs: livepatch: Fix a typo and remove the
 unnecessary gaps in a sentence
In-Reply-To: <20210305100923.3731-1-unixbhaskar@gmail.com>
References: <20210305100923.3731-1-unixbhaskar@gmail.com>
Date:   Mon, 08 Mar 2021 17:26:05 -0700
Message-ID: <87ft1541gi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> s/varibles/variables/
>
> ...and remove leading spaces from a sentence.
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes from V1:
>   Pter pointed out some awkward  leading space in a sentence ,fixed it.
>
>  Documentation/livepatch/shadow-vars.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I've applied this, poking in the suggested prepositional tweak in the
process.

Thanks,

jon
