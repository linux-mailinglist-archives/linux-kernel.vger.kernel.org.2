Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8482F356C51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352303AbhDGMj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352298AbhDGMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617799123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MYXM+Qy7GHJ4LOpIfMJnDm+ZQ+0F0Eu7MWiehRMO0DI=;
        b=QmlOdJJwa2UwNLNtwtix80M/48WuHh1ujE46rs/5fTdfb/o66MQayPxP1AX7xQvRJb4V8v
        ntPWbYZSGnx0YhRe+j9xPeTmnMyBcvpSuOXoGxPBN3LvJ0tccdgQ++31rA+V43EuquHGhu
        1AcsB/zOBHh6XMed/HLP7vsTjZibt9w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-EBKGgsv5Pher4YlXQO061g-1; Wed, 07 Apr 2021 08:38:42 -0400
X-MC-Unique: EBKGgsv5Pher4YlXQO061g-1
Received: by mail-ed1-f72.google.com with SMTP id i12so12105418edu.23
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 05:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYXM+Qy7GHJ4LOpIfMJnDm+ZQ+0F0Eu7MWiehRMO0DI=;
        b=Zh1hKzWvRLeeRhE2IAXMw/fz+os65DATnvD1qzeZnybAqmtxtrbIbqzJQ//XKDA28e
         vaTt3gPPO96XkkLkmUGFmbTfthvZXjK/7S1i7S5aq00cXyhuK8aCMy7auxSZttS6eX1G
         Xw+j5G05BJH8UmIyg1/pGPreMPiSKc5hoYxnwwqceOWgm9Nd6SE8x1uAR9Ct4MKLvHv+
         UqbR6UzJ9rOgRzX5grsmken6QXOzA/DpD/268Tuglr88cciTM/ky7ZpVbDBMRss1bJ7H
         /EGvLx79ZHb7ITT9NdgH7x3LbVNW6VOQPAgAhMcqKd8kPxzJy9yT7vffJhCmbiRJ1wx9
         bLmw==
X-Gm-Message-State: AOAM533uEgupfdyJCxbwsGvXQ3cwmsD1/6mUIHWhMvlU9n/WEbv9v6n5
        Md5rAI2rLdBNZyqOlJX6/h64RSKBRQ/ZXopZhNgtNAENqT8ey4OTWLNN5g8G+Fb3rS7PMRqc9Er
        x9Ndf8ouV0ugMO72o0bW+TuRJvgPdBdSBWlHGAk9oPvdde6KlMKzjKLQQfoUG5SsBqmBnxm4hXw
        ZC
X-Received: by 2002:a05:6402:1606:: with SMTP id f6mr4119670edv.216.1617799120499;
        Wed, 07 Apr 2021 05:38:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbY1G1HVlxxb4Y8mglIInxdO8AJneU9XNc9oVw8BkZfmrO4mZ5W0GerX/XYMel6iWzTCeP8g==
X-Received: by 2002:a05:6402:1606:: with SMTP id f6mr4119647edv.216.1617799120292;
        Wed, 07 Apr 2021 05:38:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t23sm1276951edy.6.2021.04.07.05.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 05:38:39 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: ISST: Account for increased timeout in some
 cases
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210330220840.3113959-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <263e6c6f-68d0-fcf3-0759-d8922ff0336a@redhat.com>
Date:   Wed, 7 Apr 2021 14:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210330220840.3113959-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/31/21 12:08 AM, Srinivas Pandruvada wrote:
> In some cases when firmware is busy or updating, some mailbox commands
> still timeout on some newer CPUs. To fix this issue, change how we
> process timeout.
> 
> With this change, replaced timeout from using simple count with real
> timeout in micro-seconds using ktime. When the command response takes
> more than average processing time, yield to other tasks. The worst case
> timeout is extended upto 1 milli-second.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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
>  .../intel_speed_select_if/isst_if_mbox_pci.c  | 33 +++++++++++++------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
> index a2a2d923e60c..df1fc6c719f3 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
> @@ -21,12 +21,16 @@
>  #define PUNIT_MAILBOX_BUSY_BIT		31
>  
>  /*
> - * The average time to complete some commands is about 40us. The current
> - * count is enough to satisfy 40us. But when the firmware is very busy, this
> - * causes timeout occasionally.  So increase to deal with some worst case
> - * scenarios. Most of the command still complete in few us.
> + * The average time to complete mailbox commands is less than 40us. Most of
> + * the commands complete in few micro seconds. But the same firmware handles
> + * requests from all power management features.
> + * We can create a scenario where we flood the firmware with requests then
> + * the mailbox response can be delayed for 100s of micro seconds. So define
> + * two timeouts. One for average case and one for long.
> + * If the firmware is taking more than average, just call cond_resched().
>   */
> -#define OS_MAILBOX_RETRY_COUNT		100
> +#define OS_MAILBOX_TIMEOUT_AVG_US	40
> +#define OS_MAILBOX_TIMEOUT_MAX_US	1000
>  
>  struct isst_if_device {
>  	struct mutex mutex;
> @@ -35,11 +39,13 @@ struct isst_if_device {
>  static int isst_if_mbox_cmd(struct pci_dev *pdev,
>  			    struct isst_if_mbox_cmd *mbox_cmd)
>  {
> -	u32 retries, data;
> +	s64 tm_delta = 0;
> +	ktime_t tm;
> +	u32 data;
>  	int ret;
>  
>  	/* Poll for rb bit == 0 */
> -	retries = OS_MAILBOX_RETRY_COUNT;
> +	tm = ktime_get();
>  	do {
>  		ret = pci_read_config_dword(pdev, PUNIT_MAILBOX_INTERFACE,
>  					    &data);
> @@ -48,11 +54,14 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
>  
>  		if (data & BIT_ULL(PUNIT_MAILBOX_BUSY_BIT)) {
>  			ret = -EBUSY;
> +			tm_delta = ktime_us_delta(ktime_get(), tm);
> +			if (tm_delta > OS_MAILBOX_TIMEOUT_AVG_US)
> +				cond_resched();
>  			continue;
>  		}
>  		ret = 0;
>  		break;
> -	} while (--retries);
> +	} while (tm_delta < OS_MAILBOX_TIMEOUT_MAX_US);
>  
>  	if (ret)
>  		return ret;
> @@ -74,7 +83,8 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
>  		return ret;
>  
>  	/* Poll for rb bit == 0 */
> -	retries = OS_MAILBOX_RETRY_COUNT;
> +	tm_delta = 0;
> +	tm = ktime_get();
>  	do {
>  		ret = pci_read_config_dword(pdev, PUNIT_MAILBOX_INTERFACE,
>  					    &data);
> @@ -83,6 +93,9 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
>  
>  		if (data & BIT_ULL(PUNIT_MAILBOX_BUSY_BIT)) {
>  			ret = -EBUSY;
> +			tm_delta = ktime_us_delta(ktime_get(), tm);
> +			if (tm_delta > OS_MAILBOX_TIMEOUT_AVG_US)
> +				cond_resched();
>  			continue;
>  		}
>  
> @@ -96,7 +109,7 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
>  		mbox_cmd->resp_data = data;
>  		ret = 0;
>  		break;
> -	} while (--retries);
> +	} while (tm_delta < OS_MAILBOX_TIMEOUT_MAX_US);
>  
>  	return ret;
>  }
> 

