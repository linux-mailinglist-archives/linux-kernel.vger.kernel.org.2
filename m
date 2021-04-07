Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A034F356F26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348740AbhDGOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233168AbhDGOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617806918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjWRf2e6o/JzDynLaUHm4RQ83JFb64f/gW9Jl6qFnaQ=;
        b=OnOIlSjP9gK7jSBTGjcWPP3hSk4MRCXERYxuMs71B5Vwq/MDQQa3qtbPj9jhKDIew2JwnZ
        M6yjs9RwG+KixA9+hIZdfJQabx6mDmJm5mahbsOKSeFHrcn15kbRXmf+0MKJ/5LHp8HXf2
        TUDSFJu1urZZAXcLu6cooFZL+CcHW3c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-1Gc7CZ5mMS-AWKOxmmfztA-1; Wed, 07 Apr 2021 10:48:35 -0400
X-MC-Unique: 1Gc7CZ5mMS-AWKOxmmfztA-1
Received: by mail-ed1-f71.google.com with SMTP id q12so12224294edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JjWRf2e6o/JzDynLaUHm4RQ83JFb64f/gW9Jl6qFnaQ=;
        b=FpEzS+RFoyc0ZYIyhkx8J7KpKrefdvRLMv/7Vm86MOY8J93oqyedj4LxDnUslExo8P
         mxmu1rWjhcselNHnkh9G9SiM3u8GlKABtchpVpVxZvrPM7daK0aW/aiuRHhOrxdBY4cT
         qDjWPzhpTgzkFJzw81fVTTA/9hNN1NuNd7nBSj9eZ8wVaQvBFSFi6jvaLuIzMDt/6/Hj
         ID/bAyIMfvov0VZxB8AOgHyY9BjCaIJVt7GxKQTM+a12eVM2f2+KiLKQ5kiiY7DUe9dj
         DtvfQ5ZzrhXJ4k8mxj3xyvBXAmBfjU69xdlnAu6XVOvTZSTxDsrijFZDKc6OWvZJdpCB
         inaw==
X-Gm-Message-State: AOAM532Izt+6v4ILNjjHwJEwruw0MFWH41A+uhQy6aC8Rb9uL0OdfcW5
        aM6v1jh0XmSvCqip7CTcxoxitowNHh/DBi/AN0cqPXTKMQaZ1JebzKdkPm6b2V659l/ndZzyaWV
        1mZlcTth/GIwJo2hBqC2MAyqGXPWrTppAAyJQv8UGKm5jzzgBQaehmaY3jYL+kJwX1tOvAO1wPU
        1l
X-Received: by 2002:a17:906:aad4:: with SMTP id kt20mr4157080ejb.367.1617806913667;
        Wed, 07 Apr 2021 07:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypmXkcI7aFjUtZAONHueGeCKZ2vuS1trA2VvQKkE19ZBHZlRZsYsQZJx3SDVU9wleeMZE23Q==
X-Received: by 2002:a17:906:aad4:: with SMTP id kt20mr4157051ejb.367.1617806913483;
        Wed, 07 Apr 2021 07:48:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lf6sm7731455ejc.33.2021.04.07.07.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:48:33 -0700 (PDT)
Subject: Re: [PATCH 9/9] platform/x86: intel_pmc_core: Add support for Alder
 Lake PCH-P
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
 <20210401030558.2301621-10-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <22931e34-f344-b29a-87dc-c80584ed7f37@redhat.com>
Date:   Wed, 7 Apr 2021 16:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401030558.2301621-10-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/21 5:05 AM, David E. Box wrote:
> Alder PCH-P is based on Tiger Lake PCH.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/intel_pmc_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 9168062c927e..88d582df829f 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1440,6 +1440,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&tgl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&tgl_reg_map),
>  	{}
>  };
>  
> 

