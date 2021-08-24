Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26AE3F5F33
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhHXNdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhHXNdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629811967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeV74JQJHRoEmeq7H6kmk/7VDFwFpt82W+iJfSrcr/0=;
        b=dI2EdCmDUHfLegT7gE2mirTT4JS1N/wZjyfD3GVXwNAN9eaFKMwqMcj1hmV/50knpBiZ2g
        /ESdT/mNx2+hRPhGcaMFG1p7BMqNSgmHDxf2srr5YX0az+RRIoYMd01f5xdzczzNMI72Sy
        5hA39ROmWZE2QQPeHc2POvCHYHgS4ew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-4nvEhA47PoC62Gve1t20fA-1; Tue, 24 Aug 2021 09:32:43 -0400
X-MC-Unique: 4nvEhA47PoC62Gve1t20fA-1
Received: by mail-wr1-f71.google.com with SMTP id n10-20020a5d660a0000b02901551ef5616eso5749890wru.20
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QeV74JQJHRoEmeq7H6kmk/7VDFwFpt82W+iJfSrcr/0=;
        b=T5VJJ9ADfinacGNyOcFobj+dqxy7VByCf9V2zF5jn3fOctiq3xdPKvE/0J94Ttnu/B
         Ent64r6zGgj3ObAqFh6ajkdp3E9Uo8Ho1coB7VLAxdls1AFjPOeQ5Iy82OKoGqihApYl
         3ThcZ3q0tKxGCSftmKTBBehvu9o82sU3NG1tIpJ07/MwbnYdRwLD0BRkt/NY5O46QLon
         TjsnBl/aUZLxfg+EFrYTiYOYQY2iMEZwl/HD+lr7NjoIgb84xG2bD/RXhiJvSqfYsZpw
         M6uMPCDNaKhdbU+A108/PX3CR8IeRfS+G0OyPrbpyNPDYnYAEUGluefJhVZR+jlIf+Go
         3gKw==
X-Gm-Message-State: AOAM5305PV0iBtcRglnRJsSwDjhLaByijsObg1wa2E2x5eGF0EX4cx2n
        lcTHLrZncdf3pkrszXvuQ2Udzna5uSXQDLuZyeqorygZxuaO878qeqJEEMRgradCP6zoHVuL9Hb
        hTixgl35vnFUxLbt4aC3PHLDi
X-Received: by 2002:a1c:9acc:: with SMTP id c195mr4245400wme.69.1629811962647;
        Tue, 24 Aug 2021 06:32:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJOUQhZGHcg+h797DWQJpPSgDrZrkLJZOaYSjluUYhh54hujkxG8C8Pjz+eoTss4z6d9NpTg==
X-Received: by 2002:a1c:9acc:: with SMTP id c195mr4245358wme.69.1629811962408;
        Tue, 24 Aug 2021 06:32:42 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id z7sm2316517wmi.4.2021.08.24.06.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 06:32:42 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jason Xing <xingwanli@kuaishou.com>,
        Shujin Li <lishujin@kuaishou.com>,
        =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Subject: Re: [PATCH] ixgbe: let the xdpdrv work with more than 64 cpus
To:     kerneljasonxing@gmail.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org
References: <20210824104918.7930-1-kerneljasonxing@gmail.com>
Message-ID: <59dff551-2d52-5ecc-14ac-4a6ada5b1275@redhat.com>
Date:   Tue, 24 Aug 2021 15:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824104918.7930-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/08/2021 12.49, kerneljasonxing@gmail.com wrote:
> From: Jason Xing <xingwanli@kuaishou.com>
> 
> Originally, ixgbe driver doesn't allow the mounting of xdpdrv if the
> server is equipped with more than 64 cpus online. So it turns out that
> the loading of xdpdrv causes the "NOMEM" failure.
> 
> Actually, we can adjust the algorithm and then make it work, which has
> no harm at all, only if we set the maxmium number of xdp queues.

This is not true, it can cause harm, because XDP transmission queues are 
used without locking. See drivers ndo_xdp_xmit function ixgbe_xdp_xmit().
As driver assumption is that each CPU have its own XDP TX-queue.

This patch is not a proper fix.

I do think we need a proper fix for this issue on ixgbe.


> Fixes: 33fdc82f08 ("ixgbe: add support for XDP_TX action")
> Co-developed-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  | 2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> index 0218f6c..5953996 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> @@ -299,7 +299,7 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
>   
>   static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
>   {
> -	return adapter->xdp_prog ? nr_cpu_ids : 0;
> +	return adapter->xdp_prog ? min_t(int, MAX_XDP_QUEUES, nr_cpu_ids) : 0;
>   }
>   
>   #define IXGBE_RSS_64Q_MASK	0x3F
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 14aea40..b36d16b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10130,9 +10130,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>   			return -EINVAL;
>   	}
>   
> -	if (nr_cpu_ids > MAX_XDP_QUEUES)
> -		return -ENOMEM;
> -
>   	old_prog = xchg(&adapter->xdp_prog, prog);
>   	need_reset = (!!prog != !!old_prog);
>   
> 

