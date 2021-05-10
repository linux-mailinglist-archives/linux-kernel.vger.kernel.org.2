Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C96378DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350256AbhEJM44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347960AbhEJMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:38:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC660C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:35:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r5so5907697lfr.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pqQBts0ODhA92hm3MB8OjzptbtGC+ihrqRtbHG7sVXw=;
        b=p21p5GYMrcSjHSGmiskc8Q3alQtgTWaHIOtRClPQ8u0x05D6NiCK4xu/ajtEro8mNn
         PdxPhx9sV464RdvJYGUpSLGrVUxxsGJR+HKIlEFrI/zYl29AF2uf0O/D9uvXKVXoyZ94
         ex9ePliUHc7CkPWbm7ASw0htwBO5OMLP3nfDJ9jkUCtKV7ZmK/KvesKWwAR5GD0xq6MI
         YpDEVVv3QRIcUlrB5T9osuYgmpHpYJBwusQZFRO4DdPQ2Qq4PQP5me6/KstWgidNUah5
         9BnQB0zFlzfS6akQeIPAv4/whU+FH1ic0mXg1KqUcr5RjbkOFNa7HZe75lx0VdnogPjq
         5i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pqQBts0ODhA92hm3MB8OjzptbtGC+ihrqRtbHG7sVXw=;
        b=SPrq/Beot/BQFU8+uZ1lAOoystX57f4rOIhje+bJstjKtxc6wvZD4Jn0RAIaTKHLcb
         SA6/yGMy/cW5LjZZlfW9unZXtNLav7b0n/TcnhAsXpOJDvrCX8G4778Aq4+midgUIKcW
         T1HQcDywZfckKkleufRDNpnmKzncXGoSpgrBX4Sz7M1DATDA4lBz7C3vXGtW56jJ7wVl
         GITMvzvo12RTjib94sLJp1JatE99ftVnv3W76rh1m0y+O5AAiZOELGf6k3rIKo8rEkGU
         g9s4lgYSJMyoimsVExpeLnVhghrr9t73wtECnwAYYf+QO74JcnNlf62OJtNfyPf1gIFQ
         e1Vg==
X-Gm-Message-State: AOAM531q0OiJXIw09WzvJ6mjAHpDhKu/WNtZC+ySpv2kySoE+OWpp4AJ
        Y0TN0xS+sQPKJB4+CNZE0UxEp+KJMWThWYDYTeL8hwUAtMKa
X-Google-Smtp-Source: ABdhPJwS/kyCvvJoneMwFlct9z1xQJQwExi8EAR6IhiIrla67b7o8XgStqu9hm9rlL1d8vFgpk5gTks6Lky4wu6wnrQ=
X-Received: by 2002:a05:6512:3d8f:: with SMTP id k15mr17351613lfv.227.1620650133533;
 Mon, 10 May 2021 05:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210508113342.94457-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210508113342.94457-1-j.neuschaefer@gmx.net>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 10 May 2021 15:35:22 +0300
Message-ID: <CAKKbWA4dJgjeKjY1MeLdpE0VV=ugKr7yMiC_5yn-9VXWtU3z6A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Nuvoton NPCM: Add myself as reviewer
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 2:35 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> Nuvoton NPCM7xx SoCs share a lot of the hardware design with Nuvoton
> WPCM450. I'm adding myself as a reviewer, so I don't miss patches that
> affect both NPCM7xx and WPCM450.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 661770e8e6fc1..78f9df2b6cd20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2184,6 +2184,7 @@ M:        Tali Perry <tali.perry1@gmail.com>
>  R:     Patrick Venture <venture@google.com>
>  R:     Nancy Yuen <yuenn@google.com>
>  R:     Benjamin Fair <benjaminfair@google.com>
> +R:     Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>  L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:     Supported
>  F:     Documentation/devicetree/bindings/*/*/*npcm*
> --
> 2.30.2
>


--=20
Regards,
Avi
