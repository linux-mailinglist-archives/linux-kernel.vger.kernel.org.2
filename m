Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8408D3F44E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhHWGZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234421AbhHWGZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629699898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTBmg72UzrJzwwgyL0XX6MmGnq4XiN30FwOUg0WyeL8=;
        b=FP2I2eF6Vxj4C/mxETXrKldB7G93JIfxP2rg+iQuY6zkP7hxPWMnt/LYHoLJPesp5185TT
        2M2WmoRjIDg1DTPRbPilW/A8x+plT6ZweSyMVBOdwaOXI8PutPBFnfXl31D/yohln3perb
        4DnkMDSyWr8ktMsfO1ZigPp2uOdA4bU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-UK1_s7UUMjOPvnQi5NEp8w-1; Mon, 23 Aug 2021 02:24:56 -0400
X-MC-Unique: UK1_s7UUMjOPvnQi5NEp8w-1
Received: by mail-pg1-f197.google.com with SMTP id u3-20020a6323430000b029023ba96595fdso9814069pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fTBmg72UzrJzwwgyL0XX6MmGnq4XiN30FwOUg0WyeL8=;
        b=daZSY6KbrDMQA1U6bROHYFLIZr/6fxA0jeh7g6oOWxqdHoQHJBX0dpYKTeYa03UyEb
         WT8h8x3R6HXzkdS3Zz1Wl+IJnI7gIwiEGSRqFCKjmthaLGip/BytRN+z+reWXVoWfojD
         WX6Pz0dEJs4OlA8PHdyQ/d5uJ/9ZoRrowB0uM3/b4dMfrp7YXTw/gx2qzbHF1kFZZdwz
         AoG3HfPWWbQhmIf5IqAGLFT3rd5n89P2WHpa8S1Ze2gphsvQd4V7JthCTnMxNVzTNJ+8
         Pez1+5xv3nsSm2C0wm1qmXccjxjuQUGHZNVmmEsBuqswQmXgkyvt8vfDB8MjKrcmFsl5
         PNEg==
X-Gm-Message-State: AOAM532ZBknNSOxF9HUfCEHj2LGL31n6nSUcWjKH/Chb1kzhPUxO/Rti
        S6ZZt8sSkG4oYfzOkHCTy1UcjAhyaOaBSk0zBc2Zl5Shblfaanx+xMXl3h0IWxwaRjnZJkkGx+C
        59+mC+JkzcWMfvuhC+T2urgLWerMCF3sp6pRe8WnEsSiojoSfjEI4HPCSiTwF6F4aGgNGRccO0n
        u5
X-Received: by 2002:a17:90a:b016:: with SMTP id x22mr7315328pjq.205.1629699895523;
        Sun, 22 Aug 2021 23:24:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYnrO75usjjlrGCgZzdsLDtPE2dKORuqu4cQ6/SLHByjgTAawINCsTeerUMEDWc0TN8ooDAw==
X-Received: by 2002:a17:90a:b016:: with SMTP id x22mr7315281pjq.205.1629699895193;
        Sun, 22 Aug 2021 23:24:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g3sm14314416pfi.197.2021.08.22.23.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:24:54 -0700 (PDT)
Subject: Re: [PATCH v11 01/12] iova: Export alloc_iova_fast() and
 free_iova_fast()
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3ff77bab-8bb7-ae5b-4cf1-a90ebcc00118@redhat.com>
Date:   Mon, 23 Aug 2021 14:24:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-2-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/8/18 ÏÂÎç8:06, Xie Yongji Ð´µÀ:
> Export alloc_iova_fast() and free_iova_fast() so that
> some modules can make use of the per-CPU cache to get
> rid of rbtree spinlock in alloc_iova() and free_iova()
> during IOVA allocation.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>

(If we need respin, I'd suggest to put the numbers you measured here)

Thanks


> ---
>   drivers/iommu/iova.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b6cf5f16123b..3941ed6bb99b 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -521,6 +521,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   
>   	return new_iova->pfn_lo;
>   }
> +EXPORT_SYMBOL_GPL(alloc_iova_fast);
>   
>   /**
>    * free_iova_fast - free iova pfn range into rcache
> @@ -538,6 +539,7 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
>   
>   	free_iova(iovad, pfn);
>   }
> +EXPORT_SYMBOL_GPL(free_iova_fast);
>   
>   #define fq_ring_for_each(i, fq) \
>   	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)

