Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5471C34DE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhC3C1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhC3C0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:26:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FCDC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:26:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o10so21386750lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7mF1UI/ndoc7efLF1WEvgCjnwo/MnVD4tZwc7gstIY=;
        b=HmTNTZhkr0viwYHwuWTH7w/vahMF78U2pKfc3dD1bE9CrKumXH7Thi+7zIDyTpJrtD
         iGTG+g2sKa/wYJQC8gCwX+x1EcMC23CgY3hi++gRpOba/TFLpaloBG+UNWEOz2w6Djuf
         mf4iDOVqr6CbHVKhXgxClBMkSynex4rlFJLvAIiwI22eiwnjXo4Irt8Njx6FrxA5qD5q
         KUAeVgaiWgWODLTdCw5fv/nJQt5YUnp9iLOVOQFUmSVrCy+ZUlOshY4NASFgKN2oOFWM
         loGLLZNmIbvxlTVCGaPKkhSHGAeHB8/gM+arqMh15wHyJERJhQT1yo9KHMnKuNQv+OX/
         5oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7mF1UI/ndoc7efLF1WEvgCjnwo/MnVD4tZwc7gstIY=;
        b=Wp3P9wmJdvGqjYqCYUZHPsyyAz58ZiofoD6x1q/hDPU7ItFSGJcEJ4vetrpytgQ484
         Jz5c2Qggdq0X6HKGn1RJpx83AJdNpFwbyIJ3yY/fMUzeVXMdeTIbGAk/pJuix1pNJAv3
         35ytTROmo4n/DU3DwFJQQAPfzpN7jYf08TBBoNSmDfMYHAajEKymM3wMl9IAyizBKM5P
         lLBryFs6rf46KyYgzJD9c0Hnc0JeKY5Qq579LKWo7GdcYzmu2dnBkCtkzlpRCL6XlAWE
         z8PeYfrDSv6tZfFm4yvChFBc+fBkmyaZnkreGtUL4MDSnAdNjM3VpoQS73rB9YhKu1zx
         1KLA==
X-Gm-Message-State: AOAM530ivCzTxz2xHpdBzHhcWDt9pODpP44oPWEk8Np4PlEKXrQvQ4xY
        AziyF3BJjA9Eld+/kfY9EmH9a20bjqu/D2wB5bk=
X-Google-Smtp-Source: ABdhPJzYE+I8Olw7EVD7VmjAnft6Maow6v6gio0aiOt4XLeHcx18bMih9gbn4BDNWen20m0VG9lXs5oy8bfRLNa0h2U=
X-Received: by 2002:ac2:5933:: with SMTP id v19mr17633187lfi.405.1617071212523;
 Mon, 29 Mar 2021 19:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <1616984846-184466-1-git-send-email-zhaoqianligood@gmail.com>
In-Reply-To: <1616984846-184466-1-git-send-email-zhaoqianligood@gmail.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Tue, 30 Mar 2021 10:26:41 +0800
Message-ID: <CAPx_LQGMQzq=hQ0PzR_mXzi9Gp2X=5+Sk7fjvU5+QO_VVbnJQg@mail.gmail.com>
Subject: Re: [PATCH V4] exit: trigger panic when global init has exited
To:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>
Cc:     linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, Eric, Oleg

Any comment?

From the previous discussions, i think this change is necessary, but
we need to confirm that move the decrement of signal->live is a
safe.Here are some of my considerations
There are three places that are going to be called besides do_exit().
1. current_is_single_threaded()
current_is_single_threaded() is used to check current process just has
a single thread,my patch just moved the "signal->live--" position,this
won't change anything,current_is_single_threaded() maybe get different
value, after my patch,there is no change from the current logic.

2.css_task_iter_advance()
Same as above,css_task_iter_advance() just read "signal->live",this
may return different value,but it same before my patch.
css_task_iter_advance() cgroup_threadgroup_change_begin() held around
setting PF_EXITING before signal->live is decremented,
cgroup_threadgroup_rwsem(cgroup_threadgroup_change_begin()) is used
for user to get expect stable threadgroup,cgroup has no dependencies
on setting PF_EXITING or signal->live decrement.

3.copy_process()
copy_process() is called by fork(),copy_process will incremental
"signal->live",signal->live is atomic operation,there is no race, the
patch only move position,i don't see any new dependency problems

Moving the decrement position mainly changes the order in which
variables are assigned,we need to check if the change in the order of
assignment has any side effects on other callers.
i think acct_update_integrals(),sync_mm_rss() mainly updated some
data,only exit_signals() and sched_exit() need attention.
cgroup_threadgroup_change_begin() is called in exit_signals(),and
css_task_iter_advance used "signal->live",it seems like it might be a
little related.
cgroup_threadgroup_change_begin() just give stable threadgroup for
user,and css_task_iter_advance only check if group is dead, decrement
of signal->live and sets PF_EXITING seems like safe.

From my current analysis, this is safe.
