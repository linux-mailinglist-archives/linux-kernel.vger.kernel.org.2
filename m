Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2940845881A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 03:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKVCsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 21:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhKVCsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 21:48:42 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 18:45:36 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id e136so45999076ybc.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 18:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmHBmFl4jo7vhfk+blSj8ZbPLUZ4zHrikv8Urc1dx9I=;
        b=NuHR1v+vZUbP8uoSgZKguTyHWCpdHqVIwQoceOhJvEwTBkmXc2+d05HSQkzIU7JiSR
         ne0h+BWV+2LZZ3krfNBevxk+l7ABlha/ihMqpbrYYR9H9NLZljLUgMLj+YiJMsWftksI
         cZigSH2+bDlQoik8CCe9gk73O351TsiYbbhtkX6Pgi62iiHB+9hUlS+eVW4d2W6ZBYBZ
         PVCGQ6h7zilLPP6b5dx27VEHMcBoy2W54MIJEvwTAmKLUMsxj/X8Kks03HCi8yi6Pawu
         qhhH7qy3QLtFF4+SrM0GOax5zEvf6diMvGA8aiSN5sVhhrMNiAdfhpKgVE8FyaXoxbPj
         S1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmHBmFl4jo7vhfk+blSj8ZbPLUZ4zHrikv8Urc1dx9I=;
        b=YbEwlaJGIp8bUcBj1szmA3LpQbjp3kqzxx8SzoTuyZnc7hs4PTWr4vhdhGMqTz+RXe
         N9cJA35EzPyJIe2M4/Aoi0ENohY++e6o6bhe8bVo5poZMvjm0N15a5r7V9XkkNYpd4aa
         txEBsbeE0lpVQtFNBGC4xEF/m21fENd6k01ICtLEG1dfn6B4hrfxSq2oTTaKigAW5Hlo
         MNy6RxzyTR3l5hS9WK9tfyyVlndH+UpTErTN2CM+4grhacv0ORqK+fgIUogM3qcrKpw7
         nR+aaUq/ys0vhxdIt4FcD6fMNyvhRqsxkjtoDyQAdNlzGSK2KwLfPQCm+8dmpIMMde31
         cgRA==
X-Gm-Message-State: AOAM533pio894E/Fr5pHsDuHqDY/x1F7Jk8hXNlgXyhsthtgLP+GCe/w
        Yl6xjmEbwCwhBjaR6uan34/sP6U/fHiolCusgn8=
X-Google-Smtp-Source: ABdhPJxGCXaKyVyG6qx7T8drkmBTiHp/A1h7pCaYfMO/4VuFTTPNCsKLHLz3PH1YkWKTq/unuwrZMJ4MCa0COAQlIII=
X-Received: by 2002:a25:2346:: with SMTP id j67mr59076596ybj.467.1637549135951;
 Sun, 21 Nov 2021 18:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <CAAhSdy3LgDmv5dfuOnBXpJsD_noPecgpjzf7V8v2UjM8WVHcjw@mail.gmail.com>
In-Reply-To: <CAAhSdy3LgDmv5dfuOnBXpJsD_noPecgpjzf7V8v2UjM8WVHcjw@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 22 Nov 2021 10:45:24 +0800
Message-ID: <CAEUhbmWP_e3_UWf-mO8AFwECw5Li0L=4Ywjb00jUHy2J1RX5Yg@mail.gmail.com>
Subject: Re: [PATCH 0/12] RISC-V: Clean up the defconfigs
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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

On Sat, Nov 20, 2021 at 12:32 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, Nov 19, 2021 at 10:14 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >
> > It's been a while since updating the defconfigs, so I figured it would
> > be good to go through all the diff to make sure nothing was lurking.  It
> > turns out there were two minor issues, which I've fixed with the first
> > two patches.  The rest of these are just cleanups that should have no
> > functional change.
> >
> > I don't have a K210 (I might somewhere, but I've yet to boot it) so I
> > can't test this to make sure, but I think patch 2 is the reason we have
> > a special !MMU PAGE_OFFSET config.  If someone does have one it'd be
> > nice to be able to remove that special case.
> >
> >
>
> Using savedefconfig, I used to always get a huge diff so thanks for
> doing this cleanups. Going forward, I suggest that we insiste everyone
> to always use "make savedefconfig" for creating defconfig patches.

Yep, using "savedefconfig" is always required by U-Boot maintainers. I
thought that's always the case for the Linux kernel but it seems it is
not the case.

Regards,
Bin
