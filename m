Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9163B65CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhF1Piu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236105AbhF1Ph4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624894530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXwdIk3X8hXQxAHomN/zLsNCwHoCvetUnw2dOV3ipe8=;
        b=RKvLHe4/ThqnKTNqRBIhVIaUeT+lXCuuHs6focPnjNZ4fdGK8xBISB2s5Wi25xRT7N+qHt
        GHapbhx+W1gbLpVjqXE4ZnOAkc/8OgCj6umEuqkTM+I8pVWfEc0l7gwGwjrhQdvlBoM/FO
        crcbdQTEqJ3i9fYx7TUl6maVtsVlU3k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-tAKEMIPPNH-mwpouXFpV9g-1; Mon, 28 Jun 2021 11:35:28 -0400
X-MC-Unique: tAKEMIPPNH-mwpouXFpV9g-1
Received: by mail-ed1-f69.google.com with SMTP id o8-20020aa7dd480000b02903954c05c938so2942079edw.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yXwdIk3X8hXQxAHomN/zLsNCwHoCvetUnw2dOV3ipe8=;
        b=Rx51WpdPFMy9B3/3bSUQX8p8nKikuu9b/XqBLxh2hU2xqyUYsDo0cMJCAS7sjMgMk4
         l8HAa/8V5OZGhJ4oDTW6rPp1SQwv7ifwyPmRC2VLY2Gj/teFAHf7nwk2/sK7cEkzp0H+
         +XZ5RfYptY6/Q5Ev6Hp2rV1cAynIDSaT4qyYlpR396gRoMI0s3hKhd6EOhF5cpmvqKaZ
         Mtw8Sb1KHuDsWuYMWJeRNtZXgUK1s1veCfk2lZWx3FBCsbR1AgTF9bKe/fxRCYDasFx8
         62zVegPsfMihiKPgRZGTSJJz3MmpdmE03+V5o7y3AE2SYebBopHlSftt9uUnaDAgjGA3
         Acyg==
X-Gm-Message-State: AOAM530HsUWhafn5wIb6pBd7c9A/IoNB/4WshD1D2FI2r4MH9xZWn7ZZ
        2adXxbs6f2dbKJH72n+1P333iTOd/dYsXR3Cxsb2gJ16Ny9UmodkR6ifI4QYvYGLBy8M6g6f0O5
        mhOTLdeUwKpEQnwMQW9IZ+vcollfa+dB65E0I4ny9C/IFRSOOqGDdI2nKo0K1XdG7duGI07PDwr
        hP
X-Received: by 2002:aa7:c607:: with SMTP id h7mr89206edq.13.1624894527324;
        Mon, 28 Jun 2021 08:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKWcVzXXSjUNAeYogJWwHAKcI3fCfXMxf8iGT7Bp9zXKW8ASVkVRrfL85WYQ0LvKJPEAucQg==
X-Received: by 2002:aa7:c607:: with SMTP id h7mr89188edq.13.1624894527155;
        Mon, 28 Jun 2021 08:35:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gz17sm7039974ejc.91.2021.06.28.08.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 08:35:26 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: Fix a resource leak in sd_int_dpc
To:     Xiangyang Zhang <xyz.sun.ok@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, fabioaiuto83@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210628152239.5475-1-xyz.sun.ok@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1ed687fa-3831-8dcf-35a4-6e32f5c26e97@redhat.com>
Date:   Mon, 28 Jun 2021 17:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628152239.5475-1-xyz.sun.ok@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/28/21 5:22 PM, Xiangyang Zhang wrote:
> The "c2h_evt" variable is not freed when function call
> "c2h_evt_read_88xx" failed
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index 2dd251ce177e..a545832a468e 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -909,6 +909,8 @@ void sd_int_dpc(struct adapter *adapter)
>  				} else {
>  					rtw_c2h_wk_cmd(adapter, (u8 *)c2h_evt);
>  				}
> +			} else {
> +				kfree(c2h_evt);
>  			}
>  		} else {
>  			/* Error handling for malloc fail */
> 

