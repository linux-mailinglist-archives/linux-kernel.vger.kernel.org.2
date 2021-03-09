Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE50332F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCIToR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:44:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:43306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhCIToH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:44:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC710AC1F;
        Tue,  9 Mar 2021 19:44:05 +0000 (UTC)
Date:   Tue, 9 Mar 2021 20:44:04 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: make STACKPROTECTOR_PER_TASK configurable.
Message-ID: <20210309194404.GC6564@kitsune.suse.cz>
References: <20210309123544.14040-1-msuchanek@suse.de>
 <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
 <20210309133523.GX6564@kitsune.suse.cz>
 <CAK7LNARVPYBWvaA+MCjVic+qLay1AR-+UZuyC+_FRGShL=gahg@mail.gmail.com>
 <20210309151046.GZ6564@kitsune.suse.cz>
 <CAK7LNAQ_oJJem6sdEwTjLucjHF_R70Pa=C_c__v7x3QMz-WBAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQ_oJJem6sdEwTjLucjHF_R70Pa=C_c__v7x3QMz-WBAw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:07:00AM +0900, Masahiro Yamada wrote:
> On Wed, Mar 10, 2021 at 12:10 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Tue, Mar 09, 2021 at 11:53:21PM +0900, Masahiro Yamada wrote:
> > > On Tue, Mar 9, 2021 at 10:35 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > > >
> > > > On Tue, Mar 09, 2021 at 10:22:36PM +0900, Masahiro Yamada wrote:
> > > > > On Tue, Mar 9, 2021 at 9:35 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > > > > >
> > > > > > When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
> > > > > > selected. This defeats the purpose of the all-enabled tool.
> > > > > >
> > > > > > Description copied from arm
> > > > > >
> > > > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > >
> > > > >
> > > > > Could you explain what problem
> > > > > this patch is trying to solve?
> > > >
> > > > The option cannot be disabled when compiler has the required capability.
> > >
> > >
> > > Yes.
> > > Currently, this symbol claims "def_bool y",
> > > so there is no way to disable it.
> > >
> > > But, it comes from the nature of Kconfig in general.
> > >
> > > dummy-tools is completely unrelated here.
> >
> > dummy-tools makes all configuration options available in order to be
> > able to author configuration files on system different from the one
> > where the kernel is built. This prevents authoring a configuration file
> > with this option disabled.
> 
> 
> No.
> dummy-tools enables as many $(cc-option, ...)
> and $(shell, ...) as possible. That's it.
> 
> 
> In my understanding, STACKPROTECTOR_PER_TASK
> should not be user-configurable.
> That is why 'def_bool y'.

How do you author a specific configuration with dummy-tools when options
are allowed to unconditionally follow these options that dummy-tools
enables?

Thanks

Michal
