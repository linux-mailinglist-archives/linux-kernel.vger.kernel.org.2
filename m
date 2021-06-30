Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3C3B7B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhF3CDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231765AbhF3CDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625018466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxkrysUl98zvEOYEsdrLNnYjN5TtIhoiFh8RRDC3JNQ=;
        b=N6P79qBAbSUruQ4OhKle51W4aj7QBSBprvOR0Y4hUKBwo6UjLh6VLnh1Fc8BBynYtdETxq
        7SVc6K3gW+Hl14vkc++LFsWuGCTUc5Ba33uoICAwpTdJ6zIlWxZ16mejW5f9zpLeFdfF4n
        JzK5taN/8tT0nqBWIMhNsFu1CkiM3OE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-KGyjc47RMAarmtGOaRclcg-1; Tue, 29 Jun 2021 22:01:04 -0400
X-MC-Unique: KGyjc47RMAarmtGOaRclcg-1
Received: by mail-qv1-f72.google.com with SMTP id eb2-20020ad44e420000b029025a58adfc6bso327663qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 19:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cxkrysUl98zvEOYEsdrLNnYjN5TtIhoiFh8RRDC3JNQ=;
        b=JxkPD3QoXMkeMwt8gwdkofGaEk4K0sfIUaZb/tti+XHzObUN3t05lffgA6qiRvmb50
         NRrKq6Q5+hVGQy+kZq3QKQnCPkm/jY84A4YXnk60cMx8LJ4iLJjBrqjlZtn6GbcZN1R9
         vTWIrtlhuzEU7OT0qGIqmI3TImQ2A9Nvlh1ADemDROBquXv5Umdl2fc6S4ob89bNJ0Qb
         6A4+MnJ/vKq0pcWg0laHKLiZSH8eXanfpDtWuzqcVYYoHN6kg9McqfrA8rP1zTaBW5vl
         9CtH+ORBmwtldue8bAxy/iTUAXQ0c01B8+Cg88Y5aurwOdSrsaegfIZ9DPWyVn2FMrrA
         Zl6Q==
X-Gm-Message-State: AOAM533+YhRujC0kBPmZtWlxSEdPQ6vVmnPS3+rQDlDqiFzfFHbOWTS6
        MltHm8zZWbZqnM+An4VTE3sIJdRNmGLWkxsD6Ttz7eX2Y24GsFiKhPWv9MV2jxRkBT8TwRLUieC
        pYLjtntUfAMWLNq+7ZCJk7hAb06my53Y0jIwJJ/chjpk71n+dDb48+s+LNnIr65hXW3BB4kk/
X-Received: by 2002:a05:622a:1701:: with SMTP id h1mr29531156qtk.36.1625018463698;
        Tue, 29 Jun 2021 19:01:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6TgvgdqQCqMOVaI9wKLv02IImYM8j9bEVzZm3ncv2ut9MGyy9HCvsnnYJeZst/UWqZm5Yfg==
X-Received: by 2002:a05:622a:1701:: with SMTP id h1mr29531126qtk.36.1625018463298;
        Tue, 29 Jun 2021 19:01:03 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 19sm6594444qtt.87.2021.06.29.19.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 19:01:02 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] spinlock_debug: Save stacktrace at lock acquisition
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <1625016485-32581-1-git-send-email-gurus@codeaurora.org>
Message-ID: <98f4a7f1-bce7-8e74-c124-7f5183b8cdfc@redhat.com>
Date:   Tue, 29 Jun 2021 22:01:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1625016485-32581-1-git-send-email-gurus@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 9:28 PM, Guru Das Srinagesh wrote:
> In case of spinlock recursion bugs, knowing which entity acquired the
> lock initially is key to debugging. Therefore, save the stack frames
> when the lock is acquired and print them when spinlock recursion is
> detected.
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>   include/linux/spinlock_types.h  | 3 +++
>   kernel/locking/spinlock_debug.c | 9 +++++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
> index b981caa..8a68d55 100644
> --- a/include/linux/spinlock_types.h
> +++ b/include/linux/spinlock_types.h
> @@ -22,6 +22,9 @@ typedef struct raw_spinlock {
>   #ifdef CONFIG_DEBUG_SPINLOCK
>   	unsigned int magic, owner_cpu;
>   	void *owner;
> +#define MAX_STACK_LEN 16
> +	int stack_len;
> +	unsigned long stack_trace[MAX_STACK_LEN];
>   #endif

Nak

Locking problem like this should be detected by the lockdep code. Adding 
136 bytes (64-bit archs) to the size of a spinlock is just too big an 
overhead.

Regards,
Longman

