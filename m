Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280F457B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhKTEOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhKTEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:14:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF64C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:11:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n29so21448732wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWLbJkpo6Rm01+cE0Cdbx5WIjgwCuoHArS5V+/RayoM=;
        b=V5a0P2h2KZAGPmi0Y1Ajp4Sg4CJ5JSJyQBUC1R2mOr9bI9AvjBwSZu7+FRHG+BJtaV
         P+s44AwkYt6I6LwyJVSn+Ra+SQS3oskNcqbRTAkTOkmX6z2q5oL6/nxYajJ5Scradvpa
         ca5HP7aaShn9kDjjiR2J85SBJtjACUtkeu9KlUc6tDeGmWLkc1m7kx9prPN47VN23Pzo
         fU59Q1Z5+YeXpTeGO0H9z0TKUSFycXgeOtBRPUjCKxWVwiN+4CreV+ZqPkStBiV0jl52
         kXae5QdB14DIYufgq0WFq6nNTeQmEjUtYWHOMJZ/NbpXxv6bqR0+Xo8QNcPIYqbgEC+N
         j6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWLbJkpo6Rm01+cE0Cdbx5WIjgwCuoHArS5V+/RayoM=;
        b=xm+k2/DOHUjbElFl9s6+aGZZefawwg1nwrzAXLpIhWFwEqfIBePS4+UmS09of0urgH
         HIiODHcZ+3x2+336i0Hj+2Xitpt+jIfJUiAUiJUHSRLHVPlp4rOSNg5QI3H9bsLOwXjX
         iolwMd6tprCSjQtIkhYQ9+P/PJvUOnbo7SKqjQ7JNbx/RNFUvcB58GoAB9XfpgWfNd0q
         PZXTAeeMe3CLB+0IYawDtdocs6nYclmgLomrQCGL4FjSLakM9qupjFFzV3LyuKwPvPfA
         JfWyWsIMmK/BrfgggBgFPdKa9VE0SlV1JNjnc3lb2CwARP7AcxgUv/ubFwnxJjHbc/RJ
         eBPQ==
X-Gm-Message-State: AOAM531Y1WXkL64UjoWrMckyiqq2+SlsIPOhJmyUppx888EhJdRMOA1h
        p24JPTLbc2vW1ljaVmYslmy3qGCgI2Zd7a7RcEhurg==
X-Google-Smtp-Source: ABdhPJz4aJsW/UOqF2dYULYVm3gPT0c2VUiQ/Wv+ZVkXA7hT5IVeD10iCbO4KEbry22s9NLos02JcyrZJCZ9DmUly4I=
X-Received: by 2002:a5d:628f:: with SMTP id k15mr14458898wru.363.1637381500428;
 Fri, 19 Nov 2021 20:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-1-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:41:29 +0530
Message-ID: <CAAhSdy3LgDmv5dfuOnBXpJsD_noPecgpjzf7V8v2UjM8WVHcjw@mail.gmail.com>
Subject: Re: [PATCH 0/12] RISC-V: Clean up the defconfigs
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>, axboe@kernel.dk,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:14 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> It's been a while since updating the defconfigs, so I figured it would
> be good to go through all the diff to make sure nothing was lurking.  It
> turns out there were two minor issues, which I've fixed with the first
> two patches.  The rest of these are just cleanups that should have no
> functional change.
>
> I don't have a K210 (I might somewhere, but I've yet to boot it) so I
> can't test this to make sure, but I think patch 2 is the reason we have
> a special !MMU PAGE_OFFSET config.  If someone does have one it'd be
> nice to be able to remove that special case.
>
>

Using savedefconfig, I used to always get a huge diff so thanks for
doing this cleanups. Going forward, I suggest that we insiste everyone
to always use "make savedefconfig" for creating defconfig patches.

Regards,
Anup
