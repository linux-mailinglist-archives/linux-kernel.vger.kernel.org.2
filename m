Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B068382A60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhEQK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhEQK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:58:11 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F16C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:56:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f8so4474652qth.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xULAoSsHU2psX2VG0qF90GajX4WbVpZyRpzX3ewwy9E=;
        b=RE26Ae9jS9kLTiE7fYGBWExaibp7ZjVLQmoqXAzNeSdHR9u31zfI7so12UiJl8gaAH
         40gBR3KFMNzle6nO7pR3ICx3pzCKGh9Tt+YB90ArqV0uLgWr752eo/F6QD9fyM5u8wGP
         1yZha3wGJ0wSnSQ5Thjz+UX7x9iLLGjuJcVJkUQxv6OrDaJZx5W0Lu3fFufivyca912j
         +mHcsfmuPOw0zKPMbijsau/CII/axc4Sr4tM3qqNyjTiSFHxAXUu+C00e3kp2h0YmQ5n
         DNN84FmJmWcUc1+73qzPRRPWSqAVxkrHAa4CC6zmDleRydpWWzbQiZicS0irzDgzRgZz
         KmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xULAoSsHU2psX2VG0qF90GajX4WbVpZyRpzX3ewwy9E=;
        b=W3Pu+NA9d8gUCFs8+X0lPuEadGhxQWjfG43VreUO5wvwmqMhddNb2DXRrJYoMJXFP/
         HsyOr1LwpRNdxhr/H4u+oVIbnYOTiu7ruLtp+QcRqyF5AcX+3mPMzKOtu/dOdy5UFUxY
         D84dlqCyYIDAu1SxKvyUkunbwbluyUpP/YfR4ULb9Y8EtTcbSxG09UnuaINS++jFtXQx
         7yyecj6glllopzLJ8x8mUyjtMFVbVGI5NoEHROyzB3TKBHusshcfykR4FWyVWKJhqbN5
         rZBet72LodQaT23e4UAefIUOAjjkKc9Pjew4fSupWvYe40wdp/HA93VPUHFNrXsJvEN4
         GIVg==
X-Gm-Message-State: AOAM533GoleqY28wpJGh5Z84+tgHWC9gRJVrUmUeZ/2rcHsPw6ORGH5Y
        28FNVjHxVHnbXaCdkEgxkH+/V438Pfdc66jUw/8=
X-Google-Smtp-Source: ABdhPJzgGeYq6XyfP59AYy3eG/5/dPH5GFT2NC4BqTz90/7V6DyFbIZDPncGv87Nh+TTBAWk1vA9eDrycYqmOVexodY=
X-Received: by 2002:ac8:47da:: with SMTP id d26mr55254795qtr.292.1621249014870;
 Mon, 17 May 2021 03:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210514213118.630427-1-arnd@kernel.org>
In-Reply-To: <20210514213118.630427-1-arnd@kernel.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 17 May 2021 18:56:44 +0800
Message-ID: <CAA+D8AOAUd3t8TBNtvf8rm_dXgYgL9nZe95wizaoyf5rTfNAcA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fix SND_SOC_IMX_RPMSG dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 5:33 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Kconfig produces a warning with SND_SOC_FSL_RPMSG=y and SND_IMX_SOC=m:
>
> WARNING: unmet direct dependencies detected for SND_SOC_IMX_RPMSG
>   Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m] && RPMSG [=y]
>   Selected by [y]:
>   - SND_SOC_FSL_RPMSG [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMMON_CLK [=y] && RPMSG [=y] && SND_IMX_SOC [=m]!=n
>
> Add a dependency to prevent this configuration.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu
