Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF942635A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbhJHD4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhJHD4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:56:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAF1961029;
        Fri,  8 Oct 2021 03:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633665249;
        bh=9bjgKQfarun4QyA/2O9VymBK1JLbrL/msj0uW007cKs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cwGcrCMhexhwlM0vcO8sDVstbRoiQfjjT2aQ/sdYuk7aoVSoslGL/Dmpy6knxQJHa
         LVJQ5nymL9tF2fsggPfgM/1nD9LArmb4uKYz89ggf4H1nH3L6yYPt2h9ytwdjEYhjy
         qzYwLibMRwB+L7lVXhB75eYVX63FXDy8lvpLclkfes6V3tmHrvruTcBhsyPeCQgHKn
         ps2C51AUnOvxcmf2HGDwxHDP5yQd4QdHzp6gjMkdwCuFM3IW8rUq8FB35ZAhHgO8G5
         qSB57WUb/aogqlnZDrJZl5l0KwfODjrXgyG6vPPPV/K4kRm2Pm+LipQ+UpJpIJV0QA
         fcLe+43eZ01WA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210923132046.1860549-17-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com> <20210923132046.1860549-17-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 16/17] clk: remove extra empty line
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Thu, 07 Oct 2021 20:54:08 -0700
Message-ID: <163366524853.2041162.8478038065477963434@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2021-09-23 06:20:45)
> Remove extra empty line.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Please drop this patch. It's not relevant to the series.

>  drivers/clk/clk.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 64838754cdef..815fe5f6651e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3574,7 +3574,6 @@ static int __clk_core_init(struct clk_core *core)
> =20
>         clk_core_reparent_orphans_nolock();
> =20
> -
>         kref_init(&core->ref);
>  out:
>         clk_pm_runtime_put(core);
> --=20
> 2.25.1
>
