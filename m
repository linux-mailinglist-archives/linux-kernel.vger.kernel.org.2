Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3630FF4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhBDV3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:29:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:50788 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBDV3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:29:52 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6B3401E77;
        Thu,  4 Feb 2021 21:29:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6B3401E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1612474152; bh=GFyluLyYpm71JlUqgZ+l8ppi2lbAHdwfP7WaQL5guyk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gDrRsGEUODNmGU4l085LpPPzL1lusZn03TLZxnAQrBUOkKfTTOe6rDcKKeVCEJIWP
         9RyHCr7HQbrAJNXnkoCXZ3GGIiyv6a6AWftYHO4vKTXd1nJ+WBuWvOPnzvihp9UhM5
         6w7jijvrMxV0y+CkOQ6JW4851G+1V6PZ/tsL6Y+cRwcq3m9N+v598Kd2vNXpikZMLa
         VRVJ0xQK+B9ZxPz01575yG7upQnLZY8T+4p2J6QhHtEeT8droHfauemD8n7MB5Of58
         bmdvSiNel7r7KGcWCWh12IjafzWLsB0Z1sJWe9ngJniRR1Z4z38P+gPH1Dr0rcQEIu
         lS0tZV45bfxiw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 1/5] docs: arm: marvell: drop some dead links
In-Reply-To: <20210203235305.506528-2-lkundrak@v3.sk>
References: <20210203235305.506528-1-lkundrak@v3.sk>
 <20210203235305.506528-2-lkundrak@v3.sk>
Date:   Thu, 04 Feb 2021 14:29:11 -0700
Message-ID: <87pn1ffro8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> Just remove these; there's good chance there wasn't anything useful
> there anyway.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> ---
> Changes since v1:
> - Adjust for removal of "[PATCH 1/5] docs: arm: marvell: turn the automatic
>   links into labels"
> - Split off the hunk that fixes 38x functional spec link
>
>  Documentation/arm/marvel.rst | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
> index 16ab2eb085b86..502a1b89a2c85 100644
> --- a/Documentation/arm/marvel.rst
> +++ b/Documentation/arm/marvel.rst
> @@ -63,8 +63,6 @@ Kirkwood family
>                  - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.pdf
>                  - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
>                  - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
> -  Homepage:
> -	http://www.marvell.com/embedded-processors/kirkwood/
>    Core:
>  	Feroceon 88fr131 ARMv5 compatible
>    Linux kernel mach directory:
> @@ -126,7 +124,6 @@ EBU Armada family
>  	- 88F6820 Armada 385
>  	- 88F6828 Armada 388
>  
> -    - Product infos:   http://www.marvell.com/embedded-processors/armada-38x/

So these URLs do still exist in the Wayback machine; the above is
https://web.archive.org/web/20180829171124/http://www.marvell.com/embedded-processors/armada-38x/
for example.  If we delete the links, we make it harder for any
interested person to ever find them.  Assuming that we want to keep
information about these product families in the documentation at all,
I'd think that we would want to have the online information as well.  So
I'd replace these with wayback links, or else just leave them as they
are so that sufficiently motivated people can look them up themselves...

Make sense?

Thanks,

jon
