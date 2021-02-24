Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D2B3241C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhBXQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235248AbhBXQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:06:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A75F364EFC
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614182705;
        bh=stKj60ej/VtHcUVpEicz7vhAWELNIunpuFuM/MvNJas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IVIG2WseXbGfH1qerk2Hx6hB1LNCqI0ZYO3DO4n/M8PhKATcfBBJjmx8Mw06/VrXK
         YD31mXK8DtDMZd/KaMDBf42hZzhVDaiQE1I75kdXShgrFmp/IMIb9v9VVYdxT6YFe2
         BE7N53OskH4PwEAyiD7fDiykl8W4H5eYByVIghrnwmkGHJ7pvpQ1QBcMB0firLd/JF
         WB8LqvnI26Cg+DRmq7DASGv7rO7/Zt71HZfJ+iAbwtuBtzSsZPpfJyNYENC1js6IyM
         lxgvgpRcQ+AvH/OlZXAbQ79x+HVBHAl96tFRjhSumkQafvHdVk8asuQDDKYDRQVRLw
         w2UCeTmy+OKow==
Received: by mail-ot1-f41.google.com with SMTP id h22so2612311otr.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:05:05 -0800 (PST)
X-Gm-Message-State: AOAM531TH6XUJStA8zRA4khEt37b+h4SFD4liBdHzNNjcsc2CjDWIKz7
        /7P6ijlt474YYgcFr+rDOxf1PsZp1wtVTYU9HOA=
X-Google-Smtp-Source: ABdhPJz8CsSlVeUe5UWoWlqhaRUmSie9cxXYeGRvdbLN4kGb8QDafzr1njK+JtWgKQ991fSqchEDdHIqzJKqJa46Zuc=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr25843902otf.251.1614182704665;
 Wed, 24 Feb 2021 08:05:04 -0800 (PST)
MIME-Version: 1.0
References: <202102221504.0418BE2D1@keescook> <CAHk-=wgUS-vqCk_d0wwBWgk4tRgFpYvfyob5y28c85msqpbjuw@mail.gmail.com>
 <CAHk-=wgQ=oaLD_ybzhOP+8LFNZH3Qzpc-dp4XB4cXxXLReCdnQ@mail.gmail.com> <20210223204919.549167-1-alobakin@pm.me>
In-Reply-To: <20210223204919.549167-1-alobakin@pm.me>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Feb 2021 17:04:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com>
Message-ID: <CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com>
Subject: Re: [GIT PULL v2] clang-lto for v5.12-rc1
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 1:10 AM Alexander Lobakin <alobakin@pm.me> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org> Date: Tue, 23 Feb 2021 12:33:05 -0800
>> > On Tue, Feb 23, 2021 at 9:49 AM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > On Mon, Feb 22, 2021 at 3:11 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > While x86 LTO enablement is done[1], it depends on some objtool
> > > > clean-ups[2], though it appears those actually have been in linux-next
> > > > (via tip/objtool/core), so it's possible that if that tree lands [..]
> > >
> > > That tree is actually next on my list of things to merge after this
> > > one, so it should be out soonish.
> >
> > "soonish" turned out to be later than I thought, because my "build
> > changes" set of pulls included the module change that I then wasted a
> > lot of time on trying to figure out why it slowed down my build so
> > much.
>
> I guess it's about CONFIG_TRIM_UNUSED_KSYMS you disabled in your tree.
> Well, it's actually widely used, mostly in the embedded world where
> there are often no out-of-tree modules, but a need to save as much
> space as possible.
> For full-blown systems and distributions it's almost needless, right.

Generally, CONFIG_TRIM_UNUSED_KSYMS helps mostly
when combined with either LTO or --gc-sections
(CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION), though
the effect seems to be smaller than I expected. For example on m68k:

4005135 1374302 167108 5546545 54a231 vmlinux-normal
3916254 1378078 167108 5461440 5355c0 vmlinux+trim
4012933 1362514 164280 5539727 54878f vmlinux+gcsection
3797884 1334194 164640 5296718 50d24e vmlinux+gcsection+trim

For arm64 defconfig, CONFIG_TRIM_UNUSED_KSYMS saves around
700KB by itself, or when combined with either gc-sections or LTO,
but saves a full megabyte when all three are combined:

   text    data     bss     dec     hex filename
16570322 10998617 506468 28075407 1ac658f defconfig/vmlinux
16318793 10569913 506468 27395174 1a20466 trim_defconfig/vmlinux
16281234 10984848 504291 27770373 1a7be05 gc_defconfig/vmlinux
16029705 10556880 504355 27090940 19d5ffc gc+trim_defconfig/vmlinux
17040142 11102945 504196 28647283 1b51f73 thinlto_defconfig/vmlinux
16788613 10663201 504196 27956010 1aa932a thinlto+trim_defconfig/vmlinux
16347062 11043384 502499 27892945 1a99cd1 gc+thinlto_defconfig/vmlinux
15759453 10532792 502395 26794640 198da90 gc+thinlto+trim_defconfig/vmlinux

However, the combination of thinlto and trim indeed has a steep
cost in compile time, taking almost twice as long as a normal
defconfig (gc-sections makes it slightly faster).

==== defconfig ====
     332.001786355 seconds time elapsed
    8599.464163000 seconds user
     676.919635000 seconds sys
==== trim_defconfig ====
     448.378576012 seconds time elapsed
   10735.489271000 seconds user
     964.006504000 seconds sys
==== gc_defconfig ====
     324.347492236 seconds time elapsed
    8465.785800000 seconds user
     614.899797000 seconds sys
==== gc+trim_defconfig ====
     429.188875620 seconds time elapsed
   10203.759658000 seconds user
     871.307973000 seconds sys
==== thinlto_defconfig ====
     389.793540200 seconds time elapsed
    9491.665320000 seconds user
     664.858109000 seconds sys
==== thinlto+trim_defconfig ====
     580.431820561 seconds time elapsed
   11429.515538000 seconds user
    1056.985745000 seconds sys
==== gc+thinlto_defconfig ====
     389.484364525 seconds time elapsed
    9473.831980000 seconds user
     675.057675000 seconds sys
==== gc+thinlto+trim_defconfig ====
     580.824912807 seconds time elapsed
   11433.650337000 seconds user
    1049.845569000 seconds sys

         Arnd
