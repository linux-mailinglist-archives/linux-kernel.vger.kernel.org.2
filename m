Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A903CCCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhGSDtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234345AbhGSDtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626666381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEyDmEDGfoVqfQwfMLAiRArkM1gWSjYzO4Yqw0OZBCs=;
        b=VeLJ8GzqphdMfPDv0yo9h7yhAuuWr8fUR8GO62UUH3Udwb3UgkZZw6C5t2AVRJOu+86LDV
        HAw/XU2bLWDNE5srWWynV3Wo7Eg+PnyL0c6mJhUejgQqB5GkWbTOPW0OBo2BHk+f0YTCTD
        As36mIQkdvIM6yEvCPth1uFO8tcMEPU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-oV6h-1f1PcyHKMjRmEf7AQ-1; Sun, 18 Jul 2021 23:46:20 -0400
X-MC-Unique: oV6h-1f1PcyHKMjRmEf7AQ-1
Received: by mail-pj1-f71.google.com with SMTP id j24-20020a17090a8418b02901756faa6840so2507782pjn.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 20:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yEyDmEDGfoVqfQwfMLAiRArkM1gWSjYzO4Yqw0OZBCs=;
        b=CyVTzkunUlJCA+++w1IWOF689gJc96SZbxB565yVm4KZIliQBg4FOGrTv46PBTnGIZ
         tZxjAfFPOxpMuto9HRNvRo6DFN6ggBkzKWW9xHDrOA/sDa3fyoMAihoxSfYclr+M4k2G
         v/rtgMk0RVLj5mZxZDZh2bRoNxDsmaGLADvbn14Wyl9B/dB0Zwg1vFyAFfEEmLczDNSb
         aaALZR2/aR+e006w5TF1H93MT7x8htCX/8TqTHXFP+ZAS8yYAdewjHDlyhsWUsenL7we
         +VIQv09M0hiE0GfFjSsHOvfck6H2bY3eeaesWwMqCBL4q0LXu3KSPT7T9xsV0/6VT7Yh
         2Y1A==
X-Gm-Message-State: AOAM533Uzu+kqh1czIksmOoRrJc/1HQT4uwr92dFLO30tvrI1Y4qvoMd
        RbJ2BlNjnLvHOz4TF229xv3lvAVHaYvWN/7yU074HE+tQN28rUwgzgQk9z7MbsgW5igiN2ZAa4c
        8SNN5f2A5ppIkLx7RQOC1K74FzGwie4sDWjQKqgUzo/iRd9uqoePz1/EoVh2Oi2pR+Ab+vxxGvX
        zI
X-Received: by 2002:a63:d648:: with SMTP id d8mr22825112pgj.280.1626666379335;
        Sun, 18 Jul 2021 20:46:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK2PClg+T4bdNF1ejzCKJffGRKgRhP7taoldHCCR21mctqgfmU8bprULu+NF2sidpBYZ+Vvg==
X-Received: by 2002:a63:d648:: with SMTP id d8mr22825089pgj.280.1626666379115;
        Sun, 18 Jul 2021 20:46:19 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o10sm18100561pfu.131.2021.07.18.20.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 20:46:18 -0700 (PDT)
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To:     tianxianting <xianting.tian@linux.alibaba.com>,
        Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        david@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b427ac2a-e439-3675-8a42-9fdcd23a5114@redhat.com>
Date:   Mon, 19 Jul 2021 11:46:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/16 下午8:46, tianxianting 写道:
> Do you interest in this patch? just little improvment:)
>
> 在 2021/7/13 下午11:38, Xianting Tian 写道:
>> From: Xianting Tian <xianting.tian@linux.alibaba.com>
>>
>> Use the helper virtio_find_vqs().
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c 
>> b/drivers/virtio/virtio_balloon.c
>> index 510e931..18e0bf3 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -531,8 +531,8 @@ static int init_vqs(struct virtio_balloon *vb)
>>           callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
>>       }
>>   -    err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>> -                     vqs, callbacks, names, NULL, NULL);
>> +    err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>> +                callbacks, names, NULL);
>>       if (err)
>>           return err;
>

Acked-by: Jason Wang <jasowang@redhat.com>

Maybe it's better to convert all the drivers that doesn't use 
virtio_find_vqs{_ctx}.

Thanks

