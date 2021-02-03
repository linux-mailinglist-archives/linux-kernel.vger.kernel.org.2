Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8268330D994
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhBCMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234394AbhBCMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612354264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNrxU4m48kCXgurPGNqZF1Ysv2wFEFXV5yTwl2DTSK0=;
        b=EQU0z0ijHF7r1OUVTCF7kIDAcErDjYnFcMR5VJBBxllsGurHDgDA0lDNwjy96uVHmgOcfU
        I/hC2aXfJ8ikP6Bxt3D136dLvlKucZYn7ed5UKoPKl+7JHYhLjFmcPqO1ST7x14kvGeFik
        jPo5hzF67xc6bUInH4VAXcnS6dr2thM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-3ARbPb0hPUGPiQWh5VTj4g-1; Wed, 03 Feb 2021 07:11:02 -0500
X-MC-Unique: 3ARbPb0hPUGPiQWh5VTj4g-1
Received: by mail-ed1-f70.google.com with SMTP id f21so11401825edx.23
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eNrxU4m48kCXgurPGNqZF1Ysv2wFEFXV5yTwl2DTSK0=;
        b=Y+OlZyu2PUtNTrKCLz0ZfJfDYI97EmcDFnmZQ6MCV4enU0CnTvcBTHBC/8m9CCLvbM
         2MawK4ip+GCdjvsvKNwGj4vRIb1Qh6EXBtDC8Rp19IE18ltUiUcuBa4uMIvI1zwNY1n7
         akBGiyTZ/32EN5uLWNpPH3u1a3HEv5f+ckds5BUKS5RugE78BBJUDirBgBj/vvkJuU9H
         ikvcoFR6eJrwLFAAPr7k/MxFOKQkndan0lkwk/CwO4axIAwesjoX0GCZW8GdftjMK2/W
         PrMpMyehSNT7w7Z8DBy95qB4cFyVeRSyTWQoNVXZe8+GxZgcn7WHWK1LoLqCXhoyir2M
         ummw==
X-Gm-Message-State: AOAM531DkfSwHkaWq1nJnjtOG8bbNkLq43HlNWBDzYbHyriR3zgkzIle
        kJD1Cbt+zTNm4hZlUX000vumMIQaEjxjZZY1sK+tpmEHaPCrQu9uwZ0QLPvYpCDMHeaV8vxvZGs
        NtrRYZnCK0tQTEofzKf/6r6fqAUvWacaZOQhqPZ+EVMMp3btkDUn1Wo16NwVd9LirTL9h5kHA4W
        2b
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr2655196edv.19.1612354261266;
        Wed, 03 Feb 2021 04:11:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVY6WTifrvLloI9VZH53nxwFUdupvWyj8T1hKEqfyzVNm9BOeA7KMLBND0m5A15QUVT1xy7w==
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr2655173edv.19.1612354261102;
        Wed, 03 Feb 2021 04:11:01 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id u9sm918518ejc.57.2021.02.03.04.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 04:11:00 -0800 (PST)
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Add Sapphire Rapids
 server support
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210203114320.1398801-1-dedekind1@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <957581dd-bf8f-de6e-22dd-a0102d5de01f@redhat.com>
Date:   Wed, 3 Feb 2021 13:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203114320.1398801-1-dedekind1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/3/21 12:43 PM, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Sapphire Rapids uncore frequency control is the same as Skylake and Ice Lake.
> Add the Sapphire Rapids CPU model number to the match array.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

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
>  drivers/platform/x86/intel-uncore-frequency.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel-uncore-frequency.c b/drivers/platform/x86/intel-uncore-frequency.c
> index 12d5ab7e1f5d..3ee4c5c8a64f 100644
> --- a/drivers/platform/x86/intel-uncore-frequency.c
> +++ b/drivers/platform/x86/intel-uncore-frequency.c
> @@ -377,6 +377,7 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
>  	{}
>  };
>  
> 

