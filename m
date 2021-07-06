Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC823BC90D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGFKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231221AbhGFKLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625566118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkUL5b8YgAi/G+425pjIUtZ7clWR3x75JHUPwUSdKOA=;
        b=SNx4q0MTCxoOHntz24HVkFm49v4oLqpbvfZAAZaDpBNxHOEZoP1HVfSwYDQZoteV5nsuce
        GRCvv+5TJzwIpneUmy468TQNT5fL5BPhQkH9H8RMAi1eZYOsI0G8L2s3skerdmsOG3tDAi
        NL0NpTtPQNy7rZmeRpy07DperLJcOw4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-gpfRjyj3MMuUyWRQI5iz_Q-1; Tue, 06 Jul 2021 06:08:36 -0400
X-MC-Unique: gpfRjyj3MMuUyWRQI5iz_Q-1
Received: by mail-ej1-f69.google.com with SMTP id de27-20020a1709069bdbb02904dedfc43879so1162181ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 03:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fkUL5b8YgAi/G+425pjIUtZ7clWR3x75JHUPwUSdKOA=;
        b=Sy5qkcGkzQfgcT33ROnqE07IjGUSI0Re6ceCFMdlpY4o5+zBQ0xVURrRUr7ty7m320
         0SjIBl2maFshuoYH4iFQGMcHZ/jnVwbYXy4kZ+v694VHZtiXQKqubZdLLuGSrBQ+uCUA
         Z9aKn4QX9O8NqXnKbw0lwFQME1h31c3LzlWE2rybCY0wOaFR7bLq2/TGjUEJC7KFBssU
         mpb2Bs1nb+mg90+Y9w+x4eRZ5TtGXkE9PBAya42u6IlTV5QgP6blysp8kk475KfF68+s
         BWthU63NmxiL/5d/Xxrq9U/riVBXQCFLnajAv/RT+wJw4amwhk02CrHuGjqNIKhf/K9g
         fjUw==
X-Gm-Message-State: AOAM533JtkVZL4F0DMym2rJAy5IctK3TwMwCkaAAQ6QPz3Bq7MHjLSjy
        zqbQovP0GptP4mcMq6SVB7uE+bu8W/mH2hC7nH8Iw6AMFYbqfuOjLrlMOusiPRXmYSEVhSTc2Qo
        KMhHrx/pJdEe6lX7Ko7guSx1yK21z0wO2cN5Yyn0H2JZPmfsnTDMr3R3y4ICJxGazcm1r6pi3dk
        oq
X-Received: by 2002:a17:906:1284:: with SMTP id k4mr13111095ejb.329.1625566115602;
        Tue, 06 Jul 2021 03:08:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI2oIY2Q+GKYwex6EIiIxA4L1dDu4N//GmIomNoCTAnkVBF4rfHyYmntgD3gGsPyBHTM8GOA==
X-Received: by 2002:a17:906:1284:: with SMTP id k4mr13111077ejb.329.1625566115426;
        Tue, 06 Jul 2021 03:08:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t27sm5442382eje.86.2021.07.06.03.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 03:08:35 -0700 (PDT)
Subject: Re: [PATCH 1/3] asus-wmi: Add panel overdrive functionality
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210704222148.880848-1-luke@ljones.dev>
 <20210704222148.880848-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <176320b4-7461-3a97-2958-0c35dbdac0ae@redhat.com>
Date:   Tue, 6 Jul 2021 12:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704222148.880848-2-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One more remark inline:

On 7/5/21 12:21 AM, Luke D. Jones wrote:
> Some ASUS ROG laptops have the ability to drive the display panel
> a a higher rate to eliminate or reduce ghosting.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ebaeb7bb80f5..2468076d6cd8 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c

<snip>

> +static ssize_t panel_od_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	u8 mode = asus->panel_overdrive;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);

As Barnabás pointed out in his review of patch 2/3, please
use sysfs_emit here.

Regards,

Hans

