Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6258B3913A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhEZJ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhEZJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:29:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8DC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:28:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z17so334800wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T46Fkh/snm79TPYjxPV8Q6sUOb7bSN2nDklHppfuD7U=;
        b=V8miUGcHmom+hPFSXg2JT9324Btql1cDk/LZdt3ZeMOdEaYMqO/SMWswXju19B41AT
         fxX05hIGeh97cg/sGFINIK6xmFT8wXOTvA1drnWEk2v5Wjp+g7cQzcvuZls94cOxmznx
         +egRciq1M5t7PTpWLabtLAo2qdKTktdOcjDIdZgumzEVsydki8Ps8qVKbGjTCxUaQt7j
         CGwCP+qAms3tkFEmZkH+sbyO1Gt8OKr1xqkMOTfCNg7lZt9e6oNUYAiWrxliEAjG8fvn
         Q85cresezfzGmBQw1aXgfyKskPQIJwtw10XjBQIuDyD9LtzpR6rmX57ORrJ79wFhulME
         YoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T46Fkh/snm79TPYjxPV8Q6sUOb7bSN2nDklHppfuD7U=;
        b=hTs+N6kTtmAZG8SE1EBoQapRIgceJWD5GFqXRl3qIBi4Oug1ct3+VYKfKKeDTbPdrH
         vFM6t8FB/74aGkL74zaWgrrVzaMzr89K3jjUAfluE8y1Y8xZW+2AUGuy1YuyIFtPnp0F
         T1s2/9W+Nq9TRW2jGYDRol2c8X52Y6mwrxKG0f086nOyJbq5+xpr+6N+Plh6t8WMltu5
         mA/FPKkI0l6H/xUGdkJoX++LwM8Wg/nE+oMwVfZ39wBjQU0o/SXHMmnjMyQdNMw9KAu7
         jKHouejJZqiFKAk0K96JjDLHlaXGMhekcDgDp39W4Z1l5jb0ElYpaQ7XjBbYApjgX9mf
         /dug==
X-Gm-Message-State: AOAM5321KIHAgqSVGHtmIJm/eVRqfYNevHUm3Ta2Q6yhX78wL4Skr7XF
        5Wg7S/WorNwfB9aAg8Kbar3BHA==
X-Google-Smtp-Source: ABdhPJxxLJkJoZDV7NzE/k/mdcXKtSU5x9j+Kv/YTwFDabvnODHS0PBLpvnXAzH6NU46+0ffYnwRVg==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr32425591wri.260.1622021291219;
        Wed, 26 May 2021 02:28:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:84b:9126:550a:94fc? ([2a01:e34:ed2f:f020:84b:9126:550a:94fc])
        by smtp.googlemail.com with ESMTPSA id k205sm14086604wmf.13.2021.05.26.02.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 02:28:10 -0700 (PDT)
Subject: Re: [PATCH net-next] net: netlink: remove netlink_broadcast_filtered
To:     menglong8.dong@gmail.com, kuba@kernel.org
Cc:     davem@davemloft.net, mkubecek@suse.cz, dsahern@kernel.org,
        zhudi21@huawei.com, johannes.berg@intel.com,
        marcelo.leitner@gmail.com, dong.menglong@zte.com.cn,
        ast@kernel.org, yhs@fb.com, rdunlap@infradead.org,
        yangyingliang@huawei.com, 0x7f454c46@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20210309151834.58675-1-dong.menglong@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6d59bf25-2e1e-5bd7-07f1-dff2e73c7a7e@linaro.org>
Date:   Wed, 26 May 2021 11:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210309151834.58675-1-dong.menglong@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 16:18, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> It seems that 'netlink_broadcast_filtered()' is not used anywhere
> besides 'netlink_broadcast()'. In order to reduce function calls,
> just remove it.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

I was trying to figure out if the function could be useful to filter out
some netlink messages when sending them to userspace.

Still looking for examples :/

On the other side, this function was put there as part of the network
namespace infrastructure. Even there is no user, it may be needed.

> ---
>  include/linux/netlink.h  |  4 ----
>  net/netlink/af_netlink.c | 22 ++--------------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 0bcf98098c5a..277f33e64bb3 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -160,10 +160,6 @@ bool netlink_strict_get_check(struct sk_buff *skb);
>  int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
>  int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
>  		      __u32 group, gfp_t allocation);
> -int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
> -			       __u32 portid, __u32 group, gfp_t allocation,
> -			       int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
> -			       void *filter_data);
>  int netlink_set_err(struct sock *ssk, __u32 portid, __u32 group, int code);
>  int netlink_register_notifier(struct notifier_block *nb);
>  int netlink_unregister_notifier(struct notifier_block *nb);
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index dd488938447f..b462fdc87e9b 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1405,8 +1405,6 @@ struct netlink_broadcast_data {
>  	int delivered;
>  	gfp_t allocation;
>  	struct sk_buff *skb, *skb2;
> -	int (*tx_filter)(struct sock *dsk, struct sk_buff *skb, void *data);
> -	void *tx_data;
>  };
>  
>  static void do_one_broadcast(struct sock *sk,
> @@ -1460,11 +1458,6 @@ static void do_one_broadcast(struct sock *sk,
>  			p->delivery_failure = 1;
>  		goto out;
>  	}
> -	if (p->tx_filter && p->tx_filter(sk, p->skb2, p->tx_data)) {
> -		kfree_skb(p->skb2);
> -		p->skb2 = NULL;
> -		goto out;
> -	}
>  	if (sk_filter(sk, p->skb2)) {
>  		kfree_skb(p->skb2);
>  		p->skb2 = NULL;
> @@ -1487,10 +1480,8 @@ static void do_one_broadcast(struct sock *sk,
>  	sock_put(sk);
>  }
>  
> -int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb, u32 portid,
> -	u32 group, gfp_t allocation,
> -	int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
> -	void *filter_data)
> +int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
> +		      u32 group, gfp_t allocation)
>  {
>  	struct net *net = sock_net(ssk);
>  	struct netlink_broadcast_data info;
> @@ -1509,8 +1500,6 @@ int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb, u32 portid
>  	info.allocation = allocation;
>  	info.skb = skb;
>  	info.skb2 = NULL;
> -	info.tx_filter = filter;
> -	info.tx_data = filter_data;
>  
>  	/* While we sleep in clone, do not allow to change socket list */
>  
> @@ -1536,14 +1525,7 @@ int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb, u32 portid
>  	}
>  	return -ESRCH;
>  }
> -EXPORT_SYMBOL(netlink_broadcast_filtered);
>  
> -int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
> -		      u32 group, gfp_t allocation)
> -{
> -	return netlink_broadcast_filtered(ssk, skb, portid, group, allocation,
> -		NULL, NULL);
> -}
>  EXPORT_SYMBOL(netlink_broadcast);
>  
>  struct netlink_set_err_data {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
