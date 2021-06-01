Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD54396DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhFAHVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFAHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:21:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3148DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 00:20:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so2455497wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpldND73wMpUrk8dzVr8oFsvyvtepEiOeNZ1yb6Gx1Y=;
        b=gMijSbXSnlSgRcEHgN/tRe8uiOeSqoD3nk4U8U51ttJCQZV2UevhWnYqpxy2v7kb3C
         a94jFPRwTMrgP8tiC4WR7HGCWxyAvYq4omKfUxTG/Ij57Piwyy5fBchdAUmOGd1Pa//P
         sjnnFqKLdHB3skD2XYEetA0Cy74Abnog7iPHVAIGEOJKlm4Z8e7LmuVu1TATLOu6HBQO
         uX39h5rHiPLymt3vxMSGRvUXMAy7t4Z9mgLkBcQNRkXKjPomeiXUjpV6LvY2VHb4+TqV
         D3+sVnYVb3SMaPnbMxmgvLzqfZpZdDHI67gtgZNe48ab45cVk9QGXoIk7fxiVLdMecwo
         hBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpldND73wMpUrk8dzVr8oFsvyvtepEiOeNZ1yb6Gx1Y=;
        b=Fz06aLdv2VqXat2W9go4IJN+DU+M+0M2PLjezq3D1qQAbUf90omBb7tfRMKu5Y1NF6
         PnzqId5vrt0qZ8nU2KTev0JBwQhNDiiT0HDBla8NdlDHwbFy57LYOi4GhTM8Yg+NJ7d/
         qYs06RL2KJ/057b0/NWlQJXs2WlOqeoJaGg/PqssQNkz4Wydm+9eqenjIKroHTy+/GTh
         FHX8r+QEtRXW+XpIj3/LLgr9HxJ8nP9EvIwORaYhUe0fqDRJXgO6r7DvNeR8rIRdIdV7
         pqKtW8Cd59fV7LNTPpiT1xTDUV1b7k+GO90o67PEs8j8YcDqC7k3RN647KFSSG+hYfif
         quUg==
X-Gm-Message-State: AOAM530dH1cpZdZ1H0v1uD7LTcxMjacJEyqIDHhQe2LFVT0di7MyIvsw
        aBeS/EEtVkT0Xhf8PVJPh7H4kV+9Tl7iA3ieh+zIvhwYs7Ol1w==
X-Google-Smtp-Source: ABdhPJwvCpkGp+sQ7126U4GSkq0lCk05taZm7wi11BI859TRmDY0I2NTBnYbIGAglma5QOCqQgETNaaJNdjj7bju5/c=
X-Received: by 2002:a05:6000:154e:: with SMTP id 14mr1836950wry.226.1622532003752;
 Tue, 01 Jun 2021 00:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210526070911.31681-1-cgellner@de.adit-jv.com>
In-Reply-To: <20210526070911.31681-1-cgellner@de.adit-jv.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 1 Jun 2021 09:19:53 +0200
Message-ID: <CAHUa44GEBa_UDURtnshGCNMSJK2LqX_jXmFFzPV1Zw=iYzf8Pw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] tee: optee: Allow to freeze when tee-supplicant
 is frozen
