Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486F8417D11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347689AbhIXVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbhIXVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:42:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C1C061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:41:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g14so10047648pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6BvzGqElPxmqBQ3IAuO4GrZ2ACxHqQDnGO9OXR4FYUw=;
        b=T+5Vt8JpOhJY3Koam6945ocqLW0xkaYMsiUwzlhg+PQr7aU8oTtXRopX+TyRgP7ejR
         RltRr2+92rP6CwSunNUaizQ/z8/rpzJhAljJki0wa73bSo4fqsE/7JkKDYoFc6TbTRD+
         Ljkd9zjoh/onoDPhSaCnhPWMFw6I0MeaaaouA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6BvzGqElPxmqBQ3IAuO4GrZ2ACxHqQDnGO9OXR4FYUw=;
        b=Je1jJ+kXfoXnF/y/dlzerg6xskn9rCBk6allb9O9sO5oJmqEdbO2FyQ23DvQL02pOh
         Q5gyaGEMzGpehzXge1oFnS54FRwa7DVi4SmXe8cfSzjD6Js9yGseXGS0nFXkbfdVLhQj
         rfuSutPiO+hoSNoh2hC8VdZq/Rws7s32Jx9pkjqNP3VOpu6dh0NNpr62gjgISGegbBay
         w85gLxrEgrmj6DPCznImCvIXvg5F44cAtKOlutrkCfxG3pRBM5OTUs5CZqw1kmBYmmAn
         XKeImklk4dKp6v/b3w3BAfX2CPlSpytKcA43iphVzRDTlKEfMDUEVo5g0Cz4NgqDJC4a
         mGeA==
X-Gm-Message-State: AOAM5311yhcRVkVWFp28FC+oVs7Qj8hnSPyqDPYaXQEgtGhh3gXsAcPN
        pmMHRwP7gtp/XmsRuYdMJIIUqw==
X-Google-Smtp-Source: ABdhPJyC6lK8ixuIm9iJ9qZndymlZFFBkv7KWGD/IsBeU5rrTui5h4g1u7GP1z7M59q6zh4olx9tWg==
X-Received: by 2002:a63:8f06:: with SMTP id n6mr5569586pgd.315.1632519669386;
        Fri, 24 Sep 2021 14:41:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm9394891pjd.9.2021.09.24.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:41:08 -0700 (PDT)
Date:   Fri, 24 Sep 2021 14:41:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 5/6] coredump:  Don't perform any cleanups before dumping
 core
Message-ID: <202109241440.29214C9@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <874kaax26c.fsf@disp2133>
 <202109241135.A683423@keescook>
 <87lf3lirxh.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf3lirxh.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 04:28:58PM -0500, Eric W. Biederman wrote:
> So everything should work from a locking perspective as I am not
> changing the locking I am simply moving the call from exit_mm earlier.
> 
> To explain how the locking works.
> 
> Coredumps are not handled in complete_signal, so when
> a thread dequeues the signal the other threads are all running.
> 
> If two threads dequeue core dumping signals at the same time both will
> contend for mmap_write_lock one will get it and set core_state the
> second will return -EBUSY from coredump_wait and return from do_coredump
> and proceed to do_exit.
> 
> There similar set of races that zap_threads called from coredump_wait
> resolves by testing for signal_group_exit inside of sighand lock.
> 
> The normal case is one thread runs through do_coredump, coredump_wait,
> and zap_threads, counts the threads and waits in coredump_wait for
> all of the other threads to stop.
> 
> The other threads proceed to do_exit and  coredump_task_exit.
> From their the discover that core_state is set.  And holding
> the mmap_read_lock is enough to know ensure that either
> no coredump is in progress or all of the setup is complete in
> coredump_wait.
> 
> If core_state is found it is known that there is a waiter waiting in
> coredump_wait.  So the tasks add themselves to the list.  Decrement
> the count to indicate they don't need to be waited for any longer
> and the last one waits up the waiter in coredump_wait.
> 
> The threads then spin in TASK_UNINTERRUPTLE until the coredump
> completes.
> 
> The dumping thread takes the coredump then calls coredump_finish.
> In coredump_finish the linked list is torn down, and each element
> of the linked list has sets ".task = NULL"  Then the task is woken
> up.
> 
> The task waiting in TASK_UNINTERRUPTIBLE wakes up. Sees that .task =
> NULL and proceeds with the rest of do_exit.
> 
> 
> The only change  this patch makes to that entire process is
> "task->mm = NULL" is replaced by setting PF_POSTCOREDUMP.
> 
> Does that help?

That does! Thanks very much for the run-down on the flow there. I'm
convinced. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
