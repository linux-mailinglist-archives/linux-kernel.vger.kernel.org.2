Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C67D3E086A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhHDS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237903AbhHDS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628103509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMiHkaW9ZQvg7b2LJDS0YVNddANfj9DK9sbBLB9kgEo=;
        b=VsMX6EkWq/abWEEedBBC5Dx1L5vIbhVI0znSPJfmXEa014YfNMcelAd1I4sMLn18Avfk6n
        Ej/tMNkFNkP/ybW34zoIYz9sl7KgXFRpokaRh8RhW2WSbGFpBLNYLH7tMdTaJvZ+jOSI56
        HbkGjbLivQKfEvjASZRjGGVRHcZZw+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-8GasG_TbNvOYWsbba6IL6w-1; Wed, 04 Aug 2021 14:58:28 -0400
X-MC-Unique: 8GasG_TbNvOYWsbba6IL6w-1
Received: by mail-wr1-f71.google.com with SMTP id l14-20020a5d560e0000b029013e2b4ee624so1156637wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RMiHkaW9ZQvg7b2LJDS0YVNddANfj9DK9sbBLB9kgEo=;
        b=a2TsB1eAZ11Tr29Q9WfcbMWml8+yAoXojQ8q1iYygfk+kZGcDG6I8hc73e0RoixF1A
         TnZMjQRZ1GfUFQCBp4lBEYAz2RQ3RA5yQks09L4/yRKCUmptQAnCUpkhv/TJQzBZZkxk
         OQUaKzi/W4dtVbNPvBS6c0e9Kb/YC7vIhFOHQKPfkefVKhzEVQR2+SPbOoCZPH04aKkq
         RVevVHpas66fcLkY2ALkNGp1mHmeksK+jWCHmYAG10bABEr+LwSkxt6SNjWQb6u+ZAsr
         P8QByciJSSsCrf0JgG/si6/PHRusMCJvH2psz0dUL46RtJiC2Xd7ZnwoxEATc9Juu7OY
         2obQ==
X-Gm-Message-State: AOAM531fPKFMo6nSwMllLlSx6UTsS4aStq+CbYPUpEnYp8tZqHAU+u69
        z57O8SoP4O1D0O1d4mefr2bICcZP27h8XajNHDddhuZpevSeD22y4qc5HhXzjfoMHGqvpU9h1Ah
        X/TJFNmcISOImHPROncV6J3DW
X-Received: by 2002:a05:6000:108c:: with SMTP id y12mr797396wrw.293.1628103507124;
        Wed, 04 Aug 2021 11:58:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUNgM4UxpWtxXuCVFgSL4GkwPvjtx2oiHc7lotwIGq2wCcaOfyif6+DM+W4x/EWQYO6CoOcw==
X-Received: by 2002:a05:6000:108c:: with SMTP id y12mr797376wrw.293.1628103506961;
        Wed, 04 Aug 2021 11:58:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65d3.dip0.t-ipconnect.de. [91.12.101.211])
        by smtp.gmail.com with ESMTPSA id x18sm3012706wmc.17.2021.08.04.11.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:58:26 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210804185004.1304692-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9e218f0a-460f-cc49-f495-848ebaff8b6f@redhat.com>
Date:   Wed, 4 Aug 2021 20:58:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804185004.1304692-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.21 20:50, Suren Baghdasaryan wrote:
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running. A mechanism to free resources of the target
> process in a more predictable way would improve system's ability to
> control its memory pressure.
> Introduce process_mrelease system call that releases memory of a dying
> process from the context of the caller. This way the memory is freed in
> a more controllable way with CPU affinity and priority of the caller.
> The workload of freeing the memory will also be charged to the caller.
> The operation is allowed only on a dying process.
> 
> After previous discussions [1, 2, 3] the decision was made [4] to introduce
> a dedicated system call to cover this use case.
> 
> The API is as follows,
> 
>            int process_mrelease(int pidfd, unsigned int flags);
> 
>          DESCRIPTION
>            The process_mrelease() system call is used to free the memory of
>            an exiting process.
> 
>            The pidfd selects the process referred to by the PID file
>            descriptor.
>            (See pidofd_open(2) for further information)
> 
>            The flags argument is reserved for future use; currently, this
>            argument must be specified as 0.
> 
>          RETURN VALUE
>            On success, process_mrelease() returns 0. On error, -1 is
>            returned and errno is set to indicate the error.
> 
>          ERRORS
>            EBADF  pidfd is not a valid PID file descriptor.
> 
>            EAGAIN Failed to release part of the address space.
> 
>            EINTR  The call was interrupted by a signal; see signal(7).
> 
>            EINVAL flags is not 0.
> 
>            EINVAL The memory of the task cannot be released because the
>                   process is not exiting, the address space is shared
>                   with another live process or there is a core dump in
>                   progress.
> 
>            ENOSYS This system call is not supported, for example, without
>                   MMU support built into Linux.
> 
>            ESRCH  The target process does not exist (i.e., it has terminated
>                   and been waited on).
> 
> [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
> [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
> 

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

