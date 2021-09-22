Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE735414F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhIVRse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233552AbhIVRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632332813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRAZvQi8QIkG/wXBuwsGoebLhQmRDzUFn2QwIAEv05c=;
        b=eA5L2jGXZDLbe2+dxpsmdcW+moihC0I+YEhx42Pny7Ssl2u0YrdwJq2y4Wqab1q/UhQ4U0
        zurJHynx1LuJ3C8nhKUV5LuSK006mqbY9QZOQ7093FIjPdd4eWr/q2jpnGvIZaQBReCGL/
        OIItjEMfUOA2SO5eyOZDv7wz9I67TWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-YoDu0orAOPKuciXt-6Ct-Q-1; Wed, 22 Sep 2021 13:46:51 -0400
X-MC-Unique: YoDu0orAOPKuciXt-6Ct-Q-1
Received: by mail-wr1-f70.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso2881790wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yRAZvQi8QIkG/wXBuwsGoebLhQmRDzUFn2QwIAEv05c=;
        b=k4YdNCILZ72c4BHHVUOpdvOZBxs++Zza7n5GOnhXiKq89TTjVbzXfnDwENKZLw+8og
         jVG5cCSnyXaY6aj6374eJu8Fr5XUmzo9ImEZFgdL6h32M3jDqzRY96IzjTJTYqDlGEWt
         Vz+N4Uw7/JHLe7rP/N9ZOugyqzyc5TFzg/LlEO59oabd+jOOd6Qa22QWEEdIMXVpamVB
         aDtm+SaYZC4WPt7B3O+EDeDTDU0KgPxDD+sTcDnGvwjCJZbR+bzcMEIgMomGg3ynB4u1
         gKO45ODCKguViR92ij7gdoJ3vWf1gw0eMep25XEfDDYxjUYO0mdoY1wLBpDd8J6DwZYt
         Wsug==
X-Gm-Message-State: AOAM533Rak25u2ET/5+q1osPM3Fcps905ZFZsTUArMGG48Ug6jh/kTCS
        fs8sBYGc/gjIbiLEA6054E6A4JEdijRJ/T5rpAoF6hkchp7Gjz96idwQH6GOZaAtvYCvw1SOpQm
        uJLd/YrSA20w5MUUkd0WUeSR7
X-Received: by 2002:a1c:a505:: with SMTP id o5mr353244wme.32.1632332810405;
        Wed, 22 Sep 2021 10:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRUR+LCJzoCbByZikpE+DxWdrmv2gBJFkOC+eNKZ2z9oQEsfmDCPQOFXlcLMOuckg32hVAdA==
X-Received: by 2002:a1c:a505:: with SMTP id o5mr353211wme.32.1632332810108;
        Wed, 22 Sep 2021 10:46:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64dd.dip0.t-ipconnect.de. [91.12.100.221])
        by smtp.gmail.com with ESMTPSA id s13sm6872088wmc.47.2021.09.22.10.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 10:46:49 -0700 (PDT)
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Balbir Singh <sblbir@amazon.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
References: <20210922061809.736124-1-pcc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <29f1822d-e4cd-eedb-bea8-619db1d56335@redhat.com>
Date:   Wed, 22 Sep 2021 19:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922061809.736124-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.21 08:18, Peter Collingbourne wrote:
> This patch introduces a kernel feature known as uaccess logging.
> With uaccess logging, the userspace program passes the address and size
> of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> is a request for the kernel to log any uaccesses made during the next
> syscall to the uaccess buffer. When the next syscall returns, the address
> one past the end of the logged uaccess buffer entries is written to the
> location specified by the third argument to the prctl(). In this way,
> the userspace program may enumerate the uaccesses logged to the access
> buffer to determine which accesses occurred.
> 
> Uaccess logging has several use cases focused around bug detection
> tools:
> 
> 1) Userspace memory safety tools such as ASan, MSan, HWASan and tools
>     making use of the ARM Memory Tagging Extension (MTE) need to monitor
>     all memory accesses in a program so that they can detect memory
>     errors. For accesses made purely in userspace, this is achieved
>     via compiler instrumentation, or for MTE, via direct hardware
>     support. However, accesses made by the kernel on behalf of the
>     user program via syscalls (i.e. uaccesses) are invisible to these
>     tools. With MTE there is some level of error detection possible in
>     the kernel (in synchronous mode, bad accesses generally result in
>     returning -EFAULT from the syscall), but by the time we get back to
>     userspace we've lost the information about the address and size of the
>     failed access, which makes it harder to produce a useful error report.
> 
>     With the current versions of the sanitizers, we address this by
>     interposing the libc syscall stubs with a wrapper that checks the
>     memory based on what we believe the uaccesses will be. However, this
>     creates a maintenance burden: each syscall must be annotated with
>     its uaccesses in order to be recognized by the sanitizer, and these
>     annotations must be continuously updated as the kernel changes. This
>     is especially burdensome for syscalls such as ioctl(2) which have a
>     large surface area of possible uaccesses.
> 
> 2) Verifying the validity of kernel accesses. This can be achieved in
>     conjunction with the userspace memory safety tools mentioned in (1).
>     Even a sanitizer whose syscall wrappers have complete knowledge of
>     the kernel's intended API may vary from the kernel's actual uaccesses
>     due to kernel bugs. A sanitizer with knowledge of the kernel's actual
>     uaccesses may produce more accurate error reports that reveal such
>     bugs.
> 
>     An example of such a bug, which was found by an earlier version of this
>     patch together with a prototype client of the API in HWASan, was fixed
>     by commit d0efb16294d1 ("net: don't unconditionally copy_from_user
>     a struct ifreq for socket ioctls"). Although this bug turned out to
>     relatively harmless, it was a bug nonetheless and it's always possible
>     that more serious bugs of this sort may be introduced in the future.
> 
> 3) Kernel fuzzing. We may use the list of reported kernel accesses to
>     guide a kernel fuzzing tool such as syzkaller (so that it knows which
>     parts of user memory to fuzz), as an alternative to providing the tool
>     with a list of syscalls and their uaccesses (which again thanks to
>     (2) may not be accurate).
> 
> All signals except SIGKILL and SIGSTOP are masked for the interval
> between the prctl() and the next syscall in order to prevent handlers
> for intervening asynchronous signals from issuing syscalls that may
> cause uaccesses from the wrong syscall to be logged.

Stupid question: can this be exploited from user space to effectively 
disable SIGKILL for a long time ... and do we care?

Like, the application allocates a bunch of memory, issues the prctl() 
and spins in user space. What would happen if the OOM killer selects 
this task as a target and does a do_send_sig_info(SIGKILL, 
SEND_SIG_PRIV, ...) ?

-- 
Thanks,

David / dhildenb

