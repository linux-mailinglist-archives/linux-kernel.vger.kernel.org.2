Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595043BEC7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhGGQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhGGQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:45:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A8FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 09:43:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so4763665wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1jcO0yI6pPJfzDKfj/96aZNPkzpA0/0vrFttiKfOXA=;
        b=HDl8nggq4jDLWfJVaXoLXI/XGpjg42wmsm+lscbHy6pywD9OsuSlUU2o4MTcvDEcpx
         cbErC3do9h7aOzQGK34uVcpgujTryhxd2V7ir+rKQOIMJO0b3+QhwRtK48bXTSQauWYy
         Dx+TwiTMO1mP8nLA+VAWcnBW+5NqGxa7pyMduyqIObWXu+3a4+E9chHaIUZ62Bm7Xk43
         HlxKyjExZmvO/D6kSbAP0Mm/ueEBmxBh1U5UpJ3ozdnH04G6hXBtCAvnrLlDOZNZQXeP
         DEgg/9ZkBMuvVESagNWQWbBzaTYvz0W28MntvUDeAertPvsyeTjRJxnNM4W12tG4IhVm
         KuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1jcO0yI6pPJfzDKfj/96aZNPkzpA0/0vrFttiKfOXA=;
        b=GOTWh4E0DtF7I5VdcDpVz7N/yk6ygwsg617Mgnp05AKBjxzAbETMyTAiA1jfq3bWV9
         8AVvTyhUW/EPeDgXhaE4gpIUPRnX4ii2uyma8lflcfcK8+loA0uSpikJlGj/0Nwj1npn
         w+IU22kZ6TjXtx18hKlBsaEn14/bPe+KH+ZwJufgZjqaeOZ1o74hokF2AbVHAI6DEAYW
         PIyTDc+nnEU+rFMjStrRCNIjx0MYkAbUqm9XmzsCNsJZiXdKPDYHXNBSHyfVRlozpbF0
         QoNE84PSvAk4GqUovnnvbvCEcvRPn0l2HzoznAAYmQ9vCAigfNkRQTZ9X6LKtuci82xu
         SAPA==
X-Gm-Message-State: AOAM531SNSE5rTCt005kZK1AfB1N6J+eQA9Rm+FH4w+s22prFZXXC1BE
        sHu5rx9NJXCCClKK+xSm/X8=
X-Google-Smtp-Source: ABdhPJzFJteyECZADdOlPal4VNNMEErlmEmuOKU6GXF0Wkq5u+/+j2Nfx+9GJyf1xeL60s+aZhTUVg==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr556224wmb.156.1625676195123;
        Wed, 07 Jul 2021 09:43:15 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id d8sm652693wra.41.2021.07.07.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 09:43:14 -0700 (PDT)
Date:   Wed, 7 Jul 2021 17:43:05 +0100
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: Create vkms_config_debufs in vkms_drv.c
Message-ID: <20210707164244.ktmizbd6gbuifu73@smtp.gmail.com>
References: <20210707092927.336244-1-martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707092927.336244-1-martinsdecarvalhobeatriz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07, Beatriz Martins de Carvalho wrote:
> Development vkms_config_debufs in vkms_drv.c for the long term plan of
> making vkms configurable and have multiple different instances it's
> useful to be able to get at the config of each instance in debugfs
Hi Beatriz,

Thanks for your patch.

Changes lgtm.

However commit message needs small improvements. Besides typo, it would
be good to make the subject clearer in terms of its purpose (creating
a debugfs file to get/track vkms config data).

Please, address these minor things and add my r-b.
Reviewed-by: Melissa Wen <melissa.srw@gmail.com>

> 
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 027ffe759440..c81fba6c72f0 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -28,6 +28,9 @@
>  
>  #include "vkms_drv.h"
>  
> +#include <drm/drm_print.h>
> +#include <drm/drm_debugfs.h>
> +
>  #define DRIVER_NAME	"vkms"
>  #define DRIVER_DESC	"Virtual Kernel Mode Setting"
>  #define DRIVER_DATE	"20180514"
> @@ -86,12 +89,37 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
>  	drm_atomic_helper_cleanup_planes(dev, old_state);
>  }
>  
> +static int vkms_config_show(struct seq_file *m, void *data)
> +{
> +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> +	struct drm_device *dev = node->minor->dev;
> +	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> +
> +	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
> +	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
> +	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
> +
> +	return 0;
> +}
> +
> +static const struct drm_info_list vkms_config_debugfs_list[] = {
> +	{ "vkms_config", vkms_config_show, 0 },
> +};
> +
> +static void vkms_config_debugfs_init(struct drm_minor *minor)
> +{
> +	drm_debugfs_create_files(vkms_config_debugfs_list, ARRAY_SIZE(vkms_config_debugfs_list),
> +				 minor->debugfs_root, minor);
> +}
> +
>  static const struct drm_driver vkms_driver = {
>  	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
>  	.release		= vkms_release,
>  	.fops			= &vkms_driver_fops,
>  	DRM_GEM_SHMEM_DRIVER_OPS,
>  
> +	.debugfs_init           = vkms_config_debugfs_init,
> +
>  	.name			= DRIVER_NAME,
>  	.desc			= DRIVER_DESC,
>  	.date			= DRIVER_DATE,
> -- 
> 2.25.1
> 
