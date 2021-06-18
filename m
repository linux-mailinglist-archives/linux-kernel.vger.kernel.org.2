Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706683ACB1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhFRMkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhFRMka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624019898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BPRFSs4ZDIzsU3WeQFolZqPnT6BylD3v05yUAKiC4I=;
        b=AhGKUxu0ffCzsgG696WX6ysaRLgQLrcEvATcClIZeJux4zPSEWmvIJpjaas+dGZjyV7CKl
        bic6oY7Q0fGtFR8dn06zUzvt9dJZMlUEuOwrWbIzYgemy5+AUvjxTfEjo+6ULZaI28MGDq
        5MyFIoBtbBnLPlNnpQMwLMAn2BDZjC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-Y2ewPfiHM1OWVkaMw7UpRw-1; Fri, 18 Jun 2021 08:38:17 -0400
X-MC-Unique: Y2ewPfiHM1OWVkaMw7UpRw-1
Received: by mail-wr1-f71.google.com with SMTP id f9-20020a5d64c90000b029011a3c2a0337so4347648wri.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8BPRFSs4ZDIzsU3WeQFolZqPnT6BylD3v05yUAKiC4I=;
        b=eRF93XG5xs9eXAlOL/FZHlyGsZP/l86Tt64xI2lT7unuaOoRrdpCh6ynmgrFPy0b0R
         yNtG/x2K/xZDYe/pHeAQLS/bpywayfDs285muBPwOEcOtagKzZqwTbtdrpAmJKm1tnsz
         VRmBX16CHr7rVV/p8HErYHv5zIDjHJWsG/1nCYTsJCCCyeKdmz1gEM2AOc4lewl4p+xW
         gGprnnpdIBFlkLmeaUxHgFxbWA0WHII/xFW7CeF5aEjaOubOo0E4CsT8luXyS3mgfOSw
         5iSO34L7j7BWmQ5Yp06r7CmzUICvcZSJq0NZ+xzdJ1VrZaxHgv9A3alajGgvTO2hxQuf
         5wIw==
X-Gm-Message-State: AOAM531pZYChAul7rwvP76gBpXcUHTgkvf8H14RWM99t8oJkde5nkRT0
        R7sRG8hht87a+72iZon92orRVWj2BtllqlzB+Lg5MzA0Vg077efvQae+oi4A8wjvSN3SPFpxJmN
        9/Ew7bETC7og6I3zPSVgoGz2v
X-Received: by 2002:a5d:5983:: with SMTP id n3mr12218315wri.241.1624019896285;
        Fri, 18 Jun 2021 05:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6buMSygSMET2HRRFto0utYr5pHmbiCUKzswQXXbWqPi3keYL8lMRIvXzbPyrGGaftLze7cQ==
X-Received: by 2002:a5d:5983:: with SMTP id n3mr12218290wri.241.1624019896020;
        Fri, 18 Jun 2021 05:38:16 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
        by smtp.gmail.com with ESMTPSA id b71sm2236262wmb.2.2021.06.18.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:38:14 -0700 (PDT)
Date:   Fri, 18 Jun 2021 08:38:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Keiichi Watanabe <keiichiw@chromium.org>
Cc:     netdev@vger.kernel.org, chirantan@chromium.org,
        Jason Wang <jasowang@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Enable MSI-X vector for ctrl queue
Message-ID: <20210618083650-mutt-send-email-mst@kernel.org>
References: <20210618072625.957837-1-keiichiw@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618072625.957837-1-keiichiw@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:26:25PM +0900, Keiichi Watanabe wrote:
> When we use vhost-user backend on the host, MSI-X vector should be set
> so that the vmm can get an irq FD and send it to the backend device
> process with vhost-user protocol.
> Since whether the vector is set for a queue is determined depending on
> the queue has a callback, this commit sets an empty callback for
> virtio-net's control queue.
> 
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>

I'm confused by this explanation. If the vmm wants to get
an interrupt it can do so - why change the guest driver?

> ---
>  drivers/net/virtio_net.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 11f722460513..002e3695d4b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2696,6 +2696,11 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
>  	virtnet_free_queues(vi);
>  }
>  
> +static void virtnet_ctrlq_done(struct virtqueue *rvq)
> +{
> +	/* Do nothing */
> +}
> +
>  /* How large should a single buffer be so a queue full of these can fit at
>   * least one full packet?
>   * Logic below assumes the mergeable buffer header is used.
> @@ -2748,7 +2753,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_ctrlq_done;
>  		names[total_vqs - 1] = "control";
>  	}
>  
> -- 
> 2.32.0.288.g62a8d224e6-goog

