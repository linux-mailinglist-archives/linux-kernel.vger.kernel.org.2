Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229142856D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhJKDFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhJKDFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633921418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GNTJo3xMwhtD2Ct5YhzwdlgtFwaRmbmFekAViw3kEZo=;
        b=XU2Qsvf2HGQTdHSyntUOSsUsJd/KkbS9tYeZNnTpIXzmPvSLxLNWeVpeEsp0bnR4id4Wg2
        H4G5hEZ932SX8W8GYuFl165huSqKhpMUjJnjzN+tncAe03NdF9U8a3I4punbUyMIkF1Agr
        f2lui0yer2QG++d1fbCh7CTTvq1RxT4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-q2EZoJUuNl-UAvuLyth1nw-1; Sun, 10 Oct 2021 23:03:36 -0400
X-MC-Unique: q2EZoJUuNl-UAvuLyth1nw-1
Received: by mail-pg1-f198.google.com with SMTP id 15-20020a630d4f000000b00287c5b3f77bso6190449pgn.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GNTJo3xMwhtD2Ct5YhzwdlgtFwaRmbmFekAViw3kEZo=;
        b=q+u3HnEoaqVFuXMmsAU/27GF7OUDqFGgt1NynD0Oc6RGS0IgdEeSwAptnXz1CiOVHY
         lekiq5nTc5O5WWMcDFN3ObtjJAImxEF+07jJ+Fr0DFnoTv+BA3FYP6kjQrAN6N6F9Jmo
         24/BWok5wXC8QFbd4MH+gju+Fg8ikqmu1upB6bR6QZrZxJ9Cofy4lEBCdS/8edsu4tFm
         3eYugCQa4BxgCG/IGTD15ElIi8YTHpYwqjCSNL6qh3163BsoyZiyKGkBCXn3Vd9aKAL9
         bLqXEFCHz1vWDehbP8wQyjh0479QVneEypJDM1qgCI/DOXPLhaxrfE2yBVzgLCR421cB
         /IMw==
X-Gm-Message-State: AOAM532O0AfgnGMT7pHK2pgC0RNRHfd4sYyg/gSBvG2FPSUJyIS4TxOH
        oxhtweWtu+QfFcmwQS9FYRO3lE/uCtuMe5HyXSE34XS8FOxRvhdo/ZUyRNUJkvA9zvuJ14Ha6o8
        RcFbbP1/vAMXohfJECSILsTNM
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr28009006pjk.182.1633921415760;
        Sun, 10 Oct 2021 20:03:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq4zA/dNRtVObkbAmXCEJFwrbLkG4kJ1DIqXUVxuOyW2xs/XAp5XD/L+Pi+lC7Rycj6uQiuA==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr28008982pjk.182.1633921415533;
        Sun, 10 Oct 2021 20:03:35 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d67sm6051904pga.67.2021.10.10.20.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 20:03:34 -0700 (PDT)
Subject: Re: [PATCH v4 2/7] vdpa: fix typo
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <49dc74038cdfaa7af7dab1565ba5da5d6cc4ec7d.1632882380.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9cbeb29f-63ec-9a5d-3614-4da1736806ee@redhat.com>
Date:   Mon, 11 Oct 2021 11:03:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <49dc74038cdfaa7af7dab1565ba5da5d6cc4ec7d.1632882380.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/29 ÏÂÎç2:11, Wu Zongyong Ð´µÀ:
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/vdpa.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 3972ab765de1..a896ee021e5f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -257,7 +257,7 @@ struct vdpa_config_ops {
>   	struct vdpa_notification_area
>   	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>   	/* vq irq is not expected to be changed once DRIVER_OK is set */
> -	int (*get_vq_irq)(struct vdpa_device *vdv, u16 idx);
> +	int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
>   
>   	/* Device ops */
>   	u32 (*get_vq_align)(struct vdpa_device *vdev);

