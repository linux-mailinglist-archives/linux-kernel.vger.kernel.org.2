Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0141B413390
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhIUMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232667AbhIUMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632228655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkOBjqAV0ouhbcNISGSBmXY/07/63Cpl8i+uD2W0SL4=;
        b=O60HviHKgDXB05YRFssfPGkFxT+34fFuWrJrpTzcaJDiA0mnLK8sIDZ5RIRxG7gGgmoMfF
        BoTzApYRSU38EU5pl2wnCPk8uv9faZQjqSktsnMlEx8QWTB/72mMxfa9rn+DZKde7ul1k+
        vihx4+qOreiTFk3VRsYBotnUyuf4Ze8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-bnqfKer5N3G9HE9J9yrI9w-1; Tue, 21 Sep 2021 08:50:54 -0400
X-MC-Unique: bnqfKer5N3G9HE9J9yrI9w-1
Received: by mail-ed1-f70.google.com with SMTP id m30-20020a50999e000000b003cdd7680c8cso18895740edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 05:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gkOBjqAV0ouhbcNISGSBmXY/07/63Cpl8i+uD2W0SL4=;
        b=i21INxjpRzxvb9XfYjuJQZSBE3F8pBN0S1xTLG6LMRKRB/XnFz5eUGBuBORDdL5k9e
         A8XcwTV9ObgEo74bcQJm49GGBOXb6WawrO6Rc8PR/iaCG+WJXPo8Y2Oe+FHl1qbVUI1d
         vHhA2Nn5kfmzkYieVzA7tnD5pW6mNYkyZ3Gxpy9ytWvPrjE9Ck+rpGfRyFpm9H5lHQG6
         C80pWtFZ16sEk+BAYVXnQb2yj8rKtAwGzS60o201zpjnEAzzIuWR67QQ25+pW93T+ok3
         /ynu+/vzt67gc9197wGY8SxaNVaZoNeotoRBIistlxAgU500//poanCJ1/NKtDR4FyW3
         Aeag==
X-Gm-Message-State: AOAM530juMSNzb6eGqkF41NIv3tOkS/jH0JcoRhPK4DfwAJCCuDfqzqR
        MgbeQ8NRu2ITWcn8bRroCKORyryxRhGfXoSNsN+7Qq4znl2jjNgj/sZMvGD3cPGVT2wja1MJ+a4
        HVMhdac7B/uojbsQHqwBlH+5J
X-Received: by 2002:a17:906:5045:: with SMTP id e5mr35814760ejk.239.1632228653551;
        Tue, 21 Sep 2021 05:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRrwf090vg7jBTUydLH0bX50Of6iJwYw5EC5TT6k8b62dvJQIpkfN/g1eWxoMOaoQvl3CGcg==
X-Received: by 2002:a17:906:5045:: with SMTP id e5mr35814737ejk.239.1632228653388;
        Tue, 21 Sep 2021 05:50:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b38sm8423919edf.46.2021.09.21.05.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 05:50:53 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform: lg-laptop: drop unneeded MODULE_ALIAS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <852fde2e-c2c3-0ad5-6156-05ab1b6ef74c@redhat.com>
Date:   Tue, 21 Sep 2021 14:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/21 7:00 PM, Krzysztof Kozlowski wrote:
> The MODULE_DEVICE_TABLE already creates proper alias for ACPI driver.
> Having another MODULE_ALIAS causes the alias to be duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

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
>  drivers/platform/x86/lg-laptop.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 3e520d5bca07..4f3ece819f4c 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -60,7 +60,6 @@ MODULE_ALIAS("wmi:" WMI_EVENT_GUID2);
>  MODULE_ALIAS("wmi:" WMI_EVENT_GUID3);
>  MODULE_ALIAS("wmi:" WMI_METHOD_WMAB);
>  MODULE_ALIAS("wmi:" WMI_METHOD_WMBB);
> -MODULE_ALIAS("acpi*:LGEX0815:*");
>  
>  static struct platform_device *pf_device;
>  static struct input_dev *wmi_input_dev;
> 

