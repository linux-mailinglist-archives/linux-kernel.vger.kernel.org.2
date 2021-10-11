Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8A42857C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJKDOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232813AbhJKDOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633921922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yd9mqmA+XqBl+2Vl/PPmxVFviKbrjRNGIbGC653bycI=;
        b=ARHZ9T5qqWeg0ge0dAdjRgWnGRp48Bvq0JF+iZDufyQ5om5Gpr27veFZY+MZkDvJag8pUX
        mYhj/7vq1AybYQg+aHwEpCa6+d1G6KA27A5VQ71Q4qx9GZhyeI+xwb3LJTT4nyeMYbSG1q
        OAbXLvFyyDBz+4JetspmY3WcU05CrDs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-0oOQxB7GNRqBKFxOprCY2A-1; Sun, 10 Oct 2021 23:10:30 -0400
X-MC-Unique: 0oOQxB7GNRqBKFxOprCY2A-1
Received: by mail-pf1-f199.google.com with SMTP id d187-20020a6236c4000000b0044cf291bfebso1683341pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yd9mqmA+XqBl+2Vl/PPmxVFviKbrjRNGIbGC653bycI=;
        b=0xQg7GZEzs0OCV2CP0c5UuMOmqck3rZ5PDffroMeqhMOAdaS9SY8vhlvCIxk/aSBLA
         hzHZHlzLK+jx+ayNIpj3qKazjW4F8Uo8aA3QD8mD6c/rYCVqPB/BEyIxvVe9w/Eyr25P
         zUm/66otzql6X8aPFonqHfxAhlj1SvYrdjOsQOLCRpjO+06B6GKMP/rNtlCbR0TkraM7
         XhEqooQ7aEICXgl9BWdAION7VClznIX0ZHA9PvXuxmVne+Bbcw9D+z+pSkGKo8To8Mly
         iE/Acf885rQYf0lvbNq9D/IfYv/XICVsmx9TTisRWI6ChV7WJmmmTOmE6xb4JHuxb/UC
         brvQ==
X-Gm-Message-State: AOAM533pdziwVhaSIPx5ZCm98t1yXMF7SskbdHxSKLHUy3vvwKQbAMY1
        HvzVsaF/FZCXSuINOSxLEjOQzYt5GLLNKQv3oEdJaOFDsS5MdenK/u+1B8vXUIaiH6ZlySvrPZS
        HA+LyqHy2LM9yJwpdZM6olVOn
X-Received: by 2002:a62:5101:0:b0:44c:5cc3:e088 with SMTP id f1-20020a625101000000b0044c5cc3e088mr23412402pfb.72.1633921829261;
        Sun, 10 Oct 2021 20:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEzsnGNdIaAxv7GONPx2NpCt1Gtj9JzY56rJd0EHZgWk1YGd3Hvq1eCMjR+UJz648D//GagA==
X-Received: by 2002:a62:5101:0:b0:44c:5cc3:e088 with SMTP id f1-20020a625101000000b0044c5cc3e088mr23412382pfb.72.1633921828963;
        Sun, 10 Oct 2021 20:10:28 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x23sm5943140pfq.146.2021.10.10.20.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 20:10:28 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <ab430c611c3d8074fddc6c4e0f747852678d6b3f.1632882380.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ba47edba-3438-a2b6-1783-7a42c633df2a@redhat.com>
Date:   Mon, 11 Oct 2021 11:10:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ab430c611c3d8074fddc6c4e0f747852678d6b3f.1632882380.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/29 ÏÂÎç2:11, Wu Zongyong Ð´µÀ:
> This attribute advertises the min value of virtqueue size. The value is
> 0 by default.


I think 0 is not a correct value. If I understand the spec correctly, it 
should be 1.

Thanks


>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>   drivers/vdpa/vdpa.c       | 5 +++++
>   include/uapi/linux/vdpa.h | 1 +
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1dc121a07a93..6ed79fba33e4 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -492,6 +492,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>   	      int flags, struct netlink_ext_ack *extack)
>   {
>   	u16 max_vq_size;
> +	u16 min_vq_size = 0;
>   	u32 device_id;
>   	u32 vendor_id;
>   	void *hdr;
> @@ -508,6 +509,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>   	device_id = vdev->config->get_device_id(vdev);
>   	vendor_id = vdev->config->get_vendor_id(vdev);
>   	max_vq_size = vdev->config->get_vq_num_max(vdev);
> +	if (vdev->config->get_vq_num_min)
> +		min_vq_size = vdev->config->get_vq_num_min(vdev);
>   
>   	err = -EMSGSIZE;
>   	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> @@ -520,6 +523,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>   		goto msg_err;
>   	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
>   		goto msg_err;
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
> +		goto msg_err;
>   
>   	genlmsg_end(msg, hdr);
>   	return 0;
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 66a41e4ec163..e3b87879514c 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -32,6 +32,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_VENDOR_ID,		/* u32 */
>   	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
>   	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
> +	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
>   
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,

