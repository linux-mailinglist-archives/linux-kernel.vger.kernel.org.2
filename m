Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE11340B54C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhINQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhINQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:52:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:51:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k4so30234824lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjSQE15uKcrKRnQuwXqswKvc6fyo2MaxbsLWDKYQ4RY=;
        b=DO2pmRkTjsKJiTLCol77A0gNdGwgoMm2ep17W0C9mucS7ff/YCFdWbSHs2ErU6fhPu
         YUzTMjtCt8PLZc31uy2O+m8HW0pswP6pDCYl1qQiX9gB0CrYRIo9fUGPJbMM1HH3oalL
         HrPPpKM1rd1RoAq3HwZSYyx1VeRlEHHMYTGmLqu3hR00cj54+41Zv283qlza8SvPKvAZ
         tanO7zyNiVbf6CE/ZEjUZBkJjLVMDxd2b13weLL0PMmqUaggV+EuLDXmU/dD1sz0bLCz
         uSjKQVgCiuuPHwY7GioyHiEl0/b3gCsHQ4b6BfK75gOdCzG7324Z83iVL+FENUbnD4e/
         a5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjSQE15uKcrKRnQuwXqswKvc6fyo2MaxbsLWDKYQ4RY=;
        b=jaX0iDudeJ4zuW+DvqG9G2vR5HfKtr/XjIDdsRw0v41COfj/Z5FzETB/AhCMWk5NZ+
         mdbHcKyWj4PpiEnwsux2Cf/sT/ofP3jaWDSEycuUhYkPr92BzaqWSN4j4LzuCzGMLzbl
         H3dI6oYAg9/CDsMQPSplJ//T1VYywkoyW7s/mAm71L3w8PDLDCBlvIIPallg0kh44RvJ
         QCNaXrskMpghLq3QNqsxQj+84eAI6j8Ih+wQRu4WMuxrBRHo7XHZPS2makv1qZPJ5ztE
         53JQBr7PYaraXPJLjajcJ2JJSb2INAcrHudyqIE0hGXY6xS3igfHEQTbKp1+C5Bx2u4e
         ZcSg==
X-Gm-Message-State: AOAM53015M3JxbMFp6LftGh9WaDdbrsMNnBOnHOXxjkfN0QhhWlj864M
        9CDg0baqnlHJnh3qlgE6y5ZWkjyk1bj+x7ZM5LNIxg==
X-Google-Smtp-Source: ABdhPJw8kEH9jiZmIM3Ry3MTSBK9jdpUAOYp3qY4qOZ2T79bacMn9Mr8HKuTARFGh+rP4G9Wpd+ptyNvmJGYAEKk6BQ=
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr13877402lfr.295.1631638299813;
 Tue, 14 Sep 2021 09:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-4-posk@google.com>
 <CAG48ez3Kd0sfKBi9CUSYDSd+ydkQ6H=zm2-iSB3jXHCyFvuWHw@mail.gmail.com>
In-Reply-To: <CAG48ez3Kd0sfKBi9CUSYDSd+ydkQ6H=zm2-iSB3jXHCyFvuWHw@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Sep 2021 09:51:28 -0700
Message-ID: <CAPNVh5f6iaiYP8E2jKioirjJdwJDoJT-KHQLKjtgbr68H8-HxQ@mail.gmail.com>
Subject: Re: [PATCH 3/4 v0.5] sched/umcg: RFC: implement UMCG syscalls
To:     Jann Horn <jannh@google.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 6:40 PM Jann Horn <jannh@google.com> wrote:

[...]

> I think umcg_idle_loop() should never be called from scheduler
> callbacks (meaning umcg_wq_worker_running()), only from UMCG syscalls.

I'm moving umcg_wq_worker_running() out of
core.c/sched_update_worker() and into
/kernel/entry/common.c/exit_to_user_mode_loop()
(and will rename the function appropriately).
It seems rescheduling/sleeping there is fine.

I'm not yet sure if this is all that is needed to deal with
UMCG_TF_PREEMPTED flag; but I don't expect to see
any locks held when the task truly returns to the userspace.

Maybe I'll need to set TIF_NOTIFY_RESUME in sched_update_worker()...

[...]
