Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48345FD5A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 09:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352841AbhK0IEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 03:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352928AbhK0ICp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 03:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637999970;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58Kjh48+rA0mz4yMMMVKby2HPiPhnf/RAdjUHo4rrk8=;
        b=Wjhqm85aXcYC5GLn/pZhrp3OPwiu/dAjoVS6W7S7iCWoJ1x+lmxj1GIo5ENRVK9RI0MZkS
        gtwCHxUJjVXOhrtpSlWRUQ4nHtaYH+XQwvxPR3wp0vE3r2DJLNzvNo74AH40FZaCj6p2lH
        IM69R0ewldSsZU2G82wvXkYDttI88WE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-hDywgbodPqGd4S7kcNQ3Eg-1; Sat, 27 Nov 2021 02:59:29 -0500
X-MC-Unique: hDywgbodPqGd4S7kcNQ3Eg-1
Received: by mail-wm1-f71.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so8279396wmc.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 23:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=58Kjh48+rA0mz4yMMMVKby2HPiPhnf/RAdjUHo4rrk8=;
        b=0FyFT/1Qk9EN1obOI1pkAODqU7zoWywuPm7UuWRgQun75ejk7oMD1vx3Kt1vRQmG2I
         vwCgJA5KdNJFSFW7TT58h+b0AZraTeHWnk0BSCfvxl54+wHcIQTceyBDZ2bDupIMPSby
         eEDYJky6Ju0DnDXJh2WihOl1ugmdRd0O7MS/oPwEmxHNd6pKtGUsKEKkyFJ9x5Wluj8/
         +ix/jkesZWqvdlpflRXcbjcC9GMZJPMrSof1QJmkwYAOPjhW3tTKzpLPAVA/7MjOu+8A
         I5Sm39/ppqLzsOzA9QwChh7MHoHaWlH0/DBw1vk0eZDLiTj2dtTB6w9EmhTTg5yZOVNd
         Mwog==
X-Gm-Message-State: AOAM533Qm9qaOPvSFakngp/r4hwJ7r1fHT8hJP2Tjn/bnTmr201dMdo4
        ktIHnZ/BQ3eHmJsO6LsJdUnFRwCUQ/D88roRXJo5jFPwnbFOTQHsV6fhI+sPlA4J+6+Jla9WNas
        FBBfm8PnWzo7Un7TsXSTZ2mMB
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr19152235wrx.64.1637999967652;
        Fri, 26 Nov 2021 23:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoFdzhtbBQJqlr9QWdg9YHontW3Tzr3Rv+AFm3mKY7LUujJNHPKIkOvpyLAG9zOSPSOxJ1Ug==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr19152225wrx.64.1637999967502;
        Fri, 26 Nov 2021 23:59:27 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d1sm7359363wrz.92.2021.11.26.23.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 23:59:26 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-2-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <b9068111-bc1e-cc0a-155d-04585d6f4138@redhat.com>
Date:   Sat, 27 Nov 2021 08:59:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 11/23/21 4:52 PM, Jean-Philippe Brucker wrote:
> Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
> VIRTIO_IOMMU_F_BYPASS.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/uapi/linux/virtio_iommu.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..cafd8cf7febf 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
> +#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> @@ -36,6 +37,8 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	__u8					bypass;
> +	__u8					reserved[7];
in [PATCH v3] virtio-iommu: Rework the bypass feature I see

+  u8 bypass;
+  u8 reserved[3];

What was exactly voted?

Thanks

Eric

>  };
>  
>  /* Request types */
> @@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
>  	__u8					reserved[3];
>  };
>  
> +#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
> +
>  struct virtio_iommu_req_attach {
>  	struct virtio_iommu_req_head		head;
>  	__le32					domain;
>  	__le32					endpoint;
> -	__u8					reserved[8];
> +	__le32					flags;
> +	__u8					reserved[4];
>  	struct virtio_iommu_req_tail		tail;
>  };
>  

