Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14A3358056
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhDHKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:11:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:52962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHKLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:11:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDFAEAFF7;
        Thu,  8 Apr 2021 10:11:41 +0000 (UTC)
Date:   Thu, 8 Apr 2021 12:11:40 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Philipp Rudo <prudo@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: allmodconfig not working with dummy-tools
Message-ID: <20210408101140.GK15381@kitsune.suse.cz>
References: <20210401123944.GJ15381@kitsune.suse.cz>
 <CAK7LNAQwi=Nd+OfHrXBMJtC=f262K+=XFqeYBUz=Qx2Bjbg+yg@mail.gmail.com>
 <20210403104302.GX6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210403104302.GX6564@kitsune.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 12:43:02PM +0200, Michal Suchánek wrote:
> Hello,
> 
> thanks for the fix.
> 
> On Fri, Apr 02, 2021 at 01:26:38AM +0900, Masahiro Yamada wrote:
> > On Thu, Apr 1, 2021 at 9:39 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > I squashed the following. Please wait for tomorrow's linux-next.
> 
> > diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> > index 39e65fee59bd..f6d543725f1e 100755
> > --- a/scripts/dummy-tools/gcc
> > +++ b/scripts/dummy-tools/gcc
> > @@ -67,6 +67,12 @@ if arg_contain -E "$@"; then
> >   fi
> >  fi
> > 
> > +# To set CONFIG_AS_IS_GNU
> > +if arg_contain -Wa,--version "$@"; then
> > + echo "GNU assembler (scripts/dummy-tools) 2.50"
> > + exit 0
> > +fi
> > +
> >  if arg_contain -S "$@"; then
> >   # For scripts/gcc-x86-*-has-stack-protector.sh
> >   if arg_contain -fstack-protector "$@"; then
> 
> Looks like this did not make it to linux-next (0104 does not have it,
> 0204 does not exist).
The fixup still applies locally so it loooks like it is still not
upstream.
> 
> Nonetheless, applying the fixup resolves the problem.
Mostly, I still get:

which: no elfedit in (./scripts/dummy-tools)
> 
> Thanks
> 
> Michal
