Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE5E32D43F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbhCDNeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237567AbhCDNej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614864794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwdG3t5UAHsBi9SL/Yfrq+jahm1OjtL98jDJl0ORIEY=;
        b=NcpJoCgawPfHjyYjmb9nmvJhD2xjc4qvrHrs1A5gk6ySFmHK3LGST/kO2oRXRq4cC52acB
        ng23GQWguFzf0ZYP2NzmScg9YwtkU3cfByu+hh54yx/eGLx/w0Z/5aAsvYtvShmGzhz6cK
        zXLDwwI3ymSNX0BmM/B2u9s3f8x+ccI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-CvP01_oUOgGDtH4N_TtAXA-1; Thu, 04 Mar 2021 08:33:12 -0500
X-MC-Unique: CvP01_oUOgGDtH4N_TtAXA-1
Received: by mail-ej1-f70.google.com with SMTP id 7so12105780ejh.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AwdG3t5UAHsBi9SL/Yfrq+jahm1OjtL98jDJl0ORIEY=;
        b=JQqWFnZiplgzFgqdzmJLIzRA6HPvKGATSt5qCEk0fcnAXCUrR1fBomXqbdctGfmuMk
         myN5PUEnj7Lo1cIMbX/dc7DPJPv5F2pzxEL2fXnQiz35B0sYKX3DMyCnIu326Zp/Nifu
         l3Gxm5nvrBUqG6OyocoQh081nmnYUq2GNPIH5HoVz+Y6BUDpL5mEZC+POM0fsPx7JIQg
         t6QkQVyQta7inWwCjIOa/RrpTirlK4vre9L+6Tax5M4p88Zup/m11MzGQlhD8AqEBDvO
         OhwGD7bpZBd8HO1Z28dGuCg0LBlZKYDc2Oypo4TgHGXy4PIzk7A3rHc/Ojb/V6Wg/Ect
         z+MA==
X-Gm-Message-State: AOAM5320NlPtpVIslzH60Sjtupgn7/x8GeZsSGv/Q2Dn6XEDRvitMren
        QoNvSD6JA5key1PMORZUCWRVGpZrHKOVefcpRWK+NvlrP5nGH10XnL3QFw4DQ0y41LZjN6TstbV
        GW/nK4btm4vB6xn0CAR24VqnEO1ERA2t46jFD1KQkoaHiJ/E67+pcVO9CZqI7/n4lJya0neSvYG
        Tl
X-Received: by 2002:a17:906:ca02:: with SMTP id jt2mr4251221ejb.312.1614864791420;
        Thu, 04 Mar 2021 05:33:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRN4UMPe9nXogqsA95n2ngSH6SNhgA5g5XErEYFBiB307AIH2erIH59FRujP+12a5skOZapg==
X-Received: by 2002:a17:906:ca02:: with SMTP id jt2mr4251200ejb.312.1614864791258;
        Thu, 04 Mar 2021 05:33:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e18sm23187980eji.111.2021.03.04.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:33:10 -0800 (PST)
Subject: Re: [PATCH] platform/x86: Switch to using the new API kobj_to_dev()
To:     Yang Li <yang.lee@linux.alibaba.com>, ike.pan@canonical.com
Cc:     mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1613977238-104556-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <39606d42-f60e-0c17-4c70-4e94eafbb1a0@redhat.com>
Date:   Thu, 4 Mar 2021 14:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1613977238-104556-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/22/21 8:00 AM, Yang Li wrote:
> fixed the following coccicheck:
> ./drivers/platform/x86/ideapad-laptop.c:523:60-61: WARNING opportunity
> for kobj_to_dev()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Patch does not apply, please resend it rebased on the latest pdx86/for-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

Regards,

Hans

> ---
>  drivers/platform/x86/ideapad-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 5b81baf..d6ca4f0 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -520,7 +520,7 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
>  				 struct attribute *attr,
>  				 int idx)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct ideapad_private *priv = dev_get_drvdata(dev);
>  	bool supported;
>  
> 