To:     Christoph Gellner <cgellner@de.adit-jv.com>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, May 26, 2021 at 9:10 AM Christoph Gellner
<cgellner@de.adit-jv.com> wrote:
>
> When the system is going to hibernate or suspend it might happen
> that the tee-supplicant task is frozen first.
> In this case a running OP-TEE task might get stuck in the loop using
> wait_for_completion_interruptible to wait for response of tee-supplicant.
>
> As a consequence other OP-TEE tasks waiting for the above or a
> succeeding stuck OP-TEE task might get stuck as well
> - waiting for call queue entry to be completed
> - waiting for OPTEE_RPC_WAIT_QUEUE_WAKEUP
>
> This will result in the tasks "refusing to freeze" and
> the hibernate or suspend will fail.
>
> OP-TEE issue: https://github.com/OP-TEE/optee_os/issues/4581
>
>
> - Read back the object
> PM: suspend entry (s2idle)
> Filesystems sync: 0.000 seconds
> Freezing user space processes ...
> Freezing of tasks failed after 20.008 seconds (3 tasks refusing to freeze, wq_busy=0):
> task:optee_example_s state:R  running task     stack:    0 pid:  124 ppid:     1 flags:0x00000001
> [<807d3e24>] (__schedule) from [<841c4000>] (0x841c4000)
> task:optee_example_s state:D stack:    0 pid:  126 ppid:     1 flags:0x00000001
> [<807d3e24>] (__schedule) from [<807d41d0>] (schedule+0x60/0x120)
> [<807d41d0>] (schedule) from [<807d7ffc>] (schedule_timeout+0x1f4/0x340)
> [<807d7ffc>] (schedule_timeout) from [<807d56a0>] (wait_for_completion+0x94/0xfc)
> [<807d56a0>] (wait_for_completion) from [<80692134>] (optee_cq_wait_for_completion+0x14/0x60)
> [<80692134>] (optee_cq_wait_for_completion) from [<806924dc>] (optee_do_call_with_arg+0x14c/0x154)
> [<806924dc>] (optee_do_call_with_arg) from [<80692edc>] (optee_shm_unregister+0x78/0xcc)
> [<80692edc>] (optee_shm_unregister) from [<80690a9c>] (tee_shm_release+0x88/0x174)
> [<80690a9c>] (tee_shm_release) from [<8057f89c>] (dma_buf_release+0x44/0xb0)
> [<8057f89c>] (dma_buf_release) from [<8028e4e8>] (__dentry_kill+0x110/0x17c)
> [<8028e4e8>] (__dentry_kill) from [<80276cfc>] (__fput+0xc0/0x234)
> [<80276cfc>] (__fput) from [<80140b1c>] (task_work_run+0x90/0xbc)
> [<80140b1c>] (task_work_run) from [<8010b1c8>] (do_work_pending+0x4a0/0x5a0)
> [<8010b1c8>] (do_work_pending) from [<801000cc>] (slow_work_pending+0xc/0x20)
> Exception stack(0x843f5fb0 to 0x843f5ff8)
> 5fa0:                                     00000000 7ef63448 fffffffe 00000000
> 5fc0: 7ef63448 76f163b0 7ef63448 00000006 7ef63448 7ef634e0 7ef63438 00000000
> 5fe0: 00000006 7ef63400 76e74833 76dff856 800e0130 00000004
> task:optee_example_s state:D stack:    0 pid:  128 ppid:     1 flags:0x00000001
> [<807d3e24>] (__schedule) from [<807d41d0>] (schedule+0x60/0x120)
> [<807d41d0>] (schedule) from [<807d7ffc>] (schedule_timeout+0x1f4/0x340)
> [<807d7ffc>] (schedule_timeout) from [<807d56a0>] (wait_for_completion+0x94/0xfc)
> [<807d56a0>] (wait_for_completion) from [<8069359c>] (optee_handle_rpc+0x554/0x710)
> [<8069359c>] (optee_handle_rpc) from [<806924cc>] (optee_do_call_with_arg+0x13c/0x154)
> [<806924cc>] (optee_do_call_with_arg) from [<80692910>] (optee_invoke_func+0x110/0x190)
> [<80692910>] (optee_invoke_func) from [<8068fe3c>] (tee_ioctl+0x113c/0x1244)
> [<8068fe3c>] (tee_ioctl) from [<802892ec>] (sys_ioctl+0xe0/0xa24)
> [<802892ec>] (sys_ioctl) from [<80100060>] (ret_fast_syscall+0x0/0x54)
> Exception stack(0x8424ffa8 to 0x8424fff0)
> ffa0:                   00000000 7eb67584 00000003 8010a403 7eb67438 7eb675fc
> ffc0: 00000000 7eb67584 7eb67604 00000036 7eb67448 7eb674e0 7eb67438 00000000
> ffe0: 76ef7030 7eb6742c 76ee6469 76e83178
> OOM killer enabled.
> Restarting tasks ... done.
> PM: suspend exit
> sh: write error: Device or resource busy
>
>
> The patch set will switch to interruptible waits and add try_to_freeze to allow the waiting
> OP-TEE tasks to be frozen as well.
>
> ---
>
> In my humble understanding without these patches OP-TEE tasks have only been frozen in user-space.
> With these patches it is possible that OP-TEE tasks are frozen although the OP-TEE command
> invocation didn't complete.
> I'm unable to judge if there are any OP-TEE implementations relying on the fact that suspend won't
> happen while the OP-TEE command invocation didn't complete.
>
> The theoretical alternative would be to prevent that tee-supplicant is frozen first.
>
>
> I was able to reproduce the issue in OP-TEE QEMU v7 using a modified version of
> optee_example_secure_storage (loop around REE FS read, support multi-session).
> See https://github.com/OP-TEE/optee_os/issues/4581 for details.
>
> After applying these patches (minor adjustments of the includes) I was no longer able to
> reproduce the issues.
> In my tests OP-TEE QEMU v7 did suspend and resume without troubles.
>
> I'm not able to test on other devices supporting OP-TEE.
>
>
> I decided to handle each of the locations the OP-TEE task could get stuck as a separate commit.
> The downside is that the above call stack doesn't really fit to any of the commits.
>
> Christoph Gellner (3):
>   tee: optee: Allow to freeze the task waiting for tee-supplicant
>   tee: optee: Allow to freeze while waiting for call_queue
>   tee: optee: Allow to freeze while waiting in
>     OPTEE_RPC_WAIT_QUEUE_SLEEP
>
>  drivers/tee/optee/call.c | 8 +++++++-
>  drivers/tee/optee/rpc.c  | 9 ++++++++-
>  drivers/tee/optee/supp.c | 3 +++
>  3 files changed, 18 insertions(+), 2 deletions(-)

These patches look good to me. I would really appreciate feedback from
someone who is more familiar with the usage of  try_to_freeze() and
friends.

Thanks,
Jens
