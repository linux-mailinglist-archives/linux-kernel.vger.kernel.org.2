Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0842181E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhJDUGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhJDUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:06:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C5C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:04:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h129so21801560iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=96yyMKyGyUXRTH3hvSKjxri4j4LEUV+D4xGuayE0ULY=;
        b=R4PZZbRDe1Uw0SmxR3E8GPWXAreInX1lv2ZIKVssmww5RKxP/i6bs48K8i625PrlcK
         v3/1B96x39zNBmJMKIvj7XnJyU9OFv94037UqaND5h9qIoYwJd8ty5oA1RubUIgzcytM
         8g5c5pXRGigNTCh1occRUAPDvk1rD8uVbOFPrI3GNotUqTus7Nk1kNLkFxFQ0BCHurgK
         DyQLARneICjD66JOhbmBThUz7vruvvlG5LG3zyLFEbkH+19E/i98pGGZour1wRF4ARZV
         oq9zP226hUgKzF1kGWWwzTCvsWwJLpDV2Dvf4tyHnYv4ydzzxoUQQWrFzslIqZIWgVa9
         d2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=96yyMKyGyUXRTH3hvSKjxri4j4LEUV+D4xGuayE0ULY=;
        b=P9ZPflSqoQ1U6s708TtDFwN57Mr4JlEPj/pN9NB+rLJCXvtAVWLmjvFUevXTmcSiqG
         uHK0NhMqYKVLlANU+bmyUlsVBrYmnXLUdiiTK4DFNnh8hco+D3tzOhGxV6GI+0yMBNCs
         D+yiCwU4oKYXA2uSCieAcFwGR7tROHy2kWCy43mXAZs6nJ9IiMrTe4dFlaJViE9S60co
         VBKdi2XHxjmfi1soxAIgISOcyw2aqHiswO/SD0Gz4f4WXDnOxDVqygFp7E4+IwCyfM9f
         BzHVdUMLxQxPaFXFsbpC/vEETGqKPdDRgvVn8iOKumYxp8TDSBSXDpAMVgcj2ULU9/6F
         xDNw==
X-Gm-Message-State: AOAM530Li2ovB8dBs3IepWQXnH8Vo6SvX7gI7OBL9eDs/jnoSZI42CpU
        XsEtFAVBpPwMQSVuqC0p1hbvDT6//spb2qZ27Lc=
X-Google-Smtp-Source: ABdhPJwqGVbJHLIwYioAw9M5x3CpwVjc7UxpxfUJlIy43+T/BugL8BjkE91545zKhwS5ZZO/nyM7rw==
X-Received: by 2002:a02:9542:: with SMTP id y60mr7599122jah.133.1633377854091;
        Mon, 04 Oct 2021 13:04:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a11sm10070213ilm.36.2021.10.04.13.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 13:04:13 -0700 (PDT)
Subject: Re: [PATCH V3 7/9] fork: Add worker flag to ignore signals
To:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-8-michael.christie@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3840acc-09c0-01bd-ad64-54e9d2dfb888@kernel.dk>
Date:   Mon, 4 Oct 2021 14:04:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211004192128.381453-8-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 1:21 PM, Mike Christie wrote:
> The kthread API creates threads that ignore all signals by default so
> modules like vhost that will move from that API to kernel_worker will
> not be expecting them. This patch adds a worker flag that tells
> kernel_worker to setup the task to ignore signals.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/linux/sched/task.h |  1 +
>  kernel/fork.c              | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 781abbc1c288..aefa0d221b57 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -21,6 +21,7 @@ struct css_set;
>  #define KERN_WORKER_IO		BIT(0)
>  #define KERN_WORKER_USER	BIT(1)
>  #define KERN_WORKER_NO_FILES	BIT(2)
> +#define KERN_WORKER_NO_SIGS	BIT(3)
>  
>  struct kernel_clone_args {
>  	u64 flags;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3f3fcabffa5f..34d3dca70cfb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2555,6 +2555,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>  				  unsigned long clone_flags, u32 worker_flags)
>  {
> +	struct task_struct *tsk;
> +
>  	struct kernel_clone_args args = {
>  		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
>  				   CLONE_UNTRACED) & ~CSIGNAL),
> @@ -2564,7 +2566,14 @@ struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>  		.worker_flags	= KERN_WORKER_USER | worker_flags,
>  	};
>  
> -	return copy_process(NULL, 0, node, &args);
> +	tsk = copy_process(NULL, 0, node, &args);
> +	if (IS_ERR(tsk))
> +		return tsk;
> +
> +	if (worker_flags & KERN_WORKER_NO_SIGS)
> +		ignore_signals(tsk);
> +
> +	return tsk;

When I originally did it this way, Eric (correctly) pointed out that
it's racy. See where it's currently done as part of copy_process(), not
after.

-- 
Jens Axboe

