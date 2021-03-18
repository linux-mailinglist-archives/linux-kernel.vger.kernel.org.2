Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6E3406C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCRNX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCRNXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:23:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4365C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:23:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so5525835wrn.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=CNLbEsygYvTbZT9PzULJxl1QB3RZcsVceKH9loCrMSo=;
        b=KdYIyjKFSDMwf37jeGQYAFBRtDsdKmXi0mEnmAWl95OFaVIQoCzk0gRXIgTrXcVcpA
         pYMRE3JhuiOIrKJogl/SDmvJxFqPa5pCQfbDE9tKYR8+D+a5enhIpk4tyRHpsipnB2wA
         j/4u8iG7y2qFi5tZ8c7IHhlwHKf0L3GXPA1o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CNLbEsygYvTbZT9PzULJxl1QB3RZcsVceKH9loCrMSo=;
        b=lQNN4U22TgxG7bTk64oAPrOfWy3avrG0UPgFqH7t2C9E2ZIXU1x521kySILVzwHwae
         4XEu36Rwh1DjHRiUCfZvVCnPjlqJtp4JQA7tPtx3yKgVb2wurCTdX3LFa9VZmaDJouDK
         oupI1ps+7Y1fyQUr6Z7FnfjXX4ZTX96/Kwm9IqaVBclDwMeUQtjbRA2mLQTlWZ84/FTy
         U5G03wmPk9ZuMNfn0v5o/yqD02VJSoR/wAuhBTrtuxwv0JCQ4m0KOAGLhxvBDluzkkmQ
         XM3Tx24oElRc0Ah9NKEzV1FeEUZxQqpbPUZhmg/S0zJjCYM8iHnoDnziwE5MkracFUCk
         L7XA==
X-Gm-Message-State: AOAM532bKpi293mmK5r/K+M7N/+3i+1CWrxa8cYA9fKYgZqA8qjWOX6g
        xBb8Z8hHJytb38a1iRcvdJiBLA==
X-Google-Smtp-Source: ABdhPJxSKL0C3sE7XtJXFumxv/pxpLWfuUI0p4iswqLbyoLJFVV5FzrdyfhmGdnPQvEPv5SkdtR4+A==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr9606351wrq.116.1616073789483;
        Thu, 18 Mar 2021 06:23:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c9sm2340158wml.42.2021.03.18.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:23:08 -0700 (PDT)
Date:   Thu, 18 Mar 2021 14:23:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] drm: Few typo fixes
Message-ID: <YFNUOhpMaS6d0af5@phenom.ffwll.local>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210318103739.27849-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318103739.27849-1-unixbhaskar@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 04:07:39PM +0530, Bhaskar Chowdhury wrote:
> 
> s/instatiated/instantiated/
> s/unreference/unreferenced/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Queued for 5.13 in drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_property.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index 6ee04803c362..27c824a6eb60 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -43,7 +43,7 @@
>   * property types and ranges.
>   *
>   * Properties don't store the current value directly, but need to be
> - * instatiated by attaching them to a &drm_mode_object with
> + * instantiated by attaching them to a &drm_mode_object with
>   * drm_object_attach_property().
>   *
>   * Property values are only 64bit. To support bigger piles of data (like gamma
> @@ -644,7 +644,7 @@ EXPORT_SYMBOL(drm_property_blob_get);
>   * @id: id of the blob property
>   *
>   * If successful, this takes an additional reference to the blob property.
> - * callers need to make sure to eventually unreference the returned property
> + * callers need to make sure to eventually unreferenced the returned property
>   * again, using drm_property_blob_put().
>   *
>   * Return:
> --
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
