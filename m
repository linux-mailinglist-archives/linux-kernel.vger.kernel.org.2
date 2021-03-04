Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76D032D21A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbhCDL5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhCDL5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614858953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+E1WXBwpF1z1xo6KwbA36bcObIfRAqptZ8Hj8ICzu8=;
        b=UEiYIkfCYwJeloCThUi38GFnRE/s4xjrneOCdrXgQqp+P63GxJ+GNIyQ3b0taM4Gy4505k
        SCugqpJJQ3TcxWUghMH1n1mvQKXLH/nFqZDqwqqhH5AixUadlXcAvyVXO+yqaQJpt/cDJq
        bNekTFhDLMSahWI1YGqghEXA1V74ndU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-m8uj7yC_MueKIxrgpX9uaQ-1; Thu, 04 Mar 2021 06:55:51 -0500
X-MC-Unique: m8uj7yC_MueKIxrgpX9uaQ-1
Received: by mail-ej1-f72.google.com with SMTP id w22so12092044ejv.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 03:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+E1WXBwpF1z1xo6KwbA36bcObIfRAqptZ8Hj8ICzu8=;
        b=ItYeTGXAGbxMinh7hUkbnWeb3sPwPj62LRYwKrMBogLn9hS3YEQQspp9YV46cj3XlW
         MwE+v9msf6SoMBGkp64me9H2oI0exx6paiaHLuxE+ZOrvrTNq+FlcZcGE4++KPzfFJ/S
         9poEIBdVBgnBb4wqsuSW85EV9p3Axric5n/M5Ucw9WcDlwi/RF1wRUx8viF6VNELy1zr
         0gTYaKNgzHrfwA3fqhqd3/OgB1Rryotl899cdZpKaGwvTXWkoec9GKJBkxVMt5Ro9KlI
         v9som0fSAuU6hX+HqzImTYerFn3OQ12+SinVvuLdix6aIt+IRZ8oWjz1stu1d9mJKjiD
         1XsA==
X-Gm-Message-State: AOAM5318DYsJdW8z+jIsgG9ENTaqYpqRo73DIiX5RO8lgs1+1+GSXOjM
        juRCykzEk87Xgzx5y5V22DNBVEqAs5lFrPqgjtKRcSaBbkyQ1WCFvt2OEnfbJUbnz0za9+po4Wz
        vI7DHaBqvrqvzfHopfZI5lbL2Hs5yTWfRkk4V2oA3+gawz4oxrlkGpADgZPLcAVUryJXX8konzn
        6M
X-Received: by 2002:aa7:c850:: with SMTP id g16mr3854360edt.324.1614858950417;
        Thu, 04 Mar 2021 03:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUnQl3cxRXfCHqk+b2XcgAHJWgbg2F3iqR9VrubNPG/EStNwjexjVJRIjAc32ABod+IOf0Rg==
X-Received: by 2002:aa7:c850:: with SMTP id g16mr3854334edt.324.1614858950171;
        Thu, 04 Mar 2021 03:55:50 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d3sm19878030edp.43.2021.03.04.03.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:55:49 -0800 (PST)
Subject: Re: [PATCH] x86/platform/uv: Fix indentation warning in
 Documentation/ABI/testing/sysfs-firmware-sgi_uv
To:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Tom Rix <trix@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
References: <20210219172835.253610-1-justin.ernst@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4b30e296-e4d2-c8af-a920-72a09932d3d1@redhat.com>
Date:   Thu, 4 Mar 2021 12:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210219172835.253610-1-justin.ernst@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/19/21 6:28 PM, Justin Ernst wrote:
> commit c9624cb7db1c ("x86/platform/uv: Update sysfs documentation")
> 
> misplaced the first line of a codeblock section, causing the reported
> warning message:
> Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpected indentation.
> 
> Move the misplaced line below the required blank line to remove the
> warning message.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: c9624cb7db1c ("x86/platform/uv: Update sysfs documentation")
> Acked-by: Mike Travis <mike.travis@hpe.com>
> Signed-off-by: Justin Ernst <justin.ernst@hpe.com>

Thank you for the patch.

Since this documentation documents the interface exposed by:
drivers/platform/x86/uv_sysfs.c

I've applied this patch to the pdx86 tree now:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  Documentation/ABI/testing/sysfs-firmware-sgi_uv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> index 637c668cbe45..12ed843e1d3e 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> +++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> @@ -39,8 +39,8 @@ Description:
>  
>  		The uv_type entry contains the hub revision number.
>  		This value can be used to identify the UV system version::
> -			"0.*" = Hubless UV ('*' is subtype)
>  
> +			"0.*" = Hubless UV ('*' is subtype)
>  			"3.0" = UV2
>  			"5.0" = UV3
>  			"7.0" = UV4
> 

