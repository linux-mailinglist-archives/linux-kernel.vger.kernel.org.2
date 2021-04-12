Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDEC35C612
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbhDLMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbhDLMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:21:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08236C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:20:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u4so15085944ljo.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PW2tJ+i50r3GZvO9hXoGixPdBLKy6QF6WoK9w4ZiWEw=;
        b=k99cHCRXDS0heQM0do2dQFauy+7PehPq5U+PN+oYE4vGzRxcyvtxZ1mBQUlWy5yV+P
         vODiXkuvk/cqA2trl+JW4SAvcGBACJ3T9hZziMpee+8DadVlQ8SRlhIx2rDtHBWUONRt
         ae3sfETNdVL3c35F9IOWLs+AKUkrGv2cKM3JZC34A56KR3E7bM/Wc4VbqsF99Jt4akFa
         Cs6j0bOD6eo80WXkZGHPKzxVRwnknAYwZFD459OXI2vXQFeVy6mGZ2CNFTAVBzvOy5gS
         pdpxU/L79PoH+cazqNm/a9BTg0kkSS83iSPtMalflqP/xthGNTvgYvrZJcb3fa7EOsSh
         BmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PW2tJ+i50r3GZvO9hXoGixPdBLKy6QF6WoK9w4ZiWEw=;
        b=OrhSulYY3YEUo/VO00gLmJJmxAIchdxZ0CKC8ginMYn5CBhXbApHxhT9yxa9pkSLsM
         zk69zTFZHug8lw6Pkbl/lEIU2gyvu32AcT2n8lhN5Mvho3n2Xo3STEkAOJlLea0+uzA0
         6Dh125vgTx0ZqFms9J3ix3WLcvC/7xAdmU7Zjwr5RIjlN1lRGaKG5eUXVw2n4Ds5cZdM
         ytbpk4CPmrjf6mch8gXokET9zeVjymlJNek5jQbPbcf67RxJIgLxVxWrnit4/N+TrPL7
         5nKvKe5Z8YDV/QImcsh/+KgpqjKR7FmfW28XydMyiH6bOYyr5Ei202UVvEABontswV4V
         Zw4A==
X-Gm-Message-State: AOAM530SimmF6NaA19zg+4tFOhvJkqO5B1fgJ3O/87n16Gc8v4jJHoFK
        NaTAuMEcpSCXUnvQCPjY5us/lXrUB4SCs/uy5AM=
X-Google-Smtp-Source: ABdhPJzCDLJAYVXTeY0F2bwgCewQGXxF6Mx6uv0OI/lItrZiDGTAJi80NodImhtOhdi3PINZzjee4P9xijB4tYO/yfE=
X-Received: by 2002:a2e:581a:: with SMTP id m26mr18452385ljb.33.1618230055542;
 Mon, 12 Apr 2021 05:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com> <87y2dnn3gw.mognet@arm.com>
In-Reply-To: <87y2dnn3gw.mognet@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Mon, 12 Apr 2021 20:20:26 +0800
Message-ID: <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <valentin.schneider@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:32=E5=86=99=E9=81=
=93=EF=BC=9A
>
>
> Hi,
>
> On 12/04/21 15:08, Ruifeng Zhang wrote:
> > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >
> > The arm topology still parse from the MPIDR, but it is incomplete.  Whe=
n
> > the armv8.3 cpu runs in aarch32 mode, it will parse out the wrong topol=
ogy.
> >
> > armv7 (A7) mpidr is:
> > [11:8]      [7:2]       [1:0]
> > cluster     reserved    cpu
> >
> > armv8.3 (A55) mpidr is:
> > [23:16]     [15:8]      [7:0]
> > cluster     cpu         thread
> >
> > For compatibility to keep the function of get capacity from default
> > cputype, renamed arm parse_dt_topology to get_cputype_capacity and dele=
te
> > related logic of parse from dt.
> > Arm using the same parse_dt_topology function as arm64.
> >
> > The arm device boot step is to look for the default cputype and get cpu
> > capacity firstly. Then parse the topology and capacity from dt to repla=
ce
> > default values.
> >
>
> I'm afraid I don't get it.
>
> CONFIG_COMPAT lets you run 32-bit stuff at EL0, but the kernel is still
> arm64. So if you take your armv8.3 system, the topology parsed by the
> kernel will be the same regardless of CONFIG_COMPAT.
>
> Could you elaborate on what problem you are trying to fix here?

There is a armv8.3 cpu which should work normally both on aarch64 and aarch=
32.
The MPIDR has been written to the chip register in armv8.3 format.
For example,
core0: 0000000080000000
core1: 0000000080000100
core2: 0000000080000200
...

Its cpu topology can be parsed normally on aarch64 mode (both
userspace and kernel work on arm64).

The problem is when it working on aarch32 mode (both userspace and
kernel work on arm 32-bit), the cpu topology
will parse error because of the format is different between armv7 and armv8=
.3.
The arm 32-bit driver, arch/arm/kernel/topology will parse the MPIDR
and store to the topology with armv7,
and the result is all cpu core_id is 0, the bit[1:0] of armv7 MPIDR format.

In addition, I think arm should also allow customers to configure cpu
topologies via DT.
