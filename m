Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D69426356
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbhJHDxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhJHDxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:53:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6889A60462;
        Fri,  8 Oct 2021 03:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633665097;
        bh=pKR3YtBNKGES2/NNydGS0iU1J2x9MVTJs7GYv4ymaF8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mkgm32nmpaVyGhvTW9KHxNHXqLf9KO5cN9OsiRZRAbt36Vp9Na9xuJW3qnNQUfPbV
         n+g/cx+5vBrarRhHlYqso6bCxRCVnR1NRTBXvJJazXUHuU1hdzvFZK15Zr6kGiJbDQ
         iPVeGjQhbDtMKGIgV9L6FVQ58Lc84hXkhjN5Yik6hlhlS9/S3BBihDsapZPFzvD+I3
         VuEH9ZjAj6RWuTYfVNzh01ZbAxnsvUsiFhhcCrzD483WvnLiygwnuS4X4A2sZQ1c2j
         o+FPguVAa0WoB+vBm0IOG19r8C3JwxR/OZNC4WyrRUhJYzobQ3DDPwNjRoiPzHT37I
         DXz6dexfYFe+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210923132046.1860549-3-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com> <20210923132046.1860549-3-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 02/17] clk: at91: pmc: execute suspend/resume only for backup mode
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Thu, 07 Oct 2021 20:51:36 -0700
Message-ID: <163366509609.2041162.16407625879723979586@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2021-09-23 06:20:31)
> Before going to backup mode architecture specific PM code sets the first
> word in securam (file arch/arm/mach-at91/pm.c, function at91_pm_begin()).
> Thus take this into account when suspending/resuming clocks. This will
> avoid executing unnecessary instructions when suspending to non backup
> modes. Also this commit changed the postcore_initcall() with
> subsys_initcall() to be able to execute of_find_compatible_node() since
> this was not available at the moment of postcore_initcall(). This should
> not alter the tcb_clksrc since the changes are related to clocks
> suspend/resume procedure that will be executed at the user space request,
> thus long ago after subsys_initcall().

Is the comment still relevant though?

>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index b2806946a77a..58e9c088cb22 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -110,13 +112,35 @@ struct pmc_data *pmc_data_allocate(unsigned int nco=
re, unsigned int nsystem,
>  }
> =20
>  #ifdef CONFIG_PM
> +
> +/* Address in SECURAM that say if we suspend to backup mode. */
> +static void __iomem *at91_pmc_backup_suspend;
> +
>  static int at91_pmc_suspend(void)
>  {
> +       unsigned int backup;
> +
> +       if (!at91_pmc_backup_suspend)
> +               return 0;
> +
> +       backup =3D *(unsigned int *)at91_pmc_backup_suspend;

This will fail sparse. Why are we reading iomem without using iomem
reading wrapper?

> +       if (!backup)
