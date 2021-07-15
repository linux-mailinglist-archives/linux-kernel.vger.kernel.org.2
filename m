Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB63C9A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhGOIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235749AbhGOIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626336573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTv2CcseCDxm+mEU26speVoVdaOl+FWh69D3e5ssflE=;
        b=XIl0ZPImwaTE3Z90FO7B00Hyt3cRktsHtza+wF2f4mxIg/L7WVmkLv0+9tyq+to7tHOhTW
        COBpPrPoV8cYUuc/DUtJ3m8u5KtxYXy9KSJwNrWbTTgUUSrmWbYsgjXpF55mO8Lk9MhoJp
        b+Yx21qLAivor+frrnSHStq1cibSw2I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-gGQ07Y67PQmPvijwu_q_Rg-1; Thu, 15 Jul 2021 04:09:32 -0400
X-MC-Unique: gGQ07Y67PQmPvijwu_q_Rg-1
Received: by mail-pf1-f198.google.com with SMTP id a18-20020a056a000c92b02903282ac9a232so3697174pfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tTv2CcseCDxm+mEU26speVoVdaOl+FWh69D3e5ssflE=;
        b=b8DG3H0JJtElS1Qu0AlWUYo9yvOce13GnhAKq0gkweqQ/KauJHAfaS+rl4Eaofdh/2
         oltjt0iPQrvBu1+UpRmCM7vSrWIxIoLZ46ea/YoXUYhOFp5HHfjLDVHuoskADGxizaIb
         HIIAskHkxQE+c/4zako0DmCzY1iFqtkwlXoOReDs5t/kq3FnZ9VGIp8Zr9gz741t52ZN
         aBdF60opkhdqV8o+AQLXCzt3LBb7bQyPvSaYTBDVhb9GQ6x8ukrzPmEcVX0IvxTA+1ly
         EyPsJ+mxJOgoAP5eA31seRMFXAE5nVdkAQU2jsrPwm4MNQpfosBv5oTeqJGOfxRCVqIW
         z+xw==
X-Gm-Message-State: AOAM5329GlIrHrwEvaMXtWSIeMO0lyCeRb5EfYgOXILUBZol/RFfTwiS
        XvIPxJwwXuFcVurc1zCoH/AzbveOdEOpzyZtwLMp7QfLQBLzpWDuEzveUSDBzWz8Tvyx4+aYjF4
        p8Jb8oIXPCNJbIPW4+o5DK0CwIYJwEgw/oK/WqKL30NR+e88FYBWRtuQB6rVpe1J+Q1eV4YuP8G
        Rn
X-Received: by 2002:aa7:8812:0:b029:32d:8252:fd0 with SMTP id c18-20020aa788120000b029032d82520fd0mr3420221pfo.48.1626336570822;
        Thu, 15 Jul 2021 01:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy21oKk9puljREtI9aX+P7Nz+KeImlG5GM7dAEFtmMf3aeiR7RdthHXdo9KCW7otJEMQOSdww==
X-Received: by 2002:aa7:8812:0:b029:32d:8252:fd0 with SMTP id c18-20020aa788120000b029032d82520fd0mr3420184pfo.48.1626336570575;
        Thu, 15 Jul 2021 01:09:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j20sm5350601pfc.203.2021.07.15.01.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:09:30 -0700 (PDT)
Subject: Re: [PATCH 3/4] vDPA/ifcvf: Fix return value check for
 vdpa_alloc_device()
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3f3f9594-6a79-1ddb-4c45-fd1304c7d398@redhat.com>
Date:   Thu, 15 Jul 2021 16:09:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-3-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/15 ÏÂÎç4:00, Xie Yongji Ð´µÀ:
> The vdpa_alloc_device() returns an error pointer upon
> failure, not NULL. To handle the failure correctly, this
> replaces NULL check with IS_ERR() check and propagate the
> error upwards.
>
> Fixes: 5a2414bc454e ("virtio: Intel IFC VF driver for VDPA")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 21b78f1cd521..351c6cfb24c3 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -493,9 +493,9 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
>   				    dev, &ifc_vdpa_ops, NULL);
> -	if (adapter == NULL) {
> +	if (IS_ERR(adapter)) {
>   		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
> -		return -ENOMEM;
> +		return PTR_ERR(adapter);
>   	}
>   
>   	pci_set_master(pdev);

