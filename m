Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A743B29D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhFXIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFXIGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:06:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:03:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d16so8750624lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4CQMerLOdaAc4Hp8r/ylioEm8qMWMB9NcwlnCoMYt4=;
        b=Txpr7P4/dr5mfulPl4Iblb+a6OmJv2BS3ilqkDBiR3aY6YEBxmX93idQ4TcTIg715w
         79kJrtetCmc40gIF+TETshVrXFsT42T1OLOkqjkYBK9QKr4DsZ6TBFZFOxhi5scVxrem
         CQ40sGJmg02kwh/5EYmWegjEvJxCj2k7YRiOJKb0DkKtJkkJ3eXZjst4NxaaewqHRCMD
         lL6+FUNpTAmEG/nawNEMIyhuC26NAMmg0tO3yxGAUtuyh+iogEearhWWI5gz6MY2cFsa
         p/2PjDW22aJEj16kU+hdWCoSzn5xBU6zmbmMC6+kTh8htYP9/Up3NXrjdfVys8z5OrOm
         MiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4CQMerLOdaAc4Hp8r/ylioEm8qMWMB9NcwlnCoMYt4=;
        b=SCsvrzYBZrqj5z/UD3L7yG1bkBG29fWqHKDC3ofPOknBDc/GdTI18vV9xPTBzW0Ue9
         OSLqiHSqWvdrBeCSmYKh97KOqnoj2/o4wHW5G1SHJq/Jr/SZFHRQUzdGgLLOiKVxgNbr
         nupMnlJo4q84BgCwYZ3wnak0BKqhGpyMD43PgrHEdbsWoyLV00lANoeYqQVFa47ynvsW
         EvSDAi8GrbwzmX4d+/czKRgrF0vdDbctPhj7PSVyVFQKMCg6vozrs0niksQXo4daywba
         mdvohM4cI0z5wHTojCA1iOQ3cmeXvmNL7yI60iY1z4pFddTh5yHObGTUuwqSqDIromIf
         lREw==
X-Gm-Message-State: AOAM5337a2S99AvtNuxEVi+dxO+hrx+QeEqwoUKI68NEcjs5AtxlqiWL
        DzxZZrGXq9UiVAoVU8f8uLjY6/JvPREgK2/nkIk=
X-Google-Smtp-Source: ABdhPJzLUcP2fTKnv3FpcMuRdoYQK91JVRskCMlPifB0F0OhuqPNx66iHpbJFnHrb9Vq9laCRymXhlYow7wGTG+UgY0=
X-Received: by 2002:a05:6512:63:: with SMTP id i3mr2927457lfo.587.1624521819796;
 Thu, 24 Jun 2021 01:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210618145534.438816-1-sxwjean@me.com> <20210618145534.438816-4-sxwjean@me.com>
In-Reply-To: <20210618145534.438816-4-sxwjean@me.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Thu, 24 Jun 2021 16:03:12 +0800
Message-ID: <CAEVVKH-X5XHHf-WVyM=GFvU+MrphLb3TDk4HC_2c+6uyMV0y1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] locking/lockdep: Print possible warning after
 counting deps
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi experts & Boqun,

Any comments here?

I did a test for the series, got the results below:

/ # cat /proc/lockdep
all lock classes:
ffffffffa6b63c90 FD:   37 BD:    1 +.+.: cgroup_mutex
 -> [ffffffffa6b78d70] pcpu_alloc_mutex
 -> [ffff8a783d5e8760] lock#2
 -> [ffffffffa6b8dc90] iattr_mutex
 -> [ffffffffa6b8de10] kernfs_mutex
 -> [ffffffffa6b63ab8] cgroup_file_kn_lock
 -> [ffffffffa6b63bd8] css_set_lock
 -> [ffffffffa6b65770] freezer_mutex

ffffffffa6b54fd8 FD:    1 BD:   56 -...: (console_sem).lock

