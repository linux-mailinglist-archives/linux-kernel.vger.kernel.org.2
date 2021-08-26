Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7460D3F90C5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbhHZWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243753AbhHZWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:39:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D5BC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:38:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x16so1043535pll.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5oWRZN7Q/F2Ql6WdQHGzHjQZ7h58UYmf2jucjZtZOa0=;
        b=TqqCLWzBog4EQCnIlkUaABLF4mvq+06MUzLuPO3zag6b1aAiFGCqg5bwfzAm5QpDwA
         6TZv8WyrcBvpUzc1UkxdEq/HHCcv2PyYyy1S772PFeME2VkUiex/cglNoudFdx/b9u77
         9YkZkC05kdhw98ahKecU9RbQdCVYkVbpcln6UbuHbARe+T7Z5V9f3+S44DN0H9yjUvzf
         LPgndb/pIaiuT1nMsAm7cZkIyrHYsMTjgXWbrbBclJsBTT9/gbwSlheCr7O/uL4oSRHq
         QOytUGXduGFtCqVD/MfYbS/RxqYa87fK9o1JllN0n9eFe0vwteXItkRSbLFB/Fw7Lcus
         CEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5oWRZN7Q/F2Ql6WdQHGzHjQZ7h58UYmf2jucjZtZOa0=;
        b=RG3CkxQGE0b6a4uSEPGkNXNhr6/6UWTNgDwAMXjLJ9MGcRpMUQD8HNnVjgvmzxRV3S
         qDRSp6Kj4u61aZ1pGZN0a89F3VFwY+wf8dWwwBDdxo3sx5VB1gzWRjxOcB2N0E3roQp0
         FOYEUxa9iIa6IdTLThXlU/5wES9QeR8nrGUpyd37FEr71EB/q7z8kQSWsKwXeB6ALU3r
         U5wcEEjBbv2nWo95aDotE+SkylkqLjIEGkGlaoqNE5sdSzqKPISxA9Qz2WFngnHQyUcM
         7P4f5/yicmbmDlhp64rNhjaeVeAslcLu+PoRBHM7Awr7sCUnVTtzjkA871RUyfKEi9K0
         GzpA==
X-Gm-Message-State: AOAM530wgsiN1gYa05C9WM9qrr/pX5E75rqXoPMulWioMsl0KJdFktNB
        LyNQ10kBVzoz0C8nCTAUKhhOKn2AZuw7UfFa
X-Google-Smtp-Source: ABdhPJyL7zNA/CU0/35WOSVb0ekGEAD/Nr4Y7bhWnUrsKycz26Hy5QSCRJH5ZOuJ2LVT1919LW5XKw==
X-Received: by 2002:a17:90a:6d47:: with SMTP id z65mr19175597pjj.62.1630017500566;
        Thu, 26 Aug 2021 15:38:20 -0700 (PDT)
Received: from ?IPv6:2600:380:4910:164a:b6f3:b6f:f897:c2aa? ([2600:380:4910:164a:b6f3:b6f:f897:c2aa])
        by smtp.gmail.com with ESMTPSA id pj14sm3785089pjb.35.2021.08.26.15.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 15:38:20 -0700 (PDT)
Subject: Re: [PATCH] drivers/cdrom: improved ioctl for media change detection
To:     Lukas Prediger <lumip@lumip.de>
Cc:     linux-kernel@vger.kernel.org
References: <20210805194417.12439-1-lumip@lumip.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk>
Date:   Thu, 26 Aug 2021 16:38:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805194417.12439-1-lumip@lumip.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 1:44 PM, Lukas Prediger wrote:
> The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
> global state, meaning that only one process can detect a disc change
> while the ioctl call will return 0 for other calling processes afterwards
> (see bug 213267 ).
> 
> This introduces a new cdrom ioctl, CDROM_TIMED_MEDIA_CHANGE, that
> works by maintaining a timestamp of the last detected disc change instead
> of a boolean flag: Processes calling this ioctl command can provide
> a timestamp of the last disc change known to them and receive
> an indication whether the disc was changed since then and the updated
> timestamp.
> 
> I considered fixing the buggy behavior in the original
> CDROM_MEDIA_CHANGED ioctl but that would require maintaining state
> for each calling process in the kernel, which seems like a worse
> solution than introducing this new ioctl.
> 
> Signed-off-by: Lukas Prediger <lumip@lumip.de>
> ---
> This is my first patch sent to the kernel and I followed the recommended
> process as closely as I could. If I misstepped somewhere, please let me know.
> I also tried to find a mailing list more specific to the problem but was unable,
> please inform me if there is one where this should be sent instead.
> 
> Finally, I wasn't sure whether/how to add my name to the updated docs
> and if I should update the date on them (there have been some recent commits
> that did not result in credits given to the commit author or updating
> the dates in the docs, but those did not add any new content either), so
> info in the most appropriate way would be welcome.

