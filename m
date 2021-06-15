Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481973A82F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFOOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbhFOOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623767621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+PEwO1vuzVKwcAXZ/qn4zNQsNTC2ftksP1m6DzEJUg=;
        b=eixCCYeQL9TgOQiWaHfB24I/lFrIz6lrAyO7Q9eyMog4lSiG0AncJiLKuwLR4UDTvJ08Uz
        f0DmBxqNmM+Sey8L+xcKOQSI/ECpBRP/Rjsgf5Q/OkvSNEB+FHMAvj+Ao6PGY7WnY9FnB3
        9/N8G+VvA3MSj5nRrgDpPwcnU8whV98=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-N8y_9QEyM9S7zXZXPI1SZA-1; Tue, 15 Jun 2021 10:33:32 -0400
X-MC-Unique: N8y_9QEyM9S7zXZXPI1SZA-1
Received: by mail-pl1-f197.google.com with SMTP id t5-20020a170902e845b0290102b8314d05so6004034plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C+PEwO1vuzVKwcAXZ/qn4zNQsNTC2ftksP1m6DzEJUg=;
        b=dL1hfF/oecK6YMDTXXJb3CYdVUXl25hTti46VGZPomqy7lHd5b5N071IEntcixNSqW
         cgTBu0x/HRqtsrfWII3mNuGNMHHUh8xzpFCESemDnst23IYaQS5Fn36S4aBRbM5/P3BM
         s3E8AfFjZ7zJW8CwjyzOeOr2EowKh3cL+nX39srO8p9v4veVpbzJiH2g9C4CwYmlz6HG
         cE4wvWEIX1siqZ6xVZX8B0E+bGtyDvvceoB12UUz38/quaN1xowel2IOfi/I4d+utxUo
         s07MH4GYRrk05hu1GbGx+8UTc7D3uyBzuPpmk+Tqjle6IpNo9yKrKHN55SMCBkopyPRH
         zMRA==
X-Gm-Message-State: AOAM530yLr2RjIr8wOO+OCQK1ty1tA8And4btXBig0NNu5c3E78sAhYV
        fRzdiZQ+2OIXx8GdJZFDrEj8Ivad7t8cLR2J6CgKfT4KgyvHDMUXRMjzyitJ4RPfMC6VO3bdfpm
        OSIGj/iEQ+oTy3rjItzGLkl1F2yyYgSSvg5z3Z5m/EiAxQ/lAZulX2cWtgJTNV/2jXdGjIPRLlo
        Wb
X-Received: by 2002:a17:90a:6b42:: with SMTP id x2mr10714909pjl.16.1623767610732;
        Tue, 15 Jun 2021 07:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoLgAmk1b7+hVi09blQTTsivWllOjkeEFAcRwAwvRRMpCJnIURaBSkCjKYxfrUksdkBYUPgA==
X-Received: by 2002:a17:90a:6b42:: with SMTP id x2mr10714866pjl.16.1623767610322;
        Tue, 15 Jun 2021 07:33:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o16sm13419988pfk.129.2021.06.15.07.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:33:29 -0700 (PDT)
Subject: Re: [PATCH] vhost-vdpa: log warning message if vhost_vdpa_remove gets
 blocked
To:     Gautam Dawar <gdawar.xilinx@gmail.com>
Cc:     martinh@xilinx.com, hanand@xilinx.com, gdawar@xilinx.com,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210606132909.177640-1-gdawar.xilinx@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <aa866c72-c3d9-9022-aa5b-b5a9fc9e946a@redhat.com>
Date:   Tue, 15 Jun 2021 22:33:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606132909.177640-1-gdawar.xilinx@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/6 ÏÂÎç9:29, Gautam Dawar Ð´µÀ:
> From: Gautam Dawar <gdawar@xilinx.com>
>
> If some module invokes vdpa_device_unregister (usually in the module
> unload function) when the userspace app (eg. QEMU) which had opened
> the vhost-vdpa character device is still running, vhost_vdpa_remove()
> function will block indefinitely in call to wait_for_completion().
>
> This causes the vdpa_device_unregister caller to hang and with a
> usual side-effect of rmmod command not returning when this call
> is in the module_exit function.
>
> This patch converts the wait_for_completion call to its timeout based
> counterpart (wait_for_completion_timeout) and also adds a warning
> message to alert the user/administrator about this hang situation.
>
> To eventually fix this problem, a mechanism will be required to let
> vhost-vdpa module inform the userspace of this situation and
> userspace will close the descriptor of vhost-vdpa char device.
> This will enable vhost-vdpa to continue with graceful clean-up.
>
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
> ---
>   drivers/vhost/vdpa.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bfa4c6ef554e..572b64d09b06 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1091,7 +1091,11 @@ static void vhost_vdpa_remove(struct vdpa_device *vdpa)
>   		opened = atomic_cmpxchg(&v->opened, 0, 1);
>   		if (!opened)
>   			break;
> -		wait_for_completion(&v->completion);
> +		wait_for_completion_timeout(&v->completion,
> +					    msecs_to_jiffies(1000));
> +		dev_warn_ratelimited(&v->dev,
> +				     "%s waiting for /dev/%s to be closed\n",
> +				     __func__, dev_name(&v->dev));
>   	} while (1);
>   
>   	put_device(&v->dev);


Acked-by: Jason Wang <jasowang@redhat.com>


