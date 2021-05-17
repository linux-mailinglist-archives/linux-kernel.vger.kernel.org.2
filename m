Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8706E383027
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbhEQOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbhEQOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:21:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82AC06123A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:09:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p7so2826124wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIOh8/w3jAFbRZR6B6qvkXxoI0bkEVRhq3CS0yvuHY4=;
        b=cByxw4PfXTDQI44Csx59GLW37uL7zPAYfW2WwPypM7tpQm6I9oUAKqBZ0bsF1Z7S1C
         ffxS/bx/9UFdCCWv19P48ruRS9S5VYwLA3sENlAR0gmuuAoDCm8Zv/64ysR2rwcb+pya
         a9AknJ/qQ0APAbKhC2+XhvtYxBgT4kZewdP+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lIOh8/w3jAFbRZR6B6qvkXxoI0bkEVRhq3CS0yvuHY4=;
        b=SSpRO3NlQgX3+uk5vMikFHwrKCTUCYYo+4WPbFfwG5QaF0R05LSaIyyU0GMEZv4awG
         zggfTV5aQ3eeqBcQe2yoSLJkmFNPAAZ5AeBh7uVHzTiy5P4IuOLWsnt5Iin0EAuiV4JV
         DaQlM+VMeoAzT1oqU5Pi3LQpB7idAqVXvwvKvmBcKcEEAd33LUyw6fzj0SFP8roz45NM
         7TpxPwzsM7qk2gEvLuVnd7hZr+mGUWNTJnEoYCgRyFtf3yhHrjGlxbAEOmc3+PbMPaPX
         gap8cq6HFdwYlKcr0AfW1BatPtHGWFtsKBULZv2IQVl/nvLb7fzimLE7wvgKwDoq2l0a
         mnAA==
X-Gm-Message-State: AOAM530vjUrObysST74AK9KDdVTY+/RhqXhGhN2hcjI3QXkC7eA4AXVj
        uX2MAHOe4VFPedwyLR4Kh1N6fQ==
X-Google-Smtp-Source: ABdhPJxggEzrKat8/WIdxJRJJGOuH2X6KWDEG4qPyhSVEB/a1OOQPSRz4MkApBLnYgDN4YjvvppDyg==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr5997385wrr.310.1621260588142;
        Mon, 17 May 2021 07:09:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t11sm17684321wrz.57.2021.05.17.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:09:47 -0700 (PDT)
Date:   Mon, 17 May 2021 16:09:45 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hao Peng <penghaob@uniontech.com>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm:vkms: Add NULL value after free function In function
 vkms_exit, after kfree(default_config), give specific NULL value to pointer
 default_config to avoid wild pointer.
Message-ID: <YKJ5KU4ZOXvUPM8o@phenom.ffwll.local>
Mail-Followup-To: Hao Peng <penghaob@uniontech.com>,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210512115554.10431-1-penghaob@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512115554.10431-1-penghaob@uniontech.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 07:55:54PM +0800, Hao Peng wrote:
> Signed-off-by: Hao Peng <penghaob@uniontech.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 2173b82606f6..6c63201db5d0 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -227,6 +227,7 @@ static void __exit vkms_exit(void)
>  		vkms_destroy(default_config);
>  
>  	kfree(default_config);
> +	default_config = NULL;

This is the last thing before the module us unloaded, which means no one
can access default_config anymore. So also no point in clearing it.
-Daniel

>  }
>  
>  module_init(vkms_init);
> -- 
> 2.20.1
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
