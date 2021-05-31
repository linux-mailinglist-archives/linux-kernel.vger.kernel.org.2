Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36F639559E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230107AbhEaGu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622443758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Yc0uSlr7grz8BAG5Bx+sZyGCLVXp2CTrZfFPky/9/w=;
        b=gZVFTso8CQ2qC9cp2DRumIL1/lDDCAD/G+S+iDvtWR5G1En6mx/UoSEhO3a0IhK8bX5xS6
        xLqV8Pv3rWdpPYHk1iBILTEu4XimGqlDbuoQUf9EZBap93OJmycxWkgWstnKTarzGvOkqz
        KzGnaq0iTEj1oiyvIh7399ScoIymVOo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-l6_JO9dBN2iHbZtCYobZ8A-1; Mon, 31 May 2021 02:49:16 -0400
X-MC-Unique: l6_JO9dBN2iHbZtCYobZ8A-1
Received: by mail-pf1-f197.google.com with SMTP id g21-20020aa787550000b02902db9841d2a1so5399050pfo.15
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 23:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6Yc0uSlr7grz8BAG5Bx+sZyGCLVXp2CTrZfFPky/9/w=;
        b=kIwhgSwOo5OhVOn7jMRpE413F1+JbkqhXwz28YfyGptRg4TntKZCL7BIQ8S3R3TN2z
         wBgbCjQbzkZ+coXTScQ0tYWaNEcGVp7b1Helq9aszN7jwcaPzFdOlP7g5nBALcsL6V/c
         cjgadGJ/Pyx/n5LsnTYqhARA6vEU/anGSDxkzlqwA4b9ZBjM2oZynY5Bon2k7sGdi22z
         M/iz1L3MwVG4xXuFRiLBpn+nZKoct2FGKrMo94cmR98QUbB48jQXjbHIWfTVNBzp0QmW
         vglQVQZ12FS0We/fo5d8rB/NhgHqQJffOd76krSKEzNLhDxPl87WNE1XgN17r5U3HpFW
         9G2A==
X-Gm-Message-State: AOAM531agD9N5ZNjiLqtSD1//Hnazh2+gUMe1szUTS3fbPJSqbPI47o2
        4iWA9+ADeIOeh/nQJC3yYpMH94lBDi7J4yYPFTV6HeuJJzCIpglGZZ7nYhKWVae4AH72qcBincu
        V+4rWOc6hQBo2MjAslNjoCy9f3aVjHMpALtC9E2XDIiy+Bfsqz2/c9rDDf5hVXb+kOjqKm/YpvT
        JP
X-Received: by 2002:a17:90b:3796:: with SMTP id mz22mr1584926pjb.177.1622443755448;
        Sun, 30 May 2021 23:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9RAl2ySCS8IqAypdqHE7XJCr0ttp2qTK+ufr0FDlpClMk1kWxyYqhd7HsscFqocSEmZPnrg==
X-Received: by 2002:a17:90b:3796:: with SMTP id mz22mr1584900pjb.177.1622443755124;
        Sun, 30 May 2021 23:49:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o139sm2519738pfd.96.2021.05.30.23.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 23:49:14 -0700 (PDT)
Subject: Re: [PATCH v3] virtio-net: Add validation for used length
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        kuba@kernel.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210528121157.105-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <49ab3d41-c5d8-a49d-3ff4-28ebfdba0181@redhat.com>
Date:   Mon, 31 May 2021 14:49:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528121157.105-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/28 ÏÂÎç8:11, Xie Yongji Ð´µÀ:
> This adds validation for used length (might come
> from an untrusted device) to avoid data corruption
> or loss.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/net/virtio_net.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 073fec4c0df1..01f15b65824c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -732,6 +732,17 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   
>   	rcu_read_lock();
>   	xdp_prog = rcu_dereference(rq->xdp_prog);
> +	if (unlikely(len > GOOD_PACKET_LEN)) {
> +		pr_debug("%s: rx error: len %u exceeds max size %d\n",
> +			 dev->name, len, GOOD_PACKET_LEN);
> +		dev->stats.rx_length_errors++;
> +		if (xdp_prog)
> +			goto err_xdp;
> +
> +		rcu_read_unlock();
> +		put_page(page);
> +		return NULL;
> +	}
>   	if (xdp_prog) {
>   		struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>   		struct xdp_frame *xdpf;
> @@ -888,6 +899,16 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   
>   	rcu_read_lock();
>   	xdp_prog = rcu_dereference(rq->xdp_prog);
> +	if (unlikely(len > truesize)) {
> +		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> +			 dev->name, len, (unsigned long)ctx);
> +		dev->stats.rx_length_errors++;
> +		if (xdp_prog)
> +			goto err_xdp;
> +
> +		rcu_read_unlock();
> +		goto err_skb;
> +	}


Patch looks correct but I'd rather not bother XDP here. It would be 
better if we just do the check before rcu_read_lock() and use err_skb 
directly() to avoid RCU/XDP stuffs.

Thanks


>   	if (xdp_prog) {
>   		struct xdp_frame *xdpf;
>   		struct page *xdp_page;
> @@ -1012,13 +1033,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   	}
>   	rcu_read_unlock();
>   
> -	if (unlikely(len > truesize)) {
> -		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> -			 dev->name, len, (unsigned long)ctx);
> -		dev->stats.rx_length_errors++;
> -		goto err_skb;
> -	}
> -
>   	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
>   			       metasize, !!headroom);
>   	curr_skb = head_skb;

