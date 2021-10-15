Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4AC42EC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhJOIZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237104AbhJOIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634286180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcA/AKdnJAyfY5MWpoSYVc+I5H9/vFXIYe/jlFy9tUs=;
        b=B9PSHY+H3pBUZI75BG4/g5+MJ571rd0c5R1dMxWDfFztRnAL8vwvQrz/sK5vN/G/feNNNT
        7lwJ2M55otDgNVOrSHEqhn/twajFrOu8gPNxwj8pruODNKAwFfMVWwt9s5EJ8wsovAlK4Q
        BgcUZ7+rxApw54z1ZuQ0PZmIvkDq0F0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-TM-0xB3KO8uupdVwbF41pw-1; Fri, 15 Oct 2021 04:22:59 -0400
X-MC-Unique: TM-0xB3KO8uupdVwbF41pw-1
Received: by mail-pl1-f197.google.com with SMTP id y13-20020a1709029b8d00b0013dc7c668e2so3591562plp.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XcA/AKdnJAyfY5MWpoSYVc+I5H9/vFXIYe/jlFy9tUs=;
        b=0w6irTwy2XitMBZWhQkBSUoo1FGeDqJw9QzR6Od6DD2fLjq86pmHK0PiD/e3FSd70Y
         FpMkpYjNqppl6X2Znjc0VJsKQ3enNHcOoH/QM9WaS0Pt3NAlrusCrX8XvkJbbOorTKnK
         0G16Y7dY5qAXplrlpa3ytxClqISDkMfAh1QZZCXVZ5Hfxd0vv4ecVTWn48D/mg9T1toC
         vJJJAd0N/3KqohJegqEkChlqg82K/2+KbFlc9El1Vt2pKWsBtKNtSB216wzWIRTEkHEX
         ftYrz5QAGydrwOoqe1SAomkAD2sSVVU5ManfvlOk/LcvfIaCMlNPjO4re4DzLHxTB1qM
         cStg==
X-Gm-Message-State: AOAM5302UnrK/fWJcEBgFSdQIwMz63qvai9boNoswvGGq2w0ThnyK2OS
        nhfd/EbWwcXeZ+cDAryou70FerX2FykqQfe/t54WOA4zNhS3GT6q+mbH/bSD7Ait/BtLs200P0k
        Q5yk2/1stjrGAkrOjgZYG4voN
X-Received: by 2002:a62:3893:0:b0:44b:9369:5de5 with SMTP id f141-20020a623893000000b0044b93695de5mr10422265pfa.40.1634286178115;
        Fri, 15 Oct 2021 01:22:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9xNgyFYLdtunayxJlaElANQTbK2Vwxt3HZMQjMl+A6afFTAZ2n7HSq2zfQBFbsHEzgY7crQ==
X-Received: by 2002:a62:3893:0:b0:44b:9369:5de5 with SMTP id f141-20020a623893000000b0044b93695de5mr10422247pfa.40.1634286177886;
        Fri, 15 Oct 2021 01:22:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e12sm4288876pfl.67.2021.10.15.01.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:22:57 -0700 (PDT)
Subject: Re: [PATCH v5 4/8] vdpa: add new callback get_vq_num_min in
 vdpa_config_ops
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <25435d5cde12f298133196e866662b0ef2225205.1634281805.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e658c9e3-9949-6451-c555-a3ffbe1568db@redhat.com>
Date:   Fri, 15 Oct 2021 16:22:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <25435d5cde12f298133196e866662b0ef2225205.1634281805.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/15 ÏÂÎç3:14, Wu Zongyong Ð´µÀ:
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

