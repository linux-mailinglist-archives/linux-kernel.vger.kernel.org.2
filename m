Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7E453263
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhKPMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhKPMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:50:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710CFC061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:47:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u18so37340867wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c5/KTLVvR3BJdfIEE0p7kWio2KA/K90eQBw1cy+0lJk=;
        b=kgQwvjFC345ckzu5hVYyrL57i45K0iHDRPBMVrqMmdbwGjoWDeo0bwM3NuGKoAyvci
         8DhbMJDvlWQVTgnZ5oEHpbmN/qVB0mEoPi9OLCHXMGzV0UDioO+ctv5Pb+JaAia3O0qj
         7lJIZ1sldZ1mDsTQRg8nbfMB4d1OxOSz4+4xo6fRCsIg93o6W1aG7fsiMOQao1DpySIS
         ExwTp4fXQi85Um3KIMVaRFBvPHyuV8OkFwKXP8IeSqlu0yUHUwdBq7XPt5SjgDSeF8hD
         1pnTtyAqdXG7UVSEUqZksfg03GBVgHssMkjEHofmVmpTS3XEjESp8mI8poqI3sLap9oP
         pK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c5/KTLVvR3BJdfIEE0p7kWio2KA/K90eQBw1cy+0lJk=;
        b=uy8t3d5Fj9SpfHudyE7Zij0msTRO0Ya7vMGL8rWeV0luN8opz2szfObD26FJRi6jKm
         PTmscsGy2kTuaOlViDNo2IxXtUoJARxT0Z65rDtAZbf89ACh3GsePOTnPYPlrIdj607L
         h8zl1yNsZ4ZZN2wMQEB9nYTN8KVpm0pZUoJv82RvX3QHWqtfG3IjExlOMte1UBTtPnGa
         +AMYxGdxIH8Iz0y1Ckqc86OaF1oihX07SAYQSqOPkDXcrRvnygTCRgEYhLpFviYG6H8k
         /3O0QakhSiTPAWoS3yadX7mdmKGpatcpwVXS+2I7NP2U4aM3mcg9QwGX740avSd4+Ge5
         kSvA==
X-Gm-Message-State: AOAM533WKACil8kFmdyA77DB+E5r+mK3Ji6GlvyNwhw+5hDA9moJi2wo
        wjCPWDXbHnlsZwlbXhnxdAf1dztEt+8qWQ==
X-Google-Smtp-Source: ABdhPJzYRupKewbInf6ZkbCTD95VT5VQWs/qsulaEYC2CI9irlBDBLaH5SrVdBxGJz1oSayR1/SDOw==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr9284285wrt.22.1637066845753;
        Tue, 16 Nov 2021 04:47:25 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k27sm2671323wms.41.2021.11.16.04.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 04:47:25 -0800 (PST)
Subject: Re: [PATCH] genirq/irqdesc: Add state node to show if IRQ is enabled
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
References: <20211116123447.23902-1-srinivas.kandagatla@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ffef6293-da93-2d22-f1eb-8e74a6035303@linaro.org>
Date:   Tue, 16 Nov 2021 12:47:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116123447.23902-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2021 12:34, Srinivas Kandagatla wrote:
> While debugging some issues with SoundWire WakeUp interrupt,
> I did not find a way to figure out if the interrupt is really enabled
> or disabled.
> 
> So I have added an new state entry in the sysfs to dump the current
> interrupt state.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> While debugging I found this patch very useful, specially in SoundWire Wakeup
> usecase where we dynamically enable Low Power Wakeup interrupt.
> 
> Sending this out, hoping that it will be useful for others as well.
> 
> --srini


Please ignore this patch! It will not work for every case.

--srini


> 
> 
>   Documentation/ABI/testing/sysfs-kernel-irq |  7 +++++++
>   kernel/irq/irqdesc.c                       | 16 ++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-irq b/Documentation/ABI/testing/sysfs-kernel-irq
> index 8910d0c4bcd8..d858ed133ba2 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-irq
> +++ b/Documentation/ABI/testing/sysfs-kernel-irq
> @@ -58,3 +58,10 @@ KernelVersion:	4.17
>   Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>   Description:	The wakeup state of the interrupt. Either the string
>   		'enabled' or 'disabled'.
> +
> +What:		/sys/kernel/irq/<irq>/state
> +Date:		November 2021
> +KernelVersion:	5.16
> +Contact:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +Description:	The state of the interrupt. Either the string
> +		'enabled' or 'disabled'.
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 2267e6527db3..60c69978ea45 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -265,6 +265,21 @@ static ssize_t actions_show(struct kobject *kobj,
>   }
>   IRQ_ATTR_RO(actions);
>   
> +static ssize_t state_show(struct kobject *kobj,
> +			  struct kobj_attribute *attr, char *buf)
> +{
> +	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
> +	ssize_t ret;
> +
> +	raw_spin_lock_irq(&desc->lock);
> +	ret = sprintf(buf, "%s\n",
> +		      irqd_irq_disabled(&desc->irq_data) ? "disabled" : "enabled");
> +	raw_spin_unlock_irq(&desc->lock);
> +
> +	return ret;
> +}
> +IRQ_ATTR_RO(state);
> +
>   static struct attribute *irq_attrs[] = {
>   	&per_cpu_count_attr.attr,
>   	&chip_name_attr.attr,
> @@ -273,6 +288,7 @@ static struct attribute *irq_attrs[] = {
>   	&wakeup_attr.attr,
>   	&name_attr.attr,
>   	&actions_attr.attr,
> +	&state_attr.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(irq);
> 