Thanks for sending in the patch, appologies it's taken so long to get a
response. CDROM isn't really actively maintained much these days,
unfortunately. Should get a new maintainer.

Anyway, for this patch, few comments inline.


> diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
> index 5845960ca382..8b219ba9b427 100644
> --- a/Documentation/cdrom/cdrom-standard.rst
> +++ b/Documentation/cdrom/cdrom-standard.rst
> @@ -3,9 +3,10 @@ A Linux CD-ROM standard
>  =======================
>  
>  :Author: David van Leeuwen <david@ElseWare.cistron.nl>
> -:Date: 12 March 1999
> +:Date: 5 August 2021
>  :Updated by: Erik Andersen (andersee@debian.org)
>  :Updated by: Jens Axboe (axboe@image.dk)
> +:Updated by: Lukas Prediger (lumip@lumip.de)

Drop these changes, this is from a time from before git and revision
history, no need to update them further.

> diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> index 3b4c0506de46..59305d04d034 100644
> --- a/Documentation/userspace-api/ioctl/cdrom.rst
> +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> @@ -3,8 +3,9 @@ Summary of CDROM ioctl calls
>  ============================
>  
>  - Edward A. Falk <efalk@google.com>
> +- Lukas Prediger <lumip@lumip.de>
>  
> -November, 2004
> +August, 2021

Ditto

> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index feb827eefd1a..af0721c96e06 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -344,6 +344,12 @@ static void cdrom_sysctl_register(void);
>  
>  static LIST_HEAD(cdrom_list);
>  
> +static void signal_media_change(struct cdrom_device_info *cdi)
> +{
> +	cdi->mc_flags = 0x3; /* set media changed bits, on both queues */
> +	cdi->last_media_change_time = ktime_get_mono_fast_ns();
> +}

I'd just use jiffies for this, it's not really a case of something that
needs a fine grained clock source. That'll give you 1-10ms resolution,
which should be more than adequate for this. Then use jiffies_to_msecs()
and make the API be in miliseconds.

> @@ -2391,6 +2397,46 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	return ret;
>  }
>  
> +/*
> + * Media change detection with timing information.
> + *
> + * arg is a pointer to a cdrom_timed_media_change_info struct.
> + * arg->last_media_change may be set by calling code to signal
> + * the timestamp of the last known media change (by the caller).
> + * Upon successful return, ioctl call will set arg->last_media_change
> + * to the latest media change timestamp known by the kernel/driver
> + * and set arg->has_changed to 1 if that timestamp is more recent
> + * than the timestamp set by the caller.
> + */
> +static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
> +		unsigned long arg)
> +{
> +	int ret;
> +	struct cdrom_timed_media_change_info __user *info;
> +	struct cdrom_timed_media_change_info tmp_info;
> +
> +	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
> +		return -ENOSYS;
> +
> +	info = (struct cdrom_timed_media_change_info __user *)arg;
> +	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
> +
> +	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
> +		return -EFAULT;
> +
> +	tmp_info.has_changed = (tmp_info.last_media_change < cdi->last_media_change_time);

If you make the jiffies change, you can use time_before() etc on these
which avoids the wrap.

> @@ -295,6 +297,19 @@ struct cdrom_generic_command
>  	};
>  };
>  
> +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
> +struct cdrom_timed_media_change_info
> +{
> +	__u64   last_media_change;	/* Timestamp of the last detected media
> +					 * change. May be set by caller, updated
> +					 * upon successful return of ioctl.
> +					 */
> +	__u8    has_changed;		/* Set to 1 by ioctl if last detected media
> +					 * change was more recent than
> +					 * last_media_change set by caller.
> +					 */
> +};

The struct layout should be modified such that there are no holes or
padding in it. Probably just make the has_changed a flags thing, and
make it u64 as well. Then you can define bit 0 to be HAS_CHANGED, and
that leaves you room to add more flags in the future. Though the latter
probably isn't much of a concern here, but...

-- 
Jens Axboe

