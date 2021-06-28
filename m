Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA53B5B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhF1JRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232284AbhF1JRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624871713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5bou4h074m3o/W74lRU3ezW0yQ1+IHLUSss8INpB7tU=;
        b=cARQtbAIrUBRl6xoLuaHaYz1n0IItaWD+00xfIxqT3YYgT8qcLfdAN+r8HBBBVpMzbYwPC
        xK2j827JcVkwqjbWdeSCnErFAC138/NndPbjI5uWWlLmK8BhR0O5axkZbnEAeR0wp7P8JF
        Ojai9n7SN6EvM1YMLUBnXeipKSKvEbY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-dXK-54gIMoKOuJ5SLepnsw-1; Mon, 28 Jun 2021 05:15:11 -0400
X-MC-Unique: dXK-54gIMoKOuJ5SLepnsw-1
Received: by mail-ed1-f71.google.com with SMTP id da21-20020a0564021775b0290395165c6cefso5809766edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 02:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5bou4h074m3o/W74lRU3ezW0yQ1+IHLUSss8INpB7tU=;
        b=s9eRncHxVe4mMFXoegFshOHYRwrzoHnAjmuwbgDzTbFMr9TxJepvmdfHBIywh3BYG5
         zQxTbbH4nIYhTo9EtAt4O5b5skzCIX1sLDQ/i0WzIf5qnvrsFDjpE4Yxs56oHC62ErJI
         jxuJn0XgRmCmneLGu4vhPhQSbv6YjvJFaVn3B2Tk3qUQ3+2OxQAZeJnq3kyX3pMOk/eW
         /XiWOU69KFDDojFtsPD/5rVYmAdPID2M5TAKb0CqjfsGNfM6JEv7JXh5HDt1+rZYli6o
         gj4Jfo/w6C3hBDehDgvQMsO6TbdrAa8GDOTLZd5KecpmmliJStuLThuzshEImvR5CJX+
         WkNg==
X-Gm-Message-State: AOAM533xMZYZFzuim00RJSKFaorJnRkfyYvuRwBMTmM+zyB0IEncRdtj
        22iqMDIhxpZQU+pZJU+RModl3WlSV7cuwziRDomb4YLqZvAivrSSybC2Z6T3WeBwa1WTEMYsX5q
        nLrpnYxEYJHYv6+seWvHdj5Bd
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr22633335ejf.383.1624871709980;
        Mon, 28 Jun 2021 02:15:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8mJSO5fIGvt8yQ58Tc6tauoJdaypg9Uo0BH/ZKvCHDRQqrU5UpRKRWSg513d19BQXRr3ZXg==
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr22633314ejf.383.1624871709795;
        Mon, 28 Jun 2021 02:15:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bq1sm6582042ejb.66.2021.06.28.02.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 02:15:09 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: Change user experience
 when Admin/System Password is modified
To:     Prasanth KSR <kosigiprasanth@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
References: <20210628084906.4233-1-prasanth.ksr@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f4ec848d-735b-68aa-bee2-de9a2fbbe195@redhat.com>
Date:   Mon, 28 Jun 2021 11:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210628084906.4233-1-prasanth.ksr@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/28/21 10:49 AM, Prasanth KSR wrote:
> Whenever user has changed an Admin/System Password using the sysfs,
> then we are automatically copying the new password to existing
> password field.
> 
> Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>

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
>  .../x86/dell/dell-wmi-sysman/passwordattr-interface.c         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
> index 339a082d6c18..86ec962aace9 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
> @@ -95,9 +95,9 @@ int set_new_password(const char *password_type, const char *new)
>  
>  	print_hex_dump_bytes("set new password data: ", DUMP_PREFIX_NONE, buffer, buffer_size);
>  	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
> -	/* clear current_password here and use user input from wmi_priv.current_password */
> +	/* on success copy the new password to current password */
>  	if (!ret)
> -		memset(current_password, 0, MAX_BUFF);
> +		strscpy(current_password, new, MAX_BUFF);
>  	/* explain to user the detailed failure reason */
>  	else if (ret == -EOPNOTSUPP)
>  		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured\n");
> 

