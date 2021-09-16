Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468B340DB36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbhIPNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240057AbhIPNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631798980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNUyJu951BhTSiFHZpKJrsLVVUjWy7DLWDoXmLf4AkI=;
        b=Aepjr3vHkYXTaIjzDjtOQQ/Oltx2uWqNQ5zJDQFTfIsRDXMjNqoK2y6djO6Xn2bFKqcZFt
        qN6fchJ/zsuHeJHzuT6Eb6GLijijOqTowdtlUJeagQGtmqpC+5bACd1JhxNJ1eRXsbMkwZ
        Cs0QTJ+2WCWg9aIOeBsMnrHWJAXl+24=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-CCUI0y_BMLi8lGLdmLXzVw-1; Thu, 16 Sep 2021 09:29:39 -0400
X-MC-Unique: CCUI0y_BMLi8lGLdmLXzVw-1
Received: by mail-ed1-f69.google.com with SMTP id b8-20020a056402350800b003c5e3d4e2a7so5431482edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UNUyJu951BhTSiFHZpKJrsLVVUjWy7DLWDoXmLf4AkI=;
        b=hQ6X2/Kn/2q297G+ok8Ff0jn1/Ey5WH+YCjoQnTthWU7oa60zC946qK3QchhYTpwOx
         hgtjnjJQUdys7JEoaHWnkMH+x3/t4cwpk5BBqUDAraEgTu6ZSUcrxiI6zHAM8D3bRO7z
         xOnUIsXtTzodm6YoM2fHsfy9U2m5yMa4MtIWYA+xJoKGDRoE4A4w+cGt2Q0949a+pUbn
         29jQZQbhwjF3mkDN6/klNysFcZpQzl3ymi0e9kqw6aFHvXvjUFEUOmAyM1Ni1OsI84qf
         ZdkbzUK/EiMP+SIi+WEaI0J4AAkr1tWyXxM9O2vYdbVYRWZxVMhG7gVwcim6z9+ybQaX
         5lpA==
X-Gm-Message-State: AOAM531KB4ipGDHUTX9Q3yHrsFJqReayErTwF0f+8986CmnRR8OWUUxV
        wrWirKlJyUbAE5P2COaUGpxEMMbi1YYioJMtLMKOrCaJm7+p+RnEo4pJiNpXdnWlPsiMwN6ukt3
        DeJ+4xMvjfkKKgw2ui+uREe6FjUwUeB0S6inI5QG4KqxjCev1eOTurexsv+0aQODeg7ig+jX1b8
        kv
X-Received: by 2002:a05:6402:1808:: with SMTP id g8mr6445038edy.188.1631798977774;
        Thu, 16 Sep 2021 06:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwn49jlXs40BqzVoyB89n7L3QbZtj8ZP+wvht+EJhEbTQOs9HeOEyVNBGkrMkuPr5qgBN6Nw==
X-Received: by 2002:a05:6402:1808:: with SMTP id g8mr6445018edy.188.1631798977581;
        Thu, 16 Sep 2021 06:29:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s11sm1373620edy.64.2021.09.16.06.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:29:37 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: amd-pmc: Check s0i3 cycle status
To:     Sanket Goswami <Sanket.Goswami@amd.com>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916124130.2581-1-Sanket.Goswami@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <145806c4-e544-0a76-0e63-553375d1ce9b@redhat.com>
Date:   Thu, 16 Sep 2021 15:29:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916124130.2581-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/21 2:41 PM, Sanket Goswami wrote:
> As the PM firmware returns the status of the last s0i3 in the smu_metrics
> structure, the existing name "s0i3_cyclecount" seems to be a misnomer.
> Change it accordingly to "s0i3_last_entry_status".
> 
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>

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
>  drivers/platform/x86/amd-pmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 0c970f613e09..91c1f1c6c929 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -141,7 +141,7 @@ static inline void amd_pmc_reg_write(struct amd_pmc_dev *dev, int reg_offset, u3
>  struct smu_metrics {
>  	u32 table_version;
>  	u32 hint_count;
> -	u32 s0i3_cyclecount;
> +	u32 s0i3_last_entry_status;
>  	u32 timein_s0i2;
>  	u64 timeentering_s0i3_lastcapture;
>  	u64 timeentering_s0i3_totaltime;
> @@ -170,7 +170,8 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
>  	seq_puts(s, "\n=== SMU Statistics ===\n");
>  	seq_printf(s, "Table Version: %d\n", table.table_version);
>  	seq_printf(s, "Hint Count: %d\n", table.hint_count);
> -	seq_printf(s, "S0i3 Cycle Count: %d\n", table.s0i3_cyclecount);
> +	seq_printf(s, "Last S0i3 Status: %s\n", table.s0i3_last_entry_status ? "Success" :
> +		   "Unknown/Fail");
>  	seq_printf(s, "Time (in us) to S0i3: %lld\n", table.timeentering_s0i3_lastcapture);
>  	seq_printf(s, "Time (in us) in S0i3: %lld\n", table.timein_s0i3_lastcapture);
>  
> 