ffffffffa6b54f80 FD:   68 BD:   11 +.+.: console_lock
 -> [ffffffffa6a74d58] console_owner_lock
 -> [ffffffffa6a74da0] console_owner
 -> [ffffffffa6a6a2f8] resource_lock
 -> [ffffffffa8013710] &zone->lock
 -> [ffffffffa6bea758] kbd_event_lock
 -> [ffffffffa6be12f8] vga_lock
 -> [ffffffffa6b54fd8] (console_sem).lock
 -> [ffffffffa6b54f38] syslog_lock
 -> [ffffffffa6b802e0] fs_reclaim
 -> [ffffffffa8042500] &x->wait#5
 -> [ffffffffa6bfdc70] gdp_mutex
 -> [ffffffffa80328a0] &k->list_lock
 -> [ffff8a783d5e8760] lock#2
 -> [ffffffffa6b8dc90] iattr_mutex
 -> [ffffffffa6b8de10] kernfs_mutex
 -> [ffffffffa6be2838] bus_type_sem
 -> [ffffffffa6b8e018] sysfs_symlink_target_lock
 -> [ffffffffa80421a0] &dev->power.lock
 -> [ffffffffa6c01110] dpm_list_mtx
 -> [ffffffffa6bdedd0] uevent_sock_mutex
 -> [ffffffffa8032cb0] subsys mutex#7
 -> [ffffffffa6c00958] req_lock
 -> [ffffffffa74e4ce0] &p->pi_lock
 -> [ffffffffa80423e0] &x->wait#7
 -> [ffffffffa74e7f70] &rq->__lock
 -> [ffffffffa8036c30] subsys mutex#19

I compared the TOP 3 of deps count output, the results are completely
same with/without the series patch.

Regards,
Xiongwei


On Fri, Jun 18, 2021 at 10:56 PM Xiongwei Song <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <sxwjean@gmail.com>
>
> The graph walk might hit error when counting dependencies. Once the
> return value is negative, print a warning to reminder users.
>
> However, lockdep_unlock() would be called twice if we call print_bfs_bug()
> directly in __lockdep_count_*_deps(), so as the suggestion from Boqun:
> "
> Here print_bfs_bug() will eventually call debug_locks_off_graph_unlock()
> to release the graph lock, and the caller (lockdep_count_fowards_deps())
> will also call graph_unlock() afterwards, and that means we unlock
> *twice* if a BFS error happens... although in that case, lockdep should
> stop working so messing up with the graph lock may not hurt anything,
> but still, I don't think we want to do that.
>
> So probably you can open-code __lockdep_count_forward_deps() into
> lockdep_count_forwards_deps(), and call print_bfs_bug() or
> graph_unlock() accordingly. The body of __lockdep_count_forward_deps()
> is really small, so I think it's OK to open-code it into its caller.
> "
> we put the code in __lockdep_count_*_deps() into lockdep_count_*_deps().
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  kernel/locking/lockdep.c | 45 +++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index cb94097014d8..c29453b1df50 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2024,55 +2024,52 @@ static bool noop_count(struct lock_list *entry, void *data)
>         return false;
>  }
>
> -static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
> -{
> -       unsigned long  count = 0;
> -       struct lock_list *target_entry;
> -
> -       __bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
> -
> -       return count;
> -}
>  unsigned long lockdep_count_forward_deps(struct lock_class *class)
>  {
> -       unsigned long ret, flags;
> +       unsigned long count = 0, flags;
>         struct lock_list this;
> +       struct lock_list *target_entry;
> +       enum bfs_result result;
>
>         __bfs_init_root(&this, class);
>
>         raw_local_irq_save(flags);
>         lockdep_lock();
> -       ret = __lockdep_count_forward_deps(&this);
> -       lockdep_unlock();
> -       raw_local_irq_restore(flags);
>
> -       return ret;
> -}
> +       result = __bfs_forwards(&this, (void *)&count, noop_count, NULL, &target_entry);
>
> -static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
> -{
> -       unsigned long  count = 0;
> -       struct lock_list *target_entry;
> +       if (bfs_error(result))
> +               print_bfs_bug(result);
> +       else
> +               lockdep_unlock();
>
> -       __bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +       raw_local_irq_restore(flags);
>
>         return count;
>  }
>
>  unsigned long lockdep_count_backward_deps(struct lock_class *class)
>  {
> -       unsigned long ret, flags;
> +       unsigned long  count = 0, flags;
>         struct lock_list this;
> +       struct lock_list *target_entry;
> +       enum bfs_result result;
>
>         __bfs_init_root(&this, class);
>
>         raw_local_irq_save(flags);
>         lockdep_lock();
> -       ret = __lockdep_count_backward_deps(&this);
> -       lockdep_unlock();
> +
> +       result = __bfs_backwards(&this, (void *)&count, noop_count, NULL, &target_entry);
> +
> +       if (bfs_error(result))
> +               print_bfs_bug(result);
> +       else
> +               lockdep_unlock();
> +
>         raw_local_irq_restore(flags);
>
> -       return ret;
> +       return count;
>  }
>
>  /*
> --
> 2.30.2
>
