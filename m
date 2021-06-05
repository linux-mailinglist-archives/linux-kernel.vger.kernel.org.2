Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F118939C7A8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFELEQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 5 Jun 2021 07:04:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFELEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 07:04:16 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMGZM-1m7ZQ50G8M-00JHp1; Sat, 05 Jun 2021 13:02:27 +0200
Received: by mail-wr1-f48.google.com with SMTP id c9so3114441wrt.5;
        Sat, 05 Jun 2021 04:02:26 -0700 (PDT)
X-Gm-Message-State: AOAM532TQuh59e0hpwB79zHjANdC7gxxqumMJZ6Qbbom+zm28wHTKb+l
        i8GPw3SIcLTHFItx7zzCtim5NnrmJh2pIpGysdQ=
X-Google-Smtp-Source: ABdhPJyTgAm4kMtZ4p3Ermy7kQq56j4m/FpiomcM6zHsddzu7oi+hv92VtxR6BpYVuCoQL54tJkvc1afe1lQcNxED5I=
X-Received: by 2002:a5d:4050:: with SMTP id w16mr8108472wrp.99.1622890946655;
 Sat, 05 Jun 2021 04:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210604120639.1447869-1-alex@ghiti.fr> <CAK8P3a1TiSNoqUEjTaqPyqnU8d0-p-yZkrsvmXt5fo4Rkfue_w@mail.gmail.com>
 <1287f6f3-2f07-3269-9048-8f7d08eecc09@ghiti.fr>
In-Reply-To: <1287f6f3-2f07-3269-9048-8f7d08eecc09@ghiti.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 5 Jun 2021 13:00:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1_N6dAdjWR10FtgaVz828o7W5Mp55DO3Ex+3en-ikOUw@mail.gmail.com>
Message-ID: <CAK8P3a1_N6dAdjWR10FtgaVz828o7W5Mp55DO3Ex+3en-ikOUw@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix BUILTIN_DTB for sifive and microchip soc
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:YTlaWPsnSSYSmgYtT8aehuJJ230e/R61XsF1n8IhYHguuRwly3I
 wOyvGO7HVYV02Gt5OSn/kHrdIOjRqsy/L04F5jX6NimcUR2T9qdnlthjrGfu8P5Kb9mjS0v
 T/Ulpys6qkP0aud/O/j2EkrP63TJqCVMfawXCAn4ZROurh5ZBt1JL4Flfx69s2H0wXcUy8B
 NzET+9KUNjGq8GzpEd/BA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wq7e39+7AiM=:90/xaFsy8JKcLn9eCG4Ar6
 HCizokA2fKOjGqc0TNac69ZlwVIjktKdZ41t+bi/4ZplTrNB/R4/OBtjBIf92I7IU3BBd0DsJ
 K7DDv3i2PZPE0nj+J1fSU/99MWZGznQE37jcP2v2ZG0AIOlubHJ+nSecJguH/ruHnnJxUehWz
 d5RXexvjmNKQBwZVlsE6VZ3NhmUiGNlsozpDxTEvbH+Lhw/Wx5e6+81yFWQRqi3TC4UEgWx2I
 U54Xszc7P40dVh7KPYBAQTcmtNpEsiWfqN8zU9k/KGCim+j5Illa9vzqQpqlVjMTOZTHvjfrG
 bmeoxMeG0rlDKIsOSKBNQcfD/m6f11OdEuwGrh4/PZUoLu46QTPPsY9V+jTaHGk/E5XMeml9t
 v93XFkd7xXyiGRPN9np+Ml/lSdRAmonNKZNkO8tyY7vqO28CXoSqqcQ2VyRglUPRY94mo07Fb
 sffeq0GEakpOSDgs/vMg/v8/Hk/k/9HNO2uMCbdInIE2/BmCi1gKdVNo8n2KyI455sfd9I8tI
 EQibp2ma2iG9EY5qlJrvVnRTXaEKUliWuo1aw30F51R2jkI93JLckBb3iGP4VaD0ls6TdDoVn
 Vt/VVDHdnKaiNyXAwVby0d2HTwzfoDICa3F5nqcxG06pqOLWWmZBaJWWD77ElYPro0auOL77K
 euS0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 8:37 AM Alex Ghiti <alex@ghiti.fr> wrote:
> Le 4/06/2021 à 15:08, Arnd Bergmann a écrit :
> > On Fri, Jun 4, 2021 at 2:06 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
> >>
> >> Fix BUILTIN_DTB config which resulted in a dtb that was actually not built
> >> into the Linux image: in the same manner as Canaan soc does, create an object
> >> file from the dtb file that will get linked into the Linux image.
> >>
> >> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >
> > Along the same lines as the comment that Jisheng Zhang made on the fixed
> > address, building a dtb into the kernel itself fundamentally breaks generic
> > kernel images.
> >
> > I can understand using it on K210, which is extremely limited and wouldn't
> > run a generic kernel anyway, but for normal platforms like microchip and
> > sifive, it would be better to disallow CONFIG_BUILTIN_DTB in Kconfig
> > and require a non-broken boot loader.
>
> I kind of disagree because if I want to build a custom kernel for those
> platforms with a builtin dtb for some reasons (debug, development..Etc),
> I think I should be able to do so.

How is the builtin dtb better than appended dtb, or passing the dtb to the
boot loader in that case?

         Arnd
