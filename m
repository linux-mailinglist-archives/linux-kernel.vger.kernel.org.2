Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CBF332EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhCITIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:39 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:51191 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhCITIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:08:06 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 129J7dEZ025638
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:07:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 129J7dEZ025638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615316859;
        bh=gHcj+lnNbA3JG9iSZjbM+AptgA8q9s4PdaW8jlPZx6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kQbPUclaMNIJqA/hwXsXnA2ipPIfMnhNNK1/FV/lwu33g2MATlNGsdu2JrceOaJgc
         HDMWyJe5H/15Vf24+28+Wl7wqPuRs7NALRIqOIgJXGMrPN3cFkBqCtYA2S9vLw/iOj
         2aIzg75+jUubaA6lO72bsv+He9cD26rduUjF5ExhO0+tO1ZnqiPtIye1Ku0I6EKCUH
         zL7WUutvm/jQPIxkHlEf0+5JlsRBsjU1SVf2dEQhTEcYnAgLVxeTJLkN91q1D0pDU8
         JSOn5MKmZ0cshIUbMjkOj0lcXjGrtBnZ2J7eqU8p1UARKsughcX2lKQkaUBX6gqGyP
         R9ztP8KRzg8Cw==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id m6so10118165pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:07:39 -0800 (PST)
X-Gm-Message-State: AOAM532Spf9X6F/V4rmuF1Hantm9zrAbPiABBuJJV5by7rUVYqH1Zu7U
        RTKCt/q5pdt3N0vL6SlGdWq6e3eCXMi9DG/3+80=
X-Google-Smtp-Source: ABdhPJy5VzVkYVP4p3ePlGQvTJDug3TW0ogFfD1NiO3/8kSqa6TbvAoUWHZFl9IpKKTAvPUxazkp/jrCpKL1ezpEemI=
X-Received: by 2002:aa7:956d:0:b029:1f1:5ba6:2a58 with SMTP id
 x13-20020aa7956d0000b02901f15ba62a58mr4811151pfq.63.1615316858583; Tue, 09
 Mar 2021 11:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20210309123544.14040-1-msuchanek@suse.de> <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
 <20210309133523.GX6564@kitsune.suse.cz> <CAK7LNARVPYBWvaA+MCjVic+qLay1AR-+UZuyC+_FRGShL=gahg@mail.gmail.com>
 <20210309151046.GZ6564@kitsune.suse.cz>
In-Reply-To: <20210309151046.GZ6564@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Mar 2021 04:07:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_oJJem6sdEwTjLucjHF_R70Pa=C_c__v7x3QMz-WBAw@mail.gmail.com>
Message-ID: <CAK7LNAQ_oJJem6sdEwTjLucjHF_R70Pa=C_c__v7x3QMz-WBAw@mail.gmail.com>
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

On Wed, Mar 10, 2021 at 12:10 AM Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> On Tue, Mar 09, 2021 at 11:53:21PM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 9, 2021 at 10:35 PM Michal Such=C3=A1nek <msuchanek@suse.de=
> wrote:
> > >
> > > On Tue, Mar 09, 2021 at 10:22:36PM +0900, Masahiro Yamada wrote:
> > > > On Tue, Mar 9, 2021 at 9:35 PM Michal Suchanek <msuchanek@suse.de> =
wrote:
> > > > >
> > > > > When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
> > > > > selected. This defeats the purpose of the all-enabled tool.
> > > > >
> > > > > Description copied from arm
> > > > >
> > > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > >
> > > >
> > > > Could you explain what problem
> > > > this patch is trying to solve?
> > >
> > > The option cannot be disabled when compiler has the required capabili=
ty.
> >
> >
> > Yes.
> > Currently, this symbol claims "def_bool y",
> > so there is no way to disable it.
> >
> > But, it comes from the nature of Kconfig in general.
> >
> > dummy-tools is completely unrelated here.
>
> dummy-tools makes all configuration options available in order to be
> able to author configuration files on system different from the one
> where the kernel is built. This prevents authoring a configuration file
> with this option disabled.


No.
dummy-tools enables as many $(cc-option, ...)
and $(shell, ...) as possible. That's it.


In my understanding, STACKPROTECTOR_PER_TASK
should not be user-configurable.
That is why 'def_bool y'.

--
Best Regards
Masahiro Yamada
