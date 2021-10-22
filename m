Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35F04370A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 06:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhJVEIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 00:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJVEIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 00:08:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F60C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 21:06:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s19so2606975ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 21:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mDqgl0Ho1l8D5PBpRXMaH9/GW+Qxx8683xQFHqkOrfM=;
        b=mccjPbUlHI4GgnfwzYE4fRAKTWYxULBgBCg+k66Qy664Dt6dvjc03ZiiOX6agwspts
         MrK2W7Vmuh2dz1vxgGKysGCujVzBHm+n1mvmni9W0aJotJAgSPdHFYqXMpOV6q3SL0hY
         b4pdfmUtJa4JTffNANRvYY0voB7Cg+srftHCWo9+CXU1Geh+yIvldCoxAfic6cFv4ocF
         QscmD/+q0cIOjrL/HjltrjCbrgZUTrNO+RzCqon9MTO9ynOZUlUtFxBILmB3AdjaIm76
         KkaPSrWzEkQcUCt1i+mnTYgVokaiqk2PhpKktAoMnhLsCoYfE3CI+PGs4kndAh1CWaEJ
         7WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mDqgl0Ho1l8D5PBpRXMaH9/GW+Qxx8683xQFHqkOrfM=;
        b=BO7Wxc4DcB0io43LmrcYNA93AyJhXbu2TOSiPPMAGtDYaEjdFWP4xCOActrzRhW+61
         n7TobqPzGcXBctGQ/utLG7g7ZqI65b+SDcq5B6nLrrC3NmvJXW74vybeRoa2y3cN7SaP
         hJOxxG5ePq6Zq9bz4UBvjDrOxGMK5nWLbaxsV0uGafzM0z0FLHAAZXnDPSNKAbHSgn88
         Yr2l2FuZsk2xR2y7jlyooIc1c/iGuahLGPT/L4a3ONsnFrz9gAzZe/aeWVa5rLj8D01i
         ILOv0iTh174/aqI7K2NIH/n0nrC8bOGl7khPkaZWtiDZhA7UZNngP71ysRpxlo7zKtw9
         zW5A==
X-Gm-Message-State: AOAM530NJOvTFm/dPg/ARb2veLIP+qHpSQEnas2I4dPPbdOyCkRvFE37
        BENR3GXpw4sgxtG84WI2DC+W+vUjQmjFMyviKQQ=
X-Google-Smtp-Source: ABdhPJy6miyDpN9Z2UkDEDFmdOHDmjEHQBn6UND6Nvk1OgnUQLwdPeC3gyv9XgXRu1zoki7Pul4TzLkMLcEUFSk5IcU=
X-Received: by 2002:a2e:7617:: with SMTP id r23mr10715054ljc.416.1634875589700;
 Thu, 21 Oct 2021 21:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <1634804594-4163-1-git-send-email-brookxu.cn@gmail.com>
In-Reply-To: <1634804594-4163-1-git-send-email-brookxu.cn@gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 22 Oct 2021 12:05:27 +0800
Message-ID: <CAB8ipk_1-ZMMcaLiLGYBT3N3S_VdeGMhYmCqGytcAwmPE4Ni2g@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: use max_spare_cap_cpu if it is more
 energy efficient
To:     brookxu <brookxu.cn@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunguang

brookxu <brookxu.cn@gmail.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8821=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:24=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Chunguang Xu <brookxu@tencent.com>
>
> When debugging EAS, I found that if the task is migrated to
> max_spare_cap_cpu, even if the power consumption of pd is lower,
> we still put the task on prev_cpu. Maybe we should fix it.
>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  kernel/sched/fair.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..2ae7e03de6d2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6867,8 +6867,10 @@ static int find_energy_efficient_cpu(struct task_s=
truct *p, int prev_cpu)
>                 /* Evaluate the energy impact of using max_spare_cap_cpu.=
 */
>                 if (max_spare_cap_cpu >=3D 0) {
>                         cur_delta =3D compute_energy(p, max_spare_cap_cpu=
, pd);
> -                       if (cur_delta < base_energy_pd)

this is aimed to prevent the cur_delta < 0, and usuallly, when the
task was put on the max_spare_cpu, the cur_power should be bigger than
base_pd_power,
if the cur_power < base_pd_power, the cpu util may have changed, at
this time, we should keep prev_cpu.

You can look at below discuss and patch:
https://lore.kernel.org/all/20210429101948.31224-3-Pierre.Gondois@arm.com/
https://lore.kernel.org/all/CAB8ipk_vgtg5d1obH36BYfNLZosbwr2k_U3xnAD4=3DH5u=
Zt_M_g@mail.gmail.com/



> +                       if (cur_delta < base_energy_pd) {
> +                               target =3D max_spare_cap_cpu;
>                                 goto unlock;
> +                       }
>                         cur_delta -=3D base_energy_pd;
>                         if (cur_delta < best_delta) {
>                                 best_delta =3D cur_delta;
> --
> 2.30.0
>
