Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F723CCCAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhGSDdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233720AbhGSDdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626665451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4thYMEzNgF3AoCRQde59dht0ziPpusYLCABZjd2uI4s=;
        b=OgDC5wZQUf56xcRlQs05aR8IDhy8QeXIyCUKqyuaozDl+VP4aH/gQnpa2mIt9Lqb7jsipQ
        YQ/gr/C/uEotdkkT2p4ocT0FwQr75MWFIBE2oy9Y0GnVm3hFdWvvkPNdqkVCWGvGbg+hMI
        DO20cKqkJYg11XUh1VgBHcOLkLSXQbY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-CW0CqmqeOrCNN6FUnXirkQ-1; Sun, 18 Jul 2021 23:30:50 -0400
X-MC-Unique: CW0CqmqeOrCNN6FUnXirkQ-1
Received: by mail-pg1-f197.google.com with SMTP id u190-20020a6379c70000b029022ceb8c8831so12250019pgc.22
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 20:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4thYMEzNgF3AoCRQde59dht0ziPpusYLCABZjd2uI4s=;
        b=DnqZskCJ2RnB+5F+cLq5RRWhELwMYw2d1Q09HmYdP0VWovcv4uXtJeTaXu1foIybMH
         0a55b9IR5AetjABuZkcFmLQ6uy2xtCUjwp9ze/JCu3GugxCWHNm0KzNauqfQSa4o0SW0
         kOh4L1405T1S4uCyD1MRsgXfcj7swsjYU+vfdm6wrceqEQSEeO1Rky+6lMd2660+uW1q
         z0PL9iebwdp+S6OfXYnWMRZbwQphdBCNZ81hYeE2R6aoaJJk33NvXS7NU1+Ro+byKhyw
         LpQrFgm18MeghxfV9e5xFeZ2lVnJJgB4HGabIGmy2iaZeKst4mgMF+x2FrkYtZJ4Dsny
         qMCA==
X-Gm-Message-State: AOAM533UiJdXjMlehp0L412Bgar2f2sjF8x05fyqailQrtLzVBgvpFHP
        X4rJ++HV6JabLPxHW6dCTqZaHKboaw4PHrE1J5nhlKVgtRdKmrhZDG376DYeOXp0298aMGcqe8V
        FPK+8AGJMIDFq+343TMWBVKiIt/Ae8rAMujMTjTqmcPNWevNdFu8K2EzZ+RQ51pgAD0KE0Kj0qj
        la
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr11831855pjb.51.1626665448924;
        Sun, 18 Jul 2021 20:30:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe6zlZhtmikh9nPja5DIIRB06qSd9L4IveW6TD/qUNVnYqP4YhQrac1LChSjiJDHogpY4xig==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr11831822pjb.51.1626665448660;
        Sun, 18 Jul 2021 20:30:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i1sm17606689pfo.37.2021.07.18.20.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 20:30:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] vhost: Fix the calculation in vhost_overflow()
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210716102239.96-1-xieyongji@bytedance.com>
 <20210716102239.96-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e2d68906-ffa1-4e87-4251-d83ce96a8869@redhat.com>
Date:   Mon, 19 Jul 2021 11:30:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716102239.96-2-xieyongji@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/16 下午6:22, Xie Yongji 写道:
> This fixes the incorrect calculation for integer overflow
> when the last address of iova range is 0xffffffff.
>
> Fixes: ec33d031a14b ("vhost: detect 32 bit integer wrap around“)
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/vhost/vhost.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b9e853e6094d..a9fd1b311d2f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -738,7 +738,8 @@ static bool log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
>   static bool vhost_overflow(u64 uaddr, u64 size)
>   {
>   	/* Make sure 64 bit math will not overflow. */
> -	return uaddr > ULONG_MAX || size > ULONG_MAX || uaddr > ULONG_MAX - size;
> +	return uaddr > ULONG_MAX || size > ULONG_MAX ||
> +	       uaddr - 1 > ULONG_MAX - size;
>   }


Acked-by: Jason Wang <jasowang@redhat.com>


>   
>   /* Caller should have vq mutex and device mutex. */

