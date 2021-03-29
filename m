Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183E34CCBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhC2JHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233922AbhC2JFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617008700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRHZbctdvU5CldfExqqxh/W48hH/Hyg8pzA6KkszOzU=;
        b=Iy+e7Mvlk2WidXFs4eeK3wC0uOSx/8v73BkggVn073lX8b36xYTZNlWjP9LRY6b4vb/+2B
        iEnGTSwJIdcuSA2w/XOu4kW5SL5TAnVzme6rYqr/gAtUjPFmbbiTzDJM7XWSy7k46SwZTZ
        5BRTHM6tQi1/LgzenvUGI29Dw+FZ0M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-QNjbounNOPK8-daY-yLZAw-1; Mon, 29 Mar 2021 05:04:55 -0400
X-MC-Unique: QNjbounNOPK8-daY-yLZAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3D28189C8;
        Mon, 29 Mar 2021 09:04:53 +0000 (UTC)
Received: from [10.36.114.205] (ovpn-114-205.ams2.redhat.com [10.36.114.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 751F960864;
        Mon, 29 Mar 2021 09:04:48 +0000 (UTC)
Subject: Re: [PATCH] virtio-balloon: fix a typo in comment of
 virtballoon_migratepage()
To:     Liu Xiang <liu.xiang@zlingsmart.com>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        liuxiang1999@gmail.com
References: <20210327031710.16151-1-liu.xiang@zlingsmart.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <57a2d4ed-88d7-332b-6c3e-2f39b8902ace@redhat.com>
Date:   Mon, 29 Mar 2021 11:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210327031710.16151-1-liu.xiang@zlingsmart.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.21 04:17, Liu Xiang wrote:
> Typo: compation --> compaction
> 
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7da25b87f..c25665802 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -734,7 +734,7 @@ static void report_free_page_func(struct work_struct *work)
>   #ifdef CONFIG_BALLOON_COMPACTION
>   /*
>    * virtballoon_migratepage - perform the balloon page migration on behalf of
> - *			     a compation thread.     (called under page lock)
> + *			     a compaction thread.     (called under page lock)
>    * @vb_dev_info: the balloon device
>    * @newpage: page that will replace the isolated page after migration finishes.
>    * @page   : the isolated (old) page that is about to be migrated to newpage.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

