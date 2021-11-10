Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894EE44C1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKJNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhKJNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636549996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=visrAIrttqVR0Qhg0wAKCuRIxyMBo+QeZK/AFJCCiKY=;
        b=FRAIPBUrsxYdynGV0e4Z2o+oWG9VCBRN5Bd735iYbWqbAOcmwTO8O+s1tHb7L0xkaE2SAE
        fW6wu3zDOhuwu83zlL8a574k+NuJmqoe3aFGuuAxw8hjGpu96/vGokLIu6olKO9H+II4Md
        0agJuxkMUnkbXWb9KS8PrMBG0h98+Pg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-Gn_EyFmfMb-FVjqq1KoW0Q-1; Wed, 10 Nov 2021 08:13:15 -0500
X-MC-Unique: Gn_EyFmfMb-FVjqq1KoW0Q-1
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a05640242d600b003e28aecc0afso2311097edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=visrAIrttqVR0Qhg0wAKCuRIxyMBo+QeZK/AFJCCiKY=;
        b=vPK2sVHemIy7Bwl9YlnZw6fVxn/cBH9IMM2zxKMi7b7oBEB6YS2/3hzvxGwrJZ2vFG
         cOO1vXUDOO6gXzE5UQ0sFcCFmbnV2CynyvREEVWO8F3a5YHu2A1oAFzIp0mVjnQOplay
         QfC9Mj7oqJc3RHYI6F2njevactmeCTd92OY+567RZWjjp5Kqlaqun6IXIXstXsGxy2M3
         MpamLVOUyv6ee1yfbU/QHzoNXDMv02GXwLjQOCl3IN5ShJeObNYT6deEmA3fU5nSOTvG
         Yrs1ZzdSqIr2aAiyRAkZz/KXjqgPQu1/M1NSFfYjMkpwVeABH1zWoTq/iKZVrm4shD6Z
         lATQ==
X-Gm-Message-State: AOAM531MuK5ENGghlmQLeEkNKorN1nWeKMxZdn72Fq+UnwpYMMJfnGPx
        busM117Zpmf79ZMO2ggHGbBPXV7Pga2Eoyj3c7gQgP367E7FJf3ZDkabA+fFsmh8n5fUzg+8UaK
        zH8tUSRX5K7uwpMmNdVdMcOt5
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr19528804ejc.184.1636549994173;
        Wed, 10 Nov 2021 05:13:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsZeVMKhyqzXRMT2Tt5mW+GV9dQ5b7pgNmjMkK2crXtbT9GQ+RVUtrD/M7/ZdJTobu8NVQVg==
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr19528766ejc.184.1636549993863;
        Wed, 10 Nov 2021 05:13:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e1sm7529747ejy.82.2021.11.10.05.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 05:13:13 -0800 (PST)
Message-ID: <2cff5849-3f59-2bde-b9ff-02b2a423cbb6@redhat.com>
Date:   Wed, 10 Nov 2021 14:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] media: atomisp-ov2680: initialize return var
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Deepak R Varma <drv@mailo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, Hans Verkuil <hverkuil@xs4all.nl>
References: <46ec939d911fc94b8a5e217874655e60512ad773.1636541941.git.mchehab+huawei@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <46ec939d911fc94b8a5e217874655e60512ad773.1636541941.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/10/21 11:59, Mauro Carvalho Chehab wrote:
> As the settings are only applied when the device is powered on,
> it should return 0 when the device is not powered.
> 
> Not doing that causes a warning:
> 
> 	drivers/staging/media/atomisp/i2c/atomisp-ov2680.c: In function 'ov2680_ioctl':
> 	drivers/staging/media/atomisp/i2c/atomisp-ov2680.c:390:16: warning: 'ret' may be used uninitialized in this
> 	function [-Wmaybe-uninitialized]
> 	  390 |         return ov2680_set_exposure(sd, coarse_itg, analog_gain, digital_gain);
> 	      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	drivers/staging/media/atomisp/i2c/atomisp-ov2680.c:359:13: note: 'ret' was declared here
> 	  359 |         int ret;
> 	      |             ^~~
> 
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Fixes: 6b5b60687ada ("media: atomisp-ov2680: Save/restore exposure and gain over sensor power-down")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks, the series looks good to me (weird that my compiler version
did not complain):

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series.

Regards,

Hans

> ---
>  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> index 34d008236bd9..497884d332e1 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> @@ -356,7 +356,7 @@ static int ov2680_set_exposure(struct v4l2_subdev *sd, int exposure,
>  			       int gain, int digitgain)
>  {
>  	struct ov2680_device *dev = to_ov2680_sensor(sd);
> -	int ret;
> +	int ret = 0;
>  
>  	mutex_lock(&dev->input_lock);
>  
> 

