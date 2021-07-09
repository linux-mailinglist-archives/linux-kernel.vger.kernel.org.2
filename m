Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB733C1DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhGIEB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIEB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:01:56 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8F8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:59:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d9so10922949ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Jy+wbL3yHCrFiMqsWGS+EAeGOqOu3Dy36LHF0PNkKI=;
        b=QdeyCjvCfT8p8oZ+Xsku+7FpNMHqwV1HgP3XLfgS9B4XXr22Ed/moe2exaumH9/c24
         mYVixfTXMgbucSpw8BZ0IotD6L/XKNGHAYZYuS1gHLv4ZOfZ4PgtnIb/4XLdpze6GxFn
         bjbvtpYE/f218ERLBwLOpFKksoeoqiLDX6198REMtFhPg0lKZh3SSISnV1XZMsQuTHwd
         UYiCAWEzXgoTWDffzsvtiEf1tqgeiKYW8p48HC0kOhYRhF+3bDahQ2ZB7zGAS4B9aXJh
         +oMz+xA0zNTyYRoHHTS1W/qO2oPRWano5M2X5v4LOl9/tfcsc3kpWtZKSFJVerHmFozg
         rtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Jy+wbL3yHCrFiMqsWGS+EAeGOqOu3Dy36LHF0PNkKI=;
        b=Q8LeDhyaq/AIw9G4iMZmrZQRp5mWQKDFAJTG2W+9NauxLZPE9ZIYAlF5s1gYwCSvER
         g7UYi0l7sBffnwz8/KXg6QiNawvPKWbUbCx250NFb6ZlPirCO4AzEvo+iM0/AEAucxUf
         jOtXUgJ8/UBLpJ9HyJoz+iVHjlunUVrOU/fQsCJxgonGLN7wnLiMheUuS58aKBmdvOIG
         x/lqyBCUVizMwzKpjS6/3Hp+W3aPaJRs+JWUUDgyx3dug6PXlA8cGoNW4/Yy6awQWyyR
         QfBMop62HhqDJ3JJmE2Ozp9sRG9A+C3ecPXbZZFf6I0jURsWoqLGLlu60UT5kWqJWouO
         DUCg==
X-Gm-Message-State: AOAM533s2KVE9sqsk9gWihs4yUeVoaJL8PnBPjQtAmWoH1Y+TYQs8PcA
        agQ+mpg/gqV/vcWPeVThItX4QBY9OJ+ouPjTcTI=
X-Google-Smtp-Source: ABdhPJzSXAQWMGoYtcUmToONk0bwO21UHE774tSDxiQdo0k+7z798ZoEBmF1sVxeXDs02BrRutXFVPXHdHmN8VUscGo=
X-Received: by 2002:a02:c984:: with SMTP id b4mr30649907jap.40.1625803152868;
 Thu, 08 Jul 2021 20:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210708162417.777bff77@gmail.com>
In-Reply-To: <20210708162417.777bff77@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 9 Jul 2021 11:59:01 +0800
Message-ID: <CAJhGHyBrm0iowGdX8=NDr=tBG8qM8rke2ouxWVhJRTP+pxXGJw@mail.gmail.com>
Subject: Re: BUG in alloc_workqueue (linux-next)
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xu Qiang <xuqiang36@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Pavel
Thanks for the report.

Huawei (CC-ed) is also dealing with the problem:
https://lore.kernel.org/lkml/20210708093136.2195752-1-yangyingliang@huawei.com/t/#u


Could you have a try on the fix, please?

Thanks
Lai

On Thu, Jul 8, 2021 at 9:24 PM Pavel Skripkin <paskripkin@gmail.com> wrote:

>
> I've spent some time trying to came up with a fix, but I gave
> up :( But! I have an idea about what's happening, maybe it will help
> somehow...
>
>
> So, all 3 reports have same stack trace: alloc_workqueue() in
> loop_configure(). I skimmed through syzbot's log and found, that syzbot injected
> failure into alloc_unbound_pwq() in all 3 cases:
>
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 17986 Comm: syz-executor.0 Tainted: G        W         5.13.0-next-20210706 #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> Call Trace:
>    dump_stack_lvl (lib/dump_stack.c:106 (discriminator 4))
>    should_fail.cold (lib/fault-inject.c:52 lib/fault-inject.c:146)
>    should_failslab (mm/slab_common.c:1327)
>    kmem_cache_alloc_node (mm/slab.h:487 mm/slub.c:2902 mm/slub.c:3017)
>    ? alloc_unbound_pwq (kernel/workqueue.c:3813)
>    alloc_unbound_pwq (kernel/workqueue.c:3813)
>    apply_wqattrs_prepare (kernel/workqueue.c:3963)
>    apply_workqueue_attrs_locked (kernel/workqueue.c:4041)
>    alloc_workqueue (kernel/workqueue.c:4078 kernel/workqueue.c:4201 kernel/workqueue.c:4309)
>
>
> So, if alloc_unbound_pwq() fails, apply_wqattrs_prepare() will jump to
> this code:
>
> out_free:
>         free_workqueue_attrs(tmp_attrs);
>         free_workqueue_attrs(new_attrs);
>         apply_wqattrs_cleanup(ctx);     <----|
>         return NULL;                         |
>                                              |
> put_pwq_unlocked() -> put_pwq() -> schedule_work(&pwq->unbound_release_work);
>
>
> and apply_wqattrs_cleanup() will schedule pwq_unbound_release_workfn()
> [2], but alloc_workqueue() will free workqueue_struct in case of
> alloc_unbound_pwq() error [1]. In that case we will get UAF in pwq_unbound_release_workfn()
> like in 3rd report.
>
>
> Does written above make some sence? :)
>
>
>
> With regards,
> Pavel Skripkin
