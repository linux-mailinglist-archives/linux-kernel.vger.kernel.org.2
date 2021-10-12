Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4C429BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhJLD0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhJLD0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:26:09 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D79C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:24:08 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id q13so16075916uaq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=05JfAVZ+h7mE5tV9xgtjhMjstYtcv3IxzoXo5DOS8Bc=;
        b=XGM4AalAX1+8HICtDV3dnndPWh3DVI6pEv6JOSiquVEJ1SblB3Wh3SA3h/YwHdvHIw
         TFeHRn7DVGGovIQm7GiSEo3TTWu35UdhamQiNmKjFLeewc2jMEfCNBXcewwbWg3pV/RE
         aZr/IatgS7PASkKmeIKcom7ExlE6sslE3J1fMgCoBWeYfE1k1KOtcLvXJlYdCyYbOgai
         Y3zwAT51islrFirLE3tZfvAVm3kIk07XXO+eyI9isVaswWeHdttF+IyKI5PCSz6pQJgB
         u6MIriWEatRnfAGsuACo/ebRYPdGwQ1MhyjI2KZoOS97VFWWq+Hds8CNDsG6ZQ2R+iKX
         1Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05JfAVZ+h7mE5tV9xgtjhMjstYtcv3IxzoXo5DOS8Bc=;
        b=kdqcei6bPLfjKAoux3XZrTtvtk0ubcg9bmj06yQDkjw0SzFZx2lSvblBnP7DQnvUgm
         dWMMIcewypKOjqZhwsdXb6/IJPXofT7Neug53+JDk08g2053PpScTFSvFrouUEKPPXli
         Qyu2WKflgJ9op3ZCwKGo0Q9ReR3bRVo0ureiI214E8FZAOt4rKLEuDso1Wp4bdRI85sP
         3smiiKMggljx5c2pkThaTxjJ9YIPQwS0tf2FCX+z9QfKMB6gAIRnj/SYXdZ2NsRr9PIV
         1MHcZJ24gqyu+WcOz6tQY0DBLtoriW6Td7s41UMw7tTp709OP+ABhWvWxmpkUDwvHypp
         advw==
X-Gm-Message-State: AOAM532KRF5BjIPE6GYtORtcMyDeBsjzNRAG7/vTTa6Eu/1GvNXAF+5M
        EWYg+hZJ9i4EVakLJ3EbT0iu4uBaqDL58w==
X-Google-Smtp-Source: ABdhPJz6WgBYu+RuHEVXvxf+e7LXJGJEwNqVoWCRKe+0ncKGBgDXKyCoe2oWAuKnrdznsGHQS8IaDw==
X-Received: by 2002:a67:d48a:: with SMTP id g10mr27580438vsj.3.1634009047974;
        Mon, 11 Oct 2021 20:24:07 -0700 (PDT)
Received: from fedora ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id p8sm4317509vke.11.2021.10.11.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:24:06 -0700 (PDT)
Date:   Tue, 12 Oct 2021 00:24:02 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rockchip: rkisp1: use device name for debugfs
 subdir name
Message-ID: <YWT/0gx1ByXQ7JyY@fedora>
References: <20211010175457.438627-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010175457.438627-1-mike.rudenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 08:54:57PM +0300, Mikhail Rudenko wrote:
> While testing Rockchip RK3399 with both ISPs enabled, a dmesg error
> was observed:
> ```
> [   15.559141] debugfs: Directory 'rkisp1' with parent '/' already present!
> ```
> 
> Fix it by using the device name for the debugfs subdirectory name
> instead of the driver name, thus preventing name collision.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 7474150b94ed..560f928c3752 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -426,7 +426,7 @@ static void rkisp1_debug_init(struct rkisp1_device *rkisp1)
>  {
>  	struct rkisp1_debug *debug = &rkisp1->debug;
>  
> -	debug->debugfs_dir = debugfs_create_dir(RKISP1_DRIVER_NAME, NULL);
> +	debug->debugfs_dir = debugfs_create_dir(dev_name(rkisp1->dev), NULL);
>  	debugfs_create_ulong("data_loss", 0444, debug->debugfs_dir,
>  			     &debug->data_loss);
>  	debugfs_create_ulong("outform_size_err", 0444,  debug->debugfs_dir,
> -- 
> 2.33.0
> 
