Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF253090E4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 01:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhA3AVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 19:21:48 -0500
Received: from ms.lwn.net ([45.79.88.28]:56862 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhA3AVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:21:41 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2CCC86183;
        Sat, 30 Jan 2021 00:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2CCC86183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611966029; bh=y1fFJHKIoUxe218IAZpwByu/fhOX2js7qwLkwd1p6zU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KZvoFDi1JkbU4s1BAXKECLwbfc7G9fXHOr2F5KydiGHTHbKZ3H2ZvCE10PkSiwi+A
         UpukPA/JNSDeLdZVGADYpp7rhjllPiSQ10Tq8eW0lRDP4p1x9OeV2/ANRMiBm7oWpc
         +Pml8i/rb/TbGJxS7zlxw3iFgmzeCqbaelJ7+AvuoN/L3b1o93lVEI/OEcxSKaDRcr
         imUlC+rks0Sy9WMwgDfVwToIs4aWGzgJrBB7DjtspKtBZScaJ6mu4fNq7oR5oQb0lz
         UMnHu23oL+Sb8ydiM7wjEWQKIdBt/kdtGI0IziWVgH0IXEzYkjmn55h7wTiizQ4pew
         AJAFQbjorFsyw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 1/5] docs: arm: marvell: turn the automatic links into
 labels
In-Reply-To: <20210129183950.75405-2-lkundrak@v3.sk>
References: <20210129183950.75405-1-lkundrak@v3.sk>
 <20210129183950.75405-2-lkundrak@v3.sk>
Date:   Fri, 29 Jan 2021 17:20:28 -0700
Message-ID: <87tuqzwa0j.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> Lines ending with obscenely long URLs at the end don't look good.
>
> Even if these links are not that long at this point, they will be when
> replaced with an archive link in a subsequent patch -- let's prepare for
> that.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/arm/marvel.rst | 209 ++++++++++++++++++++++++-----------
>  1 file changed, 143 insertions(+), 66 deletions(-)
>
> diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
> index 16ab2eb085b86..716551f9b60a1 100644
> --- a/Documentation/arm/marvel.rst
> +++ b/Documentation/arm/marvel.rst
> @@ -18,12 +18,12 @@ Orion family
>          - 88F5181L
>          - 88F5182
>  
> -               - Datasheet: http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
> -               - Programmer's User Guide: http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
> -               - User Manual: http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
> +               - Datasheet: `MV88F5182-datasheet.pdf`_
> +               - Programmer's User Guide: `MV88F5182-opensource-manual.pdf`_
> +               - User Manual: `MV88F5182-usermanual.pdf`_
>          - 88F5281
>  
> -               - Datasheet: http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
> +               - Datasheet: `marvel_88f5281_data_sheet.pdf`_
>          - 88F6183
>    Core:
>  	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
> @@ -32,37 +32,42 @@ Orion family
>    Linux kernel plat directory:
>  	arch/arm/plat-orion
>  
> +.. _MV88F5182-datasheet.pdf: http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
> +.. _MV88F5182-opensource-manual.pdf: http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
> +.. _MV88F5182-usermanual.pdf: http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
> +.. _marvel_88f5281_data_sheet.pdf: http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf

So I see what you're trying to do, but this has the effect of prettying
up the processed docs at the expense of making the plain-text version
harder to read.  Somebody who wants to find one of these datasheets from
the plain-text version has to skip further down in the file, hoping that
they pick out the right one among a set of long, similar URLs.
Honestly, I think we may be better off leaving them as they are.
Failing that, the right thing to do is to keep the lines defining the
URL labels right next to where they are referenced.

See what I'm getting at?

Thanks,

jon
