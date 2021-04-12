Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2580435C263
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbhDLJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239548AbhDLJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618218767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hf9Vyzd4yhDbdWoEdecJWwL+sFUTnRKnW5AGaSKyYno=;
        b=RvFqcZ3pZANr0Bu4+mjbikY+7vV0lD9SnF59+8bC1jsTD5n45LHxLsb/AecgofCwnXD4Hn
        49rSpWT5uJsQOI92CeWOgnd7gnEgwFCFhBgc6D+oqllFEBDNRI8tMW47Hh1Y7yOxiwmtTR
        0Ulz5NfxK8ruh2eRKOXB0PwIovX29Uc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-uah3J0vjOGiGtCzlPEqSkQ-1; Mon, 12 Apr 2021 05:12:45 -0400
X-MC-Unique: uah3J0vjOGiGtCzlPEqSkQ-1
Received: by mail-wr1-f69.google.com with SMTP id j24so4149974wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hf9Vyzd4yhDbdWoEdecJWwL+sFUTnRKnW5AGaSKyYno=;
        b=Kj/jH+6viWY4n6uQuVobzpKZxYgvkbMqIe13pdxEc9XaHK51B8lRvHYM/NLoWI2aAX
         0iRMuKVgCByPS/KN4SaHkN9s4KIFrxx2OtV956LkqWUEavKzaFhhAS8hdpwZ17EbyZjC
         7ZmNC4iZ8LwF2mqsPZ2vPhgtKCJdyKDgN0lwkbi5wIWEyijAn4dHrbmp4UHSxJg18ON5
         w+Ln5F70sljOwQ+e2SixEMeFblpQo4B5Fsdyw3v8q00SSmfCuSffKfpi+pHVIeQoz/4z
         ntR3sC/KfbcI4nr8KXovZeguwG3Phth7ZAQhcqIXGDpftdYh35wsR3nV6uLTyCZuWvkX
         Aggw==
X-Gm-Message-State: AOAM531mvMnhXTcwruGgELJQugqf+fegaE2tDpqTIVMz8G0w1+n5i/FP
        KlOHenfUyQ0li3ZmmqtCVSCQ94apLQ/Fl6Y+ltnVpV2dyX7zbxsXvArx5C0icJoDBq1BSh3/CFu
        8TqrjPwtfY0/BIv09AVyzcGea
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr15236724wrs.263.1618218762238;
        Mon, 12 Apr 2021 02:12:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM832CN7tVMrIa0X+HAgateah9+2m2Wr3rYm73siJgkPtK59AqFEZVni4se9AETp0Udkulig==
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr15236713wrs.263.1618218762100;
        Mon, 12 Apr 2021 02:12:42 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id u10sm15498510wrt.75.2021.04.12.02.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:12:41 -0700 (PDT)
Date:   Mon, 12 Apr 2021 05:12:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 042/111] virtio_net: Do not pull payload in skb->head
Message-ID: <20210412051230-mutt-send-email-mst@kernel.org>
References: <20210412084004.200986670@linuxfoundation.org>
 <20210412084005.653952525@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412084005.653952525@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:40:20AM +0200, Greg Kroah-Hartman wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 0f6925b3e8da0dbbb52447ca8a8b42b371aac7db ]
> 
> Xuan Zhuo reported that commit 3226b158e67c ("net: avoid 32 x truesize
> under-estimation for tiny skbs") brought  a ~10% performance drop.
> 
> The reason for the performance drop was that GRO was forced
> to chain sk_buff (using skb_shinfo(skb)->frag_list), which
> uses more memory but also cause packet consumers to go over
> a lot of overhead handling all the tiny skbs.
> 
> It turns out that virtio_net page_to_skb() has a wrong strategy :
> It allocates skbs with GOOD_COPY_LEN (128) bytes in skb->head, then
> copies 128 bytes from the page, before feeding the packet to GRO stack.
> 
> This was suboptimal before commit 3226b158e67c ("net: avoid 32 x truesize
> under-estimation for tiny skbs") because GRO was using 2 frags per MSS,
> meaning we were not packing MSS with 100% efficiency.
> 
> Fix is to pull only the ethernet header in page_to_skb()
> 
> Then, we change virtio_net_hdr_to_skb() to pull the missing
> headers, instead of assuming they were already pulled by callers.
> 
> This fixes the performance regression, but could also allow virtio_net
> to accept packets with more than 128bytes of headers.
> 
> Many thanks to Xuan Zhuo for his report, and his tests/help.
> 
> Fixes: 3226b158e67c ("net: avoid 32 x truesize under-estimation for tiny skbs")
> Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Link: https://www.spinics.net/lists/netdev/msg731397.html
> Co-Developed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


Note that an issue related to this patch was recently reported.
It's quite possible that the root cause is a bug elsewhere
in the kernel, but it probably makes sense to defer the backport
until we know more ...


> ---
>  drivers/net/virtio_net.c   | 10 +++++++---
>  include/linux/virtio_net.h | 14 +++++++++-----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b67460864b3c..d8ee001d8e8e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -406,9 +406,13 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	offset += hdr_padded_len;
>  	p += hdr_padded_len;
>  
> -	copy = len;
> -	if (copy > skb_tailroom(skb))
> -		copy = skb_tailroom(skb);
> +	/* Copy all frame if it fits skb->head, otherwise
> +	 * we let virtio_net_hdr_to_skb() and GRO pull headers as needed.
> +	 */
> +	if (len <= skb_tailroom(skb))
> +		copy = len;
> +	else
> +		copy = ETH_HLEN + metasize;
>  	skb_put_data(skb, p, copy);
>  
>  	if (metasize) {
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 98775d7fa696..b465f8f3e554 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -65,14 +65,18 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	skb_reset_mac_header(skb);
>  
>  	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> -		u16 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
> -		u16 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
> +		u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
> +		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
> +		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
> +
> +		if (!pskb_may_pull(skb, needed))
> +			return -EINVAL;
>  
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
>  
>  		p_off = skb_transport_offset(skb) + thlen;
> -		if (p_off > skb_headlen(skb))
> +		if (!pskb_may_pull(skb, p_off))
>  			return -EINVAL;
>  	} else {
>  		/* gso packets without NEEDS_CSUM do not set transport_offset.
> @@ -102,14 +106,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  			}
>  
>  			p_off = keys.control.thoff + thlen;
> -			if (p_off > skb_headlen(skb) ||
> +			if (!pskb_may_pull(skb, p_off) ||
>  			    keys.basic.ip_proto != ip_proto)
>  				return -EINVAL;
>  
>  			skb_set_transport_header(skb, keys.control.thoff);
>  		} else if (gso_type) {
>  			p_off = thlen;
> -			if (p_off > skb_headlen(skb))
> +			if (!pskb_may_pull(skb, p_off))
>  				return -EINVAL;
>  		}
>  	}
> -- 
> 2.30.2
> 
> 

