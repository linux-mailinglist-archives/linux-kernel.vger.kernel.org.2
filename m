Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB263BBEA2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhGEPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhGEPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:10:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9BC061574;
        Mon,  5 Jul 2021 08:08:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C1764384;
        Mon,  5 Jul 2021 15:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C1764384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1625497691; bh=iY36fA/k/28IsBqAFY+L047OCkDUfsYEg1X/YpFO9s0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NXszzj97R0iDF5xau88Q8faouMLi/bJMdeGbRQ7xJw4LGh921DpG87Lx81bHP6mzE
         9UxVdye6PpjEq+XJ5saxUS5/OXQEGZ1YG068YPQ1tYhnBXI9DgY+qyNZB8wqVDha4/
         uKYkBHyt2n5P3fyD47Vs/Ar+OWJpAPq0ZNE6cjHHH5RBIAUkigHyQFuVElDr+EahmE
         VDLjk+UnR+9tYcTxqhrDPPAK18lViHCz9nCZh/SKquHHeDUCk5mq79Hm+fq+nWDq0h
         fiRftfm2oe0m49f7kIkAyg112zPBFoR4VS6NV4LRyTNqo4J6adtYjCdejhSmT3QM2U
         xRDxH0uP6SpJQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nishanth Menon <nm@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Christoph Hellwig <hch@lst.de>,
        Rahul T R <r-ravikumar@ti.com>
Subject: Re: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
In-Reply-To: <20210703012931.30604-1-nm@ti.com>
References: <20210703012931.30604-1-nm@ti.com>
Date:   Mon, 05 Jul 2021 09:08:11 -0600
Message-ID: <875yxokdd0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> Lets drop the unicode characters that peeped in and replace with
> equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
> rest of license files.
>
> This messes up code such as scripts/spdxcheck.py which assumed utf-8
> LICENSE files.
>
> Fixes: bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")

So...this file *is* in UTF-8; I'm finding your changelog a bit
confusing.=20

> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Christoph Hellwig <hch@lst.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
>
> Reported-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> also see: https://lore.kernel.org/linux-spdx/20210703012128.27946-1-nm@ti=
.com/T/#u
>
>  LICENSES/dual/CC-BY-4.0 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/LICENSES/dual/CC-BY-4.0 b/LICENSES/dual/CC-BY-4.0
> index 45a81b8e4669..869cad3d1643 100644
> --- a/LICENSES/dual/CC-BY-4.0
> +++ b/LICENSES/dual/CC-BY-4.0
> @@ -392,7 +392,7 @@ Section 8 -- Interpretation.
>  Creative Commons is not a party to its public
>  licenses. Notwithstanding, Creative Commons may elect to apply one of
>  its public licenses to material it publishes and in those instances
> -will be considered the =E2=80=9CLicensor.=E2=80=9D The text of the Creat=
ive Commons
> +will be considered the "Licensor." The text of the Creative Commons

It seems that what you're really doing is replacing "smart quotes" with
the basic ASCII variety?  That seems like a fine thing to do, but that's
not really what the changelog says.

I can tweak it when I apply this.

Meanwhile, though, if there's a bug it's the spdxcheck.py issue reported
by Rahul.  That problem doesn't reproduce here; he must be running in an
environment where ASCII is assumed.  Being explicit about the encoding
expected is the right fix in any case...  Maybe I'll snag that patch as
well if nobody else beats me to it.

Thanks,

jon
