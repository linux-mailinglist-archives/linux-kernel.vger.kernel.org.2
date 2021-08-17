Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13143EF0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhHQRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhHQRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:11:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF54C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:10:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p38so42885605lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esKjOu29CtbHKWBXCsPcW8MIgPET8SIonOgdr3g5nyg=;
        b=vMiR0ARsypmr79UUSYTDBofqOVcAN344d7ssRjsdeE5ThfuRqwaaQemLcxm5dk6kA9
         NobN2xX9NS5968wMgMYjf8l+hDaXfu25vXq833X6MwoMsdf9D4R1IDmFUpt7+ha3330F
         03t5J8uV3xZ0+cogXHGKcrW2IY9Fmjh31Gn15qPGNRfridQzQmW3hDnqMQ/jSVDFwvrY
         Ys3MaUkUER/3A3A+bGItS+jSN10+jDUPCV2IxmqnU248IG85oSLue9Cr+QpbwG3WsE8G
         XAgjxsBrgA7vdS4FzTVAv6RakkZt7H3WAKtoNNqp4tz1c1/xW3lQt+W6i7RPPgqsjp3D
         u0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esKjOu29CtbHKWBXCsPcW8MIgPET8SIonOgdr3g5nyg=;
        b=NtRPIocYX40ehtTBCktO8gsJn6yrAbhjxS9b3FSrBcx73rPszLuhfE0tpNXWE5WQKa
         RX9qmB96lvoBZqdscg7/X/p5kgsTDnko4x4ISm74hDYsMahamNCAa2oE+yh0V9RCVeGL
         wUmaCVg61K3atHth1lvpRUUt/k1lveut5kCe5MMDoledF9g4p2/Tsh8dtIHFBqWkhhEe
         TZrI/cljiu8r9HC7MEKJGaCdiIKDyQK+8N2KzIc2LZMbCnRFfaDnKdlvKbJDZDW2D0Ti
         qCM9NbuMaugrx9HoSNLaFy1hXQeNsSBhLv0WG002IeuwkItrpeLN5DdYbTxvCAke7eTb
         R8vw==
X-Gm-Message-State: AOAM533CpXGnTJbdjIbPsfqYt0ClTyzfG/iemBLqk4IfW2zgve9mHCec
        gE+q5bVHZfrWPwm6z1lshrTjCokWlg/CNFnYo0b3mg==
X-Google-Smtp-Source: ABdhPJyRoyCjCJjG1YJbZsYykcq+KMEvv4mDyL3FMY3AADLwVYmc4aaMSmoU9hmVVEmp2/FqGlRdRwvjn9H7P2gGYfA=
X-Received: by 2002:a19:7507:: with SMTP id y7mr3093130lfe.358.1629220255213;
 Tue, 17 Aug 2021 10:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210811031734.GA5193@xsang-OptiPlex-9020> <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com> <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org> <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
In-Reply-To: <20210817164737.GA23342@blackbody.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 17 Aug 2021 10:10:43 -0700
Message-ID: <CALvZod4-bsv+Mn19Q9LK3DzL8GC_LuZyJyQ83RiwRiTbCJhCZQ@mail.gmail.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        andi.kleen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 9:47 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Tue, Aug 17, 2021 at 10:45:00AM +0800, Feng Tang <feng.tang@intel.com>=
 wrote:
> > Initially from the perf-c2c data, the in-cacheline hotspots are only
> > 0x0, and 0x10, and if we extends to 2 cachelines, there is one more
> > offset 0x54 (css.flags), but still I can't figure out which member
> > inside the 128 bytes range is written frequenty.
>
> Is it certain that perf-c2c reported offsets are the cacheline of the
> first bytes of struct cgroup_subsys_state? (Yeah, it looks to me so,
> given what code accesses those and your padding fixing it. I'm just
> raising it in case there was anything non-obvious.)
>
> >
> > /* pah info for cgroup_subsys_state */
> > struct cgroup_subsys_state {
> >       struct cgroup *            cgroup;               /*     0     8 *=
/
> >       struct cgroup_subsys *     ss;                   /*     8     8 *=
/
> >       struct percpu_ref          refcnt;               /*    16    16 *=
/
> >       struct list_head           sibling;              /*    32    16 *=
/
> >       struct list_head           children;             /*    48    16 *=
/
> >       /* --- cacheline 1 boundary (64 bytes) --- */
> >       struct list_head           rstat_css_node;       /*    64    16 *=
/
> >       int                        id;                   /*    80     4 *=
/
> >       unsigned int               flags;                /*    84     4 *=
/
> >       u64                        serial_nr;            /*    88     8 *=
/
> >       atomic_t                   online_cnt;           /*    96     4 *=
/
> >
> >       /* XXX 4 bytes hole, try to pack */
> >
> >       struct work_struct         destroy_work;         /*   104    32 *=
/
> >       /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> >
> > Since the test run implies this is cacheline related, and I'm not very
> > familiar with the mem_cgroup code, the original perf-c2c log is attache=
d
> > which may give more hints.
>
> As noted by Johannes, even in atomic mode, the refcnt would have the
> atomic part elsewhere. The other members shouldn't be written frequently
> unless there are some intense modifications of the cgroup tree in
> parallel.
> Does the benchmark create lots of memory cgroups in such a fashion?

From what I know the benchmark is running in the root cgroup and there
is no cgroup manipulation.
