Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF3365BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhDTPD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232835AbhDTPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618930972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rt7NKGaDjHDmt2xUfgF5jDi+mP8ivKolM0XswNMHLOA=;
        b=Djh7lF0rK2cCX8xDu54yskvMXoVX1CrAqP59cEOVo+Has61vqjM6x7PmJt1bh3USdJZfXI
        cSZRL+X2uFw2+t7/M4JdzYQrGnMoUuLDyagLbrTcvX/tY3IaKiQFjF0sgywIOkbvzbATXi
        keRTEi9RCObxs785Hr3I52Olsy0XIeE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-MYqhKWm8NXqlNQBSCjwJZA-1; Tue, 20 Apr 2021 11:02:51 -0400
X-MC-Unique: MYqhKWm8NXqlNQBSCjwJZA-1
Received: by mail-ej1-f71.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so4887256ejz.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rt7NKGaDjHDmt2xUfgF5jDi+mP8ivKolM0XswNMHLOA=;
        b=XkIRrkE5dEhTugDLZtQ7w3C6Y1GtugVe9erN/vjl4WN5vx6Z3y2/Daz8PxEyymP4U/
         yuEM27os2PUmG6m0c3aecOm5g2BEeZUbsVJYCRdEzaVTVZNL+HQYHAq38fsB1mqju3nu
         V95mPbQtAMtpJRFEDzEQEMqY9osDJY/LA9pZJ7SfsmtD51ek8S7HyFqxx+wfjnx1ljV0
         nskSu4yTBlfntQURPGjoxKRN0Wh7K4kNqTFmvhUmj9B+S1whtQDjhV0iMbkCrVwR2/EM
         VIz0Kg9XZ9ebFPsop4cKk498PKuduAJKFuRu0sSnCeZpQiWQmcCFe/icOL2DLQ6WQ1fV
         ellA==
X-Gm-Message-State: AOAM530aFw8P5o4c6rDrClY5sPrp9EOiIAqUqhn6F2iAlQCbWQqC7dKU
        czDH4SBnpIQoo4Dl30i1ws/h/9gjgSJDuJApaFlzoQPz2cnnz+axTyq5Zc1PHAnKHzHWGlon9Jh
        0yUMnU8HnLEEDL36wG1QvEk/VKhRuVs3t6Bph5AxBkjEHT2uADBjRfB5zWsimBwl7wYmbruQGi6
        ny
X-Received: by 2002:a17:906:13d6:: with SMTP id g22mr28063995ejc.475.1618930969886;
        Tue, 20 Apr 2021 08:02:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8mzqn6L2EwFc7Dx0OfYgYfDc/bUY8zJsA2Mtisctwz4KFSvxkXRHeKmP7F7oY7klb0bilcA==
X-Received: by 2002:a17:906:13d6:: with SMTP id g22mr28063975ejc.475.1618930969667;
        Tue, 20 Apr 2021 08:02:49 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bu20sm1745180ejb.76.2021.04.20.08.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:02:49 -0700 (PDT)
Subject: Re: [PATCH][next] platform/x86: intel_pmc_core: fix unsigned variable
 compared to less than zero
To:     Colin King <colin.king@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210420121044.379350-1-colin.king@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ba5a2360-68b2-a3e6-c379-5122e698bfca@redhat.com>
Date:   Tue, 20 Apr 2021 17:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420121044.379350-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 4/20/21 2:10 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for ret < 0 is always false because ret is a (unsigned) size_t
> and not a (signed) ssize_t, hence simple_write_to_buffer failures are
> never detected. Fix this by making ret a ssize_t
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 8074a79fad2e ("platform/x86: intel_pmc_core: Add option to set/clear LPM mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thank you for the patch, but I already send out the same patch myself
yesterday, so this is a duplicate.

Regards,

Hans



> ---
>  drivers/platform/x86/intel_pmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 3ae00ac85c75..d174aeb492e0 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1360,7 +1360,7 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
>  	struct pmc_dev *pmcdev = s->private;
>  	bool clear = false, c10 = false;
>  	unsigned char buf[8];
> -	size_t ret;
> +	ssize_t ret;
>  	int idx, m, mode;
>  	u32 reg;
>  
> 

