Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1003C25C0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhGIOVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGIOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:21:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F8C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:18:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l5so12551870iok.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCLoDkkZnsfCEVph7CiGHPbNElkGreiJown+HOpz3Qs=;
        b=uhWTZf1E4fA+aW1yeP3TZedffaA9AQt0sRu99VSXttjpMhs/jTS9Cmt0UvPzN5s7s4
         CoJs5Nfl+g68w8+8OpXv1AB5W7OUhwILNinr4pQ4oouOBjonVhlgJgRA1KnJOUvET5Ih
         shav5mbMhmRVFCZg026/fts9fvR3fxaU1/7abqcYd3DwqguizRd4KvfoW352zR5pHo6y
         fAOCUEAE9rXDaTS604JfwaO7GLI0gI5J+Wuh805TWwF2J/HKBZNdsp4hYgXGSO1PJixf
         NLAfmCHe54JLkW7Acx2AHK3X8V9DARw09gYv2vuIc6tPjQaB3A3GC/BpmMhXHOvn23ET
         szBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCLoDkkZnsfCEVph7CiGHPbNElkGreiJown+HOpz3Qs=;
        b=oEv5Covdnkeo4sBphcpKOZUtJewv54Kx7EI3uqwOx/f5Kd8hdC1uAQFl+K7SlMJhrc
         yCHvUM70ksS0jskn9B3N1sEPS5eO4WFvKnOnSivIKrCSO83aWKJ785RLaz3cjCLXT33f
         CVGfNrq2hnmQ2+6ekXqOkSwz4GVRv5MhyWcaNeaAXFxS5kgQNMffRsBjiNWC7DnHsU2v
         3yRfWLACE0kDMnRi4m8fSc96yAdmJ7amH5N+d17Z6HABk8hhsHxLgZYGwfkDb2c4949t
         M+vA8ZwH3jQoADiKYKkItMZDR9uHQAE2MmrpnUTTerBqThFgmPGQ1X4nLouWmsm7XLfS
         xatA==
X-Gm-Message-State: AOAM532gaADwlOl6eLKvzPJa7/TrjB+XSOqjxiOSgwtBy3ZYRwrcBw96
        Dg2gGcvEdPgtuqml1NaJF8E+E3mSTYQ1YQ==
X-Google-Smtp-Source: ABdhPJygcmrftMzhupUiWoYDNlEDOHdmH6yuCFUQEgnY/Uq3BmA2o/TeNCfQkVOEv8W8Ek+OVpS0gA==
X-Received: by 2002:a05:6638:4109:: with SMTP id ay9mr4130608jab.81.1625840310893;
        Fri, 09 Jul 2021 07:18:30 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id e5sm3078212ilu.15.2021.07.09.07.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:18:30 -0700 (PDT)
Subject: Re: [PATCH] task_work: return -EBUSY when adding same work
To:     yaozhenguo <yaozhenguo1@gmail.com>, oleg@redhat.comm
Cc:     linux-kernel@vger.kernel.org, yaozhenguo@jd.com
References: <20210709122712.42844-1-yaozhenguo1@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <872612b5-b9c6-43aa-a167-1c204d0f1c5a@kernel.dk>
Date:   Fri, 9 Jul 2021 08:18:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210709122712.42844-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/21 6:27 AM, yaozhenguo wrote:
> when same work is added to task->task_works list one by one,
> the list becomes endless loop. So return -EBUSY when this
> situation happen.
> 
> Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
> ---
>  kernel/task_work.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 1698fbe..5061ebf 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -27,7 +27,7 @@
>   * list is LIFO.
>   *
>   * RETURNS:
> - * 0 if succeeds or -ESRCH.
> + * 0 if succeeds or -ESRCH, -EBUSY.
>   */
>  int task_work_add(struct task_struct *task, struct callback_head *work,
>  		  enum task_work_notify_mode notify)
> @@ -41,6 +41,8 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  		head = READ_ONCE(task->task_works);
>  		if (unlikely(head == &work_exited))
>  			return -ESRCH;
> +		if (unlikely(head == work))
> +			return -EBUSY;
>  		work->next = head;
>  	} while (cmpxchg(&task->task_works, head, work) != head);

I don't think there's anything conceptually wrong with this patch, but
it makes me think that you hit this condition. It's really a bug in the
caller, of course, is a WARN_ON_ONCE() warranted here? And who was the
caller?

-- 
Jens Axboe

