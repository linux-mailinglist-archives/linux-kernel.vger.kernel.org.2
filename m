Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E124A39D2F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFGCck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 22:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhFGCcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623033048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ftWrDjAuGgns7tUZfM+YwyaEY5gWcXUeAuYMi5CEq8=;
        b=T8RxK0R0BA8Dbi/iLiBiOkZICfbo4Pl3oM8C17mGftu7sBOy4l1l9XCw7/IgYiyxrQ/+us
        OUURzgjucmETsL5Veo4XDh2TbCyXPopPn4iUhenD6+757yT1xOquhRcWowOsweAqbYCoCn
        AlCdzLuIbs3u1oBMUqJHh6XpGIZtLdI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-wvDwjlmYNZGH-gprI30obw-1; Sun, 06 Jun 2021 22:30:48 -0400
X-MC-Unique: wvDwjlmYNZGH-gprI30obw-1
Received: by mail-pf1-f200.google.com with SMTP id g19-20020a62e3130000b02902effdaa4a3eso407630pfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 19:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5ftWrDjAuGgns7tUZfM+YwyaEY5gWcXUeAuYMi5CEq8=;
        b=tRCjRpIOU3oiLHjUmoK7on56ySzIUrsI6ytkwEv/5VEW6R1eCbOhX+NuRvEViqB7fu
         kibih6X2NJltDUK9cl45x+E29ul5gFC49IkAV3YHxk/4feKarOIMyx0frliZLWM4JroM
         nDLKZECJ8P5DtXzDMG1M+x+itsSd81xg+VkSAYCVPD1AiLl9kaNwfqwYMll7R5V6EIZb
         IJ/7l9rckrHly8x+KLQ8eEOzZz2F555zzGUXXpHF2cxzY5OCaBBCn7oCco2zAJkw38mO
         rcqF+LkIcdlj9mDRFbtOqAw7ucOzoh7mD0HnXStE+J5qEiiZijrTEtkYUioz0PUo/Qjp
         HsJQ==
X-Gm-Message-State: AOAM531T55SM80bfd5XDtLE7sCECkGzWSVV8iIo2iZw/2lLh6B422Fsc
        /jMS8nBz2YiSqO4tP1njT98ovJ6vXxd0ootG6RV6ybW1QATexDzADUZVUMCn9O80Ij/DBselUAC
        Ja6Rodx8/S25ibztfHBjUNM/Xlkz8Kzeklo+SCSC1HqXqvqBzfCGxpDI9v+8WIIJ3zdm6y6mmaO
        +q
X-Received: by 2002:a05:6a00:170c:b029:2dc:dd8f:e083 with SMTP id h12-20020a056a00170cb02902dcdd8fe083mr15154724pfc.77.1623033046703;
        Sun, 06 Jun 2021 19:30:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3i3jp5UZ+sihlmmmhsN8MN3sAd9Mve6Tji2AE1KYNIrhOf3yqoIXUSS+q4NoskX2roAUfCw==
X-Received: by 2002:a05:6a00:170c:b029:2dc:dd8f:e083 with SMTP id h12-20020a056a00170cb02902dcdd8fe083mr15154699pfc.77.1623033046395;
        Sun, 06 Jun 2021 19:30:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o16sm6639326pfu.75.2021.06.06.19.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 19:30:45 -0700 (PDT)
Subject: Re: [PATCH] vdp/mlx5: Fix setting the correct dma_device
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210603112215.69259-1-elic@nvidia.com>
 <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com> <YLpNc5WsBWQ5f4cl@unreal>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c083f4b2-aa0a-ad3c-7a16-fe1c7dbda92d@redhat.com>
Date:   Mon, 7 Jun 2021 10:30:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLpNc5WsBWQ5f4cl@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/4 下午11:57, Leon Romanovsky 写道:
> On Fri, Jun 04, 2021 at 10:35:59AM +0800, Jason Wang wrote:
>> 在 2021/6/3 下午7:22, Eli Cohen 写道:
>>> Before SF support was introduced, the DMA device was equal to
>>> mdev->device which was in essence equal to pdev->dev;
>>> With SF introduction this is no longer true. It has already been
>>> handled for vhost_vdpa since the reference to the dma device can from
>>> within mlx5_vdpa. With virtio_vdpa this broke. To fix this we set the
>>> real dma device when initializing the device.
>>>
>>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>>
>> Note sure this is correct, according to the commit log it should be the
>> patch that introduces the SF or aux bus support for vDPA.
> Where did you see that?
>
> git log -p drivers/vdpa/mlx5/net/mlx5_vnet.c
>
> ...
> +       mvdev->vdev.dma_dev = mdev->device;
> +       err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> ...
>   comes from commit 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")


If I read the commit log and code correctly:

"

With SF introduction this is no longer true.

"

It works before SF is introduced.

Thanks


>
> Thanks
>
>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>
>> Patch looks correct.
>>
>> Thanks
>>
>>
>>> ---
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index bc33f2c523d3..a4ff158181e0 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -2046,7 +2046,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>>>    	if (err)
>>>    		goto err_mtu;
>>> -	mvdev->vdev.dma_dev = mdev->device;
>>> +	mvdev->vdev.dma_dev = &mdev->pdev->dev;
>>>    	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>>>    	if (err)
>>>    		goto err_mtu;
>> _______________________________________________
>> Virtualization mailing list
>> Virtualization@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

