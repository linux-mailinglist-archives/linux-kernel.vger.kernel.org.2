Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C091338C3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhEUJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230458AbhEUJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621590585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjVI8NV63LFnPGjIGDVYVcxDE8c9QMm9DxXJ2CvIadY=;
        b=AVHe7j1yI9ft5TGKocM2gXTZB+uNzl233tyjcQmn/HJevnwzHT78bINGV6L3+nDlKKFpvb
        eQEWanqDVAi6TJiF/jRb5APtw52uank29gyHOOwx6rb56NjRIxxCwtaUQe4SODIGKDpllx
        F68B1ROfFqtaYLKlh5YkeJ/m9KA11qQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510--VEU9objOKCPa8aKjb685Q-1; Fri, 21 May 2021 05:49:44 -0400
X-MC-Unique: -VEU9objOKCPa8aKjb685Q-1
Received: by mail-ed1-f70.google.com with SMTP id c21-20020a0564021015b029038c3f08ce5aso11150636edu.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IjVI8NV63LFnPGjIGDVYVcxDE8c9QMm9DxXJ2CvIadY=;
        b=D0lbqeEfPTbqHTtGXnqTpUx8+NtuP60zK3UzpmlGujuk3yO4nCM3k+JkYLos9fWHMc
         kUbDpEBD3FcKM7mfAlLrECeI2vLQphkMv6nz6A0v5jSeJi2VsSNOQE6z+q2T+DX/bVDi
         Mz+hPeMxiKkgYu0voJeMmheLEgxcoQKeO/qdshPjI58eT743ahfpxzF+l291HVHxq6xJ
         CE6tIlWlwEgBF4LyeylgaDVe545n/AR4/YtsByQsE82mZOrKX7A7p0NYQJpqtEj9CHQg
         5py8nrj3xOJh34uBRr0Li1XB1IRPbhyGLgAooV9DxopiyFBIJM9PjhdUlUbgz0K/CWQK
         xa5w==
X-Gm-Message-State: AOAM533vsJCL4UCNB8nadV/MlYRwA6zyNxwvp22EFCh6a9asT4b7xq0H
        OTqVZUqmNGZfdPPpx6o7uq2nZjGq1X1scOQNmBuErg0uoF8CLiNRQu2KOayQ7kpH81L0k01/iGE
        ib4JxUH7E57W5NsqEg1bLgEaF
X-Received: by 2002:a50:9549:: with SMTP id v9mr5774801eda.312.1621590583170;
        Fri, 21 May 2021 02:49:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGCWJDbkwFAmEbqh+wdMCPdSMdHGIeh58ElK08TuCsv7fsjYCeXL6Z9Y7Ni3bPbEWS1QxI7A==
X-Received: by 2002:a50:9549:: with SMTP id v9mr5774787eda.312.1621590582999;
        Fri, 21 May 2021 02:49:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id by3sm3715628edb.38.2021.05.21.02.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 02:49:42 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, hmh@hmh.eng.br
Cc:     mgross@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <1621589904-64475-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <00c331bb-17ec-89c0-6dd0-ffe2933df07b@redhat.com>
Date:   Fri, 21 May 2021 11:49:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1621589904-64475-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/21/21 11:38 AM, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> drivers/platform/x86/thinkpad_acpi.c:7942 volume_write() warn:
> inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index dd60c93..d0aa566 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -7939,7 +7939,7 @@ static int volume_write(char *buf)
>  			} else if (sscanf(cmd, "level %u", &l) == 1 &&
>  				   l >= 0 && l <= TP_EC_VOLUME_MAX) {
>  					new_level = l;
> -				continue;
> +					continue;
>  			}
>  		}
>  		if (strlencmp(cmd, "mute") == 0)

Thank you for your patch, but actually the indentation of the "new_level = l;"
is wrong, it is indented one level too much.

Please send a new version changing (reducing) the indentation of the
"new_level = l;" statement instead.

Regards,

Hans

