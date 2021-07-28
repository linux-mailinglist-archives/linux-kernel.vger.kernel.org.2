Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07C3D8B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhG1KAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235741AbhG1J77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627466398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjrGUELJrum5Ji89g/7iaRnZY9OVtK3tF4vpedgBiQw=;
        b=ZS8n+oZVnYeEF8JGG4UCnSx6dJ5g8ag6bd2xwxIaO12j24NfS97w6YviDlj5Rr0suTae2h
        Oti+0R3rBtSiX+rm7xMgqooDPdbG3NfeIlfLQ8hYEARlrdEpX7L4cfBkfs2WOs09FpHGss
        B38ILyarxwIpHnveioMg/Go6g3bsO7Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-2sMwyGl6NlW_sDQqo8Jp3g-1; Wed, 28 Jul 2021 05:59:57 -0400
X-MC-Unique: 2sMwyGl6NlW_sDQqo8Jp3g-1
Received: by mail-ej1-f71.google.com with SMTP id n9-20020a1709063789b02905854bda39fcso653472ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rjrGUELJrum5Ji89g/7iaRnZY9OVtK3tF4vpedgBiQw=;
        b=jn3bnX+g4hTdqoOjgmj0u7ZFmWJ5XxvfUl96+TJaXRk8kKh79tJb1abMC4o4pXxkgl
         geCLFDS4czpSYEt+tLqgtFf/uUWh4pxTRDKoHb0DFnykou5xml/DKJHLR7NvSf0VUtND
         v7OazWEcUFVATS7JdnPboYwl8QkswRRP9wjvYGRVXd2kzJBYm49YfctaTCaJV9PoPTqb
         cPL4l0+HWR5nBT4aY4P0I6pJCSBK2IzwJow1fb3/xLUU3kavTrO9i04t+q5OLXzW2rWu
         ICsGafq2QPULGAUleGqAEEYI2wn7GvZdaTVx3kjJf1ajTRprp6dHQAqaN10knBwrai/J
         97bw==
X-Gm-Message-State: AOAM530sBkTV42YstkiIoddhXCr9EexQT5+XR4fgRY1O+2q5NjvZpjM0
        sDmnbJdZw7piH3xU+iw6DnIChaXq4TzRueO1r3wJJKoBdULj3fmgd4ZquCJ3VWeRBrYNlJuo07/
        WF8KucHIEZOECdrwNzEP+vN2uT4RS69pd/cl6ZT4/UekR/VZybbQTXUHyRbKCCzyko52RuI2My5
        PX
X-Received: by 2002:a17:907:97c9:: with SMTP id js9mr26616798ejc.109.1627466396034;
        Wed, 28 Jul 2021 02:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+R9CtvMSrFv6XUecaVJPF6EkDx4k8me+9FoZ9YuZQCC0sy6c5eaUJPoGZ8dOhx+S85lT+Aw==
X-Received: by 2002:a17:907:97c9:: with SMTP id js9mr26616781ejc.109.1627466395789;
        Wed, 28 Jul 2021 02:59:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g24sm1838086ejo.77.2021.07.28.02.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 02:59:55 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: intel-hid: add Alder Lake ACPI device ID
To:     Ping Bao <pingbao@gmail.com>, Alex Hung <alex.hung@canonical.com>
Cc:     Ping Bao <ping.a.bao@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:INTEL HID EVENT DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210721225615.20575-1-ping.a.bao@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <49552fec-82b6-955f-584a-029e27c92d02@redhat.com>
Date:   Wed, 28 Jul 2021 11:59:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721225615.20575-1-ping.a.bao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/21 12:56 AM, Ping Bao wrote:
> Alder Lake has a new ACPI ID for Intel HID event filter device.
> 
> Signed-off-by: Ping Bao <ping.a.bao@intel.com>

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
>  drivers/platform/x86/intel-hid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
> index 078648a9201b..e5fbe017f8e1 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -25,6 +25,7 @@ static const struct acpi_device_id intel_hid_ids[] = {
>  	{"INT33D5", 0},
>  	{"INTC1051", 0},
>  	{"INTC1054", 0},
> +	{"INTC1070", 0},
>  	{"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
> 

