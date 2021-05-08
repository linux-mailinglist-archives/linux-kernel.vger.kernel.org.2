Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967743773CB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEHTYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 15:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhEHTYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 15:24:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0FC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 12:23:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n2so12552248wrm.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TS4lEMekA8yRJnKHQJcaLDOkRe95TDSgNTNkP9BEGpc=;
        b=luhaFOCU7Z0YSbnTL5OQYmZagRsf8qrqhGKaP9IB+10wVBNzvE50ucgp8l9EHNV1za
         8+S2Ss+q+fwbPJi4Q/XH6RmD5ndpttPgbCvv6tHDn6fk6jOfbPh0bfaOGjR6jpEvRdjt
         OL4kVxjzFCEIbUZxr1M0n11yo+LfKTzMOu2rdzbgwqGhKit4pajUz9EuK+M20chEAGFJ
         qNJX30FdktH817pBrM9EAl25/50bLV8khwo8ey5St0mHyA4avzDHFH0h90eBI5OKRr5y
         khr3LZU3VkwfEH8pQiFK+74eaeLY5hsraitQjRQn28Iok6Tzv2MF+9DblCOu6AU2PZKm
         NKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TS4lEMekA8yRJnKHQJcaLDOkRe95TDSgNTNkP9BEGpc=;
        b=pYPh/4tQ9qdCTXouM0h1+N4N+m47xXAva0XXQYFEBo3TeUVpqh7jUI/VuCkUjEvdjC
         2YdMV1dEyQDkIHWIZtS8vAvFCCxjeFseFb/StJHpDsE5UIRlheKl65o1IjhuL/ZJ+0TX
         8sQyeD8vfOTKfA4haXislzi3H/LkKwVWHTsYbG+Uc6454Wn/eYfH4NMP15dtlKROKUQ+
         TClDOVbG3G9JGLDFRMxChxrqmiNW9Bn+qfePtwtcVJChQQQ2bma0nhWH0eUSTQcITcu3
         26/4xSBU26Zklth7o/ivwpkm39EXMD2v9j2sPH0G9Rh//xHxZMjxgjpS4ty/RACdhxTj
         3D6w==
X-Gm-Message-State: AOAM531Ze4/kPLNKEKiMOIRorGw733ZPb+GgJJ5JdJg/mLj2uzPYppVG
        lXOqbK663l+VBQJmF9VukjPscg==
X-Google-Smtp-Source: ABdhPJxc42pcdt6Rfi6OGaya0Nmc+qAladN9DmAk+JLNtU9nw9V1WaXgp59s0CfzQo8GZuC+i04bLg==
X-Received: by 2002:a05:6000:504:: with SMTP id a4mr21229928wrf.51.1620501827277;
        Sat, 08 May 2021 12:23:47 -0700 (PDT)
Received: from localhost.localdomain (p200300d99735cc000203a406ef8aeb48.dip0.t-ipconnect.de. [2003:d9:9735:cc00:203:a406:ef8a:eb48])
        by smtp.googlemail.com with ESMTPSA id n20sm9340061wmk.12.2021.05.08.12.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 12:23:46 -0700 (PDT)
Subject: Re: [PATCH v3] ipc/mqueue: Avoid relying on a stack reference past
 its expiry
To:     Varad Gautam <varad.gautam@suse.com>, linux-kernel@vger.kernel.org
Cc:     Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Davidlohr Bueso <dbueso@suse.de>, stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>
References: <20210507133805.11678-1-varad.gautam@suse.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <71c74711-75d6-494e-6ff7-2be49b274477@colorfullife.com>
Date:   Sat, 8 May 2021 21:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210507133805.11678-1-varad.gautam@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Varad,

On 5/7/21 3:38 PM, Varad Gautam wrote:
> @@ -1005,11 +1022,9 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
>   				  struct ext_wait_queue *this)
>   {
>   	list_del(&this->list);
> -	get_task_struct(this->task);
> -
> +	wake_q_add(wake_q, this->task);
>   	/* see MQ_BARRIER for purpose/pairing */
>   	smp_store_release(&this->state, STATE_READY);
> -	wake_q_add_safe(wake_q, this->task);
>   }
>   
>   /* pipelined_send() - send a message directly to the task waiting in

First, I was too fast: I had assumed that wake_q_add() before 
smp_store_release() would be a potential lost wakeup.

As __pipelined_op() is called within spin_lock(&info->lock), and as 
wq_sleep() will reread this->state after acquiring 
spin_lock(&info->lock), I do not see a bug anymore.

But I don't like the change: Why should ipc/*.c differ from kernel/futex.c?

--

     Manfred

