Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FA231908E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBKRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:03:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhBKPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613058850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OctynX1ar7RIiKNg6rIQfEi3ttswP1mzLAJnkpLc0uc=;
        b=RI2Uv3ne+blioWFfJDENMNtropnre2VzBQ5iEvHikTRdMzABInrPF3eGIf7zm82pV//LEa
        nZjcSEoWPFQTsfgtRcoBNsFFAXbCDEA28Xyx/ezsoqWZBAiW1sBgjfDWrJZnXl1dqw3Xn0
        9Gq0jztyllD0V6pwEqaKWTwYCOcgbHM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-yljtWrtWOHG247PRnpJg9A-1; Thu, 11 Feb 2021 10:50:38 -0500
X-MC-Unique: yljtWrtWOHG247PRnpJg9A-1
Received: by mail-ed1-f71.google.com with SMTP id b1so4740224edt.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OctynX1ar7RIiKNg6rIQfEi3ttswP1mzLAJnkpLc0uc=;
        b=OYACE/cU30BdbDEv0zRIII52xdqgH2k6pfJjM0ozdA2tnhBr92vVY9Xi9xEq0fyjj/
         erWyDSTFZQihmuxUGFykj5BRQIx8P/HE2QEI674IBfKqdXLACZSuquNyxsr3A8sXxmAq
         JuUxuUKpezvjuqCsg12jXtKL6PjdUL+cjG5vystmHn8rkOxfIyfJlXn6G5L8f+7t1HUg
         oIemQBYuOGtPJzcHMG8wLvuQfj70+3MI2EfJP8lrdLNxbFZwlwemGLnDqGwwygZXMaEN
         05E/D9Xb6RqD97IBWI1ltA45V5kn+dxUnWlTnFHHpG+cgLuhL9q6m9DH7rdL/gCOG3zd
         gY0A==
X-Gm-Message-State: AOAM532H6aPhnXOHPXo42g6JlLsCNIxI42lOOS79wWjGJlcHHAg5cvn+
        rGxm/ra4phG0eCR77myrDJs6Gyr+T1zN8GAh6GDnVyf/2OltmTfNI7G0Ukg92wo54prVZQGNAF1
        E6a53jqfhvIa+3uKa5wzbY59p
X-Received: by 2002:a05:6402:104b:: with SMTP id e11mr9249603edu.367.1613058637550;
        Thu, 11 Feb 2021 07:50:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhBErHyk8KZGhQfafYwpubplafzqq8J+5udPvfs4dgWbjabZSJIfRFD0ddr+y6ZhYVOVZjbw==
X-Received: by 2002:a05:6402:104b:: with SMTP id e11mr9249589edu.367.1613058637407;
        Thu, 11 Feb 2021 07:50:37 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z22sm4134074edb.88.2021.02.11.07.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 07:50:36 -0800 (PST)
Subject: Re: [PATCH] platform/x86: intel_scu_ipc: Increase virtual timeout
 from 3 to 5 seconds
To:     Casey Bowman <casey.g.bowman@intel.com>,
        mika.westerberg@linux.intel.com
Cc:     dvhart@infradead.org, andy@infradead.org, azhar.shaikh@intel.com,
        lee.jones@linaro.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com
References: <20210210192041.17022-1-casey.g.bowman@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <74ea2a54-384c-9741-b269-f58ca15ea2f0@redhat.com>
Date:   Thu, 11 Feb 2021 16:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210192041.17022-1-casey.g.bowman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/10/21 8:20 PM, Casey Bowman wrote:
> Increasing the virtual timeout time to account for scenarios
> that may require more time, like DisplayPort Multi-Stream Transport
> (DP MST), where the disconnect time can be extended longer than
> usual.
> 
> The recommended timeout range is 5-10 seconds, of which
> we will take the lower bound.
> 
> Signed-off-by: Casey Bowman <casey.g.bowman@intel.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

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
>  drivers/platform/x86/intel_scu_ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index d9cf7f7602b0..9171a46a9e3f 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -75,7 +75,7 @@ struct intel_scu_ipc_dev {
>  #define IPC_READ_BUFFER		0x90
>  
>  /* Timeout in jiffies */
> -#define IPC_TIMEOUT		(3 * HZ)
> +#define IPC_TIMEOUT		(5 * HZ)
>  
>  static struct intel_scu_ipc_dev *ipcdev; /* Only one for now */
>  static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
> 

