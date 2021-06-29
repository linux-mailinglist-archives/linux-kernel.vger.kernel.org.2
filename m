Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25E3B763C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhF2QKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhF2QGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:06:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389EC061787
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:03:48 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o6so12204963oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22YCX1gTuHxij8jBkd6zakC86sS35hKmpf8kUxvjUtA=;
        b=uNeO5HQ/ALYrv8nofxfYkzdeDAGS1Xx9YbfqiTXo82HWDllL+J+AvuQpCzIVUM8K+a
         SKl340JpBbSYnEzjVYXgxousi3t27+S5sloXkIBnbywCuwwUDmadKGIVmFozaPq1S2zo
         /CQnqX/w48kCBJ4oUo15C37Nx1sSYhDwWr1YcAf0lKMLGuOwwsleJ0t15S65WSS570QZ
         AtgV6/DxttbW5g7DSxr/F8Mbu7uylHJ9wV0w5LtaeAHRU32gQRnHzz3uB52Ux6cXBsnq
         RJrfqVVqO5cRx1P2B0dT28h6QzLckbINiLl1dsuoPFfYrYS+Fm8vGnvJ3exh8T6U2qc5
         ZUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22YCX1gTuHxij8jBkd6zakC86sS35hKmpf8kUxvjUtA=;
        b=nqI9odEVueOc93PmzO7Tp2a0mXYYgV+M+yG4Ge+kqau4fOgZb4C2ZRTmicawhb64uw
         yyKql1NHKAuXrPBpQ7biKJeXQmQPPX/6JeKMjv/1d6hY5KgTfc9vvElzjGlAttBqkN7m
         6p62o3ielJmEhupDasNMOGnwm9jihA2+L0s+Cnu35oKmFXmxjDidAXUaZrSblNGf6HPZ
         NuusSOZOgfPWU8JTJ3S8BYOvLohWaynzHEjE+S9t0RjKYJL5rFUaOTqtPE2zXu/gQf05
         Gqek3UEjCT+oDYoDAtnXL+AsUMWsIxP4d0mqkIi/s2npRRaZosdK1sop0uBQzXMVg4k0
         XrrA==
X-Gm-Message-State: AOAM533AjcErIB0MDQwEoqpJ9f9o+NCfxgTWIjv00A6vxEIO9/zvlCAj
        RdfzDU8PtPNZFlyb7CI+S4c0cg==
X-Google-Smtp-Source: ABdhPJx4ReJpcx5aMpggn8YB+452U+YvCzJu2XF3zGPSA+kp4p1LMkT+7egjWO81/LUgvGGbBcRaNQ==
X-Received: by 2002:aca:3285:: with SMTP id y127mr22031113oiy.115.1624982628172;
        Tue, 29 Jun 2021 09:03:48 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y18sm3941779oiv.46.2021.06.29.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:03:47 -0700 (PDT)
Date:   Tue, 29 Jun 2021 11:03:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        mathieu.poirier@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        mark-pk.tsai@mediatek.com, weiting.tsai@mediatek.com
Subject: Re: [PATCH] remoteproc: export rproc re/unregister to virtio device
 APIs
Message-ID: <YNtEYUuW/OKSQlfp@yoga>
References: <20210629150002.8050-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629150002.8050-1-phil.chang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Jun 10:00 CDT 2021, Phil Chang wrote:

> In some case, the remote processor already boot up on previous state,
> but still need register to virtio device, so that exported those APIs.
> 
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> Signed-off-by: YJ chiang <yj.chiang@mediatek.com>
> ---
> Hi
> 
> In our case, the remote processor is already boot up in u-boot,
> we don't want to boot again or load fw in driver but register to virtio
> device for rpmsg. so that needs those API exported.
> Furthermore, the rproc_vq_interrupt is exported, so those functions
> should be exported also.
> 

Would the recently introduces support in remoteproc for "attaching" to
an already running remote processor be useful to you?


If you don't need a remoteproc driver, but rather just want e.g. a
platform_driver that spawns the appropriate virtio devices, wouldn't
virtio_mmio work?

Regards,
Bjorn

> thanks
> 
>  drivers/remoteproc/remoteproc_virtio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 0cc617f76068..e23658a76f5e 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -425,6 +425,7 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  out:
>  	return ret;
>  }
> +EXPORT_SYMBOL(rproc_add_virtio_dev);
>  
>  /**
>   * rproc_remove_virtio_dev() - remove an rproc-induced virtio device
> @@ -440,3 +441,4 @@ int rproc_remove_virtio_dev(struct device *dev, void *data)
>  	unregister_virtio_device(vdev);
>  	return 0;
>  }
> +EXPORT_SYMBOL(rproc_remove_virtio_dev);
> -- 
> 2.18.0
> 
