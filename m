Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E56370B1B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 12:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhEBKhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhEBKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 06:37:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526FC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 03:36:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q2so2146063pfh.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=nBVktWzWQs0ycy4eKYb+aWc95BFCqBy6EYnYKyLnjK8=;
        b=AJntAANakgvRSf7hmmuM/lzpDKoiWoXaj+vVMLF+fZsCQTOKl74DFP8kMuWnqVYbaM
         oFqz/6kbPE1oeOq11iQTSkeqVBbpHRimaWwnm42/3G2XuKaamx//oYbBQFURpohZGWoi
         edQ24k06DS0Sr/98QWi7wO9TxOeeGxC8PjCWlohkyosJsNjZ/M9OLQ4uYDwJ2GXuJ4Qy
         uOuhJ5fzug600sLCvHWz6e8xTLweHpQ/G5FD5rNJGzFWHxwTO+tSrbXHmvorA8DHTCs0
         zwhkTLbZF2IErEfGE8cOQgOE5cGcNISZskXW/yzHOHT46myueE513k6TY/3YTXnNbqWa
         eyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=nBVktWzWQs0ycy4eKYb+aWc95BFCqBy6EYnYKyLnjK8=;
        b=RNNt0XM6T2kQUCXdh3sui6owWu21SBxeQG/1XqYq7sCYMh1raFunPUhGlPhW07f4aM
         pu130WeNJfvcenYi8W87F1lIJfX68TcNorPwmaoskvHEDf2/yZ29BGAwckNQv825QqNx
         VUuH1GR7ND+KCbmF+aLLXU9MLJoUogvTw5WfeILOWQOwAJm2NW6bvw80cwagXcgeoKqD
         Y3qVGW8KYy+02ioqFbt3Ka64eVCL/ZswhDTt/hKRfat5L721khelDLiAp2ipkQ1AoI2V
         l025j3aJPAVeushMtZjT0p4/KYhez/7qzTGfnebNxz69g05mYzawgSBijF2uFQUnFP5N
         LMKg==
X-Gm-Message-State: AOAM533qr7+AnOzZp9oOjBDLG2U3OpAVGvjmAKsrQuYzC0HcJ0WoECS2
        z6e2WakNpunsavlMbd0JE7Y=
X-Google-Smtp-Source: ABdhPJzCjOdkQJYJB+L/1YPQM1uheCztA9Q5CyQcFjCdn7f88RCIQ+IbD+4aI/fe71w/2u5yg4bCJg==
X-Received: by 2002:a62:2d6:0:b029:204:9b3b:dced with SMTP id 205-20020a6202d60000b02902049b3bdcedmr13687340pfc.36.1619951780422;
        Sun, 02 May 2021 03:36:20 -0700 (PDT)
Received: from localhost ([61.68.127.20])
        by smtp.gmail.com with ESMTPSA id k12sm6937414pgh.16.2021.05.02.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 03:36:20 -0700 (PDT)
Date:   Sun, 02 May 2021 20:36:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/ioremap: Fix iomap_max_page_shift
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <0d615a242c4470462da547dc332e4ec5f00479dd.1619855673.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0d615a242c4470462da547dc332e4ec5f00479dd.1619855673.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1619951627.yczq2mwbu6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of May 1, 2021 5:58 pm:
> iomap_max_page_shift is expected to contain a page shift,
> so it can't be a 'bool', has to be an 'unsigned int'
>=20
> And fix the default values: P4D_SHIFT is when huge iomap is allowed.

Ugh, thanks that's obviously right.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Fixes: bbc180a5adb0 ("mm: HUGE_VMAP arch support cleanup")
> ---
>  mm/ioremap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index d1dcc7e744ac..2f7193c6a99e 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -16,16 +16,16 @@
>  #include "pgalloc-track.h"
> =20
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static bool __ro_after_init iomap_max_page_shift =3D PAGE_SHIFT;
> +static unsigned int __ro_after_init iomap_max_page_shift =3D P4D_SHIFT;
> =20
>  static int __init set_nohugeiomap(char *str)
>  {
> -	iomap_max_page_shift =3D P4D_SHIFT;
> +	iomap_max_page_shift =3D PAGE_SHIFT;
>  	return 0;
>  }
>  early_param("nohugeiomap", set_nohugeiomap);
>  #else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static const bool iomap_max_page_shift =3D PAGE_SHIFT;
> +static const unsigned int iomap_max_page_shift =3D PAGE_SHIFT;
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> =20
>  int ioremap_page_range(unsigned long addr,
> --=20
> 2.25.0
>=20
>=20
