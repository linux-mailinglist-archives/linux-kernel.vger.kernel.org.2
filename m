Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC13090E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 01:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhA3ASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 19:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhA3AQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:16:34 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235BC06174A;
        Fri, 29 Jan 2021 16:15:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 468C36142;
        Sat, 30 Jan 2021 00:15:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 468C36142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611965742; bh=M2tjm2zvpwz+6McLyPCdVsfVAKOBKj8VqkTZQibMfiM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BKy484P3LlfiDsc2tWkvciRrtHOVRbwBMWJs9fR9wf8Z0GIUTJmmf4ZvnkVv2F4Nu
         xHCcvSKmFXbdZ/vqXNNW9CA5j06HY6O5MTc3PBAihx1tIjE8RdUSKkHNh2N9eGGSxH
         vb8FB7yIhqpqR6+ZsEsDua4HiIF9XB5Irp2tmvSayEu62ABTz8Ba9CclgSkr2nKVWP
         kHccip/bUrJL7RTZYji/NNKIIkkFugXj0kZ72pJWC+ZrjUIB79n5n3kUwpube4z7e/
         tOS4mitZx4B9StbG0pd4377Bdjt3owntYUL9YGe/obxOaHxuaVvPeM4PRMTmRUOEd7
         g8rHoO0ZCdyEA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Noa Sakurajin <noasakurajin@web.de>
Cc:     Noa Sakurajin <noasakurajin@web.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] Updates Documentation/Makefile to use Python3 as fallback
In-Reply-To: <20210129113544.25946-1-noasakurajin@web.de>
References: <20210129113544.25946-1-noasakurajin@web.de>
Date:   Fri, 29 Jan 2021 17:15:41 -0700
Message-ID: <87y2gbwa8i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noa Sakurajin <noasakurajin@web.de> writes:

[CC += kbuild maintainers]

>  Before the command python was needed for the documentation to build.
>  This patch checks if python is available and uses python3 as
>  fallback.
>
>  This is needed because a lot of distribution (at least Ubuntu)
>  only provide python3 and not python. scripts/sphinx-pre-install
>  checks for python3 first and does not check if python exists
>  which causes it to report that everything is installed even
>  if the documentation build failed.
>
> Signed-off-by: Noa Sakurajin <noasakurajin@web.de>
> ---
>  Documentation/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 61a7310b49e0..8a4a7df3b74a 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -75,7 +75,8 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>        cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media $2 && \
>  	PYTHONDONTWRITEBYTECODE=1 \
>  	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
> -	$(PYTHON) $(srctree)/scripts/jobserver-exec \
> +	PY=$(shell command -v $(PYTHON) 2> /dev/null) \
> +	$${PY:-"$(PYTHON3)"} $(srctree)/scripts/jobserver-exec \

So I see what you're trying to do, and we definitely want this to work.
I susped this isn't the right fix, though; it could leave us open to
similar issues elsewhere in the tree.

Personally, I think that $(PYTHON) should get a working Python if it's
installed, so I would suggest fixing the top-level Makefile to set it
correctly.  Masahiro, thoughts on that?

Alternatively, we could just say $(PYTHON3) and explicitly leave Python2
behind; that needs to happen in the not-too-distant future regardless
but we haven't decided to actually do it yet.

Thanks,

jon
