Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13E53C7B90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhGNCRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237439AbhGNCRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626228888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lETjBLf02DlKWY99ILUZ8EMCaetURHel393ebRunFe0=;
        b=RpanRK4do7fmp5b/4CL2veP13uT33cWzgV4AxMm8fCh2lRD5BVlU7EWkK5WiUGZ+PL6+2S
        1vji2GCy00j8WYjqi7eRw9kvwLx0fYZoE7VPje+IrQ7xP5ng09w+2deSH7oVggqWUkhLlW
        eaudGc368XAVesmd5r8TNo66Ez40IyA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-4kphtghsMCe93rcY52F2Zw-1; Tue, 13 Jul 2021 22:14:47 -0400
X-MC-Unique: 4kphtghsMCe93rcY52F2Zw-1
Received: by mail-pf1-f197.google.com with SMTP id b10-20020a056a000ccab029032dc5f71f6aso491357pfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lETjBLf02DlKWY99ILUZ8EMCaetURHel393ebRunFe0=;
        b=eghunmIH9hf6awJU/ApseP+QCQjtsKpZFSKSSJVRh7E4DJeKqfmx4sro1VaV3NehLW
         pYxzbqBqX71iehVnKGE7kVTH8GBT3n6pgGfLAvSZ5f4jXzimcuJvmCD9SKpgch6d15et
         b2TlcJ1yq+GAbfS7Ngyw1XDyaXzpgfnfSLA1C5pfgORVXo3IBcca5xdYb2sRaNxf2qsi
         9/E3jLya8ZpT+yXf8SOK1fyvaU6XvR0SQNZ2CGhLm6MnDkwPR64eIpDAMasMyvKnn5z0
         fLcJhmGm9cRmrfIIcbkUroiEaauDUjSfwWJ9jE7e3ChIHbYy79C3d5/xRycUCwgkykJE
         j1OQ==
X-Gm-Message-State: AOAM5304rTcZWo9vmPGhxBp37KXj/qEFSBuhw84sq3sTQ/A27rz8Zcpu
        ApnYEwcpxSpaQu2faG8YXuCL/h5yvmo8zpNv8Ovuh41EzAMH39dQMUXVW1G9UMyHrHqEyKkLHxT
        vFfy4Ky6dnv9T95+eVYPHRKLXrCVA8riuWR5DFtckxBXtHR+ExmZVD+QGA0ZePiTAOlXz8c/A7m
        X9
X-Received: by 2002:a17:90a:5b10:: with SMTP id o16mr7219063pji.76.1626228885738;
        Tue, 13 Jul 2021 19:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOiPXFxUcdLZWrtqR5/IHD7VsylcBTQze23cRfzIoKwRQb/qtzHoUNsMb4X6hRI8thHVVbZQ==
X-Received: by 2002:a17:90a:5b10:: with SMTP id o16mr7219014pji.76.1626228885330;
        Tue, 13 Jul 2021 19:14:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p40sm469474pfw.79.2021.07.13.19.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 19:14:44 -0700 (PDT)
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        joro@8bytes.org, gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com> <20210713113114.GL1954@kadam>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
Date:   Wed, 14 Jul 2021 10:14:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713113114.GL1954@kadam>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/13 ÏÂÎç7:31, Dan Carpenter Ð´µÀ:
> On Tue, Jul 13, 2021 at 04:46:52PM +0800, Xie Yongji wrote:
>> @@ -613,37 +618,28 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
>>   	}
>>   }
>>   
>> -static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>> -					   struct vhost_iotlb_msg *msg)
>> +static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>> +			     u64 iova, u64 size, u64 uaddr, u32 perm)
>>   {
>>   	struct vhost_dev *dev = &v->vdev;
>> -	struct vhost_iotlb *iotlb = dev->iotlb;
>>   	struct page **page_list;
>>   	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>   	unsigned int gup_flags = FOLL_LONGTERM;
>>   	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>>   	unsigned long lock_limit, sz2pin, nchunks, i;
>> -	u64 iova = msg->iova;
>> +	u64 start = iova;
>>   	long pinned;
>>   	int ret = 0;
>>   
>> -	if (msg->iova < v->range.first ||
>> -	    msg->iova + msg->size - 1 > v->range.last)
>> -		return -EINVAL;
> This is not related to your patch, but can the "msg->iova + msg->size"
> addition can have an integer overflow.  From looking at the callers it
> seems like it can.  msg comes from:
>    vhost_chr_write_iter()
>    --> dev->msg_handler(dev, &msg);
>        --> vhost_vdpa_process_iotlb_msg()
>           --> vhost_vdpa_process_iotlb_update()


Yes.


>
> If I'm thinking of the right thing then these are allowed to overflow to
> 0 because of the " - 1" but not further than that.  I believe the check
> needs to be something like:
>
> 	if (msg->iova < v->range.first ||
> 	    msg->iova - 1 > U64_MAX - msg->size ||


I guess we don't need - 1 here?

Thanks


> 	    msg->iova + msg->size - 1 > v->range.last)
>
> But writing integer overflow check correctly is notoriously difficult.
> Do you think you could send a fix for that which is separate from the
> patcheset?  We'd want to backport it to stable.
>
> regards,
> dan carpenter
>

