Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EFE3EB991
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhHMPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbhHMPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:54:17 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD0C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:53:51 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id js7so5446651qvb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CwihxQvLtJhhIw8oFBGmVElpiNeOrquat4Xu9F0jAOg=;
        b=UobTjhUsdatqGjnwoy+XW7bcjQSD/T9CvT2bXzZDpMrL2ktB4pTVorEnfKGLiRVdsd
         SaCfPQUapfOVtf/dnRmTOERUsFeylckFCTl+VqV+5VK9Jk1l5lUG8GC3BbBtEvOGembA
         kCJ7V2LGik3JBVB5ag0re4REBTCXwxQpA6QyEy4WncXKDBkKjtXaIuMcE9/kNug6sx5O
         o2vYbmZZBOEW8v0h5xcAO45+OPC8p4EDjc17/i3oqbbgC583wR+6AtFLGKJJ4anAlcJY
         r4Ovg9Tg0l+YDPYnACSdAvADw1B1vrJYG/7WPco/q7rLwaVrVuCFB3Kk/drhiwO5SOZH
         CmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CwihxQvLtJhhIw8oFBGmVElpiNeOrquat4Xu9F0jAOg=;
        b=g2Z5IqDcpbOE+39bRBRJKQJjIf/CgSivpCFLnRPHxC2w1FwRg5kNBC/14VoJM+Hids
         gymJZyAIBB9EUWhiDYl0wf0z64c4L3KnyfzNDYjHvgkpp4nB/7ftf63S9GEue5kN2C34
         HIevJDYWNQn67Z3EMjEtnLscM+dUclyEVHjt6IZevrJ1dfqa5urG66BmkHsin5k8UNhA
         Db1lsk06qeQuHHr5TL7BIGcPCBjXtU2ahAswa3PAiWGXD06B7Mlsh+jfO9eyU8tRxUXP
         cjYrLa7T5A2ADpAz5Zfu+QmsKczjzZ+j3Qm2c76lGqPmnwqPvDdppfcYjl7iCs+fZdEe
         OWug==
X-Gm-Message-State: AOAM532Wybm2E29/rfTnQkJeuICoIXPLu2h5LqxDsyFTLfKCWSey0AhR
        +OI/hfl7p92ZYHgapn6kRmX69Q==
X-Google-Smtp-Source: ABdhPJyYmLSrD3vLL1+cF8UUwaEG2k11P+wOic5kAZmLdn06ptIPRaFjlYyvsipkypN3if7BppYm7A==
X-Received: by 2002:a0c:ef84:: with SMTP id w4mr3256725qvr.34.1628870030094;
        Fri, 13 Aug 2021 08:53:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q26sm1141166qki.120.2021.08.13.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 08:53:49 -0700 (PDT)
Subject: Re: [PATCH -next v3] nbd: add the check to prevent overflow in
 __nbd_ioctl()
To:     Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     patchwork@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20210804021212.990223-1-libaokun1@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <49104529-74e4-27ed-945f-75e04c1b5968@toxicpanda.com>
Date:   Fri, 13 Aug 2021 11:53:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210804021212.990223-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 10:12 PM, Baokun Li wrote:
> If user specify a large enough value of NBD blocks option, it may trigger
> signed integer overflow which may lead to nbd->config->bytesize becomes a
> large or small value, zero in particular.
> 
> UBSAN: Undefined behaviour in drivers/block/nbd.c:325:31
> signed integer overflow:
> 1024 * 4611686155866341414 cannot be represented in type 'long long int'
> [...]
> Call trace:
> [...]
>   handle_overflow+0x188/0x1dc lib/ubsan.c:192
>   __ubsan_handle_mul_overflow+0x34/0x44 lib/ubsan.c:213
>   nbd_size_set drivers/block/nbd.c:325 [inline]
>   __nbd_ioctl drivers/block/nbd.c:1342 [inline]
>   nbd_ioctl+0x998/0xa10 drivers/block/nbd.c:1395
>   __blkdev_driver_ioctl block/ioctl.c:311 [inline]
> [...]
> 
> Although it is not a big deal, still silence the UBSAN by limit
> the input value.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Use check_mul_overflow().
> V2->V3:
> 	The check_mul_overflow function requires the same input parameter type.
> 
>   drivers/block/nbd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c38317979f74..5a42b838d26c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1384,6 +1384,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   		       unsigned int cmd, unsigned long arg)
>   {
>   	struct nbd_config *config = nbd->config;
> +	loff_t bytesize;
>   
>   	switch (cmd) {
>   	case NBD_DISCONNECT:
> @@ -1398,8 +1399,11 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   	case NBD_SET_SIZE:
>   		return nbd_set_size(nbd, arg, config->blksize);
>   	case NBD_SET_SIZE_BLOCKS:
> -		return nbd_set_size(nbd, arg * config->blksize,
> -				    config->blksize);
> +		if (unlikely(check_mul_overflow((loff_t)arg,
> +						config->blksize,
> +						&bytesize)))
> +			return -EINVAL;
> +		return nbd_set_size(nbd, bytesize, config->blksize);

The unlikely isn't needed here, just makes it harder to read the thing, drop it 
and then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
