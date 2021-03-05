Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72AF32E193
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCEF0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEF0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:26:30 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 21:26:27 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id j8so722224otc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 21:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9xiYNY+6CRe7n01VVJfgZJ+/7nxidlPRaWVwT26cUU=;
        b=m3tjq1W3YXjIl436zWYnjwhWsgpZ1ZsEqCA0Wmtcfz7k2ddyK+S9gBk6Db8BZj9tmc
         mzyWCq20pUOdDY3a1QQ7jiNZI3uWhkeNejI4kb1u3SzIp2D8bC5nWp7RpHizZ7UZHy/y
         X2VbHX/EjhnhAKEt3PeOUI9H79LvDHUE8ch02WsSOi3r14iGXwp/nmWqABQ5byi/MSFV
         730Q/AYHN14ooxY6BhOXZcc2VJFI5gaybBN8OJ4LQEzPWNHPS1Ob1wVD1hJ+Bh9D+stj
         cbhrJ1zLwLSlAka+egHu2s1r+5Fpa390k7p/v1DT4XytwPSuqK5HggmKiLpticIIj1hS
         NumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9xiYNY+6CRe7n01VVJfgZJ+/7nxidlPRaWVwT26cUU=;
        b=g7S8ub6PLEsfe0YdPzhxzFwogM4n9cieu/Ot3vuRNODli2QcRJPasFCMRNfvNI3xjC
         yhFf6B5U+43SMXlToY7P2mpoT4tyuNJkK7nH1iuRnJqRJmApM+TWMRicK4h7sZgwE9No
         IBJYMJgheXCTJfB7wTix3wYac1S4ObPRMFR6LpIaTqX8nNGPGQN6XijiN1suUTYci/eC
         jj+tusoGsftO8CN8qy2kNhZ8I1L1apNng9i4CrnZl2agUrHXZYIO3w7Kh1zyxJlcZOMx
         qTqJoDWTMDnzxYu3EIRb47eszOIMH37QpLjG+VDl5VR5/kXJe/FNb8hpcNuGTsU0ObNN
         pkzQ==
X-Gm-Message-State: AOAM530epnWNKH7OA0HbydiBD+e/s5Mw5h8BgSe8rbEjS5i6KvZ7EmqS
        f21KMYFyI/liWpUekNZUmulxAQ==
X-Google-Smtp-Source: ABdhPJwbjwUgJN6i2/JVWVSKLR6RCq6k3m5TOA6DbZwBeNPC5OCMrApGqzhvU3pk0Q+gGDxQwHXgRQ==
X-Received: by 2002:a05:6830:2452:: with SMTP id x18mr6462837otr.322.1614921987053;
        Thu, 04 Mar 2021 21:26:27 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s73sm335831oih.36.2021.03.04.21.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 21:26:26 -0800 (PST)
Date:   Thu, 4 Mar 2021 23:26:24 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, sharathv@codeaurora.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net: qualcomm: rmnet: don't use C
 bit-fields in rmnet checksum header
Message-ID: <YEHBANdYaI+Meb7t@builder.lan>
References: <20210304223431.15045-1-elder@linaro.org>
 <20210304223431.15045-7-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304223431.15045-7-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Mar 16:34 CST 2021, Alex Elder wrote:

