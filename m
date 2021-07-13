Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2304B3C6886
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhGMCdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 22:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhGMCdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 22:33:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E22C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 19:30:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f30so47354910lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JrKfZ890ZxcwAR57XkwKiWxHYjmRbFSfY7iYs08PcE=;
        b=XoXhSAe2m3APh5TGTbpo/yATNZ3V5VthaqChwTciPNbGSF89XSpc1nJBbnTKSKyzc5
         DC0KIEckWhePqSHtGCopICigvGqr3TJe4ro/AYEq32pGCOZmpxoSFzz6E6sUR9NoVPX8
         9Hu8co9Y5Ik+3i6qqv8AknH1hpXASzfuwTNRmT750wkKH7CGC94OFPwvNzTi0aseKggw
         1KpBIwo2TSRsbj3qkLBEXoEkQOqDt++32B+WcXe7GsaqkgZFGuh2gZmsJt78HgfSDyOc
         K7L5i+cyzr/n7lcVXBHGMp12k0+OU8chzECIzhS0o9E/cFfOSTgpB3lr3s4M3X/iUmkh
         dhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JrKfZ890ZxcwAR57XkwKiWxHYjmRbFSfY7iYs08PcE=;
        b=TosRgXO9zcBMcvHUN9EDp02jrsaoMK2+gI5L+mIPF08ZzzHdk06WHw7h9qeI6vZejs
         iY42mWVR9Ouep43CGGCqFJCyE9KRY0WtJ4hHlJzLLGFB1NuFxE5sCnwo+EBAGn5tC5/l
         JZ4at/HuV2bh10WeGfWbEFmozqBxRZKHK6IH0UuAkLxRmRMny1ELXvZfHDiYq2y/hrJu
         yDFu8LqqQkVig96SI4wjQrGzNWqpoJRkM18TvhyrU4eBru+ewIxoocweVH1slZ3zwIAD
         aB1tfTMF+FHMbN52W+B0cnAR08Br5R7+kHUy906t+obepUYes7lC5YeUkKrRTnzzRW/g
         Nx9A==
X-Gm-Message-State: AOAM533/VPgMb/QyIZ6hdZ7KJvzrRFvwEXwUmSjoYifPJ1yUzFn4yvbn
        qBrn+0B7nVs7XlJRq3xoAUdrY4n90VMlIf2buiM=
X-Google-Smtp-Source: ABdhPJxMOkNGRZ8sPs8QsoAVqIuVsZAaUGRy8UnlCbqyq51RR/vwmAdUXbTkcZjpk+ep9GII1SHERsV9+YIYaiLsnyA=
X-Received: by 2002:ac2:530a:: with SMTP id c10mr1498109lfh.24.1626143419838;
 Mon, 12 Jul 2021 19:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210711141430.896595-1-sxwjean@me.com> <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
 <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com> <1c4c058b-3745-5586-4961-79d83fb5b049@redhat.com>
In-Reply-To: <1c4c058b-3745-5586-4961-79d83fb5b049@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 13 Jul 2021 10:29:53 +0800
Message-ID: <CAEVVKH9rG46B7SH2cQNVFQOJywgbcPaz+gLKk1Zhioh8zB5vjw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of check_wait_context()
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 9:04 PM Waiman Long <llong@redhat.com> wrote:
>
> On 7/12/21 4:18 AM, Xiongwei Song wrote:
> > On Mon, Jul 12, 2021 at 12:43 AM Waiman Long <llong@redhat.com> wrote:
> >> On 7/11/21 10:14 AM, Xiongwei Song wrote:
> >>> From: Xiongwei Song <sxwjean@gmail.com>
> >>>
> >>> We now always get a "Invalid wait context" warning with
> >>> CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:
> >>>
> >>>        [    0.705900] =============================
> >>>        [    0.706002] [ BUG: Invalid wait context ]
> >>>        [    0.706180] 5.13.0+ #4 Not tainted
> >>>        [    0.706349] -----------------------------
> >> I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is experimental
> >> and it is turned off by default. Turning it on can cause problem as
> >> shown in your lockdep splat. Limiting it to just PREEMPT_RT will defeat
> >> its purpose to find potential spinlock nesting problem in non-PREEMPT_RT
> >> kernel.
> > As far as I know, a spinlock can nest another spinlock. In
> > non-PREEMPT_RT kernel
> > spin_lock and raw_spin_lock are same , so here acquiring a spin_lock in hardirq
> > context is acceptable, the warning is not needed. My knowledge on this
> > is not enough,
> > Will dig into this.
> >
> >> The point is to fix the issue found,
> > Agree. I thought there was a spinlock usage issue, but by checking
> > deactivate_slab context,
> > looks like the spinlock usage is well. Maybe I'm missing something?
>
> Yes, spinlock and raw spinlock are the same in non-RT kernel. They are
> only different in RT kernel. However, non-RT kernel is also more heavily
> tested than the RT kernel counterpart. The purpose of this config option
> is to expose spinlock nesting problem in more areas of the code. If you
> look at the config help text of PROVE_RAW_LOCK_NESTING:
>
>          help
>           Enable the raw_spinlock vs. spinlock nesting checks which ensure
>           that the lock nesting rules for PREEMPT_RT enabled kernels are
>           not violated.
>
>           NOTE: There are known nesting problems. So if you enable this
>           option expect lockdep splats until these problems have been fully
>           addressed which is work in progress. This config switch allows to
>           identify and analyze these problems. It will be removed and the
>           check permanentely enabled once the main issues have been fixed.
>
>           If unsure, select N.
Yes, I checked before sending patch, but didn't understand everything.
Thanks, :-).

> So lockdep splat is expected. It will take time to address all the
> issues found.
Ok.

Regards,
Xiongwei
>
> Cheers,
> Longman
>
