Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCB40A390
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbhINCa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233167AbhINCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631586581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWpNoDWZfo5O44DTcs5Qn11a6fTtXXK38bHt1D2HGgI=;
        b=Sx9LEquoJEkUPi1sNO/eVjaII5WWktatetk27dv+k+gwvMz7QDFVC3v6Jr3BT5MDnRTnci
        R9wjWhXakSaOku9xMZdHSYwHhm/GD0kVomY0p7xaea0EEswVfLmDrTEBbk2sbpuH9CSB18
        M9akig90x5/GjXiNIMXdkXTN0aDskqc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-10_KLo5gM6WGJhnj3INSuw-1; Mon, 13 Sep 2021 22:29:40 -0400
X-MC-Unique: 10_KLo5gM6WGJhnj3INSuw-1
Received: by mail-pl1-f199.google.com with SMTP id e2-20020a17090301c200b0013b8b16c22cso1683661plh.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jWpNoDWZfo5O44DTcs5Qn11a6fTtXXK38bHt1D2HGgI=;
        b=ihFdiKhXOzCdefWOvrpdQhI8eP4I+LdJaPsqR/EowBkMSyv4C74y+3nVsTZdpG+tee
         VCeikcyPgxgwNi8UhtsqP+YYySA9ShEMJbEnVd9LGuyegKIFMg3h8vRcadD791Kumq94
         4bgb/wKj8+XjyRFXpt3gXKtbzXQafEm6d1beN7+fyGZ+1pk2MV+EtTWshM50vmKgrOnT
         Iwssj9m25/leWNGRZRHewihdgQvzQ9OvpMqoZJ2TBLJJb2zRXsusuCgCcXjDAjYZuV34
         DG9EI7/E4BPRjK9FIDlhesW2jlDx7//4Lis12A0Rxx/XjrzdRx/ohcjiKEfdXKhKTLS7
         7Lvw==
X-Gm-Message-State: AOAM530ZymrD6HmBTqsfQ81k0UPe78RkbUGn86MNCGnP2OTo3Tib5EE5
        NpyQBbCRX7roce/ocxXchJGq9j5NDkAAD0GYVf+zxxS+rZlauw8kJIaPZ1vXgZm1TMFcpQOUMZS
        FLQfJ+U/pY7cgG9qYvkVkq2Ad
X-Received: by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id e6-20020aa782460000b029039a1e0acd48mr2383687pfn.14.1631586579069;
        Mon, 13 Sep 2021 19:29:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyDoDWWN1L4/NFxKEPHiQqcmOu9yl+2/kwaCFANAW481c4BvNQynvTcsuZh2QwKD1KzkZD6g==
X-Received: by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id e6-20020aa782460000b029039a1e0acd48mr2383666pfn.14.1631586578768;
        Mon, 13 Sep 2021 19:29:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y26sm8202998pfe.69.2021.09.13.19.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:29:38 -0700 (PDT)
Subject: Re: [PATCH 1/9] virtio-blk: validate num_queues during probe
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, david.kaplan@amd.com, konrad.wilk@oracle.com,
        f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-2-jasowang@redhat.com>
 <20210913074814.wcrrisaomlhvtmo5@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e225518e-77c5-3fbd-ad79-a29dae564b20@redhat.com>
Date:   Tue, 14 Sep 2021 10:29:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913074814.wcrrisaomlhvtmo5@steredhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/9/13 下午3:48, Stefano Garzarella 写道:
> On Mon, Sep 13, 2021 at 01:53:45PM +0800, Jason Wang wrote:
>> If an untrusted device neogitates BLK_F_MQ but advertises a zero
>> num_queues, the driver may end up trying to allocating zero size
>> buffers where ZERO_SIZE_PTR is returned which may pass the checking
>> against the NULL. This will lead unexpected results.
>>
>> Fixing this by using single queue if num_queues is zero.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> drivers/block/virtio_blk.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index e574fbf5e6df..f130d12df4b9 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -498,7 +498,8 @@ static int init_vq(struct virtio_blk *vblk)
>>     err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
>>                    struct virtio_blk_config, num_queues,
>>                    &num_vqs);
>> -    if (err)
>> +    /* We need at least on virtqueue */
>
> s/on/one/
>
> The rest LGTM.
>
> Stefano


Will fix in next version.

Thanks


>
>> +    if (err || !num_vqs)
>>         num_vqs = 1;
>>
>>     num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
>> -- 
>> 2.25.1
>>
>> _______________________________________________
>> Virtualization mailing list
>> Virtualization@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>>
>

