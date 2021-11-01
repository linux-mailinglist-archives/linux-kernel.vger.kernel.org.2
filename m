Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0C44157E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhKAInG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231805AbhKAInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635756030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xG02j+2l2mZLkyt+TpF2G0aulBqscjth8gUxjgVZezY=;
        b=FnXTfK1geImmRlI77HKoGj57So0jsUSHYPBjJUrVvjIDlxK+11KoFrk7nPrh+skvSEFVqD
        4iUpOqNCwfID+pHYutJy9HxCEl56C4BFcVWppdxRtmPNzpVINaSemIXRSIalGJGFHYp3Lf
        MwdCA/kV4SozB/O28rttZ/emZ6zcbAw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-hX6bk9jhMHud2pN3rTDVJA-1; Mon, 01 Nov 2021 04:40:29 -0400
X-MC-Unique: hX6bk9jhMHud2pN3rTDVJA-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so14926737edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xG02j+2l2mZLkyt+TpF2G0aulBqscjth8gUxjgVZezY=;
        b=zr+7ZmQAyqHDMH49kpgId+0mTHjne7u5LM8KR09yJnlTrVs/SGMju4jg6bp2hngmNS
         7LheOYC33TphHcd36XVC0e7zObSEBQhDnQF8FOS//Jp/17CQnGjOptPEF8zA2YJ9vSIy
         kkEu52LONHDKSN8byh6faQXwwzrTVHpv4KokrKnIZZ6X/bz3VyB+gM/a1tqBpwWqagp7
         K6s4AP1XKSWkJL8uN2Fd2/mUWCdLchX5eMYjEqmJ0wUToItheFv7RJgF874Uh2BRUoIA
         1fZj3OJTvt6ub9mc4DVCH/Esr0ZQsxDADR9YsXU0UrqaZUenu7ZMMS6Zw5aK2QTJer9x
         1LSw==
X-Gm-Message-State: AOAM532XuvZXQT9m/bWPDElWY6fBKydJ7EnPnOB1Jmnq2YvXLdUwbERn
        MIW7zAbeDNYEWbpzFDOq1h+m8AaQG58LnOZSlG0F55HXbpSv++yel00MCo8L/+oAkZrNind9veu
        i89LSnUHbb2uP0VlMYhvVAI0V
X-Received: by 2002:a17:906:9753:: with SMTP id o19mr16290318ejy.513.1635756028250;
        Mon, 01 Nov 2021 01:40:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRLzYbWnPDC085EPIZWH2RRdLkJUu6nKtFVO5sJTsosKOeosrJ5fmlxUDbieMdkrBJ/VNAfw==
X-Received: by 2002:a17:906:9753:: with SMTP id o19mr16290290ejy.513.1635756028044;
        Mon, 01 Nov 2021 01:40:28 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
        by smtp.gmail.com with ESMTPSA id eg33sm5763112edb.77.2021.11.01.01.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 01:40:27 -0700 (PDT)
Date:   Mon, 1 Nov 2021 04:40:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andrew Melnychenko <andrew@daynix.com>
Cc:     jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
        yan@daynix.com
Subject: Re: [RFC PATCH 1/4] drivers/net/virtio_net: Fixed vheader to use v1.
Message-ID: <20211101043723-mutt-send-email-mst@kernel.org>
References: <20211031045959.143001-1-andrew@daynix.com>
 <20211031045959.143001-2-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211031045959.143001-2-andrew@daynix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 06:59:56AM +0200, Andrew Melnychenko wrote:
> The header v1 provides additional info about RSS.
> Added changes to computing proper header length.
> In the next patches, the header may contain RSS hash info
> for the hash population.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4ad25a8b0870..b72b21ac8ebd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -240,13 +240,13 @@ struct virtnet_info {
>  };
>  
>  struct padded_vnet_hdr {
> -	struct virtio_net_hdr_mrg_rxbuf hdr;
> +	struct virtio_net_hdr_v1_hash hdr;
>  	/*
>  	 * hdr is in a separate sg buffer, and data sg buffer shares same page
>  	 * with this header sg. This padding makes next sg 16 byte aligned
>  	 * after the header.
>  	 */
> -	char padding[4];
> +	char padding[12];
>  };
>  
>  static bool is_xdp_frame(void *ptr)


This is not helpful as a separate patch, just reserving extra space.
better squash with the patches making use of the change.

> @@ -1636,7 +1636,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	int num_sg;
> -	unsigned hdr_len = vi->hdr_len;
> +	unsigned int hdr_len = vi->hdr_len;
>  	bool can_push;


if we want this, pls make it a separate patch.


>  
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> -- 
> 2.33.1

