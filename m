Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAEF332945
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCIOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:54:48 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:27039 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhCIOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:54:23 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 129ErwVA022937
        for <linux-kernel@vger.kernel.org>; Tue, 9 Mar 2021 23:53:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 129ErwVA022937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615301639;
        bh=9dbxmmCJGIIcZtYkRaA26NTON8amq3oSId7Jc5fjq4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d1H+YIWJuaC4U8hgqez+zfnpFHK9q7e251hhGcd6qhJPC15YvORcG+aSzfx0Z0WfA
         LW0K6vg18es8jKnrXZ2sDL0DD7amIITsRFsmfXFyUlw+LiEVwyR4G1LfzlwkuHF6Sf
         cdePbBKqjWnxQKDGz5KqTTeLTbb8niXVGU2eyki60hMwwV8xNpUjo/sdlx2NFTg2Tj
         EKF1NTEtfaE59vrxlGHdE7toRkAbj0i+9K0kf2cGnzwiDflH1ND6/d9R1qS/wsGDa0
         JJGPenYXLCZjm88gaU1BbUfYxrgUAHHP97tGZNfIJk1D7xQ9rodxXRJ6PKseLY4/JN
         meTjE9wSQGPiQ==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id a188so9640722pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:53:58 -0800 (PST)
X-Gm-Message-State: AOAM533TFFpOtgQWkxxMZjTscNZuRz5p2T/KZ9YbiGbahJ8z4Fi+hhI9
        BoJjIvR7pqxmHD8L3M+gULBAgrtUq9lIoebXqZo=
X-Google-Smtp-Source: ABdhPJw7fnUA542cPIjJRyzOi8rbyugp7wC2kou7h9Q/JGVx4YTVqkaBMgURTjnjT/c6z2lC6HGVVRAFHyVWYthHLu8=
X-Received: by 2002:a65:41c6:: with SMTP id b6mr24925857pgq.7.1615301638088;
 Tue, 09 Mar 2021 06:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20210309123544.14040-1-msuchanek@suse.de> <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
 <20210309133523.GX6564@kitsune.suse.cz>
In-Reply-To: <20210309133523.GX6564@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 9 Mar 2021 23:53:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVPYBWvaA+MCjVic+qLay1AR-+UZuyC+_FRGShL=gahg@mail.gmail.com>
Message-ID: <CAK7LNARVPYBWvaA+MCjVic+qLay1AR-+UZuyC+_FRGShL=gahg@mail.gmail.com>
Subject: Re: [PATCH] arm64: make STACKPROTECTOR_PER_TASK configurable.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:35 PM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> On Tue, Mar 09, 2021 at 10:22:36PM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 9, 2021 at 9:35 PM Michal Suchanek <msuchanek@suse.de> wrot=
e:
> > >
> > > When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
> > > selected. This defeats the purpose of the all-enabled tool.
> > >
> > > Description copied from arm
> > >
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> >
> >
> > Could you explain what problem
> > this patch is trying to solve?
>
> The option cannot be disabled when compiler has the required capability.


Yes.
Currently, this symbol claims "def_bool y",
so there is no way to disable it.

But, it comes from the nature of Kconfig in general.

dummy-tools is completely unrelated here.







--=20
Best Regards
Masahiro Yamada
