Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02F03C9A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhGOIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhGOIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626336664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsyq0RE9WU7Ypp4Gm+eQdmDLZ+QGqhUmGOqrJ08ECV8=;
        b=M+28B+pJ/e5neDifuIqaPObyFlnnOtarb49Ad9fUrEp+rzfVxnH/FiMyKjvIr7VB0YcNhK
        0L5/ZNom2zTm1mKcYrrXY6dL+X3VUdeEU5BEe09z5oZfsDAtyVJ4hjPwzWBHtqjIDzSvee
        Wg73z191aHAsnRka8Dg7LcA9oJvfdPg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-zuJ-uiFoORqSkQg8BORR7A-1; Thu, 15 Jul 2021 04:11:03 -0400
X-MC-Unique: zuJ-uiFoORqSkQg8BORR7A-1
Received: by mail-pl1-f198.google.com with SMTP id e12-20020a170902784cb02901298fdd4067so1176565pln.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tsyq0RE9WU7Ypp4Gm+eQdmDLZ+QGqhUmGOqrJ08ECV8=;
        b=ry5riK0iNR0OJxsai0Y4jANSsDtnptIW0zJuCz2KoybZ73/7YMnenXYynyr8X+1r/2
         YEhc2kPIsJ6lSsgkwwZGZdsUPTdBjQfCYB/KupMQk4+D/WU3pIWxABFyxPZGjxzLeEEE
         7APqOPClDg4DVy87iTTqOIRV+V+MqaCwd8tp9J/FHYACpva8mWudOM67k3YY7hjoHhbu
         UmVMO6y/mKDs4C4OmZH0yVdzG1ZcgHOXDEldTglQe3idsmgE3yldVL3WE1f/xA1AMICA
         mD4m9MyFSnnbhwmaVmi96Xb1PWDHaOLiHUxekxP7nQZl5MSo2fPiGstv97TVl84J3q/H
         ZrIg==
X-Gm-Message-State: AOAM533PNzj1s47VCtdbuBhyoAcPop9nShEYE0VMrKjL07CkwhiYkthM
        SoLEEA5eBqFhC0/QXWG7/yAvqPOFRgoD+YMNudPn76fK3uybUDfmaw0AXBICxTOb6ZUc2W/hTX2
        SFWYY49LGXoCCofaNHwnQy7qINEK9MQbyiIhyT/+LQasTlbupMbQt+YoPUQ4wYGk/wJ84L//24m
        Ip
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr3275862pjb.52.1626336662422;
        Thu, 15 Jul 2021 01:11:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgdRSlGSxamOhLsopmlpgUvS49WuoZJFtfu/4SL+rwM+O8AzT3DsZTC193gTbNFSIv6SvnpA==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr3275838pjb.52.1626336662106;
        Thu, 15 Jul 2021 01:11:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x68sm5470497pfb.115.2021.07.15.01.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:11:01 -0700 (PDT)
Subject: Re: [PATCH 4/4] vdpa: Add documentation for vdpa_alloc_device() macro
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-4-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <30a9222e-30fc-8dfb-312e-05367785ff6a@redhat.com>
Date:   Thu, 15 Jul 2021 16:10:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-4-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/15 ÏÂÎç4:00, Xie Yongji Ð´µÀ:
> The return value of vdpa_alloc_device() macro is not very
> clear, so that most of callers did the wrong check. Let's
> add some comments to better document it.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/vdpa.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 3357ac98878d..8cfe49d201dd 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -277,6 +277,17 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   					const struct vdpa_config_ops *config,
>   					size_t size, const char *name);
>   
> +/**
> + * vdpa_alloc_device - allocate and initilaize a vDPA device
> + *
> + * @dev_struct: the type of the parent structure
> + * @member: the name of struct vdpa_device within the @dev_struct
> + * @parent: the parent device
> + * @config: the bus operations that is supported by this device
> + * @name: name of the vdpa device
> + *
> + * Return allocated data structure or ERR_PTR upon error
> + */
>   #define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
>   			  container_of(__vdpa_alloc_device( \
>   				       parent, config, \

