Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E226534A7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCZNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhCZNHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:07:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D771619FE;
        Fri, 26 Mar 2021 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616764025;
        bh=x/GK+JD94YsfoYZeLWzsM1EmTyqcxHwM2Vqefncnveg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2/avi/Dh7YzODTB0l8GLVG6HWTEO6Td7nimdFSaE8m2IP4Ww7V1d9XRlcZ+5srHU
         SSoFTb2WWt6KcygqmfmLm6M0dATs/gg5rTnRWBEcd+FOlegCq4ZcIJ20I3Qt+EUCVz
         +vrJwVPPFjY3al3MqmtVk5M775jZ3vmOJgeeJgtilzBGNhD6LjAKuTLP5vxhsmH9tS
         odXnB4EFjgTiKzmU2lM4+lhu7T4J3ggqPCeOJR5716JhyMVWNJY/POQV/Mfhn9zCkU
         rSBSPj9wTF2uNhp9YmAorCP66xMgPflfBKmp3RGWuxa0zUpXR2OGu544Trl/MghCl9
         oLUmbJkBNvL0g==
Date:   Fri, 26 Mar 2021 06:07:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 0/3] Fix CONFIG_FUNCTION_TRACER with clang
Message-ID: <20210326130702.3yaz2vqwejnfnlq4@MSI.localdomain>
References: <20210325223807.2423265-1-nathan@kernel.org>
 <CA+icZUWgxmrtM=oj-aJi1KXxZx0YUZDiUPK42MjHvqS96aazYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWgxmrtM=oj-aJi1KXxZx0YUZDiUPK42MjHvqS96aazYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 09:37:55AM +0100, Sedat Dilek wrote:
> On Thu, Mar 25, 2021 at 11:38 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi all,
> >
> > This series fixes function tracing with clang.
> >
> > Patch 1 adjusts the mcount regex in scripts/recordmcount.pl to handle
> > the presence of PLT relocations, which happen with clang. Without this,
> > the mcount_loc section will not be created properly.
> >
> > Patch 2 adds a workaround for clang less than 13.0.0 in relation to the
> > mcount symbol name, which was "mcount" rather than "_mcount". This was
> > written as a separate patch so that it can be reverted when the minimum
> > clang version is bumped to clang 13.0.0.
> >
> > Patch 3 avoids a build error when -fpatchable-function-entry is not
> > available, which is the case with clang less than 13.0.0. This will make
> > dynamic ftrace unavailable but all of the other function tracing should
> > work due to the prescence of the previous patch.
> >
> > I am hoping this series can go in as fixes for 5.12, due to patch 3, but
> > if not, they can always be backported (patches 1 and 2 are already
> > marked for stable).
> >
> > This series has been build tested with gcc-8 through gcc-10 and clang-11
> > through clang-13 with defconfig and nommu_virt_defconfig plus
> > CONFIG_FTRACE=y and CONFIG_FUNCTION_TRACER=y then boot tested under
> > QEMU.
> >
> > Cheers,
> > Nathan
> >
> > Nathan Chancellor (3):
> >   scripts/recordmcount.pl: Fix RISC-V regex for clang
> >   riscv: Workaround mcount name prior to clang-13
> >   riscv: Select HAVE_DYNAMIC_FTRACE when -fpatchable-function-entry is
> >     available
> >
> 
> Does this only fixes stuff for clang + riscv?

Yes.

> If so, please put a label "riscv" also in the cover-letter.

Sure, my apologies for not doing that in the first place, I must have
been in a rush with the cover letter.

In my defense, I think the titles of my commit messages and the diffstat
below make that obvious without the tag :)

Cheers,
Nathan

> - Sedat -
> 
> >  arch/riscv/Kconfig              |  2 +-
> >  arch/riscv/include/asm/ftrace.h | 14 ++++++++++++--
> >  arch/riscv/kernel/mcount.S      | 10 +++++-----
> >  scripts/recordmcount.pl         |  2 +-
> >  4 files changed, 19 insertions(+), 9 deletions(-)
> >
> > --
> > 2.31.0
> >
