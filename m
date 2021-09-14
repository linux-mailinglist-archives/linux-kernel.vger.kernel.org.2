Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87440B695
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhINSPi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Sep 2021 14:15:38 -0400
Received: from aposti.net ([89.234.176.197]:53232 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhINSPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:15:36 -0400
Date:   Tue, 14 Sep 2021 19:14:09 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] DRM/Panel : abt-y030xx067a yellow tint fix
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <LZRFZQ.68IYZZZISOEV3@crapouillou.net>
In-Reply-To: <20210914092716.2370039-1-cbranchereau@gmail.com>
References: <20210914092716.2370039-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Le mar., sept. 14 2021 at 11:27:16 +0200, Christophe Branchereau 
<cbranchereau@gmail.com> a écrit :
> The previous parameters caused an unbalanced yellow tint.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/gpu/drm/panel/panel-abt-y030xx067a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c 
> b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> index 2d8794d495d0..3d8a9ab47cae 100644
> --- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> +++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> @@ -146,8 +146,8 @@ static const struct reg_sequence 
> y030xx067a_init_sequence[] = {
>  	{ 0x09, REG09_SUB_BRIGHT_R(0x20) },
>  	{ 0x0a, REG0A_SUB_BRIGHT_B(0x20) },
>  	{ 0x0b, REG0B_HD_FREERUN | REG0B_VD_FREERUN },
> -	{ 0x0c, REG0C_CONTRAST_R(0x10) },
> -	{ 0x0d, REG0D_CONTRAST_G(0x10) },
> +	{ 0x0c, REG0C_CONTRAST_R(0x00) },
> +	{ 0x0d, REG0D_CONTRAST_G(0x00) },
>  	{ 0x0e, REG0E_CONTRAST_B(0x10) },
>  	{ 0x0f, 0 },
>  	{ 0x10, REG10_BRIGHT(0x7f) },
> --
> 2.33.0
> 


