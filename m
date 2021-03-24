Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD15934844B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhCXWAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbhCXWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:00:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE58C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:00:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so82113wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3StMOwc0jJRs3gCodn1X+cgKnhL/pkdpaA+0ab7e1tM=;
        b=SOF65gx4e2PFWffP9jHgPOyi9O2EFiDlVH+BiWAWi2DtafM+8kEcjw4w0wPjv315yE
         eExNg6thcBR691XfqwMxcXpm7EsZiMA0SacoU1msAhvpCUUazu5z7IocvCBDNIbZQto1
         E9GWCOSwczpuSVlMIY/LPCnqZzt0jMcdvweJBinHp8tCeU7MXyc77b7MnjKLdahuito6
         zM3szUGXjq6UN+QZZhQwPjqnVdaJliMxXUFRijLzI3PWK3KAlEn86Qjr8W3BMFokPrMj
         fGfp38/GJlHlqnKKPA3d2Y7oK9RxjKHMMChSihJbnVSV7Ncw4ZZ4kJW7cTR9OMMKW1dR
         pnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3StMOwc0jJRs3gCodn1X+cgKnhL/pkdpaA+0ab7e1tM=;
        b=s6BJ6GtvfJ1xUhrgLqVdku2WTtJVmfXxgfYIy310LxiiKBPQImK0i+tZD7Xekpl1wu
         7U6KNNZFKmzmkKrRaV8XTkuKs9uU9G/8lS+/w6sktLdlIqYOHCPJWH9ZXVOCHcNDh2v4
         e54xqSBmvhq5mWtxG+U6yG32VPTNrlsdNLG8LX0ASmO9ZILTCvzWw5jmoXTnrj1UHSVh
         ekNujQKJKCzU1ox3VXRyBnWl8FUeZa+E4fca0f8D+DbBlHoL1pywUatA5ww5LYthgJn3
         b1HOjz5tgA68rsSKybwWSDIyqmv4fJvzYSSG2U3rtGgg9KbNxXeHf4YBMzl5rs1OAdTk
         3m6Q==
X-Gm-Message-State: AOAM531eQVkZoPRgtct6spULUU45TqQ+iyUCnLQtluki1M/sno2OBlhf
        +JZO+PgMAC3M6gg6q4v1IX4=
X-Google-Smtp-Source: ABdhPJwUmmIf8dqawk0il4BbMj532OMCkepT+IGFZqNoY5CGbH60hAceO/Q49Khdn5D0063YoEC9IQ==
X-Received: by 2002:a7b:cbc4:: with SMTP id n4mr5021146wmi.153.1616623215161;
        Wed, 24 Mar 2021 15:00:15 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id v18sm4965760wru.85.2021.03.24.15.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 15:00:14 -0700 (PDT)
Date:   Wed, 24 Mar 2021 19:00:08 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com,
        syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: fix misuse of WARN_ON
Message-ID: <20210324220008.nqwwwfugyfngbn3x@smtp.gmail.com>
References: <20210320132840.1315853-1-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320132840.1315853-1-dvyukov@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, Dmitry Vyukov wrote:
> vkms_vblank_simulate() uses WARN_ON for timing-dependent condition
> (timer overrun). This is a mis-use of WARN_ON, WARN_ON must be used
> to denote kernel bugs. Use pr_warn() instead.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Melissa Wen <melissa.srw@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Change-Id: I7f01c288092bc7e472ec63af198f93ce3d8c49f7
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 0443b7deeaef6..758d8a98d96b3 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -18,7 +18,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
>  
>  	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
>  					  output->period_ns);
> -	WARN_ON(ret_overrun != 1);
> +	if (ret_overrun != 1)
> +		pr_warn("%s: vblank timer overrun\n", __func__);

Hi Dmitry,

Thanks for your patch.

Looks good to me.
The Change-Id tag just seems a little noisy to me, but can be
fixed while applying.

Acked-by: Melissa Wen <melissa.srw@gmail.com>

>  
>  	spin_lock(&output->lock);
>  	ret = drm_crtc_handle_vblank(crtc);
> 
> base-commit: e94c55b8e0a0bbe9a026250cf31e2fa45957d776
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
