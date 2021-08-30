Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC13FBB25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbhH3RmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbhH3RmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:42:06 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94845C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:41:12 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y3so16957861ilm.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+O0RNc3jbrY9aGTI5kzjQXfNk8YSfy4dVQqI70uLIpA=;
        b=XoW88OaK4oFkHhPRFjhLU/lr9tE8W1Nk2kQVGiS6tt5KQmoTjvbYrjAvU1HfwGuTqe
         r6DfX6ZrdtMyxcExcNkA3s4rREuAxcs9uk6rQdnH3+ngLuSRBT0/quXTVtUCTWgA7aQd
         SwrxD9JMoRDhYuGZqTRXopNUyZepMDL97yTTsZIXtCfCciYXPRpPBRGQx2x3EuZQsKSJ
         qFshnx/HVkN9q47slR+UHhzEqRBVMDDRC6ADzNwxzMoSsG451hp6rB26qZuVfAREU144
         sLvZS9op5awv+yuCYHQpNoj5h6LH1r3GIM51EhNS8Pn1+FKd3Wf4UGJUcLJsL38hUfV0
         TPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+O0RNc3jbrY9aGTI5kzjQXfNk8YSfy4dVQqI70uLIpA=;
        b=YwLCIlpjsjlQNOZtEaoIWelxftqA5AhXY6GCX08vD3hz4AeEf9G6NYvjW3hnpllPCv
         e6aw3P6NeUdK5peXby6OJ7okIMF56q1s/wK6/u948N6K8gzqWBocngBcPJ2T1WzFwEsn
         HfWXz+NCRXZevFaDAj+gtRZFhWzhXV31Wy1WQ7wy624oxc+ZvfL25szYGaVVGSfUWMW9
         cTZhiPdx17u7LMWDVAfSiebC4OnXi7cAVvaqDVETavY2HO2y5CD5SKk74LGMrVT4+sWV
         Z3MTPcW6i+xWgl1D8rU7RajqK4Zlq/sNoqfb6+2Cf6Nfe++UUzeMPnsMa/LVi9fhjst4
         YXdg==
X-Gm-Message-State: AOAM532xTjcmgmc/FIa4abGhD1K2R2MbNNmnM4/hsNEbr9bCtyjnpP2p
        GC4Zgeu48myi1PDcjg0+GNk55g56gtDTtXd6W/A=
X-Google-Smtp-Source: ABdhPJzFZ6SAb33f8nLKqru5YTGbEkGGGFPUH9//jGQBpTtQ+Q9bABNdA/d7+wvcoQxpwiW07YlYhdcPFZrF1/UJrgA=
X-Received: by 2002:a05:6e02:130e:: with SMTP id g14mr17416934ilr.81.1630345271925;
 Mon, 30 Aug 2021 10:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK+bU8e_mue_-a4cm85THkg=MyNOf6O2so4D+22wzG_LPu=4LA@mail.gmail.com>
 <CAADnVQKNNcj_2U_E=3NPgbO76JB4MPZ131zd4ykE4jOt6TAVkg@mail.gmail.com>
In-Reply-To: <CAADnVQKNNcj_2U_E=3NPgbO76JB4MPZ131zd4ykE4jOt6TAVkg@mail.gmail.com>
From:   Etienne Martineau <etmartin101@gmail.com>
Date:   Mon, 30 Aug 2021 13:41:01 -0400
Message-ID: <CAK+bU8fAEL0tyG1wA24LWnT=-X+_Gsti3gEq3Y=Wp11MWH+q0Q@mail.gmail.com>
Subject: Re: Question related to ( commit 9f691549f76d "bpf: fix struct
 htab_elem layout" )
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     yonch@yonch.com, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Chenbo Feng <fengc@google.com>, sashal@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 12:39 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 30, 2021 at 7:17 AM Etienne Martineau <etmartin101@gmail.com> wrote:
> >
> > Hi,
> >
> > I've been staring at this commit for some time and I wonder what were the
> > symptoms when the issue was reproduced?
> >   "The bug was discovered by manual code analysis and reproducible
> >     only with explicit udelay() in lookup_elem_raw()."
> >
> > I tried various stress test + timing combinations in lookup_elem_raw() but no
> > luck.
>
> That fix was a long time ago :)
> afair the issue will not look like  a crash, but rather an element
> will not be found.
> That's what lookup_nulls_elem_raw() is fixing.

Under that same scenario I wonder if it's also possible to have a
messed up element somehow?

>
> > I believe that one of our production boxes ran into that issue lately with a GPF
> > in the area of htab_map_lookup_elem(). The crash was seen on an outdated
> > 4.9 stable.
>
> Would be great if you can reproduce it on the latest kernel.

We have another deployment on 5.4 stable running the same bpf code so
will let you know.
