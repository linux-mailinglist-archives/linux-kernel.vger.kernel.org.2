Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676D342856F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhJKDGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhJKDGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633921461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T79BKdCqOj489zc3OMzu2/jJB+p06oKh0yYujOy933Y=;
        b=MYLXmxTBszOmjtaGjJoIorRAN04cRlXGXkPQc5jewC8/sDxRrm9P5huY1bPw8I8nKz84qf
        wwsQvk61znLlRInWIUg0PMr+6SaYsRagdEpUXVNo2RMyaZvVGZmcdMxm1wCZA/L9p48oVz
        KZbbJ7FGMgotd++q+Ff1zL256CzwGNo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-SviUat8oOXKLnKQjv_RO3g-1; Sun, 10 Oct 2021 23:04:19 -0400
X-MC-Unique: SviUat8oOXKLnKQjv_RO3g-1
Received: by mail-pg1-f199.google.com with SMTP id q23-20020a6562570000b029023cbfb4fd73so6169787pgv.14
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T79BKdCqOj489zc3OMzu2/jJB+p06oKh0yYujOy933Y=;
        b=yrw5byZQ9hKHW9W6VOXwrHQDUUemItK0wFsvci2UmwZibyzijtQgNr+VCLUXM6M3Pf
         iCWfaAB+MOzEaBk4dak+WMxo8gBMNyB9KFXvLywzZZ+bqdlcrYhJbn7jQWC44nts9DLA
         dcyYcRxnHySAUbPcP/blBnjAbs0XAGYMW4B+3sLj9Getr2sFu6Clw8/t4YITMJ2FY5OR
         X39MbpR5BQvHOpeT0Hs1VSeF8nTmQhz8vFqp/wyRPoMs8+7eZ7qFqaLarXGcOeDqbmDw
         rN5HfjffZc6ZRoFsps+wcxAPYIRx2881v5tzC5yh92ugW8ZYYHCI2+smJwQ5mZq+vxGv
         DApg==
X-Gm-Message-State: AOAM5303zJQ9gqFtq7qzpWvgo7USjTkQZHrlbZ5QnXupXUV5jyAN7Vql
        DgPVpIY74oijOfIp/4Q51akApotLAlHvXiinHBHQwbLVvrW9M/U6n1OzwT8jpwjS15zk0ms09eG
        Qj6jLtNXzoKfYJCO/RurJC1LD
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr27157210pjb.100.1633921458614;
        Sun, 10 Oct 2021 20:04:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj5eVsOT5kcTZ/KTOQVLWqO2RshC4Do9f4Y1Paq4OzbE2pH4irvvwspv1U+ckK8B0ZVkiBng==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr27157183pjb.100.1633921458358;
        Sun, 10 Oct 2021 20:04:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z9sm5505242pji.42.2021.10.10.20.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 20:04:17 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] vdpa: add new callback get_vq_num_min in
 vdpa_config_ops
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <451ce3c272ebd5d532db1ed19c2ab53c4609f7ad.1632882380.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a07c02e3-e5eb-ae94-33d9-26c29de484c9@redhat.com>
Date:   Mon, 11 Oct 2021 11:04:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <451ce3c272ebd5d532db1ed19c2ab53c4609f7ad.1632882380.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/29 ÏÂÎç2:11, Wu Zongyong Ð´µÀ:
> This callback is optional. For vdpa devices that not support to change
> virtqueue size, get_vq_num_min and get_vq_num_max will return the same
> value, so that users can choose a correct value for that device.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/vdpa.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index a896ee021e5f..30864848950b 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -171,6 +171,9 @@ struct vdpa_map_file {
>    * @get_vq_num_max:		Get the max size of virtqueue
>    *				@vdev: vdpa device
>    *				Returns u16: max size of virtqueue
> + * @get_vq_num_min:		Get the min size of virtqueue (optional)
> + *				@vdev: vdpa device
> + *				Returns u16: min size of virtqueue
>    * @get_device_id:		Get virtio device id
>    *				@vdev: vdpa device
>    *				Returns u32: virtio device id
> @@ -266,6 +269,7 @@ struct vdpa_config_ops {
>   	void (*set_config_cb)(struct vdpa_device *vdev,
>   			      struct vdpa_callback *cb);
>   	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> +	u16 (*get_vq_num_min)(struct vdpa_device *vdev);
>   	u32 (*get_device_id)(struct vdpa_device *vdev);
>   	u32 (*get_vendor_id)(struct vdpa_device *vdev);
>   	u8 (*get_status)(struct vdpa_device *vdev);

