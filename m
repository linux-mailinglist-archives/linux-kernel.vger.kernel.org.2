Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2939BFC0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFDSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:38:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFDSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:38:25 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7AAk-1lJMqX14rU-017RtI; Fri, 04 Jun 2021 20:36:37 +0200
Received: by mail-wm1-f54.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4693936wmc.1;
        Fri, 04 Jun 2021 11:36:37 -0700 (PDT)
X-Gm-Message-State: AOAM5315HHajlRd031SMEeTQz7Jmb8mZx8qX6e9sgOZQobiSWgGPVwHB
        jOHcqn39AtFjZbmid/gF7UXXkhh1zAJJugAC/E0=
X-Google-Smtp-Source: ABdhPJwToM45Hdp+Wi5DdfbjyZP3na9DVtUhy8/aD4zsYx/xdlCq2bqXt89T3uaq4bh3FeccqmZDvwKFYZJbITPagkc=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4994277wmb.142.1622831796909;
 Fri, 04 Jun 2021 11:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1TiSNoqUEjTaqPyqnU8d0-p-yZkrsvmXt5fo4Rkfue_w@mail.gmail.com>
 <mhng-f1a76f5f-ad66-40ae-aad3-cd2f669f33bf@palmerdabbelt-glaptop>
In-Reply-To: <mhng-f1a76f5f-ad66-40ae-aad3-cd2f669f33bf@palmerdabbelt-glaptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Jun 2021 20:34:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0fsYwMOioFd7UqzVT0oDSKAA=cjo2o781juO1v88sLAw@mail.gmail.com>
Message-ID: <CAK8P3a0fsYwMOioFd7UqzVT0oDSKAA=cjo2o781juO1v88sLAw@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix BUILTIN_DTB for sifive and microchip soc
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eHcu3cIokUADhj30Ha0pgHJqQEQ6udt8j1cXNpC7zeTbYZM/K+C
 TdXNfwagMEeViZr31Yk/vLoc0zvGQ4LbB/5cuH1MS+GhTsK8M8D70qFWFiF78pQaF/uiQt6
 OSz1cXCxk7yGlM4q+0yakem9PSOmTEM8XdQg6M5VestycHC2ZAbki6MhgUNjMEzrcEQ3lJc
 DQXQIdXxiohVlHrSbyWWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hdDV2UK3ELA=:Cf7BruLfzYvpjTN5OC5cxC
 faRxpxvSUI9Tg1oFD37TF5xnYrD4S6Wi+aqTdWAnNJlJTKxZN01HODq5tNb34ywER33HKKHrk
 wbbcy+KjU5zDWkF/6lJtZnJTKJQD4mIKcVakuiJm5LI0FH10jJBg45W43GlUp1SNQktSqWHFL
 LfMAUnufa1Qzd+6gQziN7uj2QUPnOV9aAkg9H8M0nFJocRLznZfb6lefwmZYT5ctJoeDUiCJv
 ePqvfrY32q3trm6OvmrvAGxlIfny2H61VBX6YJjRyEPgQZJBMJWf7RfWgZVbM5AaSyoxnlQK3
 oIagAqhD4HOXRY3Hs3+Or0hf19MWzmXODI6ETEl3K1u4yUnv81ZdjT9lhS0N2pMEAY1UsM3Sl
 xGJjB4YAoGAsXi0jbtValAQxK4QA5o/5f6ZK41oT7y5flxdOY4T+VywCvMCxKrsmbQVL4SxYV
 lNnZ6ne71Ks6xsax8xLT6WoJXgK4RiX1eJHbz32J4fkybcXXOf22i3pX0lGYeLLXfZtJKdeZn
 Tc7Gu1dy6JBPtYsmwvnn3lUJyiJrDC5Ygh599XhDtDQQjHfvPfKRtixwWg1dRMT+d8T/tdVd2
 NHZrHz2L+w/k4i2AgsBdEY4rvqG9/DVlukOy5Y241mnUTfJNWceBgDkRUklxQPUc15T5Pbq7j
 4T/8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 5:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Fri, 04 Jun 2021 06:08:05 PDT (-0700), Arnd Bergmann wrote:
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
> When we first added BUILTIN_DTB we actually had a compatibility
> mechanism in there.  There isn't enough in the ISA to handle board
> compatibility, but we were hoping to get something to deal with that.
> It didn't pan out so we dropped the compatibility mechanism, which is
> how we ended up here.
>
> Maybe the right thing to do here is to add some sort of "be compatible
> with the platform spec" Kconfig, which we could then use to disallow all
> these features that result in non-portable kernels?

Yes, I should have read your email before I replied with the same
suggestion to Vitaly ;-)

       Arnd
