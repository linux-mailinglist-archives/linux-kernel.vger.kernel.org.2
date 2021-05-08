Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2A237735B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhEHRWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHRWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 13:22:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 10:21:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s82so6861819wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4liHOJyGJNPGOCPl94LSL5pcnedq0NEhqgb7CHl88k0=;
        b=O774SfoE20ZE34BIOhlsdZEoOBm9l5Z4xEkknOhOz8TEJ2OrXnvu1IYlpb3pYZguri
         HUFTw2yo9RmPGbGbIEwT7GwHkAmuWt2Zm/MToeIwGW9hI/OVMncx2IZiSR7qyImlqsyX
         P+bLEz+pbrMlls8G8U9M6vwYLSEoggiVRNKXHjUUBjqTGgGhVg8AOZfs26kFHw1dJoOn
         XgaUNuhhOCVwbClCzckz81Tm+U9lue1UnRSXBffY0TbZcX5JvE23kZ3U572W4aZeWnfZ
         s9D0lb2YDtLatCXh4la9ihux3/z/ZmaQBv1oWVHn3rKggNmKpL51JNCGkRlMgq25RIu1
         JtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4liHOJyGJNPGOCPl94LSL5pcnedq0NEhqgb7CHl88k0=;
        b=l2IfZiaJs0YkdKr1+oEy4fXX2WL1GdlPRPjR9/7VS5c3M+6S4VLIs5U3PHb/MsTMxL
         pCYj4d3ZnFumf+g9/9Wf3u9a1acsSQ2AU2evOQx5wXqvnPuiO7q7Kx4Z997z+zVotJ9w
         o067bH7iQeu2YVmJE9UxohIRHsgWxXHVBrn2fxWjazORjXOAjNvy7vOhXYBF02x7RYbc
         LILLtPtqvY83J1xMrTPvKa499XnARIirKk4Zqlfd7e08n6g2GrX1QHqGzta5/C4vonDC
         AqywIE/TNLAnf1dMIxMS7Aiwt4qDzfVabzacfFQs62VSHtAN9uzAilNw41AkruEGN5P2
         4pXg==
X-Gm-Message-State: AOAM531Kvn4UnYBMuZNGGXGAiFwmx5NX9vyG9jAOcHZGnzcC3siuMfkQ
        H12mZwWioe2iHnvDsFJfHMkU9w==
X-Google-Smtp-Source: ABdhPJzza7vh1+3rGc7Jh/dOgtcAuqjE38SG7gEWE1GCoM9gegGsihU9qxrQssEQ/ChsGbMhsKa+4Q==
X-Received: by 2002:a05:600c:154a:: with SMTP id f10mr17072554wmg.31.1620494490607;
        Sat, 08 May 2021 10:21:30 -0700 (PDT)
Received: from localhost.localdomain (p200300d99735cc000203a406ef8aeb48.dip0.t-ipconnect.de. [2003:d9:9735:cc00:203:a406:ef8a:eb48])
        by smtp.googlemail.com with ESMTPSA id z6sm11848469wmf.9.2021.05.08.10.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 10:21:30 -0700 (PDT)
Subject: Re: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its
 expiry
To:     Davidlohr Bueso <dbueso@suse.de>,
        Varad Gautam <varad.gautam@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210504155534.17270-1-varad.gautam@suse.com>
 <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <7bf3af5b-26a6-b6df-1b53-c5217ef4a10c@colorfullife.com>
Date:   Sat, 8 May 2021 19:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On 5/4/21 11:53 PM, Davidlohr Bueso wrote:
> @@ -1005,11 +1023,9 @@ static inline void __pipelined_op(struct 
> wake_q_head *wake_q,
>                    struct ext_wait_queue *this)
>  {
>      list_del(&this->list);
> -    get_task_struct(this->task);
> -
> +    wake_q_add(wake_q, this->task);
>      /* see MQ_BARRIER for purpose/pairing */
>      smp_store_release(&this->state, STATE_READY);
> -    wake_q_add_safe(wake_q, this->task);
>  }
>
>  /* pipelined_send() - send a message directly to the task waiting in

This can result in lost wakeups:
wake_q_add() wakes up this->task, and the tasks reads this->state before 
the smp_store_release() writes STATE_READY.

I would really prefer if we make kernel/futex.c and ipc/whatever as 
similar as possible:
The futex slow path, ipc/sem.c, ipc/msg.c and ipc/mqueue.c are all the 
same, thus the code should be the same as well.
[a task goes to sleep, another wakes it up, the woken up task doesn't 
acquire any locks, and the wake_q framework is used]

--

     Manfred

