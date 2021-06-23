Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2E3B121F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 05:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFWDYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 23:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230130AbhFWDYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624418503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWlbc40C50LijiHCCJzyep6SiSEpW0rDy9NGBjdyYbA=;
        b=YzsQ+FOMReqpGU356oTAH1/5rQrdMSMAXBitL8uvSGfdD6qR5M4Q1pfVSM5myHKne27u1A
        hKT/IeJfLvSOHf5vq7SzmUOsN5JMiN26xV66DToMKT8a9rsppt6SQImtrmvn/hwY0sBeYL
        0BGD8RbBiG6P1uMEzulODS6UYqtFSH8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-mgIy2lUMNHmE3z1KFqz7UQ-1; Tue, 22 Jun 2021 23:21:41 -0400
X-MC-Unique: mgIy2lUMNHmE3z1KFqz7UQ-1
Received: by mail-pj1-f70.google.com with SMTP id b9-20020a17090aa589b029016e99e81994so3028343pjq.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 20:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zWlbc40C50LijiHCCJzyep6SiSEpW0rDy9NGBjdyYbA=;
        b=Z7Gve0Y8vRvsVK66TAHwZ4ncnmTm38S97wfh6UgEepD9Dp5zp0YjMqHTfiKt+R49G5
         lTV8AABqcO9mVCIhEUfIKzFUKmGdz/Sp8fH3QjAWmrFZh33rCHTRRc7EJF7Nx83yGPk9
         uLkys7+4cZNSsvnwCcPRumjNEGSJdqgMOQoW1sg4WuF/zvwLt6GLAmx6Z4ogfu7QWDBx
         W1lO8K7uvQ2fC531X4C/QqFPuGqjKi2krnqCQupPqiyTeagZvueW1f54/kD07cCO6Ax/
         jrB8GzzOgM9QE9PPAxZFkG3P13agI+bfn9FEc3bUvLB2SJm++K1R1SWkxO8zJHtiTNP5
         XRZA==
X-Gm-Message-State: AOAM531w04NyBhvqjPlZ8A46wWKr6fs7+26kk9yimoN8OOHc4GI85OaI
        KbFX3+FVWnTSbt9ERJVQBYH2b6oT/4ETQkM4ckuzU/OjKpTXyyo6oHmX+HrNJg0dqpMW6fFGuG2
        kE9RIX27/RQUdxTHBHJGzJiDA7o3o9PIUsLloGhI1jhZWGhUCjvNtlS0nrC15d0hAdhP9M8KYyy
        Lk
X-Received: by 2002:a17:902:b7c9:b029:122:ee2d:25f1 with SMTP id v9-20020a170902b7c9b0290122ee2d25f1mr18442851plz.14.1624418500670;
        Tue, 22 Jun 2021 20:21:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVf/8m6UPTzEYOWFv8UWW41KD4RglcuNWJjez0EQY1P5pso7Arv0qpZ5oVROBdBY5Sey953g==
X-Received: by 2002:a17:902:b7c9:b029:122:ee2d:25f1 with SMTP id v9-20020a170902b7c9b0290122ee2d25f1mr18442829plz.14.1624418500227;
        Tue, 22 Jun 2021 20:21:40 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y190sm656547pfc.85.2021.06.22.20.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 20:21:39 -0700 (PDT)
Subject: Re: [PATCH] vringh: Use wiov->used to check for read/write desc order
To:     Neeraj Upadhyay <neeraju@codeaurora.org>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1d7f1fb3-b22c-1ca9-0635-be3f14b97c4a@redhat.com>
Date:   Wed, 23 Jun 2021 11:21:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/22 ÏÂÎç7:37, Neeraj Upadhyay Ð´µÀ:
> As iov->used is incremented when descriptors are processed
> in __vringh_iov(), use it to check for incorrect read
> and write descriptor order.
>
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vhost/vringh.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 4af8fa2..14e2043 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -359,7 +359,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
>   			iov = wiov;
>   		else {
>   			iov = riov;
> -			if (unlikely(wiov && wiov->i)) {
> +			if (unlikely(wiov && wiov->used)) {
>   				vringh_bad("Readable desc %p after writable",
>   					   &descs[i]);
>   				err = -EINVAL;

