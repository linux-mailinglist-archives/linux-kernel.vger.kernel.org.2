Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA4434B731
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhC0MRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0MRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:17:35 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78015C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 05:17:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v26so8110490iox.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=W0OCNJlAmSG63LfDiOFxZzKLOJtCIjR/fUw42G8WAYI=;
        b=iEWQcmzfe1YXd0pp2Aq7mgJ9QaK2nVkq6mYvXsPmLN7UysMFvRvedIyIVnNd/I3XWL
         AUw7xSQN55n7TASuf9xxb53665/TolORGTIGNTzMOUgLfSiSF09d4+0YvFxwhYbXpCyn
         kHZ95SVcqwA7RQ6QiXxbUBhQ4fxlMyjCXf5ImsHu0V60oXJCNuaj8Hnzu/+JDAcVFW3s
         2Hkz2Ro5e39ooRKSdV53UiR1jntHvXl3HYPyx1Z+JoTdGHiolNu9vheL3orubZROpsLN
         bZQZgJVQUjvSejKL7kEcmVwijJkZpjMJbr1AFhIvFe1gVoTrtRsPYoxDtZhpJOpALQmr
         huRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=W0OCNJlAmSG63LfDiOFxZzKLOJtCIjR/fUw42G8WAYI=;
        b=Gx6dwSYGL5dcFtpRMRvFbShV0qi+FmwPH0rz9T/Orklw3iEQngTEzSnD/gqtSokZ82
         fnh1fvdwSG1bT25Zzol+nj44dnQwnic2toYTEctEqjOiU2JvhRT59zeVgmnFtTPTY4t8
         kyVtIur/Q8fCQortIo5eajf3uj4mjHkmWMag/WNONdVpCyTxv9CcXMRZMP7wte+yTDxA
         aWWCy9ZwF2p/zl9WKnyCVQKqYg4H+h0yIYU+j2g6LytVM1ngk0DcxHdpYRdax04CX63R
         hgj8x4+rp1qoxrmhheAmqW5OLTU1G97PmFneMCb4OY98pcea2dojZ7N0P/W/g1a2YLhg
         yjiA==
X-Gm-Message-State: AOAM532Z/BOyq/NLM7t5dMcCiTSR2fnOs+WK6dszVcYDjUwSsAoTSCSf
        XW9yngxPTuXpzsLazbE00iR8fIjTi3dpjiJAINk=
X-Google-Smtp-Source: ABdhPJxq0LbjHww3sV5wuK2q4vWZC2pFkSIydOiu6GLexH1m0wSxxKl5Hwo5znh81XK59ms4cf7fbgr7Us4ud3CNyTI=
X-Received: by 2002:a5d:9d13:: with SMTP id j19mr14040542ioj.110.1616847454985;
 Sat, 27 Mar 2021 05:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210325223807.2423265-1-nathan@kernel.org> <CA+icZUWgxmrtM=oj-aJi1KXxZx0YUZDiUPK42MjHvqS96aazYQ@mail.gmail.com>
 <20210326130702.3yaz2vqwejnfnlq4@MSI.localdomain>
In-Reply-To: <20210326130702.3yaz2vqwejnfnlq4@MSI.localdomain>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 27 Mar 2021 13:16:58 +0100
Message-ID: <CA+icZUVHyGSX1R89O-MG-fwfw7BPLGBP8COcpyPCwmhNj88d3Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix CONFIG_FUNCTION_TRACER with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 2:07 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 09:37:55AM +0100, Sedat Dilek wrote:
> > On Thu, Mar 25, 2021 at 11:38 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Hi all,
> > >
> > > This series fixes function tracing with clang.
> > >
> > > Patch 1 adjusts the mcount regex in scripts/recordmcount.pl to handle
> > > the presence of PLT relocations, which happen with clang. Without this,
> > > the mcount_loc section will not be created properly.
> > >
> > > Patch 2 adds a workaround for clang less than 13.0.0 in relation to the
> > > mcount symbol name, which was "mcount" rather than "_mcount". This was
> > > written as a separate patch so that it can be reverted when the minimum
> > > clang version is bumped to clang 13.0.0.
> > >
> > > Patch 3 avoids a build error when -fpatchable-function-entry is not
> > > available, which is the case with clang less than 13.0.0. This will make
> > > dynamic ftrace unavailable but all of the other function tracing should
> > > work due to the prescence of the previous patch.
> > >
> > > I am hoping this series can go in as fixes for 5.12, due to patch 3, but
> > > if not, they can always be backported (patches 1 and 2 are already
> > > marked for stable).
> > >
> > > This series has been build tested with gcc-8 through gcc-10 and clang-11
> > > through clang-13 with defconfig and nommu_virt_defconfig plus
> > > CONFIG_FTRACE=y and CONFIG_FUNCTION_TRACER=y then boot tested under
> > > QEMU.
> > >
> > > Cheers,
> > > Nathan
> > >
> > > Nathan Chancellor (3):
> > >   scripts/recordmcount.pl: Fix RISC-V regex for clang
> > >   riscv: Workaround mcount name prior to clang-13
> > >   riscv: Select HAVE_DYNAMIC_FTRACE when -fpatchable-function-entry is
> > >     available
> > >
> >
> > Does this only fixes stuff for clang + riscv?
>
> Yes.
>
> > If so, please put a label "riscv" also in the cover-letter.
>
> Sure, my apologies for not doing that in the first place, I must have
> been in a rush with the cover letter.
>
> In my defense, I think the titles of my commit messages and the diffstat
> below make that obvious without the tag :)
>

No need for any apologies.
I was fooled as you sent two triple-patchset nearly simultaneously.
This riscv patchset here was not of interest to me.

- Sedat -

>
> > - Sedat -
> >
> > >  arch/riscv/Kconfig              |  2 +-
> > >  arch/riscv/include/asm/ftrace.h | 14 ++++++++++++--
> > >  arch/riscv/kernel/mcount.S      | 10 +++++-----
> > >  scripts/recordmcount.pl         |  2 +-
> > >  4 files changed, 19 insertions(+), 9 deletions(-)
> > >
> > > --
> > > 2.31.0
> > >
