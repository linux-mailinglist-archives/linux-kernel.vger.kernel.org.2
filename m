Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DB39013C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhEYMrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhEYMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621946767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAsSn0QqqS827pEDp2tUmlZZNLwNBxRbKX1OInU2lIM=;
        b=Y1C3Js3MVc6gBf82pWGNt0iQsh10gpABJ3zE9SrEtBtFu317TRF+3syR4GiQb5IfmB+4Rn
        kRCLpqdNdXRaK3mBaKW3KsO75eSDfvlZ6MNxucSThE6DSExeR5Iw0lPBSLSKboCOzIIzil
        BA3jOcpomNmmE5wHR0iazmKw0E7IhzE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-bcvHTPzwNpCPpdE7rkJUew-1; Tue, 25 May 2021 08:46:06 -0400
X-MC-Unique: bcvHTPzwNpCPpdE7rkJUew-1
Received: by mail-ej1-f72.google.com with SMTP id eb10-20020a170907280ab02903d65bd14481so8437488ejc.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BAsSn0QqqS827pEDp2tUmlZZNLwNBxRbKX1OInU2lIM=;
        b=iXFm2lDI6WctPCybHCx0XvcmbisgFBBKV9pphfm658xjKnTd8gNlu896WELRNlkJLE
         Rc2HfXDscc6JROrYK4Nf0kYtf/3By2hIF5DvdHvyaPkxyjp1t39S6+eHMHlrCsSyR7+R
         2o3QokANLFbsu/2mzWvAKtHIGGxvRJVvrxhRDIko+oLNctB5HXb5rPzrdgKikRX6+bZl
         TmQW0heaU7HO+eoSGpUJVU84ntPKXeiV6moV5P3dtWWXzqM4hXDGkuvqc8D9jZvRcRQR
         YmfVu7hJbBq+qChxNyOHVtlgAc5Ro9hG6+b2RpXvYo/sSF8L6BgsGFXgNdblgvDkXoLz
         vXCA==
X-Gm-Message-State: AOAM5338zebGZImH4C0RSUHlDpMaRsndej9DtnvIzR7E0mfS0wtdhscC
        k5LrMd9jx0oixVG/rLnHw9RqFdLRjns6hksRQ3JPNTdyS4+M1niOaHosmtU33KqB1WKkTbNNbXu
        A79X797vRegwt7Sfjfy76ftUU
X-Received: by 2002:a17:906:914d:: with SMTP id y13mr28396471ejw.489.1621946764867;
        Tue, 25 May 2021 05:46:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC24QkEUJbBUYm9nsAY/iT6F2AsbeP/cQgBHwWHXbl0ufK8TwUkYxJZeJhUNBBg0OZ4UCYgw==
X-Received: by 2002:a17:906:914d:: with SMTP id y13mr28396455ejw.489.1621946764680;
        Tue, 25 May 2021 05:46:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q18sm10517988edd.3.2021.05.25.05.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 05:46:04 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Fix inconsistent
 indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, hmh@hmh.eng.br
Cc:     mgross@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <1621837438-70790-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <86bee518-cf29-f1b1-c1fc-b939f418be84@redhat.com>
Date:   Tue, 25 May 2021 14:46:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1621837438-70790-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/24/21 8:23 AM, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> drivers/platform/x86/thinkpad_acpi.c:7942 volume_write() warn:
> inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

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
> Changes in v2:
>   -For the follow advice: https://lore.kernel.org/patchwork/patch/1434215/
> 
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index dd60c93..b7fec1b 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -7938,7 +7938,7 @@ static int volume_write(char *buf)
>  				continue;
>  			} else if (sscanf(cmd, "level %u", &l) == 1 &&
>  				   l >= 0 && l <= TP_EC_VOLUME_MAX) {
> -					new_level = l;
> +				new_level = l;
>  				continue;
>  			}
>  		}
> 

