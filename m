Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031A840D07B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhIOXxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232836AbhIOXxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:53:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CB8D61165
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749942;
        bh=dC9oi9O5eCY0bQWAwOWHLh1Y1B3AGrOrpCQG49W3ukU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OHLOiLM/iQEz8VJTlS2ULSJb8g7rgk9yIjXWdyPfe4BNbNIZM445DMtQTGV4KmwGq
         UhVuRKK6OJnFAYvGBnvH87k7NwGEUn22H7BL0fN7l+fMSF1locLcVNa1rcX1aNZo02
         3WdO444J6rJnNgE8xe6wXaijoT8iDogMclJT1j7wkr+8uQVB56zROtFVp0yaCEr5oW
         Hd8hWqmiGzx4+2tPZGjPNsZpNMF8iL2yBELV/tF6R7QYuelFF7hzSZywp2aHrkLa+Y
         km79Na63OLMWpuqpSJLl9tFs14ZrUv0c0yLPhqHAY4yVGS3ALzdubkDEkLA8uYK89i
         xCPVMl+QAmKNQ==
Received: by mail-lf1-f43.google.com with SMTP id h16so11080969lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:52:21 -0700 (PDT)
X-Gm-Message-State: AOAM532lCx7B1pmgWXHXqeJOUPPszbMseWxrWy4CvKr8Bq/7TV+xWPTH
        bj2SdWUqkjxoEHgsEemqFKAKEES/dD6NFDd5c1U=
X-Google-Smtp-Source: ABdhPJwqbxx7gFmmGHl/IX/YB8dTX9bdPtDP6/AFDZzBMsrgGF2Huh0g2FQZ6addhbdNk8e4w/HLPxohJrdDcO9oOSs=
X-Received: by 2002:a05:6512:304f:: with SMTP id b15mr1897345lfb.462.1631749940374;
 Wed, 15 Sep 2021 16:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-2-guoren@kernel.org>
 <20210915074557.GA20024@lst.de>
In-Reply-To: <20210915074557.GA20024@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 16 Sep 2021 07:52:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ0Nbb7QCFjKdY223eHQjeV3_05Ub3N3LM7hvY38gizsg@mail.gmail.com>
Message-ID: <CAJF2gTQ0Nbb7QCFjKdY223eHQjeV3_05Ub3N3LM7hvY38gizsg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 1/6] riscv: pgtable: Add custom protection_map init
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Sep 15, 2021 at 3:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Sep 11, 2021 at 05:21:34PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Some RISC-V CPU vendors have defined their own PTE attributes to
> > solve non-coherent DMA bus problems. That makes _P/SXXX definitions
> > contain global variables which could be initialized at the early
> > boot stage before setup_vm. The patch prevents compile errors.
>
> That sounds way to nice for someone who deliberatly ignores the
> specification and should definitively not go into the kernel
> commit log like this.
Okay. In the next version, I will optimize the wording.

>
> > This patch is similar to 316d097c4cd4  (x86/pti: Filter at
> > vma->vm_page_prot population) which give a choice for arch custom
> > implementation.
>
> How?  To me it looks like a bad duplication of such functionality in
> a way that totally breaks abstractions.  architectures really do not
> have any business changing protection_map.
D1's _P/SXXX definintion is different from riscv standard spec to get
non-coherency supported. It sets the highest bits and current spec
must keep zero. So we using a global variable struct in the _P/SXXX
definition to let vendors init their own _P/SXXX values during
bootstrap that is very early stage before setup_vm().


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
