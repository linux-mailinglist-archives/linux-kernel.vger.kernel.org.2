Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8A5396AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhFACWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhFACWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622514056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHJV0WlocBHDOX8jLF2mkpZ5nqCjiTVwGU4D5WLHsm8=;
        b=AhHZ71VWQ8B9IteZJ1abzLeFuANl2joUwkr9NbH+nI99KloR8tqcrwAAuPNmjLEw3rIa24
        bbQ+Fh9n/Ojfw7NAXwxHRH69lKv2Datkp7fbPklIrEE4GdG+J1exrjiggHp77fCTgmsVXZ
        O/sU7gtF6dJMAiaSDQfTHVb6dTa9wu4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-trU_0rQOPM6VVN_xc9ANAw-1; Mon, 31 May 2021 22:20:55 -0400
X-MC-Unique: trU_0rQOPM6VVN_xc9ANAw-1
Received: by mail-pf1-f200.google.com with SMTP id v22-20020aa785160000b02902ddbe7f56bdso6575356pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RHJV0WlocBHDOX8jLF2mkpZ5nqCjiTVwGU4D5WLHsm8=;
        b=WhBBBQOOJUJo4v2wveogukuHwa/NHKS902sW/fY9d0h9EsOpb2A1UIlbPxmLFWYerM
         cPJNUhoUT/+9t2LopsaGR51KuVUoFx0zjG13LA5pR1zqNoZMGZff7ffuAxcCSeObmL5B
         v6xqrHseOXOSAwHbkHGtSxDfYPWViOjH2aD+UpKFTQnXsNgU43REz8HA6qlPfQ79jCzC
         Z8SoFjhg1OU3+hBxORIx0mhnRy13JZSHHPztKtZWSSSreaiZdVFNfqKK1j/WUrRoT5BF
         8aEYk70pH54Cej+GDattiJwotGfjC2M2RHH97qIPJvUOdWw5yfdqTuqHueNlU90SGVTI
         IJ9g==
X-Gm-Message-State: AOAM533/mM+OOF66r9yU6gewv9925q9RuHqdlYFzJxoWEK2GNbInuUDV
        wBdh6FknFCMMNN2oo7URW8efJYYL+hWdgujtXmPwxRK5tUG75cd1IiknCD5MCBaWfgBM7kstHaA
        z/+WeWFNkh7zpYkFVl0mryMaMkjT1wdLsk7xYmnAHcm9DFWWEpLNafvkWrA34eDMuYpKTCNXxqK
        H5
X-Received: by 2002:a17:90a:f50b:: with SMTP id cs11mr9520586pjb.207.1622514054052;
        Mon, 31 May 2021 19:20:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxVrXcTasCSSiYsHm316XHk1ghILzTBFdpIAESw/JpgIYRaR6IcNyGyler2uXnVOlhL/IRYw==
X-Received: by 2002:a17:90a:f50b:: with SMTP id cs11mr9520561pjb.207.1622514053738;
        Mon, 31 May 2021 19:20:53 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p11sm12351136pgn.65.2021.05.31.19.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 19:20:53 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio/vdpa: Clear the available index during probe
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160502.31610-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2a0a106c-af92-37b7-84de-5754b8ac645b@redhat.com>
Date:   Tue, 1 Jun 2021 10:20:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531160502.31610-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/1 ÉÏÎç12:05, Eli Cohen Ð´µÀ:
> Clear the available index as part of the initialization process to
> clear and values that might be left from previous usage of the device.
> For example, if the device was previously used by vhost_vdpa and now
> probed by vhost_vdpa, you want to start with indices.
>
> Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---


Acked-by: Jason Wang <jasowang@redhat.com>

Note that we probably need a follow-up fixes for vp_vdpa driver.

I will post it soon.

Thanks


>   drivers/virtio/virtio_vdpa.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index e28acf482e0c..32fb121a6ec4 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -142,6 +142,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>   	struct vdpa_callback cb;
>   	struct virtqueue *vq;
>   	u64 desc_addr, driver_addr, device_addr;
> +	struct vdpa_vq_state state = {0};
>   	unsigned long flags;
>   	u32 align, num;
>   	int err;
> @@ -191,6 +192,11 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>   		goto err_vq;
>   	}
>   
> +	/* reset available index */
> +	err = ops->set_vq_state(vdpa, index, &state);
> +	if (err)
> +		goto err_vq;
> +
>   	ops->set_vq_ready(vdpa, index, 1);
>   
>   	vq->priv = info;

