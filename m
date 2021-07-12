Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA23C422F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 05:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhGLDsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 23:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhGLDr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:47:59 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C6C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 20:45:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x192so26639897ybe.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L8ABxoOXKbcQzRy9ZMSwc0rHcel/3PapmdQiNjhjtyM=;
        b=B4hu6mCh97PyyC0CX0GpULhun7wNTh/YyLK6fVp/yoRmNEIb48LQI18vts7fhdPc53
         27851wxAL41qLj0Au2accSnJ9eMspcUQrpVAVNer+7aAYsQHfolpe5v/5lYH+m/MlpiQ
         Eu1ar5nGEjnJWNK1pfWi5/11J4hdFMrKQxiYbgloMfJsEDt/Y5N75Oz1j2sFv7TXdJqc
         NwIAEOV4AtbjZDyjjJaPv0BdyzFH3vZSQWxuB4rkixXx6TdP+CwawbNFXRh+N8SkWTV+
         uUgiCJJZyuaE6bnqZz/ldxusHLctuMSqBD+e9/52wKvl1Rem4eDoOahfBKS/y3i3Mscx
         d7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L8ABxoOXKbcQzRy9ZMSwc0rHcel/3PapmdQiNjhjtyM=;
        b=LyGz7A3C/72Ltcdv+hNdMchF33BXSspQ5Z+W7Qt2E5etpNBTbpmZI9nYmT6L39KIsc
         qWJ67Gg6uAxlg5VmHLsv2OzbmDz/UKAe0v/hkn7Ax1EeILSISTgSGbDr3uu1Fpy6/1P/
         cdAwaLNsHwtBQsVCpwrfiShcYLqUo6iPDmfOKFAfe6yGXENe0NtTmb03Ok0ZDOVidk4T
         8Mp4+cBVOKC2YQ7jf6BlLuaxkmtzeKF0H3aX77+C3lxG/dB+YLYsgtISsNnM8PgbRfYz
         hfzch17I7ROD/fw/8qMB9halBvzv0UokXiQBzNfMB4BogDD31ylnDCuY+7LR6r+P0UzH
         WeMg==
X-Gm-Message-State: AOAM531HYRPKfnM7JYK4+eWuG4p68IsNUxvFvcmYQSflqcSfqcIeRXWn
        r0wFWqHtPBm2uq4C+LlOQ/dYKnzFtDH/4Z0JiK0=
X-Google-Smtp-Source: ABdhPJwbOaa/J7hh7brEK3NBXjhdYcR4Vn9F1p4kGCr4bIx44+TWX7DQMi8Sc1Kf7CsMLD+cPG/B9Ohg5spQSRRANac=
X-Received: by 2002:a25:8143:: with SMTP id j3mr62233680ybm.237.1626061511524;
 Sun, 11 Jul 2021 20:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210709122712.42844-1-yaozhenguo1@gmail.com> <872612b5-b9c6-43aa-a167-1c204d0f1c5a@kernel.dk>
 <CA+WzARnFgohHZ=BhL4OaCagB_c1uB6a=Bv7vM_zRUJeANHksEg@mail.gmail.com> <db2410e2-1f1a-b396-10d1-1df3ec061b78@kernel.dk>
In-Reply-To: <db2410e2-1f1a-b396-10d1-1df3ec061b78@kernel.dk>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Mon, 12 Jul 2021 11:45:00 +0800
Message-ID: <CA+WzARkyhLrntJfZ2cCB+Z5kiiLAB=OzhERgWQ66bVKr++Yk-A@mail.gmail.com>
Subject: Re: [PATCH] task_work: return -EBUSY when adding same work
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org, yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue happens in a stress test of memory UE injection. It has
more than once UEs reported to the OS at the same moment in the test.
So  do_machine_check-->queue_task_work is called many times.
mce_kill_me work is added to list many times.  When mce_kill_me is add
to the list,  it becomes the list header and then another mce_kill_me
is added to the list before task_work_run is called.  The list becomes
a dead loop: task->task_works =3D mce_kill_me, mce_kill_me->next =3D
mce_kill_me.  When the task want to  return to user mode and run
task_work_run.  It becomes a dead loop and never return to user mode
and process signal SIGBUS that mce_kill_me sent to him. I fix this by
following patch
--
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 22791aa..9333696 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1299,7 +1299,9 @@ static void queue_task_work(struct mce *m, int
kill_current_task)
        else
                current->mce_kill_me.func =3D kill_me_maybe;

-       task_work_add(current, &current->mce_kill_me, TWA_RESUME);
+       /* Avoid endless loops when task_work_run is running */
+       if (READ_ONCE(current->task_works) !=3D &current->mce_kill_me)
+               task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
--
But I think it is better return an error in task_work_add when same
work is added to the list. Similar problem may happen in other scenes.
It is hard to debug when it is a seldom issue.

Jens Axboe <axboe@kernel.dk> =E4=BA=8E2021=E5=B9=B47=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/11/21 8:13 PM, zhenguo yao wrote:
> > Yes I hit this condition.  The caller is queue_task_work in
> > arch/x86/kernel/cpu/mce/core.c.
> > It is really a BUG. I have submitted another patch to fix it:
> > https://lkml.org/lkml/2021/7/9/186.
>
> That patch seems broken, what happens if mce_kill_me is added already,
> but it isn't the first work item in the list?
>
> --
> Jens Axboe
>
