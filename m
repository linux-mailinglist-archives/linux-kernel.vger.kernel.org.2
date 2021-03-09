Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9972A3329DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhCIPK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:10:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhCIPKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:10:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB08EAE15;
        Tue,  9 Mar 2021 15:10:47 +0000 (UTC)
Date:   Tue, 9 Mar 2021 16:10:46 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: make STACKPROTECTOR_PER_TASK configurable.
Message-ID: <20210309151046.GZ6564@kitsune.suse.cz>
References: <20210309123544.14040-1-msuchanek@suse.de>
 <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
 <20210309133523.GX6564@kitsune.suse.cz>
 <CAK7LNARVPYBWvaA+MCjVic+qLay1AR-+UZuyC+_FRGShL=gahg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARVPYBWvaA+MCjVic+qLay1AR-+UZuyC+_FRGShL=gahg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 11:53:21PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 9, 2021 at 10:35 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Tue, Mar 09, 2021 at 10:22:36PM +0900, Masahiro Yamada wrote:
> > > On Tue, Mar 9, 2021 at 9:35 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > > >
> > > > When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
> > > > selected. This defeats the purpose of the all-enabled tool.
> > > >
> > > > Description copied from arm
> > > >
> > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > >
> > >
> > > Could you explain what problem
> > > this patch is trying to solve?
> >
> > The option cannot be disabled when compiler has the required capability.
> 
> 
> Yes.
> Currently, this symbol claims "def_bool y",
> so there is no way to disable it.
> 
> But, it comes from the nature of Kconfig in general.
> 
> dummy-tools is completely unrelated here.

dummy-tools makes all configuration options available in order to be
able to author configuration files on system different from the one
where the kernel is built. This prevents authoring a configuration file
with this option disabled.

Thanks

Michal
