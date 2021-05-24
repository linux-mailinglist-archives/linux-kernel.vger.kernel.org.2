Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C0E38F61D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhEXXMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:12:40 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:43752 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEXXMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:12:38 -0400
Received: by mail-ej1-f42.google.com with SMTP id f18so14098601ejq.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F7WP2tnI4GZXM+X6wYZmJy5zq0U3wilOKGw5axjD9o=;
        b=tvubuW1NOlFBMbMDKdoJz34zzwhoNEevRlSZeFYlk0Ca7lk+ozAsz0WAH+2TLnt5sW
         0uh+zZKOwGK3gPnx0s1uiy3gkq/tQ0QZKuA7VEQkZq+Cf2GriAiz6rlE79d+09PQNYoF
         YVjc29k0A+JGlmGwEbeOE3y4xBdU8Nnyf5kT+3VP34TpCAgt0+CS20wgM9qMdsyJlu9i
         pjXA9AsweZtaZL0LFUXZbLdHQgQQda+dmZrwqSc68fn8qYq8jmM+hZc9P0bImPmex9HA
         sJiXWAyp3yvBHwiNUu3uH5TQX8Bh+S0Py1HIjfdwOVT5VzVcFHeBo3ns0hSqlztNpVVu
         jc5A==
X-Gm-Message-State: AOAM531tg7nTi1Pm7VgYWxgUU9G+igsYKGrFxQOQ9UCtj7iOqjg+Z7FG
        qDkMFsX1IkB+dAxRwE+XzZBstqIJqPExawI9qvA=
X-Google-Smtp-Source: ABdhPJxxiH9/bVzmp2TlY7P3lsCq/5EoULyHdsa94sajVCiNYdsSNQk+MoFss5cDapPw+OSOpGjWLHaHggBNGM4Kx+k=
X-Received: by 2002:a17:906:2dca:: with SMTP id h10mr25217977eji.507.1621897868000;
 Mon, 24 May 2021 16:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com> <20210523193259.26200-16-chang.seok.bae@intel.com>
In-Reply-To: <20210523193259.26200-16-chang.seok.bae@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 19:10:57 -0400
Message-ID: <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
Subject: Re: [PATCH v5 15/28] x86/arch_prctl: Create ARCH_GET_XSTATE/ARCH_PUT_XSTATE
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 3:39 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> N.B. This interface is currently under active discussion on LKML. This [v4]]
> proposal implements a per-task system call with GET/PUT semantics. A
> per-process system call without PUT semantics may be superior.

There is a better way...

In the v5 strawman here, every library routine that uses AMX
must precede that use with a system call
requesting permission from the kernel,
and then a system call yielding permission.
These calls must be always present because
this API requires that it be invoked per task,
but the library has no idea if the current thread has called the API or not.

The two concepts at play are "fine grained permission" and "buffer management".
We can improve on this by treating them as dependent, rather than equivalent.

The reality is that process-wide, rather than task-specific permission
is sufficient.
For if there exists a use-case where an administrator would want to grant
AMX access to one task in a process, but deny it from another, I have
yet to imagine it,
and I pity the application/library programmer who would have to face it.

Further, I submit that granting permission to an application,
but then denying permission to a subsequent request is unrealistic.
Applications will have already initialized their threads
and data structures based on the capabilities of the hardware.
Asking them to cope with such a change at run time is not reasonable.

The reality is that if they actually look at a failed return code,
they will exit.
If they ignore the return code and proceed, they will trap and crash.
Not likely will programmers be excited, or willing, to write code
to actually handle dynamic loss of permission.

The down-side of permission (whether it be per-process as proposed here,
or per-task, as in the v5 patch) is that to check if AMX is enabled, user-space
must check three things instead of two:

1. CPUID has AMX
2. XCR0 has AMX
3. Linux permission has been requested and granted to this process

If we accept that fine-grained permission is required, I don't see a practical
or efficient way to do it without #3.  (No, our hardware can not trap CPUID
reads, or avoid VMEXIT on XCR0 changes)

And so I propose:
1. Per-process permission (not per-task).
2. Permission, once granted, remains valid for the lifetime of that process.

And so any access to AMX before this process-wide permission is
granted will fail,
and any access to AMX after process-side permission is granted will succeed.

Period.

Which brings us to context switch buffer management.

After per-process permission is granted, we have two options on how
to handle context switch buffer management, both have merit:

1. On-demand.  Any task in a process that has AMX permission can touch AMX.
When it does, it takes a #NM, the kernel allocates the 8KB buffer, disarms XFD
and returns.  This is how v4 of this patch series worked.

The first benefit of on-demand is that user-space isn't mandated to do any
more Linux-specific system calls after the per-process permission is granted.

The second benefit of on-demand is that a process with 1,000 threads
and only 8 of them
in a pool actually touch AMX, then 8 buffers will be allocated, not 1,000.

The dis-advantage of on-demand is that there is no buffer release mechanism --
the buffer lives as long as the task lives.  Though, per previous conversation,
a future kernel could easily implement a buffer re-claim mechanism
behind the scenes
since the kernel is empowered to re-arm XFD for whatever reason it wants...

2. Synchronous allocation.  Any task in the process that has AMX permission can
make a 2nd system call to request that the kernel synchronously allocate the
8KB buffer for that task. *

* This could also be implemented to mean "allocate for this task
and upon the creation of all future threads in this process".
Though doing so could result in cases where the kernel allocates
many more buffers than are actually necessary.

The benefit of synchronous allocation is that after an application has created
all of its threads, it knows that it would have got a synchronous error code
from this special system call if any of them failed to allocate.

Note that detection of allocation failure upon thread creation
could also be implemented using dynamic allocation by simply touching
AMX state --
except the failure would be delivered through a signal,
rather than an error code from a special system call.

Although it is possible, and it is implemented in v5, I don't advocate that
synchronous allocation have a matching synchronous de-allocation.
I don't think programmers will use it; and I don't see a case for
complicating the kernel code with reference counters that are unused.

So the value proposition for synchronous allocation is thin, but it exists.

My recommendation is to implement both #1 and #2, and to document
that #1 may fail you with a signal, while #2 under the same scenario
would fail you with a return code.  If you are a programmer that prefers
that error code rather than writing a signal handler, then use the
new system call.

-Len Brown
Intel Open Source Technology Center
