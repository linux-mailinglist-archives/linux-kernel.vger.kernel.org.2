Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C193C2074
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhGIIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhGIIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:09:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C79C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 01:07:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so1038431wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rwDUqJDLNIVBQpGIKksCGIR0p460wa02dXr2uK97Uqk=;
        b=BARaNw++soLYV+k5DXbBNW7bXHlJBeJURfkGl/IC/RpnDmdwoayLOj0SiIYeiy/e3y
         6MbPvVDOxlQp21XaZQ65WqduZwu1avfXXvyO+FSEw7HYifygfTeHylVLXC9Z5+yRuHq9
         wU1GOG48OgyejhEIfn4r/IIOf7DbsXui8D3fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rwDUqJDLNIVBQpGIKksCGIR0p460wa02dXr2uK97Uqk=;
        b=HEade5epSgjfysCNGlI0SbAJArII7rJas2NrJ0oovXCbaXP2Ep1X/3uMoKRKS5ruMD
         hhddQiui2gyeg9QKZVamsaIpekCT/tfkkfopQE2BjJDAZ20umMVMeoflrZgOM+z+/Kd8
         tG3jMZHTmBW906f5TkFFxSxMS2RBKbKR0ddLrG6cWrfTOHUBYKG8wLNqUOF2uFAjDwkl
         /1Nw5dBeOvnbTKc7BwHZcuP2gBCsBEQM4xA3vWeH5x0QBiVDnEKAyY5WE06mvmhyzmGW
         F+2xOx13QVROtNKWT8g3ikjTg+E2HnyuLaQjyCNdCWUfR2nHQ9lY8IZIj99IXSJYYk6l
         4SLg==
X-Gm-Message-State: AOAM531cPa/jGJ4qPNx3cg8Fy8jcqyK3VYqWU3HumXe3blh72tIgPqNo
        OBeL5F1dKwYtOYuzm9kiB1d8Jg==
X-Google-Smtp-Source: ABdhPJzl3oNBQtHbVIKWoBzYJt7iZ9nBuhE//4CcOHYu9qovTilEv9yHlUHnR8rt4o89nyDHC11nxg==
X-Received: by 2002:a05:6000:180f:: with SMTP id m15mr39878099wrh.388.1625818023327;
        Fri, 09 Jul 2021 01:07:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h21sm4054327wmq.38.2021.07.09.01.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 01:07:02 -0700 (PDT)
Date:   Fri, 9 Jul 2021 10:07:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Harshvardhan Jha <harshvardhan.jha@oracle.com>
Cc:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] drm/gma500: Fix end of loop tests for list_for_each_entry
Message-ID: <YOgDpQKxRfNxqhLm@phenom.ffwll.local>
Mail-Followup-To: Harshvardhan Jha <harshvardhan.jha@oracle.com>,
        patrik.r.jakobsson@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
References: <20210709073959.11443-1-harshvardhan.jha@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709073959.11443-1-harshvardhan.jha@oracle.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 01:09:59PM +0530, Harshvardhan Jha wrote:
> The list_for_each_entry() iterator, "connector" in this code, can never be
> NULL.  If we exit the loop without finding the correct  connector then
> "connector" points invalid memory that is an offset from the list head.
> This will eventually lead to memory corruption and presumably a kernel
> crash.
> 
> Fixes: 9bd81acdb648 ("gma500: Convert Oaktrail to work with new output handling")
> Signed-off-by: Harshvardhan Jha <harshvardhan.jha@oracle.com>
>  ---

The space here before the --- tripped the tooling, but I caught it :-)

Thanks for the patch, applied to drm-misc-next for 5.15.
-Daniel

> From static analysis.  Not tested.
> ---
>  drivers/gpu/drm/gma500/oaktrail_lvds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
> index 432bdcc57ac9..a1332878857b 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
> @@ -117,7 +117,7 @@ static void oaktrail_lvds_mode_set(struct drm_encoder *encoder,
>  			continue;
>  	}
>  
> -	if (!connector) {
> +	if (list_entry_is_head(connector, &mode_config->connector_list, head)) {
>  		DRM_ERROR("Couldn't find connector when setting mode");
>  		gma_power_end(dev);
>  		return;
> -- 
> 2.32.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
