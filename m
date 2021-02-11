Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272C1319165
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhBKRqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:46:11 -0500
Received: from ms.lwn.net ([45.79.88.28]:51630 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhBKREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:04:51 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3EB7B4EB3;
        Thu, 11 Feb 2021 17:04:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3EB7B4EB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1613063048; bh=aMufq1Egd/yK6OMTtpi9xhpZ88WCcSnEMH+UEkktgGc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LrDZ37Q91HqFe+LhvksfXG2y6leZoEHOM3VAg/6ZSJQnkDCTj6ODuenvZbe3Akn/T
         LwlEewJVOpaUgLI5rcRKO5qnEOWXQ050vNKqZ+xysOeWFwBclJfy+omkwU/Km5Kcao
         dKTeMcldO5+X7nE0xG2CeEFX12CHklzRr3s0oyrE1vPM59suUHh4tyHceMSmn3Xpyy
         xkccROiyw3jRnCK6/R4z4EVDAiVR+lYQDvmyA3XmV5J1/nqxWqoeyzdXTr7wXce3hZ
         /f/HaFJtWFt+zrDowNAHLOK6j/JuKsPV8d3oxXUGsuSn2rRRas7GCowkFz31jWln43
         B5cPa2mlXkx7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, swboyd@chromium.org,
        tiwai@suse.de, nfraprado@protonmail.com, mchehab+huawei@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] docs: kernel-hacking: Remove the word fuck,trying to be
 civil :)
In-Reply-To: <20210205115951.1276526-1-unixbhaskar@gmail.com>
References: <20210205115951.1276526-1-unixbhaskar@gmail.com>
Date:   Thu, 11 Feb 2021 10:04:07 -0700
Message-ID: <87sg62pmd4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> s/fuck//
>
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/kernel-hacking/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
> index c3448929a824..ed1284c6f078 100644
> --- a/Documentation/kernel-hacking/locking.rst
> +++ b/Documentation/kernel-hacking/locking.rst
> @@ -958,7 +958,7 @@ grabs a read lock, searches a list, fails to find what it wants, drops
>  the read lock, grabs a write lock and inserts the object has a race
>  condition.
>
> -If you don't see why, please stay the fuck away from my code.
> +If you don't see why, please stay away from my code.

Sigh.

I've gotten a few variants of this patch over the years...I guess maybe
the time has come to apply one, so I did.  If the word is too offensive
to be in our docs, though, perhaps it shouldn't be in the changelog
either, so I rewrote it:

    docs: kernel-hacking: be more civil
    
    Remove the f-bomb from locking.rst.  Let's have a moment of silence,
    though, as we mark the passing of the last of Rusty's once plentiful
    profanities in this venerable document.

Thanks,

jon
