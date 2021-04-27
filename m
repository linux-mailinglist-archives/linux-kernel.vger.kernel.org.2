Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C636BFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhD0HSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhD0HSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:18:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEFBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:17:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x5so8039589wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjUUBU9azeBmUqt9FTCUe9KTsCd2j5HTfrKosK0Jdz0=;
        b=HtKdCYFol3rZCVP2abKMy3nqiGNGdsAP5aGu9V1tC5EnY47xuuHfx0BLug1/VduIwD
         MXanYhAoe9wrJltR1MgT/B5FHcMm0NpNsUd9o0gd2zCKXT5uswGF6M+rhxkHGRzRo1CL
         WmI5KbXJJLFzyL+jWrxMtB5WoY1sK66z2qJWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rjUUBU9azeBmUqt9FTCUe9KTsCd2j5HTfrKosK0Jdz0=;
        b=oF1rxzisruqtFHYABtPqkmaB86gOrq18SouxiuBI4qAFvm2spzUuBd3WRfvjiY51Rp
         48rbstSMzrCCvpJIhBja0DeYX2v57LQDHSnUNTd8izv9cPIoDiMa4JZS0oOWzQ/0H59w
         4Wy1V4xCqpnt0y7WDlTar86d7hThcRh+bmWAe7/S3+gBXfdrL9HvDXAHfWzyO/jCcoLK
         +EvKSjAxRWyMnfd5+LD9T8DVXGIGlGIGTU2BIUeFUPpl+qLW383SKZpS2/2uns7kKYkB
         arsdBSxfOVOtlQuZtnU7IuACtZYdGRIOHU187GyjmxVdlhTIsbPoqA1+e1ImB/qMgzoM
         eDLA==
X-Gm-Message-State: AOAM532/zRWlhJh8ZK1zTmTIckSPak60Sy0/ZtKwE/8R7b+g9aQCF95s
        zMZLhD2nB6drgxToKaTn0e/iRMUMlocBBg==
X-Google-Smtp-Source: ABdhPJzso7RpwB2noNmPVEKp40bdQGe73zAhgpDLAPSQupdzs/xRL24B+abq43DxRfXT6KAxkx4VKg==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr4027635wrw.355.1619507878532;
        Tue, 27 Apr 2021 00:17:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t2sm1608394wmg.38.2021.04.27.00.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 00:17:58 -0700 (PDT)
Date:   Tue, 27 Apr 2021 09:17:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joseph Kogut <joseph.kogut@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: remove usage of drm_pci_alloc/free
Message-ID: <YIe6pKUULMutAkG3@phenom.ffwll.local>
Mail-Followup-To: Joseph Kogut <joseph.kogut@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
References: <20210423020248.3427369-1-joseph.kogut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423020248.3427369-1-joseph.kogut@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:02:43PM -0700, Joseph Kogut wrote:
> Remove usage of legacy dma-api abstraction in preparation for removal
> 
> Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
> ---
> Checkpatch warns here that r128 is marked obsolete, and asks for no
> unnecessary modifications.
> 
> This series aims to address the FIXME in drivers/gpu/drm/drm_pci.c
> explaining that drm_pci_alloc/free is a needless abstraction of the
> dma-api, and it should be removed. Unfortunately, doing this requires
> removing the usage from an obsolete driver as well.
> 
> If this patch is rejected for modifying an obsolete driver, would it be
> appropriate to follow up removing the FIXME from drm_pci?

Feels like a good enough reason, both patches queued up in drm-misc-next
for 5.14. Thanks a lot for doing them.
-Daniel

