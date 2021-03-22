Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB9344667
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCVOAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCVN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:59:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E325C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:59:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v4so16963990wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKdbo+Uu7/ENUhR68YhWcl8X+eXVBT0c9mOmmwkHCnM=;
        b=Gj1KfSTiuddoeJH/lBxsJ9EQ+hE8vdALwwP0jUHXIqZijfU4GRCWVEKf5dBdMI35bm
         nivCJhhOxw/eaDu8UI+2szAEnV7uUla9f8wOW74JT7ZqK3cuLcRPwfvklX+AKZp++XAp
         wPnWch7Uk2Ve+Gfh9gfzGt7MSCaex2xttVyss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aKdbo+Uu7/ENUhR68YhWcl8X+eXVBT0c9mOmmwkHCnM=;
        b=KifPRtpLcWHAQeajBxZmU/H0d4KNeo+aocVlwG15hvR0jZB8r51lPxmQCeIM7bAQzG
         GYh7frTN/aVtppBLYM0V0DXTw5wuag3bobrb3PsCLwSXcSTeBTvYULRtWMQqpaLHOVvY
         fcKoAoHEFhWsC+vH1+lrLq9dsKQAALuXI0U55REqTWymJMRAmpkWBFLNnAu5XQjvkRYQ
         7axdb1hIti3krWCBQdsmyzqXJP0c1kZRtUKnDCu6+AJJSAfSZPH31/PAFfa38nJzhNn6
         4tFvoNH2yfVMhcldldaQEJtIXlx3rdNCaKlma+h1SLnYP9zPtzyj0RA0IrQOqbU/2rHk
         BRvQ==
X-Gm-Message-State: AOAM532fd1WJSohwSeuq5glS3yo/RRgwYgWQdyhJaHvYFvEirq4YmWF3
        r6KEZtUj5pueOMzhEXsfkAApHA==
X-Google-Smtp-Source: ABdhPJxBJbd4aMVAfgIyjvZ1Cg0G2JhoHy5EF4aIr3EEDV5lFFXSjfEDIl29cpNrk8EoT35qvP8akw==
X-Received: by 2002:adf:e441:: with SMTP id t1mr18441558wrm.21.1616421566393;
        Mon, 22 Mar 2021 06:59:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v13sm22720694wrt.45.2021.03.22.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:59:25 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:59:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Yue Zou <zouyue3@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vgaarb: avoid -Wempty-body warnings
Message-ID: <YFiivD6B5SZLZl7Z@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Yue Zou <zouyue3@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20210322105307.1291840-1-arnd@kernel.org>
 <20210322105307.1291840-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322105307.1291840-2-arnd@kernel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:53:00AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 shows a few warnings for an empty macro:
> 
> drivers/gpu/drm/qxl/qxl_drv.c: In function 'qxl_pci_probe':
> drivers/gpu/drm/qxl/qxl_drv.c:131:50: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   131 |                 vga_put(pdev, VGA_RSRC_LEGACY_IO);
>       |                                                  ^
> drivers/gpu/drm/qxl/qxl_drv.c: In function 'qxl_pci_remove':
> drivers/gpu/drm/qxl/qxl_drv.c:159:50: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   159 |                 vga_put(pdev, VGA_RSRC_LEGACY_IO);
> 
> Change this to an inline function to make it more robust and avoid
> the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Both applied to drm-misc-next for 5.13, thanks for your patches.
-Daniel

> ---
>  include/linux/vgaarb.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index fc6dfeba04a5..dc6ddce92066 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -112,7 +112,9 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
>  #if defined(CONFIG_VGA_ARB)
>  extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
>  #else
> -#define vga_put(pdev, rsrc)
> +static inline void vga_put(struct pci_dev *pdev, unsigned int rsrc)
> +{
> +}
>  #endif
>  
>  
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