> Replace the use of C bit-fields in the rmnet_map_ul_csum_header
> structure with a single two-byte (big endian) structure member,
> and use field masks to encode or get values within it.
> 
> Previously rmnet_map_ipv4_ul_csum_header() would update values in
> the host byte-order fields, and then forcibly fix their byte order
> using a combination of byte order operations and types.
> 
> Instead, just compute the value that needs to go into the new
> structure member and save it with a simple byte-order conversion.
> 
> Make similar simplifications in rmnet_map_ipv6_ul_csum_header().
> 
> Finally, in rmnet_map_checksum_uplink_packet() a set of assignments
> zeroes every field in the upload checksum header.  Replace that with
> a single memset() operation.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 34 ++++++-------------
>  include/linux/if_rmnet.h                      | 21 ++++++------
>  2 files changed, 21 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 29d485b868a65..db76bbf000aa1 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -198,23 +198,19 @@ rmnet_map_ipv4_ul_csum_header(void *iphdr,
>  			      struct rmnet_map_ul_csum_header *ul_header,
>  			      struct sk_buff *skb)
>  {
> -	__be16 *hdr = (__be16 *)ul_header;
>  	struct iphdr *ip4h = iphdr;
>  	u16 offset;
> +	u16 val;
>  
>  	offset = skb_transport_header(skb) - (unsigned char *)iphdr;
>  	ul_header->csum_start_offset = htons(offset);
>  
> -	ul_header->csum_insert_offset = skb->csum_offset;
> -	ul_header->csum_enabled = 1;
> +	val = be16_encode_bits(1, MAP_CSUM_UL_ENABLED_FMASK);

Why are you using be16_ here? Won't that cancel the htons() below?

Regards,
Bjorn

>  	if (ip4h->protocol == IPPROTO_UDP)
> -		ul_header->udp_ind = 1;
> -	else
> -		ul_header->udp_ind = 0;
> +		val |= be16_encode_bits(1, MAP_CSUM_UL_UDP_FMASK);
> +	val |= be16_encode_bits(skb->csum_offset, MAP_CSUM_UL_OFFSET_FMASK);
>  
> -	/* Changing remaining fields to network order */
> -	hdr++;
> -	*hdr = htons((__force u16)*hdr);
> +	ul_header->csum_info = htons(val);
>  
>  	skb->ip_summed = CHECKSUM_NONE;
>  
> @@ -241,24 +237,19 @@ rmnet_map_ipv6_ul_csum_header(void *ip6hdr,
>  			      struct rmnet_map_ul_csum_header *ul_header,
>  			      struct sk_buff *skb)
>  {
> -	__be16 *hdr = (__be16 *)ul_header;
>  	struct ipv6hdr *ip6h = ip6hdr;
>  	u16 offset;
> +	u16 val;
>  
>  	offset = skb_transport_header(skb) - (unsigned char *)ip6hdr;
>  	ul_header->csum_start_offset = htons(offset);
>  
> -	ul_header->csum_insert_offset = skb->csum_offset;
> -	ul_header->csum_enabled = 1;
> -
> +	val = be16_encode_bits(1, MAP_CSUM_UL_ENABLED_FMASK);
>  	if (ip6h->nexthdr == IPPROTO_UDP)
> -		ul_header->udp_ind = 1;
> -	else
> -		ul_header->udp_ind = 0;
> +		val |= be16_encode_bits(1, MAP_CSUM_UL_UDP_FMASK);
> +	val |= be16_encode_bits(skb->csum_offset, MAP_CSUM_UL_OFFSET_FMASK);
>  
> -	/* Changing remaining fields to network order */
> -	hdr++;
> -	*hdr = htons((__force u16)*hdr);
> +	ul_header->csum_info = htons(val);
>  
>  	skb->ip_summed = CHECKSUM_NONE;
>  
> @@ -425,10 +416,7 @@ void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
>  	}
>  
>  sw_csum:
> -	ul_header->csum_start_offset = 0;
> -	ul_header->csum_insert_offset = 0;
> -	ul_header->csum_enabled = 0;
> -	ul_header->udp_ind = 0;
> +	memset(ul_header, 0, sizeof(*ul_header));
>  
>  	priv->stats.csum_sw++;
>  }
> diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
> index 1fbb7531238b6..149d696feb520 100644
> --- a/include/linux/if_rmnet.h
> +++ b/include/linux/if_rmnet.h
> @@ -33,17 +33,16 @@ struct rmnet_map_dl_csum_trailer {
>  
>  struct rmnet_map_ul_csum_header {
>  	__be16 csum_start_offset;
> -#if defined(__LITTLE_ENDIAN_BITFIELD)
> -	u16 csum_insert_offset:14;
> -	u16 udp_ind:1;
> -	u16 csum_enabled:1;
> -#elif defined (__BIG_ENDIAN_BITFIELD)
> -	u16 csum_enabled:1;
> -	u16 udp_ind:1;
> -	u16 csum_insert_offset:14;
> -#else
> -#error	"Please fix <asm/byteorder.h>"
> -#endif
> +	__be16 csum_info;		/* MAP_CSUM_UL_*_FMASK */
>  } __aligned(1);
>  
> +/* csum_info field:
> + *  ENABLED:	1 = checksum computation requested
> + *  UDP:	1 = UDP checksum (zero checkum means no checksum)
> + *  OFFSET:	where (offset in bytes) to insert computed checksum
> + */
> +#define MAP_CSUM_UL_OFFSET_FMASK	GENMASK(13, 0)
> +#define MAP_CSUM_UL_UDP_FMASK		GENMASK(14, 14)
> +#define MAP_CSUM_UL_ENABLED_FMASK	GENMASK(15, 15)
> +
>  #endif /* !(_LINUX_IF_RMNET_H_) */
> -- 
> 2.20.1
> 
