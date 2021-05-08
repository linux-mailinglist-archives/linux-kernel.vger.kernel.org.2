Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87837377070
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhEHHf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 03:35:59 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51644 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHHf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 03:35:57 -0400
Received: from pmoreau.org (unknown [88.129.173.226])
        (Authenticated sender: pierre.morrow@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 605A1B0053E;
        Sat,  8 May 2021 09:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1620459265;
        bh=CoRmAemj/IAoMOFqzKxhniIqN+11bAiqsffykCtDA5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8AoDu73pLmKkDzdHapqCOTc9l2GpsNhhWg7LvSeQwEiaEfCKTiLc2DS2OvA/dUCs
         KHvWNs8pUEEB/fz1cz9YU8M96mF8JBvMe4mK4ZGcNZOCD7DfqUl1+LfRseYfPagMPB
         7IdmCnLyWLcJG6rbIhe+YSkU2onMgCudJhxn53BMgWTdXwm/JSN1lILpGM4Qlw4rAe
         iwxHaF6cSca/IwOUfyPxH+P27I4BD19siDm9zhrh/BEw0ifQcYIh/6BjggPWy7HLbx
         7TL4cvMESw4zd61rVDqO087ybwoFjoFLMjf5XD+95VS4Cn9pMlkWxRn7TZbA7rxLYf
         sWi+JvOGdN2JA==
Date:   Sat, 8 May 2021 09:34:00 +0200
From:   Pierre Moreau <pierre.morrow@free.fr>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] drm/nouveau: fix error return code in
 nouveau_backlight_init()
Message-ID: <20210508073400.nnmwwyoxqqiwv36w@pmoreau.org>
Mail-Followup-To: Zhen Lei <thunder.leizhen@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508034810.2374-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210508034810.2374-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zhen,

There was a similar patch sent in last month, though which does not seem to
have been merged yet; see
https://lists.freedesktop.org/archives/nouveau/2021-April/038451.html.

Whether `ret` should be `-ENOSPC` or `-ENOMEM` is hard to say as
`nouveau_get_backlight_name()` could fail due to either.

I will propose an alternative fix which modifies `nouveau_get_backlight_name()`
to return an int so the actual error code can be propagated back instead of
guessed, as well as fix an ida ID leak which I just spotted.

Best,
Pierre

On 2021-05-08 — 11:48, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Fixes: db1a0ae21461 ("drm/nouveau/bl: Assign different names to interfaces")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index 72f35a2babcb..097ca344a086 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -273,6 +273,7 @@ nouveau_backlight_init(struct drm_connector *connector)
>  		return -ENOMEM;
>  
>  	if (!nouveau_get_backlight_name(backlight_name, bl)) {
> +		ret = -ENOSPC;
>  		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
>  		goto fail_alloc;
>  	}
> -- 
> 2.25.1
> 
> 