> 
>  drivers/gpu/drm/drm_bufs.c         | 19 ++++++++++++++++---
>  drivers/gpu/drm/drm_dma.c          |  8 +++++++-
>  drivers/gpu/drm/r128/ati_pcigart.c | 22 ++++++++++++++++++----
>  3 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index e3d77dfefb0a..94bc1f6049c9 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -674,12 +674,17 @@ int drm_legacy_rmmap_ioctl(struct drm_device *dev, void *data,
>  static void drm_cleanup_buf_error(struct drm_device *dev,
>  				  struct drm_buf_entry *entry)
>  {
> +	drm_dma_handle_t *dmah;
>  	int i;
>  
>  	if (entry->seg_count) {
>  		for (i = 0; i < entry->seg_count; i++) {
>  			if (entry->seglist[i]) {
> -				drm_pci_free(dev, entry->seglist[i]);
> +				dmah = entry->seglist[i];
> +				dma_free_coherent(dev->dev,
> +						  dmah->size,
> +						  dmah->vaddr,
> +						  dmah->busaddr);
>  			}
>  		}
>  		kfree(entry->seglist);
> @@ -978,10 +983,18 @@ int drm_legacy_addbufs_pci(struct drm_device *dev,
>  	page_count = 0;
>  
>  	while (entry->buf_count < count) {
> +		dmah = kmalloc(sizeof(drm_dma_handle_t), GFP_KERNEL);
> +		if (!dmah)
> +			return -ENOMEM;
>  
> -		dmah = drm_pci_alloc(dev, PAGE_SIZE << page_order, 0x1000);
> +		dmah->size = total;
> +		dmah->vaddr = dma_alloc_coherent(dev->dev,
> +						 dmah->size,
> +						 &dmah->busaddr,
> +						 GFP_KERNEL);
> +		if (!dmah->vaddr) {
> +			kfree(dmah);
>  
> -		if (!dmah) {
>  			/* Set count correctly so we free the proper amount. */
>  			entry->buf_count = count;
>  			entry->seg_count = count;
> diff --git a/drivers/gpu/drm/drm_dma.c b/drivers/gpu/drm/drm_dma.c
> index d07ba54ec945..eb6b741a6f99 100644
> --- a/drivers/gpu/drm/drm_dma.c
> +++ b/drivers/gpu/drm/drm_dma.c
> @@ -81,6 +81,7 @@ int drm_legacy_dma_setup(struct drm_device *dev)
>  void drm_legacy_dma_takedown(struct drm_device *dev)
>  {
>  	struct drm_device_dma *dma = dev->dma;
> +	drm_dma_handle_t *dmah;
>  	int i, j;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA) ||
> @@ -100,7 +101,12 @@ void drm_legacy_dma_takedown(struct drm_device *dev)
>  				  dma->bufs[i].seg_count);
>  			for (j = 0; j < dma->bufs[i].seg_count; j++) {
>  				if (dma->bufs[i].seglist[j]) {
> -					drm_pci_free(dev, dma->bufs[i].seglist[j]);
> +					dmah = dma->bufs[i].seglist[j];
> +					dma_free_coherent(dev->dev,
> +							  dmah->size,
> +							  dmah->vaddr,
> +							  dmah->busaddr);
> +					kfree(dmah);
>  				}
>  			}
>  			kfree(dma->bufs[i].seglist);
> diff --git a/drivers/gpu/drm/r128/ati_pcigart.c b/drivers/gpu/drm/r128/ati_pcigart.c
> index 1234ec60c0af..fbb0cfd79758 100644
> --- a/drivers/gpu/drm/r128/ati_pcigart.c
> +++ b/drivers/gpu/drm/r128/ati_pcigart.c
> @@ -45,18 +45,32 @@
>  static int drm_ati_alloc_pcigart_table(struct drm_device *dev,
>  				       struct drm_ati_pcigart_info *gart_info)
>  {
> -	gart_info->table_handle = drm_pci_alloc(dev, gart_info->table_size,
> -						PAGE_SIZE);
> -	if (gart_info->table_handle == NULL)
> +	drm_dma_handle_t *dmah = kmalloc(sizeof(drm_dma_handle_t), GFP_KERNEL);
> +
> +	if (!dmah)
> +		return -ENOMEM;
> +
> +	dmah->size = gart_info->table_size;
> +	dmah->vaddr = dma_alloc_coherent(dev->dev,
> +					 dmah->size,
> +					 &dmah->busaddr,
> +					 GFP_KERNEL);
> +
> +	if (!dmah->vaddr) {
> +		kfree(dmah);
>  		return -ENOMEM;
> +	}
>  
> +	gart_info->table_handle = dmah;
>  	return 0;
>  }
>  
>  static void drm_ati_free_pcigart_table(struct drm_device *dev,
>  				       struct drm_ati_pcigart_info *gart_info)
>  {
> -	drm_pci_free(dev, gart_info->table_handle);
> +	drm_dma_handle_t *dmah = gart_info->table_handle;
> +
> +	dma_free_coherent(dev->dev, dmah->size, dmah->vaddr, dmah->busaddr);
>  	gart_info->table_handle = NULL;
>  }
>  
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
