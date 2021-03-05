Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286A132F2B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCESfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCEScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:32:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DE4C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 10:32:06 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id g9so2891567ilc.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xyYvWN9CdVcGaizLmclP8f/7E1L76lIbSbn9tpFjonE=;
        b=EwU19WKQglB4fj5XTujhitA2tx0OM+SV2CtSd0dTsvxj242jTHXwQEnoyhojxAHuLF
         wQphFkNayBbDddUcmcV8AS+CEBW5kufh+/uskGY1SgMGn5QajykCczcK7wrRrnWTHIwc
         ApbBhL9hJ8pVHRf08MgqKUCxENI1zFCq3l39CvSZCmGwb/eaGOdUG5xaVWIYLgcgLaHS
         LHaDO2zSBJQ29tN2YLt8ImI0XrtTbYm3s8rta7nVweOP3DV9GugyHdsM11ipF/CDAqAj
         IB/1FGaXOmwQ59+5rFOi4dZS674MODhcLakAafqYCNxAkcTdQ1ERhBz7WHigzTh+FYQh
         lTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xyYvWN9CdVcGaizLmclP8f/7E1L76lIbSbn9tpFjonE=;
        b=qeEg3eEkPg6wcVHt94KKcAptWlkDyGZZe1sBMttjpjddXXoZdnRAQz6H5enCpCPaIV
         0RKBlyji0aE9bd00uaRZNUTmvW8eLi8RQO0yYaFGBH+mksioBt1PHeUSGnCzxxMPdip1
         6HESIe42AOjkApIkKqV9Hc9Hik9s4xTjDXfrWCUJWWXx3QMJsDa2E6LsUd7/J2FazBsC
         vVhGmHZzJqjqdbRUUwnoRPREYBhQiPF1SPUjYTQHvWt1lbV8f5DLCGDHNlZpbs3V5jh+
         29i1OkvR9VbegoGZWJypDHrPx9GW3OTggiPKOc2SZBc3JmUV5hzdA7XzdaZl7Lap8Wsx
         LTtg==
X-Gm-Message-State: AOAM5307u7JHDaulUVkhDoc0beUR6I4rkikDpRE16/UEVm0jiJByZsG1
        euxS4clBTXFaVbLLlv2nxv0hkA==
X-Google-Smtp-Source: ABdhPJxm+EZVrr7eQOOci/buzkKSaRKVj7cA3NiT34F6vl0PFTL1OxMsiOrSYOfkrtaXCYWDt7kP9Q==
X-Received: by 2002:a05:6e02:506:: with SMTP id d6mr10155780ils.150.1614969125837;
        Fri, 05 Mar 2021 10:32:05 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l16sm1704564ils.11.2021.03.05.10.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 10:32:05 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: Fix the recursive blkg rwstat
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org
References: <1614932007-97224-1-git-send-email-xlpang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4cc104d1-9aa3-a838-b786-9a808dd85945@kernel.dk>
Date:   Fri, 5 Mar 2021 11:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614932007-97224-1-git-send-email-xlpang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/21 1:13 AM, Xunlei Pang wrote:
> The current blkio.throttle.io_service_bytes_recursive doesn't
> work correctly.
> 
> As an example, for the following blkcg hierarchy:
>  (Made 1GB READ in test1, 512MB READ in test2)
>      test
>     /    \
>  test1   test2
> 
> $ head -n 1 test/test1/blkio.throttle.io_service_bytes_recursive
> 8:0 Read 1073684480
> $ head -n 1 test/test2/blkio.throttle.io_service_bytes_recursive
> 8:0 Read 537448448
> $ head -n 1 test/blkio.throttle.io_service_bytes_recursive
> 8:0 Read 537448448
> 
> Clearly, above data of "test" reflects "test2" not "test1"+"test2".
> 
> Do the correct summary in blkg_rwstat_recursive_sum().

LGTM, Tejun?

> 
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  block/blk-cgroup-rwstat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
> index 85d5790..3304e84 100644
> --- a/block/blk-cgroup-rwstat.c
> +++ b/block/blk-cgroup-rwstat.c
> @@ -109,6 +109,7 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
>  
>  	lockdep_assert_held(&blkg->q->queue_lock);
>  
> +	memset(sum, 0, sizeof(*sum));
>  	rcu_read_lock();
>  	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
>  		struct blkg_rwstat *rwstat;
> @@ -122,7 +123,7 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
>  			rwstat = (void *)pos_blkg + off;
>  
>  		for (i = 0; i < BLKG_RWSTAT_NR; i++)
> -			sum->cnt[i] = blkg_rwstat_read_counter(rwstat, i);
> +			sum->cnt[i] += blkg_rwstat_read_counter(rwstat, i);
>  	}
>  	rcu_read_unlock();
>  }
> 


-- 
Jens Axboe

