Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC3454D60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbhKQStf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbhKQStd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:49:33 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C95C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:46:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso6033890pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3NBdeMa7UJMp4oi4jtQR34QCAkYIt9zpa2vLRHjbdpw=;
        b=lN5cP4MflcVUN1WmXVMPFWM/aHOSEKfEgvuMYKcvxfCau4pbSypcVZjz+3oM9xySCt
         xXwZYEeHT49QEC/pMboGvTGIhGFLwLLKXvlT/X/vaSTO9UGAGdPNNOFBQpnSf19pSoBm
         fUIv/Hbym58VbLb6LtebxSLCy7urH0Rc43Oj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NBdeMa7UJMp4oi4jtQR34QCAkYIt9zpa2vLRHjbdpw=;
        b=ocZp9r/VYfLR0RWhaOvaIMoJuRo9dH+QQcuJom5a01zcbKEC7Jqwq21VuLmyQSQ+Oy
         e2i6YIQYECgMNVeWpxMCq4b0iHW8KvfUb93+QJgeFUzAvBQ6yUsHPOyjTLiUUHOmMDLE
         4deq+10ASX5fVdk0obj2BR35h7Zylmv0Yjg4sG6TGBvr4hBiXD/DD63aR28oI/CF6OA3
         Lil2tnp0cR9cO/6tzh+DMiuLtBubWeC8UbQpr8Ya0Sw0FgF7B1cMVdr0S4VoS4V+LY+D
         WMWI6xNSazSb/RU9o6Fk8xy3FOjBPUN+MqUuSuAQw+Rot7d3iKazyWUwMl6nLMSh7wGw
         Ylgg==
X-Gm-Message-State: AOAM532aOsiISN0eGtirp63vds4m6E+5RoBTm2kRRakLd0HqIMvPfGP8
        1sc521CKXBAhd8//MNNnv0b5Ww==
X-Google-Smtp-Source: ABdhPJw+8DZ051H38mziwHvk/XKKV65pKWaK+EuXnBraSMFA9Kra9YEDD6X9lyJxzsX4nTdCK+RgCw==
X-Received: by 2002:a17:90b:1b45:: with SMTP id nv5mr2352297pjb.120.1637174793988;
        Wed, 17 Nov 2021 10:46:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u9sm362856pfi.23.2021.11.17.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:46:33 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:46:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] ipv6: check return value of ipv6_skip_exthdr
Message-ID: <202111171046.A3390D8A4A@keescook>
References: <20211117181610.2731938-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117181610.2731938-1-jordy@pwning.systems>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 07:16:10PM +0100, Jordy Zomer wrote:
> The offset value is used in pointer math on skb->data.
> Since ipv6_skip_exthdr may return -1 the pointer to uh and th
> may not point to the actual udp and tcp headers and potentially
> overwrite other stuff. This is why I think this should be checked.
> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  net/ipv6/esp6.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index ed2f061b8768..dc4251655df9 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -808,6 +808,11 @@ int esp6_input_done2(struct sk_buff *skb, int err)
>  		struct tcphdr *th;
>  
>  		offset = ipv6_skip_exthdr(skb, offset, &nexthdr, &frag_off);
> +
> +		if (offset < 0)
> +			err = -EINVAL;
> +			goto out;
> +

Oh, and, this needs { }s. The CI noticed too:
https://patchwork.kernel.org/project/netdevbpf/patch/20211117181610.2731938-1-jordy@pwning.systems/

>  		uh = (void *)(skb->data + offset);
>  		th = (void *)(skb->data + offset);
>  		hdr_len += offset;
> -- 
> 2.27.0
> 

-- 
Kees Cook
