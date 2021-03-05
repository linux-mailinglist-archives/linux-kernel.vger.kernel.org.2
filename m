Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5E32E05F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCEEHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEEHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:07:16 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD0BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 20:07:16 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id r19so576842otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 20:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g2X3AuyS9pE7ney+yblpjXrUEFgN6B0LhuiKB+8C6j0=;
        b=l/+cAui14+nB7D+m/sfh68LTZXT+BoYCuLhsKYjhD9JfvmIHQ4b011TqbRm2jmscQc
         +80zUf7mAUDIp4jLhWh6/Tg/IzM+bv3LGMJaZXXd89ExVF+Gf9NqcGK+3RZi9+O1znDx
         xry+M51zEbftdbh9+SVLEimRUkNDyVKN9lZBUYxdAgjv5NXTdCpz75nDCo2ZWonwx7h7
         TGFWYnvlgSzVQIIfBd1fefoROaKgfE20+bcPRwx4Lhd01nFY7QJt+CIFUd7DSi6j+7xB
         dWTlwYDUN+gQm8+5wUREFB55o8VFKjXnY+QDEaUp3zZtqsnPx6gvV8GwoPhbHB+a09VI
         Oh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g2X3AuyS9pE7ney+yblpjXrUEFgN6B0LhuiKB+8C6j0=;
        b=Ia3JQUmyG3dEmS32aYSmUZ5reIYQMd047WoGWRWaXnwMNhUwbxqi3crsdZ4U7FFlhU
         sV26zoStcPpWOrf3vP14IGfWxZYGNDCQips5o5mcxcb6FIaINhhDqHYPr511vwbIw6v+
         ExscfibmfHr60aJwJCAPn0QwLZVjlPCZAOYyOnt4CRlbY8nm7dAKCvCSJfhbfD4s1sWl
         IQuMcwoiTaQwYbg2mZ2mvgG3sHD8EkH4OoJ3qX7gkv7j48D+WIVmuz+ZoEV/5+pqyrpp
         NYp7QklC9eBwfgP6Ejvz3AnyWf/OTc+0Mp4Bw2MFHLJxkfHhuveUUP/14Tvu65Mgcib9
         NURw==
X-Gm-Message-State: AOAM532sxmn5+QyiPdIrS8qdlYT+koFIzVDkYTPm0gj5Ol2dUDSDt7E3
        noNgVvQ0ala4yGrQ2dWKPcvwV6VyeIyNcA==
X-Google-Smtp-Source: ABdhPJzwBPs6wvWsm27RwtgAjbWHeKN4hGUqDR46f7Eiu0YSpf+/VPwLOfH75cJImSiyaO3EBcuJ4g==
X-Received: by 2002:a05:6830:2119:: with SMTP id i25mr6086111otc.249.1614917235811;
        Thu, 04 Mar 2021 20:07:15 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s21sm339104oos.5.2021.03.04.20.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 20:07:15 -0800 (PST)
Date:   Thu, 4 Mar 2021 22:07:13 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, sharathv@codeaurora.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: qualcomm: rmnet: simplify some byte
 order logic
Message-ID: <YEGucXIUQ59UcLrJ@builder.lan>
References: <20210304223431.15045-1-elder@linaro.org>
 <20210304223431.15045-3-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304223431.15045-3-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Mar 16:34 CST 2021, Alex Elder wrote:

> In rmnet_map_ipv4_ul_csum_header() and rmnet_map_ipv6_ul_csum_header()
> the offset within a packet at which checksumming should commence is
> calculated.  This calculation involves byte swapping and a forced type
> conversion that makes it hard to understand.
> 
> Simplify this by computing the offset in host byte order, then
> converting the result when assigning it into the header field.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 22 ++++++++++---------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 21d38167f9618..bd1aa11c9ce59 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -197,12 +197,13 @@ rmnet_map_ipv4_ul_csum_header(void *iphdr,
>  			      struct rmnet_map_ul_csum_header *ul_header,
>  			      struct sk_buff *skb)
>  {
> -	struct iphdr *ip4h = (struct iphdr *)iphdr;
> -	__be16 *hdr = (__be16 *)ul_header, offset;
> +	__be16 *hdr = (__be16 *)ul_header;
> +	struct iphdr *ip4h = iphdr;
> +	u16 offset;
> +
> +	offset = skb_transport_header(skb) - (unsigned char *)iphdr;
> +	ul_header->csum_start_offset = htons(offset);
>  
> -	offset = htons((__force u16)(skb_transport_header(skb) -

Just curious, why does this require a __force, or even a cast?


Regardless, your proposed way of writing it is easier to read.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> -				     (unsigned char *)iphdr));
> -	ul_header->csum_start_offset = offset;
>  	ul_header->csum_insert_offset = skb->csum_offset;
>  	ul_header->csum_enabled = 1;
>  	if (ip4h->protocol == IPPROTO_UDP)
> @@ -239,12 +240,13 @@ rmnet_map_ipv6_ul_csum_header(void *ip6hdr,
>  			      struct rmnet_map_ul_csum_header *ul_header,
>  			      struct sk_buff *skb)
>  {
> -	struct ipv6hdr *ip6h = (struct ipv6hdr *)ip6hdr;
> -	__be16 *hdr = (__be16 *)ul_header, offset;
> +	__be16 *hdr = (__be16 *)ul_header;
> +	struct ipv6hdr *ip6h = ip6hdr;
> +	u16 offset;
> +
> +	offset = skb_transport_header(skb) - (unsigned char *)ip6hdr;
> +	ul_header->csum_start_offset = htons(offset);
>  
> -	offset = htons((__force u16)(skb_transport_header(skb) -
> -				     (unsigned char *)ip6hdr));
> -	ul_header->csum_start_offset = offset;
>  	ul_header->csum_insert_offset = skb->csum_offset;
>  	ul_header->csum_enabled = 1;
>  
> -- 
> 2.20.1
> 
