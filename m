Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7442EBE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhJOIWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233729AbhJOIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634285913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AR7NmtJeDKbUolQgFEf1uh0PVLHMymws/0LyfI2hS+8=;
        b=GLgM+DJQx9joBSnPQUwtmny2F7LtkVDAiP3KWTmNplhLmQJB0gmrGQ31qaBD5A226Q2iD6
        gOgmb4zH92w689tYqtVSR7S2bMeCUaXzTXb0eKelsSFrwuXUXswCtKfGuX5Gq9FgQ7Vtfa
        B2f5qfLUJJIAWDDVRmNhmPX8bfshTCI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-jd2bQI_MNyKdeoefXtHtag-1; Fri, 15 Oct 2021 04:18:31 -0400
X-MC-Unique: jd2bQI_MNyKdeoefXtHtag-1
Received: by mail-pg1-f197.google.com with SMTP id t9-20020a63b249000000b002993d73be40so4673169pgo.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AR7NmtJeDKbUolQgFEf1uh0PVLHMymws/0LyfI2hS+8=;
        b=Xr4x9OXnN/ZU1wfPI9rTuIZaUj+eMGd1+9Iah9Cni7HhDQBXE9l6KivD7QtM//ACqt
         L5I5QKgNV0Qt7YnOq+MUezvi3befUme9ClK4Ct886yPdMNVF3u6O833q+n0+NpiOhS/K
         COvD6cxugIW6fHgoJyhCNAV6M4UichBZwczrUMRJw/ac1SC1VNv7rgssc7AfJSorY/yj
         sbeh1EJO8jshi66ThjZCJcdZX4QjfO6GBt1TfPyisd9QUMEwN768yCZyG5bJGYlax/dR
         BUp36vwFT5G0RxzfBb6wTpaEG2KKOIExF4qznOOI0fNUokxKYUw65YoLbebLqBPUC8qt
         suEA==
X-Gm-Message-State: AOAM530ldEZSsSHCHQUBqiBPpRLhYpFLdeUNsuaci1FN5k+xoeZvjx8Q
        K3Pig8YQJ4maSBLrzjcHboBsz8qAeupNolgzNVAssNu/IS0P51oePZx4LONwuVe+EoQ7epqhFik
        OEo42JUZAQVVULGegI+BiUTQ1
X-Received: by 2002:a62:6243:0:b0:44b:e10e:61b0 with SMTP id w64-20020a626243000000b0044be10e61b0mr10013324pfb.53.1634285910338;
        Fri, 15 Oct 2021 01:18:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKi1J9Dv5m7Hzhrxa7SAAKzEt+oDX9bo4a9zUH0AYB9m+fPbcsqJOxHucHRQn/BvVA4daJVg==
X-Received: by 2002:a62:6243:0:b0:44b:e10e:61b0 with SMTP id w64-20020a626243000000b0044be10e61b0mr10013296pfb.53.1634285909984;
        Fri, 15 Oct 2021 01:18:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h1sm4607177pfh.183.2021.10.15.01.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:18:29 -0700 (PDT)
Subject: Re: [PATCH v5 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <71914be7-827a-b496-90cb-1c0b5f573c37@redhat.com>
Date:   Fri, 15 Oct 2021 16:18:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/15 ÏÂÎç3:15, Wu Zongyong Ð´µÀ:
> +
> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +	u64 features = vp_legacy_get_features(ldev);
> +
> +	features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> +	features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
> +
> +	return features;
> +}
> +
> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> +		ENI_ERR(ldev->pci_dev,
> +			"VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> +		return -EINVAL;
> +	}
> +
> +	vp_legacy_set_features(ldev, (u32)features);
> +
> +	return 0;
> +}


Hi:

It looks like some of my previous comments were ignored?

> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +	u64 features = vp_legacy_get_features(ldev);
> +
> +	features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> +	features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);

VERSION_1 is also needed?


> +
> +	return features;
> +}
> +
> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +	if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> +		ENI_ERR(ldev->pci_dev,
> +			"VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> +		return -EINVAL;

Do we need to make sure FEATURE_OK is not set in this case or the ENI can do
this for us?

Other looks good.

Thanks

