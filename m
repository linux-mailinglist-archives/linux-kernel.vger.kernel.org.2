Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF03CCCAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhGSDdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233720AbhGSDdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626665420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8AXAqR0AohBpEbwcmGVsNxBi5Kp7RTSu2ilJlIpwRU=;
        b=KwbDYVgiE4QcbZ74wwzoy94+mnY5JGwJ00giQ1JLtZEJl/xtpBckEPenD5SirZ8p7RYu6h
        FrJxbUIZ2SLr8PgIi93b1uNr7lxuy4zPAcH2TtGntKHRucT969gA2miHm3FRba1qFX1LDs
        0GZHDiK9Bx0458HT+MyHwig6ZXP+/v0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-iS6hIbGuO5Sg7UoxuOYqHA-1; Sun, 18 Jul 2021 23:30:19 -0400
X-MC-Unique: iS6hIbGuO5Sg7UoxuOYqHA-1
Received: by mail-pf1-f197.google.com with SMTP id i1-20020aa78d810000b02903414cf39ec3so3384594pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 20:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/8AXAqR0AohBpEbwcmGVsNxBi5Kp7RTSu2ilJlIpwRU=;
        b=tlkqnoFGhhKkWofBgxHBNn3Yv79HM9Gf/Hjm5bxF2yGxuXuJ+/ZzqecA9M9J+/d3t4
         pwMmhIthqvZ1DOzkAUxxyxsLUUpBNaPX+ZTEKLamlsRxtM6s5nC/JDB32Ih6z1lGlCjA
         BnOkU83gcJTwaiWvmbSzETjTuhL/jIiGS7Kx36IWl0t5UBR2KSHT0EapuMnarJprC8fW
         JPcAfmS9CMGpNvYBOLCrPEUYNP+oJWQMxnQfHnp/yXYbHm2K6jdwdZElEWRysLh+xXab
         UsONb5a3pSJG+xzqF5Rq3eaJKdKTc4OB7Q3m7r+KR820rMgd/bZ5Vg+HXGeuir4x23L8
         wBgA==
X-Gm-Message-State: AOAM530S/+mOGHtfQSl9VlyTP9QBBkV1rFZeJGxKbxSnM5PsIf6eUQRj
        2KJ2+s6HowbfLi6HfaEOiy7SXrRM8O2HKpBt8y3rZGM7NUPZkviTdG5EsYPpj4u7K+ZFsZ/wbf9
        JHWPJ12oHU/k0N62i/5W/l4swjHRml6bWz1Ssg1PmHnJRYNH1iQKYr6tQYKK9N4Vy9Cj3ypUD34
        Nn
X-Received: by 2002:aa7:8749:0:b029:2f1:3dd0:674 with SMTP id g9-20020aa787490000b02902f13dd00674mr23860569pfo.65.1626665418083;
        Sun, 18 Jul 2021 20:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD4b232b49HdYW9qUVvO5iv20zE2ujVm/gOCoi/jEoPMtqfZc0iUMGhKioUYZZPFxG721zzg==
X-Received: by 2002:aa7:8749:0:b029:2f1:3dd0:674 with SMTP id g9-20020aa787490000b02902f13dd00674mr23860547pfo.65.1626665417809;
        Sun, 18 Jul 2021 20:30:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u20sm4356864pjx.31.2021.07.18.20.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 20:30:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] vhost-vdpa: Fix integer overflow in
 vhost_vdpa_process_iotlb_update()
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210716102239.96-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b6c93e88-0ba2-d07e-2597-e6935ab8de18@redhat.com>
Date:   Mon, 19 Jul 2021 11:30:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716102239.96-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/16 ÏÂÎç6:22, Xie Yongji Ð´µÀ:
> The "msg->iova + msg->size" addition can have an integer overflow
> if the iotlb message is from a malicious user space application.
> So let's fix it.
>
> Fixes: 1b48dc03e575 ("vhost: vdpa: report iova range")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vhost/vdpa.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 210ab35a7ebf..8e3c8790d493 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -615,6 +615,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   	int ret = 0;
>   
>   	if (msg->iova < v->range.first ||
> +	    msg->iova - 1 > U64_MAX - msg->size ||
>   	    msg->iova + msg->size - 1 > v->range.last)
>   		return -EINVAL;
>   

