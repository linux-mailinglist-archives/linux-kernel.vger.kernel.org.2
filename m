Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D03875CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbhERJ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241006AbhERJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621331700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+VCDqtzyoP1/MzTBF9IVeYAYQ0ccxPfD6Ur9tV2oQ+o=;
        b=QxslfdtDobxarcH53NHc1d5Yvhmg2VC8nDhk3/a3yfeAJ6Yy1BRYx2S3ylP5cgriCo741d
        IE5LpTQobzL57pZfBfuJEeJhkqis5vvd9Qa22d5ux1eyTSC6KMKyukgKff7k8/jXV7F83g
        pkTgw6sRJZ6KC/iPjhZu6yC8c4DNJkw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-aLXZg9jzNeuW7yahtncapQ-1; Tue, 18 May 2021 05:54:58 -0400
X-MC-Unique: aLXZg9jzNeuW7yahtncapQ-1
Received: by mail-wr1-f69.google.com with SMTP id x10-20020adfc18a0000b029010d83c83f2aso5334100wre.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+VCDqtzyoP1/MzTBF9IVeYAYQ0ccxPfD6Ur9tV2oQ+o=;
        b=sMN/U2lYdMUGC4UgfHmy5VGs9Pe4syAOd+EcFsAMcEjzzxtIASpHKPgBEk9U6kKURL
         rILNdxG/4sTFpTya/K5WGVFroc7w73dFhO4P+qVhirYM/I8sf2kNCv5ciqgFnTNXDl8W
         lHC92LYOfZfGg8vE8Sm+mhd4krUsMZPz1U+dnKt1WDjtNKGsjeM3RY71cosK3HrtcaVs
         dMinO4MIrZ5H8H14Vphpr+E0D+bkx3P9+hWMXcD3drJP+aSS+vb0Xx3nilFGdX9CTQEH
         9NXnsTrjQ08uq9Ar7SeOqxPGrokuFVHaT+/8T02sXwNByjMYRn5aG71+6FQc+3BVaCLH
         /2gQ==
X-Gm-Message-State: AOAM530DRZjjO6Agas/85rOKq6f6p04u0rXnMegPkYlBdtWcVUsfsaek
        qa6KZ9/8k355XgA2orReq+Z7dZAYzm0mDTpj1P0F8/erzdwEmvUuCJEqRrgNZdSsOCNU9MyeG2/
        kOgohN2Z9kGSj7h7WBuyo0zTv
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr4484502wmh.151.1621331697559;
        Tue, 18 May 2021 02:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtNhcvWHDo9BYsG3WxxnHpLZNjEaHmYXrXsXLGKZi1sCaVICC9ZVl/Fur/33Pf1AoORsMwvA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr4484493wmh.151.1621331697424;
        Tue, 18 May 2021 02:54:57 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
        by smtp.gmail.com with ESMTPSA id f6sm24076804wru.72.2021.05.18.02.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:54:56 -0700 (PDT)
Date:   Tue, 18 May 2021 05:54:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
Message-ID: <20210518055336-mutt-send-email-mst@kernel.org>
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo in subject

On Tue, May 18, 2021 at 05:46:56PM +0800, Xianting Tian wrote:
> When met error, we output a print to avoid a BUG().
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c921ebf3ae82..a66174d13e81 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1647,9 +1647,8 @@ static int xmit_skb(struct send_queue *sq, struct
> sk_buff *skb)
>  		hdr = skb_vnet_hdr(skb);
> 
>  	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
> -				    virtio_is_little_endian(vi->vdev), false,
> -				    0))
> -		BUG();
> +				virtio_is_little_endian(vi->vdev), false, 0))
> +		return -EPROTO;
> 

why EPROTO? can you add some comments to explain what is going on pls?

is this related to a malicious hypervisor thing?

don't we want at least a WARN_ON? Or _ONCE?

>  	if (vi->mergeable_rx_bufs)
>  		hdr->num_buffers = 0;
> -- 
> 2.17.1

