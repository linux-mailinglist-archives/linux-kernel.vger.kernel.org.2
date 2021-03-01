Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF2329FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbhCBDqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbhCAVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:02:53 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E9C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:02:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o34so13141448qtd.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFcvnO1HNMuOGWQ7vPwfy1mABKol50jsSED8oqXz3w4=;
        b=ePyeyOwdtWTmL4mr/ceS1jF1+XYHfY77lFcrAZUpC/oEqU0QquNezyx2LhPIl4LR/a
         L4TX46cTBScfgJe/KJgEOgs7XiK4voIycvYw6vSytEZDES6LaBscHSc8alq0odANZb9s
         /5jKUm9XvKFzUk8sWD0yhGBbgyybPTLfwmfyIT53cURtrXHt/jNhxTh9QYzdd3WjfbSI
         hx2xyiw8WHRhb8TsnF2L/jIx/v9Zg/ZIZMyox3llutp3aMEOG3QdT42kriMYjM0OU9Jx
         RYwLN2oUSbqkEQTr7um8qkjQIv5QdJMUAWdVBSMH/dFHe1cgtZ4f4QNKAvi94JVzDqGi
         qXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFcvnO1HNMuOGWQ7vPwfy1mABKol50jsSED8oqXz3w4=;
        b=DgyEbxUbLi7x6DDPp7X7RZyVgIytTCwlgqFet8Qb872np+hlx9MwbewFtcsG1kkrdW
         0s49xbtdwCP4WMBC4ZnIphnq5K5K11eE0/lkYJfwo207VgvA4mMTi4fMr2hh3a8D+Mf+
         SaOh+dOtX4Tcy78bDAFw6Kd5I//5TldB2MMwfMWRGeLee9gep1VkL5AyIY3YHqBZlLan
         qpuKjFRTzGpZVNwDI6NGrJzL5Zxd03umW2hX8tr9amn/NnT7hp277jb6dYoVxhKVQ01H
         xIshvQ5gv3MoyIKclQqoXcVZf4G8TqO1XuhZatg10ZCasDaL7lrS64v8or3bJNQHCYmG
         kiGQ==
X-Gm-Message-State: AOAM532g0WWSX9LdoewZWXsq1CEwafRz1F0i06m+TlrgNhcvhWjPnkFd
        3f4FdN+gYNxjZIMldLx0dqruOJPinTWFG9LYRvygiQ==
X-Google-Smtp-Source: ABdhPJxWt9ZuCtybtuGv7AuylOIJp2KNVLEknrmU0SSvKVZCFe2x3Z5EM/Jit4SPKiVVn6DXjz/HGcvdlQz1aew9z4Y=
X-Received: by 2002:ac8:110e:: with SMTP id c14mr14755625qtj.293.1614632531464;
 Mon, 01 Mar 2021 13:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org> <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
 <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net> <e1ee6187-77a7-dbf2-3e14-adba48460f5b@oracle.com>
 <CABk29NvX9_RxpZ71ihR7Y_Nhpg0TpBfdXzehptO52VuwOmS2Ww@mail.gmail.com>
 <c65bde1e-bac9-e6b6-e6c8-78b93f27b8e4@oracle.com> <94f43bb6-501c-2851-de32-6f4356b4a480@oracle.com>
 <ef574666-26f4-299e-65c8-2348948651f9@oracle.com> <238a7db7-3263-a391-3c57-143e9d422351@oracle.com>
In-Reply-To: <238a7db7-3263-a391-3c57-143e9d422351@oracle.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 1 Mar 2021 13:01:57 -0800
Message-ID: <CABk29NuGDmRADRjcOKN7zbYYsd8yV-KkMwvgokz9-bX2G3YYpQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core scheduling
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:08 PM Chris Hyser <chris.hyser@oracle.com> wrote:
>
> Update:
>
> The clone syscall stress test I have is causing a deadlock with this patchset when
> compiled with CONFIG_PROVE_RAW_LOCK_NESTING=y. I am able to get stacktraces with
> nmi_watchdog and am looking through those. Josh was not able to duplicate the
> deadlock, instead getting an actual warning about kmalloc w/GFP_ATOMIC while
> under a raw spinlock in the function __sched_core_update_cookie(). When I retry
> the test with a patch Josh sent, removing the kmalloc() and thus the trigger of
> the warning, no more deadlock. So some combination of CONFIGs, timing and
> function calls seems to have found something in this LOCK proving code.
>
> -chrish

I have a patch to remove the dynamic allocation and overall simplify
the logic here. Will squash that along with the rest of the
modifications suggested by Peter in the next version.
