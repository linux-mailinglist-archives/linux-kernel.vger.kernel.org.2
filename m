Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6643E9F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhHLHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234118AbhHLHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628754120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4TpO8iJibyPxP/Isv1KfPXChojva1yiR6ZPzSTMnXo=;
        b=gtAHdIQmc8G6PwKLOvNixLe26Ix5oPsvIpuP2BhEIfEoW074NeREv2Kj+Bslm6pL63djOA
        NZBCREhmbQz6pX7JBAEttVDiUE9K28vqvCz0Sin95/IZf1LPJiqB4u8kYvYHdVYzDJvag0
        ZvcREVPWe0m7IogO45WFsG0A3yeA6u4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-kGVgusB3MrGLSozZaboD_g-1; Thu, 12 Aug 2021 03:41:55 -0400
X-MC-Unique: kGVgusB3MrGLSozZaboD_g-1
Received: by mail-ed1-f71.google.com with SMTP id m16-20020a056402511000b003bead176527so95114edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4TpO8iJibyPxP/Isv1KfPXChojva1yiR6ZPzSTMnXo=;
        b=Txh6E24XdBGeIwfzC2Lh6RrjJKWI141DoUC2CNl0wChsg8yeWTd2h4D+2y+VXnI0It
         mfh7BlBQEl+cpb0Nn8RbfpMqww0zhjUmgGyBL56T8sZsrxnBZ9a9O4ePX7ESjuakDANP
         QaCzdJ4jL3GXmsLxgWv+9fvV5+weCcj9t4oUjDu+3CJv6PSLUhHAt1RoHbqjMlDm/x0r
         Lel0cNKya7sCYVMOoIVRNnR3jV48Nt+2xiVYG9QjG5uqcV3y6wplwUXi6BKlYSiLcqG/
         /QE3pZMAQCu61bjPrFO0gPnealXWcBFUzjzr1nL5TVL9Z89oKWZ52sbptEeOlA26sw9U
         TImw==
X-Gm-Message-State: AOAM533/omT3Oz5cBMS9+txmyWN5bXVePTImTbaazbAtg/zIfue0rs4y
        a+iduenzawmtsWjxyO183flEhOv1BlWvQEKGOo6IxQM1J7k6N4M/3Y01/PGP1gggv7jy9WHCkmd
        TpGkwnLo16CEeIaxfVy9+cDSE
X-Received: by 2002:a17:906:551:: with SMTP id k17mr2361849eja.391.1628754114674;
        Thu, 12 Aug 2021 00:41:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv5hHff6uRU/Ik2WW3csB/wvz4oYxpyyIYPf+uZAO6Be3jJaOO0j0iG3axT0YOjaZHnHVFqA==
X-Received: by 2002:a17:906:551:: with SMTP id k17mr2361838eja.391.1628754114537;
        Thu, 12 Aug 2021 00:41:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f8sm737462edy.57.2021.08.12.00.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 00:41:54 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: ISST: Fix optimization with use of numa
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
References: <20210811033633.1204567-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <119ab09f-9aab-9980-c1d3-72decff43488@redhat.com>
Date:   Thu, 12 Aug 2021 09:41:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811033633.1204567-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/21 5:36 AM, Srinivas Pandruvada wrote:
> When numa is used to map CPU to PCI device, the optimized path to read
> from cached data is not working and still calls _isst_if_get_pci_dev().
> 
> The reason is that when caching the mapping, numa information is not
> available as it is read later. So move the assignment of
> isst_cpu_info[cpu].numa_node before calling _isst_if_get_pci_dev().
> 
> Fixes: aa2ddd242572 ("platform/x86: ISST: Use numa node id for cpu pci dev mapping")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> Fixed "Fixes tag" as suggested by Stephen Rothwell

Thanks, but I just fixed this myself in the pdx86/for-next tree and I've
done a forced-push of for-next with the fixed Fixes tag.

Either way this is resolved now :)

Regards,

Hans




> 
> Update:
> 	The fixes tag was wrong
> This patch can wait for next merge window as these systems are not
> shipped.
> 
>  drivers/platform/x86/intel_speed_select_if/isst_if_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
> index 6f0cc679c8e5..8a4d52a9028d 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
> @@ -379,6 +379,8 @@ static int isst_if_cpu_online(unsigned int cpu)
>  	u64 data;
>  	int ret;
>  
> +	isst_cpu_info[cpu].numa_node = cpu_to_node(cpu);
> +
>  	ret = rdmsrl_safe(MSR_CPU_BUS_NUMBER, &data);
>  	if (ret) {
>  		/* This is not a fatal error on MSR mailbox only I/F */
> @@ -397,7 +399,6 @@ static int isst_if_cpu_online(unsigned int cpu)
>  		return ret;
>  	}
>  	isst_cpu_info[cpu].punit_cpu_id = data;
> -	isst_cpu_info[cpu].numa_node = cpu_to_node(cpu);
>  
>  	isst_restore_msr_local(cpu);
>  
> 

