Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E240F239
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhIQGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhIQGV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB0436103C;
        Fri, 17 Sep 2021 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631859605;
        bh=1Nit0NWU/BQMpjN9xQFwjbTFQ11n4UzaM6ahT36Z4Uk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uTQdBwEQH9nApxqG5lIRvQ9A8WPX8pMnVeTXmYyVA2q1ta9xHr3TrXvEkYO1ECCXy
         6tLW0pikhSOoNrKJVWePELS5OxJCsiHgqXEIY9KnTResBpFlJufc/XBpzfmJQlEnE8
         D1ZDEG0jfNMxYj2YsPVNH0Hq765xIBossyhFFP5vthI0So48eJL2PUVVS4p0LdeVC+
         TLf+70cmSub0Ub1y9/D80PZwodhb7F30ar8GvcsYJ8QlEtgWmAckg0HOLiYZ4xnuZM
         nKbtPlM/iPKMmo1xN6f21PjmyA/rfCQKcyqEOkhE6hURlhYbqQ40uZvGZkqY+JH2CP
         /BAyXS5IUO2lg==
Received: by mail-lf1-f48.google.com with SMTP id b15so10004696lfe.7;
        Thu, 16 Sep 2021 23:20:05 -0700 (PDT)
X-Gm-Message-State: AOAM530EEh43gpxIk6Vtp1pGlqf6igIv1BEa96Nf74JwyBebgVokZFs3
        4r57XdInuXAxwS7qyBgRtUiG4+T0QEozfivzs78=
X-Google-Smtp-Source: ABdhPJxKYK7g0ZGUrJmwoweTscq2mCURTlX+AFb0KObcnOEzLmsbXzw8+xBrNthTJH05apDukakqxh3DKcOq8K2cZ7U=
X-Received: by 2002:a05:6512:44a:: with SMTP id y10mr6758095lfk.60.1631859604056;
 Thu, 16 Sep 2021 23:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210917043838.3514789-1-linux@roeck-us.net> <20210917043838.3514789-4-linux@roeck-us.net>
In-Reply-To: <20210917043838.3514789-4-linux@roeck-us.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 17 Sep 2021 14:19:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSqKZKnUw-UQt5Tiag3T0D04dBW9FijaxPX7Q985=+j7w@mail.gmail.com>
Message-ID: <CAJF2gTSqKZKnUw-UQt5Tiag3T0D04dBW9FijaxPX7Q985=+j7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] csky: Make HAVE_TCM depend on !COMPILE_TEST
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked, thx. It'll in next-tree.

On Fri, Sep 17, 2021 at 12:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Building csky:allmodconfig results in the following build errors.
>
> arch/csky/mm/tcm.c:9:2: error:
>                 #error "You should define ITCM_RAM_BASE"
>     9 | #error "You should define ITCM_RAM_BASE"
>       |  ^~~~~
> arch/csky/mm/tcm.c:14:2: error:
>                 #error "You should define DTCM_RAM_BASE"
>    14 | #error "You should define DTCM_RAM_BASE"
>       |  ^~~~~
> arch/csky/mm/tcm.c:18:2: error:
>                 #error "You should define correct DTCM_RAM_BASE"
>    18 | #error "You should define correct DTCM_RAM_BASE"
>
> This is seen with compile tests since those enable HAVE_TCM,
> but do not provide useful default values for ITCM_RAM_BASE or
> DTCM_RAM_BASE. Disable HAVE_TCM for commpile tests to avoid
> the error.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/csky/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 58ca3ef02bab..823d3d5a9e11 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -241,6 +241,7 @@ endchoice
>
>  menuconfig HAVE_TCM
>         bool "Tightly-Coupled/Sram Memory"
> +       depends on !COMPILE_TEST
>         help
>           The implementation are not only used by TCM (Tightly-Coupled Meory)
>           but also used by sram on SOC bus. It follow existed linux tcm
> --
> 2.33.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
