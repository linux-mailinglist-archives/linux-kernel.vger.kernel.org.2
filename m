Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E034699F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhCWULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230242AbhCWUK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616530257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMmqphSIpyGIdwXaXQ9UFjEoXFttNCQg2W2cJwWjR9I=;
        b=c93mpHnkLMZGedPoJ1e5FfNkeYCslmrnYdxq8pOWjQXZLwjR+exUMA8l1XJREtiAIfXc8F
        aHZUDlrsjnCX+Bn3e6n4tZfVsyA2Vqe+wmlMAtfJqL9A2MmIxsBKhwO2Jhdbjswa8dtl+y
        0Vc0b8D/javKShvBydFwT2KUZ5Zz9VU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-Xeqgm1SLM32SpAF-Iumh6Q-1; Tue, 23 Mar 2021 16:10:56 -0400
X-MC-Unique: Xeqgm1SLM32SpAF-Iumh6Q-1
Received: by mail-ed1-f70.google.com with SMTP id n20so1515878edr.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMmqphSIpyGIdwXaXQ9UFjEoXFttNCQg2W2cJwWjR9I=;
        b=aMlZcWJW7uSt8rVTgrY6AREE4s/7oMcPa7cfvxQl4wIEjykMzynKMw4gnRL9YREimI
         kEJ6mThb2Oew8A0xHlS/Tq9NlOYY0EEwoPZ4sOc2gW+79o38rVq06rRgZ/6n9gCndsiE
         TQ10MSpEUREFh0DpuMNvcRZl1af0D1BtC5NiqPdGI6p0U8dBRapf/3fRRadGlUEED3l5
         BVMflTD2EMlXDUyRX5o3fi4lCffVrlsQWTGQoONhWRo7oqY/K9DvNd4r4wm+DUlhkvVY
         Te00/Nb97cS93Cs4aQT6AKH+FedsnMprgrGKqAz4ffPwK7d/Qc8O/JaPcOeZCelaOQzh
         QBIQ==
X-Gm-Message-State: AOAM531ocIQIhEOkOtnNddYkLdX/vH61XX9u7VjPC3HynNQvIsoKrSck
        Vh8pxxRWWCc118dW705O1B08bXvlCEC8AXY+kvtcDsuSbbBAqUaZrwpJJRtENRsCd2Aca6Zlxi+
        il2iS+/ozlg/hMveRbX+8wE6GVuzG/eJtwOJpth2EidNoCs3sx7zb0Y9IOfWdkO3Koe2BjEBvJI
        D/
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr6571551eje.104.1616530254618;
        Tue, 23 Mar 2021 13:10:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmQnpxczsdFVTCGrCOlrNBdv4450SdVerGPHtabMnbA6KqhVkl6oDhjpPgZ+CJH7bKt+sEsQ==
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr6571536eje.104.1616530254459;
        Tue, 23 Mar 2021 13:10:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q26sm11651636eja.45.2021.03.23.13.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:10:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: intel_pmt_class: Initial resource to 0
To:     "David E. Box" <david.e.box@linux.intel.com>,
        mgross@linux.intel.com
Cc:     lee.jones@linaro.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210317024455.3071477-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce0a6502-21d6-0010-66d7-beeacd16d063@redhat.com>
Date:   Tue, 23 Mar 2021 21:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210317024455.3071477-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/17/21 3:44 AM, David E. Box wrote:
> Initialize the struct resource in intel_pmt_dev_register to zero to avoid a
> fault should the char *name field be non-zero.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
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
> 
> Base commit is v5.12-rc3.
> 
>  drivers/platform/x86/intel_pmt_class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_pmt_class.c b/drivers/platform/x86/intel_pmt_class.c
> index c8939fba4509..ee2b3bbeb83d 100644
> --- a/drivers/platform/x86/intel_pmt_class.c
> +++ b/drivers/platform/x86/intel_pmt_class.c
> @@ -173,7 +173,7 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
>  				  struct intel_pmt_namespace *ns,
>  				  struct device *parent)
>  {
> -	struct resource res;
> +	struct resource res = {0};
>  	struct device *dev;
>  	int ret;
>  
> 
> base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
> 

