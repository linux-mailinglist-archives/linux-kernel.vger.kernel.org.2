Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1033E2B77
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbhHFNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344071AbhHFNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Kg/3wpbHPGY8QiEti3oujLf1Kfz97Fyjmx7Lv1iixU=;
        b=eZK5TQMuXYO1ABew6xEbB9EsB+HZzwe1arqlK4QRMdRxMs8KdgKZru3kjpUW/5jirX6UoA
        yznFOBsyDThiIEGgcqCpGAqV9qyZUuaE/s4NlKDPw3w5dMRGOc9Sgj6GZlWydHmg+HgNdo
        6waeRqUYdI27t0l2p7OSHvrTpMEpHO8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-3Bia0mb0OmW467OKqKC4qg-1; Fri, 06 Aug 2021 09:36:59 -0400
X-MC-Unique: 3Bia0mb0OmW467OKqKC4qg-1
Received: by mail-ed1-f71.google.com with SMTP id ee50-20020a0564022932b02903be1503f932so1548065edb.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 06:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Kg/3wpbHPGY8QiEti3oujLf1Kfz97Fyjmx7Lv1iixU=;
        b=LP9GkwqE1X66swOvPZTsrI090eTOWgv+Z8ZNbLgRuQfhqgejVT0xZkT/g0WEKMRwR4
         DBUUt3D6n+EOhsnyRlzjk41Cj7+vE+mKYfMHTMjkFtBVTdoF5uTKQSNYq33XylNvv+gu
         6A0jvkRFfL5iSqqishL+2OavMH719TZqTXMGr/Ve4QeCKYY1+zN3GNAUMUQHMEveYN98
         g5xTOfZ+J3TpnDDXFgvDTx8dQ63NqurAoH4krJuU8U8VrmTvq5pbrzthz+h/MYRvB0LC
         nHbnqg2nbQsKUQn+EHMRs3uP6OzfyhECqDQuMc3P4dD4tuNeIM+5KOji9k4q0ROeg9rl
         FCAQ==
X-Gm-Message-State: AOAM531HE2CRM/n4obX5cuWnA+OnwlVX0odbCLzk4ZTv+PrFcm2ZvWUn
        0JSwRSHQl2pecIb6k9kbNozZeVtGRmUZjFi5qZ9kaDS+Mhdqc4Qi90syuA+AFwY+8gd7xfhd5Us
        hxttlHzVBh2tHOqGVmKdVZH3z
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr12867729edb.348.1628257017283;
        Fri, 06 Aug 2021 06:36:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9ZlD3WAV5kdYQff1yayXheNG81y9yPNMtBlE5lwppefJUPLztti6EY51K9I02yGx//2FhEA==
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr12867713edb.348.1628257017173;
        Fri, 06 Aug 2021 06:36:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n16sm3858799edt.31.2021.08.06.06.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 06:36:56 -0700 (PDT)
Subject: Re: [PATCH 17/38] platform/x86: Replace deprecated CPU-hotplug
 functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-18-bigeasy@linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9769b45b-40c0-b7fd-01f2-6852df18def0@redhat.com>
Date:   Fri, 6 Aug 2021 15:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803141621.780504-18-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/21 4:16 PM, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <mgross@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
>  drivers/platform/x86/dell/dcdbas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
> index 28447c180be88..5e63d62250481 100644
> --- a/drivers/platform/x86/dell/dcdbas.c
> +++ b/drivers/platform/x86/dell/dcdbas.c
> @@ -278,9 +278,9 @@ int dcdbas_smi_request(struct smi_cmd *smi_cmd)
>  	}
>  
>  	/* SMI requires CPU 0 */
> -	get_online_cpus();
> +	cpus_read_lock();
>  	ret = smp_call_on_cpu(0, raise_smi, smi_cmd, true);
> -	put_online_cpus();
> +	cpus_read_unlock();
>  
>  	return ret;
>  }
> 

