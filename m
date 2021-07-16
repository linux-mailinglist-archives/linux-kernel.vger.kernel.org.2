Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EDA3CB788
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhGPM4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232757AbhGPM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626440028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPTvg/IdQ5a8q1Cw2aONE7wqYd41qCqeyO8lI1tAOio=;
        b=Aki8yLEkr7NTZkRBvMqCtGIL05++in5lb1I9bWKic0jM6QOechHWiICFwzrAyJXqzqrJq9
        NcNprWTqF2AS2uieRGlfdb4Jx8jevZqac6O8+MgZa48o5/chWMYBhV8SxJ3RpCrvL6I6W4
        XK9xiWHIjA3jAYzZk1srFgwOJVOkUyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-fFSt400nMzmEUDWFFMy0rA-1; Fri, 16 Jul 2021 08:53:45 -0400
X-MC-Unique: fFSt400nMzmEUDWFFMy0rA-1
Received: by mail-wr1-f72.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so4794006wrc.20
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZPTvg/IdQ5a8q1Cw2aONE7wqYd41qCqeyO8lI1tAOio=;
        b=NIgopcLZ1KaHCEOYSJL2rpw4DaYbVa2287WROoh+GMG/IJme/mlUPnGqThA1nS/XbD
         ny2SwLKSEQ5McaxSAkcavAq8QhXNCC1QWrzrpkp7pZ4Vrqc09bcrzSlNnv0gtFLowRLE
         65sODkEK/RqWVcSYXPpIFlxWiHg1v1rcs3IQRGIm1uoanIS13tgVVzQH6X84S1+F5vwl
         aahwTONQWeC+qEwrUxLrbXW2jUamNlJsX5OiDPF8MzGv8Immg8gQ9b7L/X1fT5g0iqOk
         R0tKYuw8XsAZU/nxfrHN+pEI0r8bij0ZLUWep59XuiUfFqs/V5AHfkT8I+CqlHH41IDc
         DLYA==
X-Gm-Message-State: AOAM531n2aTelmpaoQeboBvF70/V3kJ50OPkis7w9yxwSJa+18gZqjkx
        Qy7+KjW7XktjFyHqRLMgdLDTtTEYo0f3j0OrxjtzRzqEw6lhBQNt29SnMzoX14iXgFe4e4V5S/n
        KTyCzYRQ+TBXU57irOXGj0h+Mrw0nb2OGgGl5R22/kjwoiMWciR3K3o8sP/1R6izKWXheeqJH
X-Received: by 2002:a5d:428d:: with SMTP id k13mr12290466wrq.269.1626440023983;
        Fri, 16 Jul 2021 05:53:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6BW5q2g15VlrWMWnSGVnKtR76dMaQz5P9c1z3WEUts29V8IRrZ432wuNnnmC9NNxuPsb/EQ==
X-Received: by 2002:a5d:428d:: with SMTP id k13mr12290445wrq.269.1626440023790;
        Fri, 16 Jul 2021 05:53:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
        by smtp.gmail.com with ESMTPSA id z16sm9867946wrh.58.2021.07.16.05.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 05:53:42 -0700 (PDT)
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To:     tianxianting <xianting.tian@linux.alibaba.com>,
        Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <95d7f688-79fc-05dc-87ca-da46e0179f0e@redhat.com>
Date:   Fri, 16 Jul 2021 14:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.21 14:46, tianxianting wrote:
> Do you interest in this patch? just little improvment:)

I am, especially when I'm cc'ed and aware of it ;)

Reviewed-by: David Hildenbrand <david@redhat.com>

One nit below

> 
> ÔÚ 2021/7/13 ÏÂÎç11:38, Xianting Tian Ð´µÀ:
>> From: Xianting Tian <xianting.tian@linux.alibaba.com>
>>
>> Use the helper virtio_find_vqs().
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>    drivers/virtio/virtio_balloon.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 510e931..18e0bf3 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -531,8 +531,8 @@ static int init_vqs(struct virtio_balloon *vb)
>>    		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
>>    	}
>>    
>> -	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>> -					 vqs, callbacks, names, NULL, NULL);
>> +	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>> +				callbacks, names, NULL);
				^
we tend to indent this such that it is aligned with the line above (see 
the old code), unless the code becomes unreadable


-- 
Thanks,

David / dhildenb

