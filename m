Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20B41DA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351165AbhI3Mzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351127AbhI3Mzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:55:45 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA0C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:54:03 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n71so7448385iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=se4EiZ00KtrBxjyRNVBoxuylYR7GsMp6vwQq86rutw4=;
        b=LmRe3QFhGUUogxSg/CCyhlKdpk/4mZBmoSK5hvOhVvGWQaUJHDIO0TfaqXzIjmXCBH
         WUJK6oGSX3BJuE9OChsHTC4d497mmW83oPSjbhhSa0WV1cwNHca532+qYfZD06C9aZPc
         nHwbB8TVQelA5DeQONC90hxdF4wAp+oq+FfPTqmBsQarPQXGc3XSxCYPNx6aEiLSTyUc
         CeVa/NfGioZ+5Jww//Z0l5BjKvHnEU80gJDdjfO5iVHzPDoKcMBIDkt3H80Et+ATy9jB
         35UKDxLR2R1JJw4eStsmBtW3Ry4P3Gv56B451/2LYKAxbpH1jIqeQqlzPM0eCloQRui1
         iZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=se4EiZ00KtrBxjyRNVBoxuylYR7GsMp6vwQq86rutw4=;
        b=K5Skp2ZH/2Vw7c807pLwqD4xE1q7xNaotndlsREEYRD5IGJBgrtwCqJ4vBPR6j4W3P
         WMgvd9QXfLRt/fEIKk3niJ0Rc26t8aF4w8Si8cTz/e7OfEY8wGyDQgMU5JaOlJ9K9xXE
         u8/UwEQxw93QHHyLtqVmjMQ4y+5pL4EAa+gO/D0esXi2vWV/wjvuko+PmPmUWGFF6JSm
         tJV1AlykwFHYJj1uWoZzR/Yz9YfUNRazQqr5kZ9DNxn05rkr+DeqFOa1siqQIno8ExXj
         EXMdrnUfv4/gPqAL3dpRFdMaKWLpKvvh7mGJT8ZaqDNlExvEH0cLUN4drP98oq38J+vk
         gMDg==
X-Gm-Message-State: AOAM533bnViah1Zz4V9AcGr2MMcr9YqOjCrANZgJ1KXpMBF8nhgwsH60
        EltlTIKBxOZLSfguUMqA/2k40V6tQerH9ZGUAiQ=
X-Google-Smtp-Source: ABdhPJxGJAPx9Jjiz0QqV8F7jMg1PldCu6DQT0Q0wxjqT54Ja84VaZxZSsZxpigYPVS12yntEsfNSOF9DyPsQPYPXco=
X-Received: by 2002:a5d:9493:: with SMTP id v19mr3677984ioj.34.1633006442959;
 Thu, 30 Sep 2021 05:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-5-laoar.shao@gmail.com>
 <202109291113.6DE8D6F3D@keescook>
In-Reply-To: <202109291113.6DE8D6F3D@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Sep 2021 20:53:27 +0800
Message-ID: <CALOAHbD3HUqUnjMYKX7NGwVWiS4K7OvS6uPNWucnOA5Cy3pn9w@mail.gmail.com>
Subject: Re: [PATCH 4/5] kernel: increase the size of kthread's comm
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 2:20 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 29, 2021 at 11:50:35AM +0000, Yafang Shao wrote:
> > This patch increases the size of ktread's comm from 16 to 24, which is
> > the same with workqueue's, to improve this situation. After this cahnge,
> > [...]
> > Because there're only a few of kthreads, so it won't increase too much
> > memory.
>
> Even without the performance impact changes, the math here doesn't hold
> either, since using kmalloc means there are slabs being allocated to hold
> the task "comm"s now (which comes with overhead), and every task added
> a pointer to those 16 bytes (i.e. 8 more bytes on 64-bit systems). So
> this change, even if there was 0 overhead in using slabs, would be
> identical to having just raised TASK_COMM_LEN to 24. 8 byte pointer,
> 16 byte allocation == 24 bytes.
>

Right, thanks for the explanation. I missed the pointer before.

What about reusing the kthread_data() to store the the comm if the
kthread is not a kworker?

struct kthread {
     ...
     void *data;  // reuse this pointer
     ...
}

The logic will be something as follows,

    if (kthread_is_kworker) {
          store_worker_desc_into_kthread_data(); // already did in the kernel
     } else {
          store_comm_into_kthread_data();   // that is what we should change
    }

And then we modify the  proc_task_name() correspondingly.

-- 
Thanks
Yafang
