Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52634400438
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbhICRjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350131AbhICRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630690727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcAvoo19buGVEGmVC+HxjQw0o0kMxJreD0uWTHELoFc=;
        b=NgRiAfKo1QJN4h3SVcZrrD9Onw47ivg3whoSFWiiKdMZJqsPx7zdZiW70nRR9CljskgCP9
        PB2XN47OYDyUG1xli8tw0wRgvUs1+AlVon+s6hQUJefEzD7bxlmBkziWcSmXfvqX2us96Q
        JWhO5TjjnODuatCgCDF16xGNQSR+QaU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-s1rwW1t6P3OT3wHLIKduGg-1; Fri, 03 Sep 2021 13:38:46 -0400
X-MC-Unique: s1rwW1t6P3OT3wHLIKduGg-1
Received: by mail-lf1-f71.google.com with SMTP id w18-20020ac25d520000b02903c5ff81b281so2606307lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcAvoo19buGVEGmVC+HxjQw0o0kMxJreD0uWTHELoFc=;
        b=CECRmYN1+//seZ1If7pmEjKemKBP60jetosTYJm4FJsRKXceg4qPNPKSJipIpOUoo9
         vAqRnzKTN2w3aE6tsOygn+mMEs4iFqXAOgeZg8OW+6kCrwlK+5zq02jKFaUXOxNh4/T5
         Z3jlyYi3fDR5z6QVb5oYqZ/REP+sxQaQ1nZPlohEZfVhZuZjqajyJ2U1/Sp504Gy+5SH
         zzEYbt1kZ8Uf2/kKAQu12fAA5Mk1eFd6goSnfTPHrneUy46gTHepcewNF7/c6jLguVaj
         yjVYLlGLiw+0/V3jDQx1RBSFWOcCVvBkMuE/ld3zFaVPduIHbxd/OYBl0VEDYsp2nCo/
         PCBA==
X-Gm-Message-State: AOAM533Z5H3qIb1EOW50++4Mqk+OWw072DifB+fw/tweRklw3D1QDHjQ
        I2jwukAv21bGI/V5/Pc8kGQZU8EVI8lSL35qZ0sEY/Jquhu2dDjBe5tZtKCvnjt3fsClMA5NbAh
        OxKX6/Wp+RNAtKIlXtloyP3LDbQsp44htLV+LcbbR
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr113590ljf.497.1630690725224;
        Fri, 03 Sep 2021 10:38:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1hPYmjIk2MoVunVciRj1xBPn5rTK5p9CHMBfNXcZg8mQ+8eh87/vr8xHk8gMlmESu6lsTsU4Q3b7LL8z6kiI=
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr113580ljf.497.1630690725025;
 Fri, 03 Sep 2021 10:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210824152423.300346181@fuller.cnet> <20210824152646.948424573@fuller.cnet>
 <CAFki+LkNcwFATSth4cvU=-7aBZjaLLNU6UFWYv1DxkeYwkeuSg@mail.gmail.com>
 <20210901173204.GA48995@fuller.cnet> <20210901183345.GA51358@fuller.cnet>
In-Reply-To: <20210901183345.GA51358@fuller.cnet>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 3 Sep 2021 13:38:33 -0400
Message-ID: <CAFki+LkOvGdqRw=tzFvC6Z9vmi5wR60nAnAQ77Pb9t_N6Fu_ug@mail.gmail.com>
Subject: Re: [patch V3 8/8] mm: vmstat_refresh: avoid queueing work item if
 cpu stats are clean
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 2:34 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Wed, Sep 01, 2021 at 02:32:04PM -0300, Marcelo Tosatti wrote:
> > On Wed, Sep 01, 2021 at 09:05:55AM -0400, Nitesh Lal wrote:
> > > Hi Marcelo,
> > >
> > > On Tue, Aug 24, 2021 at 11:42 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > > >
> > > > It is not necessary to queue work item to run refresh_vm_stats
> > > > on a remote CPU if that CPU has no dirty stats and no per-CPU
> > > > allocations for remote nodes.
> > > >
> > > > This fixes sosreport hang (which uses vmstat_refresh) with
> > > > spinning SCHED_FIFO process.
> > > >
> > >
> > > I was still able to reproduce the sosreport hang with this patchset and I
> > > am wondering if that is because right now we do vmstat_sync and then cancel
> > > any pending jobs on a CPU in the context of one task.
> >
> > Hi Nitesh,
> >
> > Did you use chisol (with proper flags) and the modified oslat?
> >

Yes, I used your patches.
This is the command that I used:
chisol -q vmstat_sync -I conf ./oslat -f 1 -c 5,6,7,8,9,10,11,12,13,14,15 -D 15m

> > Tested with "echo 1 > /proc/sys/vmstat_refresh" and it was successful
> > (no hangs).

I see, I tried with "sos report --batch", which should have a similar effect.


--
Thanks
Nitesh

