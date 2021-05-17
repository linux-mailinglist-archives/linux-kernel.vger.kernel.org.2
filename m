Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE093828C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhEQJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236174AbhEQJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621244918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tEiWMxvFfDaLBpfAi6mBYrtAgfz0m3EOWCPsuf6C4M=;
        b=beouFtmP6aeiUYE1WisgUgQ2AtGrd4SJ8TsbRcAn9z8GwMbHKPqzaEfDtZv1JMLF/ceSkJ
        FUOFfUZHhRiB/+rU/6pbb5pRu+hE+LbCpxvwPKTSiRdW8HiWKUOguSqCvAoMbuWxSBEt8V
        piw23JTGewQT3+awh7hATxlNyCNXduI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-OxhmL6sXM-GGh1aY7mlaHQ-1; Mon, 17 May 2021 05:48:36 -0400
X-MC-Unique: OxhmL6sXM-GGh1aY7mlaHQ-1
Received: by mail-wm1-f69.google.com with SMTP id x82-20020a1c63550000b0290158057efb6dso403177wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1tEiWMxvFfDaLBpfAi6mBYrtAgfz0m3EOWCPsuf6C4M=;
        b=sE6iDsXcwTNz2C2/vq38VLYvZZEh275981BNqxDHxoo18U3PrUah19SFVXLDLjtwdE
         jkgUu83zrfHxzWmG9AHpV1z89ET/rehMILYaE1kXmZZbWiY5/W/i0S7vkpJUrqMHAeQg
         OJIFivLAfUn0Aa97Sgzx1Tk8aedRRp+VSgPlTSjz4Q1mntpX/Nl3uSUt8YZLxKLl3/11
         J5zcJ/2lSONaP1qycU3gT4cXvYMucXdK+wEw4LK/N76oDuJd1tBRDxlFZR7LyOLcn+90
         9+uJMQLOqz5Nzu5xjPm+yyCPG7CvCyq8VZk3SqU3Ijd00s4xunP0l2+VcOM1yG4kgoBo
         tsfg==
X-Gm-Message-State: AOAM532ZBz4uRc5OkYcOac71QTy9kPVT8tZu/PrChgXEIhRsMPpLcgDN
        LApVmOMIummK1v/DmSL3B8ojYIllz5w0/NHnRgWhXkVIVEbcLJsQQv1wkWrXxjET8C8VSaTD1dZ
        7Nc527SWu8QjjS2NeM5/jIXSLddb09JMQ4Kn8n5uIugofBU+FsU4GLdjpAjcUI79TC5hvPr9T
X-Received: by 2002:adf:ab54:: with SMTP id r20mr5015734wrc.303.1621244915412;
        Mon, 17 May 2021 02:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuGZWmkxNmth9iAq6lB+UpMloyMQwHTboefJhsB1s2BlK2Srhv7jCp8ez8YpU/rBwomOcu5A==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr5015679wrc.303.1621244915043;
        Mon, 17 May 2021 02:48:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6833.dip0.t-ipconnect.de. [91.12.104.51])
        by smtp.gmail.com with ESMTPSA id g66sm13847531wma.11.2021.05.17.02.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 02:48:34 -0700 (PDT)
Subject: Re: [RFC PATCH 13/15] virtio-mem: Handle virtio_device_ready()
 failure
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, vgoyal@redhat.com, miklos@szeredi.hu,
        lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210517093428.670-1-xieyongji@bytedance.com>
 <20210517093428.670-14-xieyongji@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <20e1d79f-c3f6-5553-d6b6-1f1051c39ccc@redhat.com>
Date:   Mon, 17 May 2021 11:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517093428.670-14-xieyongji@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.21 11:34, Xie Yongji wrote:
> Now virtio_device_ready() will return error if we get
> invalid status. Let's handle this case on probe.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/virtio/virtio_mem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 32a8e359a5c3..1148c392ff94 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2602,13 +2602,17 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>   	if (rc)
>   		goto out_unreg_mem;
>   
> -	virtio_device_ready(vdev);
> +	rc = virtio_device_ready(vdev);
> +	if (rc)
> +		goto out_unreg_device;
>   
>   	/* trigger a config update to start processing the requested_size */
>   	atomic_set(&vm->config_changed, 1);
>   	queue_work(system_freezable_wq, &vm->wq);
>   
>   	return 0;
> +out_unreg_device:
> +	unregister_virtio_mem_device(vm);
>   out_unreg_mem:
>   	unregister_memory_notifier(&vm->memory_notifier);
>   out_del_resource:
> 

I assume this will really be a corner case to hit, right?


Failing after essentially being done initializing looks sub-optimal, anyhow:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

