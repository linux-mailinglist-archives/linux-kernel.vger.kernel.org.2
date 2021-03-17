Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D803933EFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCQLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhCQLyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:54:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9A7164F2A;
        Wed, 17 Mar 2021 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615982083;
        bh=GmQ75fNkKGyxDuMPQluIYApqwkIGssLIIUJlFc8URIY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=klF22XywXZ2p74BuS1cZYk4rx2lVXTSjaF4UPvdf0ZdDLHERXZmE3VUbgDFhgwNJM
         sqr3daV6+ZCq0pp6nayVGecVQ9oP3Ev3KK3EgvOOafkBWl7/JWzDD4CeJ1txqTZLS0
         drGFXYFy72N0i6WHCTgzOCoZJeCv1cXq1QZ+ZM6BgniNoGrnKKx2faHRJact0l2cnd
         hTd90NwD/0LfxJOjBJpIbl2EOCrEO7S3HtcHqaYF0P/Su3shLKEMl/NGVtfCTK565y
         itUMTsETJ2UOqOlTOy0+yC8O0ywXGW/sCznXy+yq7ftMdjS5TcsTP81cdaTOPUyPuj
         q35SZ15wOoKwA==
Subject: Re: [PATCH] omapdrm/dss/dsi.c:modify 'u32'->'int'
To:     ChunyouTang <tangchunyou@163.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tangchunyou@yulong.com, airlied@linux.ie, daniel@ffwll.ch,
        sebastian.reichel@collabora.com, laurent.pinchart@ideasonboard.com
References: <20210317094852.424-1-tangchunyou@163.com>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <93f05e6c-21ad-5b4b-3406-14229ea4feef@kernel.org>
Date:   Wed, 17 Mar 2021 13:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317094852.424-1-tangchunyou@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/03/2021 11:48, ChunyouTang wrote:
> From: tangchunyou <tangchunyou@yulong.com>
> 
> 1.the type of mipi_dsi_create_packet id int
> 2.u32 can not < 0
> 
> Signed-off-by: tangchunyou <tangchunyou@yulong.com>
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 8e11612..11c502d 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2149,7 +2149,7 @@ static int dsi_vc_send_short(struct dsi_data *dsi, int vc,
>   			     const struct mipi_dsi_msg *msg)
>   {
>   	struct mipi_dsi_packet pkt;
> -	u32 r;
> +	int r;
>   
>   	r = mipi_dsi_create_packet(&pkt, msg);
>   	if (r < 0)
> 

I have already applies a similar patch "drm/omap: dsi: fix unsigned 
expression compared with zero".

  Tomi
