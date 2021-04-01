Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BEF351DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhDASbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbhDASJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:09:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53926C05BD1F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:01:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so2746193ejj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKucwrvqnS4ht56NCdJBx9ixTsgm/R5Veio9TkNchd4=;
        b=vU5K+nMRwdzl1ovjDPA/LcNRYNCAK+kL3SOr5YE4ZFIgc2bgUQofJFw3K1pi8nCj/F
         5usKW5GoZ19gPKAuTc49VuOwyGi9u6ao6UbCdpVYGc8F47h7ELB+tD3TQoQkuA3O47kL
         x5OYsOLIzkX4tHnmQeQ3RgiVrNCzpxsF8l0Ic1GwaYD8SKOL1TKHFvfv1j+ECET85lun
         jxTE3qQy0/4whF7B8RWXot/WDWrAVWXsMSJ44NrXCRFULgLQr/d4rgfoQDYEtvVrLIqg
         wTF6OpHP7wxFFCort23WIr1aqPZn2bnlUQItRt4/H/fy3oA0cC4dnETDFnatvlS6u7rS
         rEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKucwrvqnS4ht56NCdJBx9ixTsgm/R5Veio9TkNchd4=;
        b=GpioRyXOgUL/lq4mvRGnflDlgu7qZU91RComkku8wXLxRK570pZsfJxALIVwPoeJGs
         +I0bhgSDuJBCNUgRMivRDzqPHsQUsg9XhpnyK0yjQxpwDzzXHV49aSO9OBwYUJe8dqof
         H5E704nlFpCtGCj2AjhWRLStzHvzCMeYWNRAFNDVOpI7IAsh1T+n5QjKcpBGX4EiNAax
         SYBYWD5ZxbpzTUF5Taj6mPmD5irlq/1vE0MmlFjUA3Np5RIZn7UBxJzqEkilben+vtyu
         w42d3aZ2K+jQ0i2LNqSfIHk0gVGZLUqkbJ73++XlVbIj+LBiFsQeQvo9kX5JAvJRIdik
         GMaQ==
X-Gm-Message-State: AOAM533IQO6msAs5zPcBJw2Qmm+1OwI5jDWzFGWCMB9LnNfhkktZGXuM
        tE6Y2FdZSaKDikuaXp1wKarguVqPG4sNixb+y7A=
X-Google-Smtp-Source: ABdhPJw0Q0FmAEQV3rWyMyG72YjzxQat9aGGgn5eiai9dSLSwA7qAsnC7lnjcZuTYBRQB3d8XNHq0Q==
X-Received: by 2002:a17:907:7683:: with SMTP id jv3mr8912633ejc.450.1617282082032;
        Thu, 01 Apr 2021 06:01:22 -0700 (PDT)
Received: from linux.fritz.box (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id k12sm3467494edo.50.2021.04.01.06.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:01:21 -0700 (PDT)
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix a use after free in
 get_initial_state
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
References: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Message-ID: <cb0f43e4-bfde-ac77-5153-f2f3cbed0172@linbit.com>
Date:   Thu, 1 Apr 2021 15:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 1:57 PM, Lv Yunlong wrote:
> In get_initial_state, it calls notify_initial_state_done(skb,..) if
> cb->args[5]==1. I see that if genlmsg_put() failed in
> notify_initial_state_done(), the skb will be freed by nlmsg_free(skb).
> Then get_initial_state will goto out and the freed skb will be used by
> return value skb->len.
> 
> My patch lets skb_len = skb->len and return the skb_len to avoid the uaf.
> 
> Fixes: a29728463b254 ("drbd: Backport the "events2" command")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   drivers/block/drbd/drbd_nl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index bf7de4c7b96c..474f84675d0a 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -4905,6 +4905,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>   	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
>   	unsigned int seq = cb->args[2];
>   	unsigned int n;
> +	unsigned int skb_len = skb->len;
>   	enum drbd_notification_type flags = 0;
>   
>   	/* There is no need for taking notification_mutex here: it doesn't
> @@ -4915,7 +4916,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>   	cb->args[5]--;
>   	if (cb->args[5] == 1) {
>   		notify_initial_state_done(skb, seq);
> -		goto out;
> +		return skb_len;
>   	}
>   	n = cb->args[4]++;
>   	if (cb->args[4] < cb->args[3])
> 

Thanks for the patch!

I think the problem goes even further: skb can also be freed in the 
notify_*_state_change -> notify_*_state calls below.

Also, at the point where we save skb->len into skb_len, skb is not 
initialized yet. Maybe it makes more sense to not return a length in the 
first place here, but an error code instead.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
