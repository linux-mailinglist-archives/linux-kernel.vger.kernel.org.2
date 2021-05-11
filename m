Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1058037A001
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhEKGvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhEKGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620715814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umA1WrHOFiVlBbjKzKntHglDQdg2BgS3oCexgpceoV4=;
        b=C3hZ1C9ZulrWTPUKToIwD6r37MfnNgVc4uCAa4DH0Yenaq2lqYqGxSdTOZ0DjNp7iYuqUR
        p3OigLjZUlG2K1Pm+gVHZMXqRPODIyoydNZlERGKSkhrEKg234Mo7nfTJyNjV4DdqTR1+c
        DeojI2FANWxh6RK9dl+eHvv0pC4gvoQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-KRntNO8cMueaNrSayMngAQ-1; Tue, 11 May 2021 02:50:11 -0400
X-MC-Unique: KRntNO8cMueaNrSayMngAQ-1
Received: by mail-pl1-f197.google.com with SMTP id n18-20020a170902d0d2b02900ed5de16a2dso7132709pln.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 23:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=umA1WrHOFiVlBbjKzKntHglDQdg2BgS3oCexgpceoV4=;
        b=GcFox3kBf981sHfNDWh/nyxat7+qMQ+1bhF1iZNTxUanUxE2th/6tTrAl3t6f1Z8sV
         mOssA2K3dbDvGW9vIEhZtNu1wAX6ZhmW7JGZgnpd7QKmaSEANMu4G0BkxaedmZwovTH4
         FhFKZH0CvsaccFSDJ5oGPI4FWfM8Jr8vafSTzeRsxyNdbKA/WlFWL8s0KHh4nuPRHev3
         HYWxlFeH4GznBVzGhDkdAPKurBxXRiVXQMs834ROGhRhIZ2TcKgEsG4GimIyA3XX9I0q
         56pIdP+Fudf9vqzCa6alawE5HXLpum1WFsx71yXV4Zm0aBJSmCgFShJxdjY/prCxITNe
         f4xQ==
X-Gm-Message-State: AOAM532sXzJZLu+y6vQTqZp0nMaKcCN74x6p5mY1Bp9VSowulkvAWzT1
        teWNe5DpffhASis7co/413rSBumkiiWmj9hvXAEskizygU0hEumAtY+Y39odpn/yA6skY0ajdlL
        DSpi7l314gDqzP6d4KbDPUHxf
X-Received: by 2002:a17:90b:184:: with SMTP id t4mr3416779pjs.223.1620715810243;
        Mon, 10 May 2021 23:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0nIA3fflnZGCrCpbroOw85DYJI2FzsmmyMHTk1Ihc+KFfaCk0aGqGfPaWbSRNEdOwp4oOXg==
X-Received: by 2002:a17:90b:184:: with SMTP id t4mr3416761pjs.223.1620715810062;
        Mon, 10 May 2021 23:50:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j16sm13601256pgh.69.2021.05.10.23.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:50:09 -0700 (PDT)
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To:     Yuri Benditovich <yuri.benditovich@daynix.com>,
        davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
Date:   Tue, 11 May 2021 14:50:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511044253.469034-5-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/11 ÏÂÎç12:42, Yuri Benditovich Ð´µÀ:
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   drivers/net/tun.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 84f832806313..a35054f9d941 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2812,7 +2812,7 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>   			arg &= ~(TUN_F_TSO4|TUN_F_TSO6);
>   		}
>   
> -		arg &= ~TUN_F_UFO;
> +		arg &= ~(TUN_F_UFO|TUN_F_USO);


It looks to me kernel doesn't use "USO", so TUN_F_UDP_GSO_L4 is a better 
name for this and I guess we should toggle NETIF_F_UDP_GSO_l4 here?

And how about macvtap?

Thanks


>   	}
>   
>   	/* This gives the user a way to test for new features in future by

