Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742D3397CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhFAWvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:51:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:45718 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhFAWvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:51:45 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6ABE46E2;
        Tue,  1 Jun 2021 22:50:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6ABE46E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622587803; bh=ATNrq6rcLnlA0PjNk5Gm9LEzS+SsfUIsSB2YkEN3AtY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lTqUt73fxImotw5y40/z5/uMMMpKILxJjB7FDL+NSnklCwrZ8UH5Nnl0STNixdwoO
         BMJ9iQfhIvUkE4X+igDjUhymF7S9St5pghwXQ0Ujafb/MlNZq3G5Sbx7BzWNRy+bu2
         PHCbbgLHEW4hDN1ZdIwegSVoXI9+uf7+JBesda1ciZ3fA8/nxq62Slibm7c9em+wNm
         QN+lH+It3ogvMMOaxWA6b0hUL7slNY0bbg1Ta/kwIKE6mLBLlec5wO4/Z9klaQ2bfB
         OnIcO9uTpPlIkKvve4J2btWUkafVV7DC+51BbmfA3p+UG3SYTSZWa04kPNb4xki2ne
         eD5SZf6g+paKQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Wu X.C." <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: pdfdocs: Prevent column squeezing by tabulary
In-Reply-To: <277d68fa-c96a-0ccb-6ce0-4d314851d9fe@gmail.com>
References: <277d68fa-c96a-0ccb-6ce0-4d314851d9fe@gmail.com>
Date:   Tue, 01 Jun 2021 16:50:02 -0600
Message-ID: <87eedl8ajp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Setting a reasonable width to \tymin prevents column squeezing
> by tabulary.
> Width of 20em works well in almost all the tables still in the
> ascii-art format.
>
> Excerpt from tabulary package documentation at [1]:
>
>     To stop very narrow columns being too 'squeezed' by this process
>     any columns that are narrower than \tymin are set to their natural
>     width.
>
> [1]: https://mirrors.ctan.org/macros/latex/contrib/tabulary/tabulary.pdf
>
> Note: Sphinx has its own default value of \tymin set in
> sphinxlatextables.sty (Sphinx 4.0.2) and sphinxmulticell.sty
> (Sphinx 2.4.4) as follows:
>
>     \setlength{\tymin}{3\fontcharwd\font`0 }
>
> , which is not sufficient for kernel-doc.
>
> Tested against Sphinx versions 2.4.4 and 4.0.2.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> Hi all,
>
> This is another attempt to improve pdfdocs output.
> As far as I see, I don't see any obvious regression by
> this change.
>
> The effect of this change can be seen in (not limited to)
> the MODULE_LICENSE section in process.pdf (pages 10 and 11).
>
> I'd like to know this change looks reasonable to you.
>
> Any feedback is welcome!
>
>         Thanks, Akira
>
> --
>  Documentation/conf.py | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

jon
