Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7606932E7C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhCEMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCEMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:19:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529FC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 04:19:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u14so1876452wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 04:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0YBjnh9sRcW5SiNs3e12Ik4FV9ZcvnWgirhrfzXeMbg=;
        b=RNELQySBCYYkbbv0Dq8kJsUVA66c6RVE3zRqU3mGO29wBK0EeUUVd+Dgyu+Kl+BPR7
         Epl3E2sBVP8wAgVVLtIPpVduN4Bw4VMr5ruLM9uv18L2YS960izrRxi1zB0Pqp2aGMAo
         bKEf2JOKYKaWTNhv4cCzyPSNl7TWhaFY9+n1VNev1U+tj/ZZ6vDRKlweQ0TsEbvCBSQk
         96Lv9EHhl+vyRJGp48fDQpP6JBiAHF7Qap7rppNekNrgPpK1P8AWN8sOj8qE8iLnkxcP
         /mXhm/yfNcflyKZ1pGq8diRl9BJhHMTL2+GVW0xHoSIy3UYa9RTi5amAe4UzzOijGe3h
         233Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0YBjnh9sRcW5SiNs3e12Ik4FV9ZcvnWgirhrfzXeMbg=;
        b=c8xFj9cKO5YIbYGNVoKqfCNOVTQyQ2ETUPj0ZD/vqqTiDcMQfIgizvS/yrTRpJ8bsn
         eFpGweo4Ga/dy3pEuoMkIkIomq8GNJKiicfgS9EuxU4x6Ebizbvm+7UuThuCUkbX/EWX
         /HCY7rkyOx/bccToOka7A0yHqeh4yiNCbme2qL5Nhe77C8GdPaabqRMmrrCSQnMNitG9
         9mGUum+hngAJmqOXkcQ2Aa3aBQE+i5B46gPtq1Zv2k0mmjOdiOfhQHAKFB6Fd1gtWPDD
         CTFro0loT/XqyezlwXqRzTcEZNENGxf0zCgnoiDk0UL3JXFHXp2Ka+p5A8QewkvI3U58
         eKew==
X-Gm-Message-State: AOAM5332S3Oovdex5xsfIVy64Q2s5f15btomgGCPtwpSGYqDHJhec5C+
        YyY3zQvZkiLjjjNqaE52H7c0Ww==
X-Google-Smtp-Source: ABdhPJzCO1AQHSr/Rir1FDEysAjCPswJzHXnMpaDagDgQT7WP0KlJxSvPrq6AapamF5qzUkzXdwg+w==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr9429695wrs.98.1614946791306;
        Fri, 05 Mar 2021 04:19:51 -0800 (PST)
Received: from netronome.com ([2001:982:7ed1:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id f22sm4401729wmc.33.2021.03.05.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 04:19:50 -0800 (PST)
Date:   Fri, 5 Mar 2021 13:19:50 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] nfp: Fix fall-through warnings for Clang
Message-ID: <20210305121949.GF8899@netronome.com>
References: <20210305094937.GA141307@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305094937.GA141307@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 03:49:37AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks Gustavo,

this looks good to me.

Acked-by: Simon Horman <simon.horman@netronome.com>

> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
> index b3cabc274121..3b8e675087de 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
> @@ -103,6 +103,7 @@ nfp_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
>  	case NFP_PORT_PF_PORT:
>  	case NFP_PORT_VF_PORT:
>  		nfp_repr_vnic_get_stats64(repr->port, stats);
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 
