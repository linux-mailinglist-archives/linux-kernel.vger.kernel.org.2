Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63513380D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhENPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbhENPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:39:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:38:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l1so9239455ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iC65EQDlm2AWTk5I/j00uXGgVICsmrFxa7f464WVG3A=;
        b=ZmxORW6tOJu/AU96zWgbw2lTWWhlDEsnllpsb3NbqrzwfcShQuiAvFFzulMbYc3Sk4
         lxPuwv/tEvJ/lHHVGm96czDr1CqqDxHVsUFY5/2Ymr6SLfDmI9+vCo1ZxlymR9dmfwIa
         7BfZcdqiUp9oI927vNYAbolEYaIDnhD48FFfrDT0Ns/9pksP+tmDvBVzCtEazuvgcmpW
         lkDdkDXIdAL/fGAFYjsQ9mk0KTVuBJ8pnOxGn0K4T0clRFFmrWk6HFVQYj7SQwJoBhBm
         t72pVvMQ7FK2tYpAJf9sSGxM5mvuGjOSZcBCO1FvXDckNCJ6NbROfw2bmmB7YDKIhIh0
         X1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iC65EQDlm2AWTk5I/j00uXGgVICsmrFxa7f464WVG3A=;
        b=bKDqAN35nmYi8OlIF1Apvhy9WDLb5DkJ9ozGq3A3WQAWIDqhKf2ulW0gYEh3fmFfp+
         E6rt1ZVFiJsEZqNR5g69VtLU7HUYVqHkJGtgHstl9e7lNXhcHHeyRmu/mqQD/iOrLYbN
         P/YDRYyi1hmCIrmkGQKNmmWjsaUAlCauauskKcKeaia6R7zr2SFO4G2XH2sOebGa8iUL
         /yT8R7kQGvyNgMNBG4GbZwAFGXSgI4yS6mlDFPypMV/jyWcVypzDNuAmFwxA63aEe2Ma
         il4Sg5P0Y2a87VQnNvRQfOuD5GqzuKOOmpC9fp20DacB8DBtUMq/5tGxHZVIDEs2J2g0
         xJyw==
X-Gm-Message-State: AOAM532AjJ8s6wq9VM2AhA9tdLI4J//iw5xxb9hVv0UrPpzLQSX+nuC4
        EDELbwmqf9JhHj5IRuFXT+ldibe4czYRDSsu
X-Google-Smtp-Source: ABdhPJymCOshLJp/cZvtoXptKlf+87H1B5eTbNbrDduiFCONCy2QoJjLI5w4WcjcJ85WY3Kf8Ze29A==
X-Received: by 2002:a17:906:14c1:: with SMTP id y1mr50789807ejc.481.1621006712913;
        Fri, 14 May 2021 08:38:32 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970469005bb43495a574ac97.dip0.t-ipconnect.de. [2003:d9:9704:6900:5bb4:3495:a574:ac97])
        by smtp.googlemail.com with ESMTPSA id j22sm3961738ejt.11.2021.05.14.08.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:38:32 -0700 (PDT)
Subject: Re: [RFC PATCH] ipc/mqueue: add detector of wakeup race
To:     Hillf Danton <hdanton@sina.com>, Davidlohr Bueso <dbueso@suse.de>
Cc:     Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210511073630.3002-1-hdanton@sina.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <88f7224c-bf12-0900-2a49-a4c7a108dcda@colorfullife.com>
Date:   Fri, 14 May 2021 17:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511073630.3002-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 5/11/21 9:36 AM, Hillf Danton wrote:
> Apart from the pipeline wakeup, there are wakeups from timer timeout, signal,
> and spurious sources. Because the race between pipeline and non pipeline
> wakeups is not frequent, we handle it under lock on the waiter side.
>
> On the waker side, wait condition is set true before adding waiter to the wake
> queue to cut the chance for missing wakup, and it is updated to be READY after
> wake_q_add to show that the race window is closed by the waker and it is safe
> now for waiter to go home in bid to cut the risk that waiter exits while waker
> is dereferencing waiter's resouces.
>
> Based on the initial work from Varad Gautam.
>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
>
> --- y/ipc/mqueue.c
> +++ x/ipc/mqueue.c
> @@ -55,7 +55,8 @@ struct mqueue_fs_context {
>   #define RECV		1
>   
>   #define STATE_NONE	0
> -#define STATE_READY	1
> +#define STATE_TRUE	1
> +#define STATE_READY	2 /* detector of wakeup race */
>   
>   struct posix_msg_tree_node {
>   	struct rb_node		rb_node;
> @@ -722,7 +723,7 @@ static int wq_sleep(struct mqueue_inode_
>   		spin_lock(&info->lock);
>   
>   		/* we hold info->lock, so no memory barrier required */
> -		if (READ_ONCE(ewp->state) == STATE_READY) {
> +		if (READ_ONCE(ewp->state) != STATE_NONE) {
>   			retval = 0;
>   			goto out_unlock;
>   		}
> @@ -1005,11 +1006,11 @@ static inline void __pipelined_op(struct
>   				  struct ext_wait_queue *this)
>   {
>   	list_del(&this->list);
> -	get_task_struct(this->task);
>   
> +	this->state = STATE_TRUE;
> +	wake_q_add(wake_q, this->task);
>   	/* see MQ_BARRIER for purpose/pairing */
>   	smp_store_release(&this->state, STATE_READY);
> -	wake_q_add_safe(wake_q, this->task);
>   }
>   
>   /* pipelined_send() - send a message directly to the task waiting in

As I have written in the other mail:

Copying this->task into a local variable is far simpler.

(before we had wake_q, an approach with 3 states was used, see e.g.: 
https://elixir.bootlin.com/linux/v2.6.39.4/source/ipc/msg.c#L858 : 
-EAGAIN, NULL, <valid pointer>. But due to the wake_q framework, we do 
not need that anymore)

-- 

     Manfred

