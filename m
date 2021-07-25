Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822B93D4FE5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGYTvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 15:51:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:41892 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhGYTvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 15:51:46 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3B73C2E5;
        Sun, 25 Jul 2021 20:32:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B73C2E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627245134; bh=7QhT/J297QJT6Cpdjm8wSVongOzafPvd1mgJJWRPlIo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aVUV6GVJiw1fuLB9GXqhwGSohd4wOM1cQ4qbk2AhFsvNf2xdQkFZd4RYduwjNp6LJ
         Iqk8JXcoVJhckFgIK1YgRlGTRjDN9rIvSKuXGIquOfQXO8CIzzo4bTu4HGPGZs+eJO
         gTQ4Qz+11ftYdzoQI+Opfih0HjccQAUyvn/WKo/sWsJMxy4xoI1RG8i2qsSXTEZqce
         Yjkq7CpPTQZ6zdyXOnhlqZtCd7NIqlXkMahFYdz5mj307M/sUVcH0sd3rqntdKQxi3
         huTO/fR/pZrPWMn/djvyW6vZ5hJlL7OTfxYEF1Xl4NImKAK2bRAOIp2ZHcM/H50WO/
         dUR9rW1NiTV2A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] deprecated.rst: Include details on "no_hash_pointers"
In-Reply-To: <20210723200526.3424128-1-keescook@chromium.org>
References: <20210723200526.3424128-1-keescook@chromium.org>
Date:   Sun, 25 Jul 2021 14:32:13 -0600
Message-ID: <87o8aquoc2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Linus decided a debug toggle for %p was tolerable, so update the
> %p deprecation documentation.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/process/deprecated.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 9d83b8db8874..8ced754a5a0f 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -164,7 +164,9 @@ Paraphrasing Linus's current `guidance <https://lore.kernel.org/lkml/CA+55aFwQEd
>    up to Linus's scrutiny, maybe you can use "%px", along with making sure
>    you have sensible permissions.
>  
> -And finally, know that a toggle for "%p" hashing will `not be accepted <https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/>`_.
> +If you are debugging something where "%p" hashing is causing problems,
> +you can temporarily boot with the debug flag "`no_hash_pointers
> +<https://git.kernel.org/linus/5ead723a20e0447bc7db33dc3070b420e5f80aa6>`_".

Applied, thanks.

jon
