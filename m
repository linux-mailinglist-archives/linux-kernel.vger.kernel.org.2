Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC003DCEBE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 04:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhHBCpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 22:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhHBCpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 22:45:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047EEC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 19:45:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so360416pjr.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7u4fte1I6XIi4Oa7tBUvd/LMR8RaZqPasnqunasW4l0=;
        b=TY3Et26rst9zBPDSawe9WsBnPw9rX53CTLEDaL3lUnZDtW0Xk/Qxr5OKE9/fIe0EmV
         QaI27nyiIrxnZOhtzYucKFt49lB0PLoaMNpurrU9eHQZpBeOciZRx6ghD1hOovrK3JPP
         zu6cw5v2sP53UoYfyJ4nKho65DbHfRujSZ0WJzQfcu9sOjgEOiTGdbKaEmgZQ5MW29an
         j4jVaEXyowSCQJQZZcQ2y/pnDG4RPtXUPVNR7KKEApAJE5BUSBIGX0G2UVyRH5Uv47m9
         +k9HTNRnS8f9+VdP3eyFdKp7aAugOp072LM27gB1z20PeDoBRX6pWNPsv5fjN4ZQ30MK
         TT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7u4fte1I6XIi4Oa7tBUvd/LMR8RaZqPasnqunasW4l0=;
        b=ciwIfTGt9wqIhGP0YuNyI83yJoa3iiC2StoPkWh5+naIeP/zXovz1ske2ajAu+prrB
         cvkXujtni8zmRfNQ5WtOYc+EJqodrjAAXr3lgUpt5D4HEdVFE4G5lghIZCLo3vvOL4gz
         BRvYNe74hzuGuQMP7mGgNmKD4fkbe5cdespsWp214Rq0FdEuYFIpRG8mfONBrNy0I/dN
         CAtDD/1bD1j8oax/tFAQl3rGcEv2zmd3ZStLGsV8aCCfW08YOmT0W0yLBX9udOzguicb
         NGyQ9rE6NW1OL+4O3h2K9Jf99K3w3Bv8k6J9M5bx2GIuDVR3/jkIIDN8UaVoqL6urudP
         talg==
X-Gm-Message-State: AOAM5337RDUsoymhogs7NG+N7lNiFwYEPTenoVgWoaCG0vEfsU9C6hWX
        c4okiRf6PoqpGOJ75IbTYQGEIA==
X-Google-Smtp-Source: ABdhPJxThBu6/4FiTIIrPr1IbLXE3F7yeSoCP4Q9JCx1pYA9F/leuwwCu+SM59zcybTR+zcm5EWLsw==
X-Received: by 2002:a17:90a:6e47:: with SMTP id s7mr15295337pjm.160.1627872299586;
        Sun, 01 Aug 2021 19:44:59 -0700 (PDT)
Received: from [10.76.46.68] ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id w11sm8676719pjr.44.2021.08.01.19.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 19:44:59 -0700 (PDT)
Subject: Re: Re: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
 <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
 <585f936d-9d27-a481-f590-bd07f98f34de@bytedance.com>
 <20210730160319.6dfeaf7a@oasis.local.home>
From:   Gang Li <ligang.bdlg@bytedance.com>
Message-ID: <89c20b62-c0ab-3200-fb33-eb2058b7ba67@bytedance.com>
Date:   Mon, 2 Aug 2021 10:44:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730160319.6dfeaf7a@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/21 4:03 AM, Steven Rostedt wrote:
> Yes, synthetic events are just like normal events, and have triggers,
> stack traces, and do pretty much anything that another event can do.
> 
> I'm just finishing up a libtracfs called tracefs_sql() (hopefully
> posting it today), that allows you to create a synthetic event via an
> SQL statement. But I don't think this is what you are looking for.
> 
> What about using function tracing? Because the tracepoint is called
> from __mmap_lock* helper functions that function tracer can see, you
> can just do the following:
> 
>   # trace-cmd start -e mmap_lock -p function -l '__mmap_lock_*'
>   # trace-cmd show
> [..]
>         trace-cmd-1840    [006] ....   194.576801: __mmap_lock_do_trace_start_locking <-do_user_addr_fault
>         trace-cmd-1840    [006] ...1   194.576805: mmap_lock_start_locking: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false
> 
>         trace-cmd-1840    [006] ....   194.576806: __mmap_lock_do_trace_acquire_returned <-do_user_addr_fault
>         trace-cmd-1840    [006] ...1   194.576807: mmap_lock_acquire_returned: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false success=true
> 
>         trace-cmd-1840    [006] ....   194.576811: __mmap_lock_do_trace_released <-do_user_addr_fault
>         trace-cmd-1840    [006] ...1   194.576812: mmap_lock_released: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false
> 
>         trace-cmd-1840    [006] ....   194.576815: __mmap_lock_do_trace_start_locking <-do_user_addr_fault
>         trace-cmd-1840    [006] ...1   194.576816: mmap_lock_start_locking: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false
> 
>         trace-cmd-1840    [006] ....   194.576816: __mmap_lock_do_trace_acquire_returned <-do_user_addr_fault
>         trace-cmd-1840    [006] ...1   194.576817: mmap_lock_acquire_returned: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false success=true
> 
>         trace-cmd-1840    [006] ....   194.576820: __mmap_lock_do_trace_released <-do_user_addr_fault
>         trace-cmd-1840    [006] ...1   194.576821: mmap_lock_released: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false
> 
> 
> This looks exactly like the robots you are looking for.
> 
> -- Steve
> 

I think this is exactly what I am looking for.
Thanks!
