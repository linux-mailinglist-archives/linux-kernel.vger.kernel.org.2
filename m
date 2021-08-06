Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8983E2B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbhHFNEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343955AbhHFNEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628255064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hs0w4oRs/L7L3VP+7skGyjzywBKMx60j6QPBGR1/Tg=;
        b=aNkTdqAaYreM7RUhZIYMxKyxaBhoAuaMOycIOqOFv6qTJTJ05pl2NTXeFVqEhgiX18+fuS
        6gnrAyq9HjKKlGq3m5ppmrw5wcbmrePgYPW3XmuMa+fiJ1GNWIUQ4E1XJA99dY3QUsohFK
        0ebm6xusbf1H/f2/z5MGCKxWoz6nb24=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-sOKVw9pSMV2fFdQz9Xul2w-1; Fri, 06 Aug 2021 09:04:22 -0400
X-MC-Unique: sOKVw9pSMV2fFdQz9Xul2w-1
Received: by mail-ed1-f72.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso4718523edp.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 06:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4hs0w4oRs/L7L3VP+7skGyjzywBKMx60j6QPBGR1/Tg=;
        b=LpDs1V/MXh1ZmDy3GU2qzys9WhX4Cq0VAZviiBOeiHUxqoH9t97ygaf3JVl/1eSTGY
         Ti2/Mo++ykuvpGZfFRonBpFdd2ZhMwyzw+mWpTM7t8a1GzF1sJwbXB+fRzqwMTAOkU4l
         skClCaTIIisvhSSNdD2MryAuHjXwkG6rd14pRVBrnjfrFcEXwZGBhhpIcW4l3YHssOlm
         EJH0tn/B+V8FNksx0rKp90n4AN+OxCoKDjW3rG8f1z53xLJDsq6uFKn00iOz3/QhPflO
         5VZBoTnLt+FQHlQBQPBVb2N5u3QQwtt4XgTj9t6thGwzxqHOx+QOArWfnOs++mFAPc6y
         4jsg==
X-Gm-Message-State: AOAM530qeYnDiDEL3JAjdSCiWyjPx1Sg6O6a+eK4AT0t5mUpB3VQjZgq
        C0U6N23scERy4edpaAZS3J1SEe8APIF1e3WA/N/Ib1YhHDYsUTOcb5aIpwJIvhXSN9TuA1Jods0
        QeqGZnQhrc7pp5PHCROy1uH+nj8S3rYwt1gA1n9OAE4lEbF61Fh9qWzf0PJrxRcEm8n+V2vsh2O
        Y=
X-Received: by 2002:a17:906:e089:: with SMTP id gh9mr9951467ejb.80.1628255061453;
        Fri, 06 Aug 2021 06:04:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXGv9I+aAgqWItLp0znSb2GfN8riI8mY1FQgntjET1H0kSpGYRoG2AAKoz4bkBdl+KgkZnnA==
X-Received: by 2002:a17:906:e089:: with SMTP id gh9mr9951437ejb.80.1628255061201;
        Fri, 06 Aug 2021 06:04:21 -0700 (PDT)
Received: from x1.bristot.me (host-95-239-202-226.retail.telecomitalia.it. [95.239.202.226])
        by smtp.gmail.com with ESMTPSA id y2sm1372927ejd.111.2021.08.06.06.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 06:04:20 -0700 (PDT)
Subject: Re: [PATCH] kernel/hung_task.c: Fix a typo in check_hung_task()
 comment
To:     Jun Miao <jun.miao@windriver.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, deller@gmx.de,
        wei.liu@kernel.org
Cc:     peterz@infradead.org, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
References: <20210806114049.649909-1-jun.miao@windriver.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f0ba6af0-248d-b7ac-a06e-adba5798d582@redhat.com>
Date:   Fri, 6 Aug 2021 15:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806114049.649909-1-jun.miao@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 1:40 PM, Jun Miao wrote:

> It's "mustn't", not "musn't". Let's fix that.
> 
> Signed-off-by: Jun Miao <jun.miao@windriver.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel
> ---
>  kernel/hung_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 9888e2bc8c76..ea5ba912db06 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -99,7 +99,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	/*
>  	 * When a freshly created task is scheduled once, changes its state to
>  	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
> -	 * musn't be checked.
> +	 * mustn't be checked.
>  	 */
>  	if (unlikely(!switch_count))
>  		return;
> 

