Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E14351B19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhDASG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237309AbhDARvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Di0BWBiR9j8X6GwMiIH6dAiJ9FfCbmkOlLWEvf+m8I=;
        b=jQOthO5RBuy8EAUGTdzAx9QbusbJQKsbUwktEdu4AdI/fqq+LZa2U4L+BoP52TKsyCTx1M
        9VlVMl08S2xzU65a6YSHf3PcvPGi1Qu47GRlA3vM0cKuICVRjVU8cmCUW1JK1F2KykoXRa
        rg/vhAHeINh2d2mSJxdfew9xz72f7vA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-W5brmruLNO-UO12uvdFh7A-1; Thu, 01 Apr 2021 09:49:19 -0400
X-MC-Unique: W5brmruLNO-UO12uvdFh7A-1
Received: by mail-ej1-f69.google.com with SMTP id p11so2241711eju.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Di0BWBiR9j8X6GwMiIH6dAiJ9FfCbmkOlLWEvf+m8I=;
        b=NqqLrlH8QjgJb+s+/OoP0FQPTljbfJPFfU3t+v6Ncus+mRQEOcmiGE2Jw3L3188srt
         Ayo3S5sGBPl9z+m/KuywrxuoiqwfO+eRppN1wN/6EryMImCTVfH9NTd6tngmb0oR+emW
         N/oxI+RniaTS/ExQb2S3PaTivOlQ3D3O63pmOJqclVkR4z15fpEeGAYX9XKiWE0htJTf
         edpEx0OhgFtfofPkSfjpvC15wCMHryXuoLoN4oljaaR4sq5TTr/ktAtsMbFy7NoyiYM3
         /mprYOveRw9P7h8ipn0Noot/L/MPo9HEkDLGTzVlCPgJ1fA1mchyLw2ijpGqyiipZWrl
         z5cA==
X-Gm-Message-State: AOAM530sIO4ntZw7xnCLbCAqieRQ43MhBO/H0qxeudgq8+vKK7lswYh7
        mq4AiT93TOln6hy0MBwYrspQS4x3kgqtZjjFUUCJ9nhp4LGaQemTbL/RNJ4c0e3tsux1/fTiihT
        uhQ+YEjZc7gcxxwLXP0a1CEm7GTTphZPlMDW22GkGSrfF88p+q7uBdRHuQctYXOXfzx+oFf6gVw
        mc
X-Received: by 2002:a17:906:e48:: with SMTP id q8mr9366891eji.84.1617284957357;
        Thu, 01 Apr 2021 06:49:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQCqTJPlf5xHvtZrdLYGwFx8VHwJr7Nn508W2djrIkVNqJD9RRZhr4LvfkPbi+pedlY2rRgA==
X-Received: by 2002:a17:906:e48:: with SMTP id q8mr9366872eji.84.1617284957182;
        Thu, 01 Apr 2021 06:49:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g21sm2822186ejd.6.2021.04.01.06.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:49:16 -0700 (PDT)
Subject: Re: [PATCH 31/32] Documentation: update sysfs-platform_profile.rst
 reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-kernel@vger.kernel.org
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <828434d891e40234255e3f06c13827b7996b1ad1.1617279356.git.mchehab+huawei@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e042f8f8-0ba1-098d-2503-8c319c3c2bf9@redhat.com>
Date:   Thu, 1 Apr 2021 15:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <828434d891e40234255e3f06c13827b7996b1ad1.1617279356.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/21 2:17 PM, Mauro Carvalho Chehab wrote:
> The file name: Documentation/ABI/testing/sysfs-platform_profile.rst
> should be, instead: Documentation/userspace-api/sysfs-platform_profile.rst.
> 
> Update its cross-reference accordingly.
> 
> Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
> Fixes: 8e0cbf356377 ("Documentation: Add documentation for new platform_profile sysfs attribute")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, I assume you will merge this through your tree?

Regards,

Hans

> ---
>  include/linux/platform_profile.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index a6329003aee7..e5cbb6841f3a 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -2,7 +2,7 @@
>  /*
>   * Platform profile sysfs interface
>   *
> - * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
> + * See Documentation/userspace-api/sysfs-platform_profile.rst for more
>   * information.
>   */
>  
> 

