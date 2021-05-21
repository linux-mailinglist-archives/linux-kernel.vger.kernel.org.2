Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB55F38C532
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhEUKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230480AbhEUKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60AF86008E;
        Fri, 21 May 2021 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621593948;
        bh=AouORxPeos/y+srTBjjykWrp10gH9l+EJwzDVaBiOsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pwl/YLjmbbmCHYM/4vkJnO4I9Xq5kU+l5NYkEjGdbPDx7Q2Uy5sr1HCjPDGq/Kifb
         5WNYRdL7oSDo6bi58PSRQHTJK29fktEFhr3UT41QSaSPo+dvGT4Lu3wtIPAF8TTazG
         sac01OBCJb29sqDlCrzbFNlcHyUgXU8Xzqtbj+TQ=
Date:   Fri, 21 May 2021 12:45:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Perret <qperret@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>, kernel-team@android.com
Subject: Re: [PATCH] export: Make CRCs robust to symbol trimming
Message-ID: <YKePWull0E86SXpm@kroah.com>
References: <20210408180105.2496212-1-qperret@google.com>
 <YJkJ21n71SIkUppu@google.com>
 <CAF2Aj3iJ3jGCSTaO0p8WT2TrRX--QxQT0bD6iH1+OGbx5H-muQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF2Aj3iJ3jGCSTaO0p8WT2TrRX--QxQT0bD6iH1+OGbx5H-muQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:57:44AM +0100, Lee Jones wrote:
> On Mon, 10 May 2021 at 11:25, Quentin Perret <qperret@google.com> wrote:
> 
> > Hi,
> >
> > On Thursday 08 Apr 2021 at 18:01:05 (+0000), Quentin Perret wrote:
> > > The CRC calculation done by genksyms is triggered when the parser hits
> > > EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
> > > types, and uses that as the input for the CRC calculation. In the case
> > > of forward-declared structs, the type expands to 'UNKNOWN'. Next, the
> > > result of the expansion of each type is cached, and is re-used when/if
> > > the same type is seen again for another exported symbol in the file.
> > >
> > > Unfortunately, this can cause CRC 'stability' issues when a struct
> > > definition becomes visible in the middle of a C file. For example, let's
> > > assume code with the following pattern:
> > >
> > >     struct foo;
> > >
> > >     int bar(struct foo *arg)
> > >     {
> > >       /* Do work ... */
> > >     }
> > >     EXPORT_SYMBOL_GPL(bar);
> > >
> > >     /* This contains struct foo's definition */
> > >     #include "foo.h"
> > >
> > >     int baz(struct foo *arg)
> > >     {
> > >       /* Do more work ... */
> > >     }
> > >     EXPORT_SYMBOL_GPL(baz);
> > >
> > > Here, baz's CRC will be computed using the expansion of struct foo that
> > > was cached after bar's CRC calculation ('UNKOWN' here). But if
> > > EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
> > > trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
> > > late, during baz's CRC calculation, which now has visibility over the
> > > full struct definition, hence resulting in a different CRC for baz.
> > >
> > > This can cause annoying issues for distro kernel (such as the Android
> > > Generic Kernel Image) which use CONFIG_UNUSED_KSYMS_WHITELIST. Indeed,
> > > as per the above, adding a symbol to the whitelist can change the CRC of
> > > symbols that are already kept exported. As such, modules built against a
> > > kernel with a trimmed ABI may not load against the same kernel built
> > > with an extended whitelist, even though they are still strictly binary
> > > compatible. While rebuilding the modules would obviously solve the
> > > issue, I believe this classifies as an odd genksyms corner case, and it
> > > gets in the way of kernel updates in the GKI context.
> > >
> > > To work around the issue, make sure to keep issuing the
> > > __GENKSYMS_EXPORT_SYMBOL macros for all trimmed symbols, hence making
> > > the genksyms parsing insensitive to symbol trimming.
> > >
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> >
> > Gentle ping.
> >
> > Is there anything else I should do in this one?
> >
> 
> With Greg's Ack and ~6 weeks on the list, you're probably golden.
> 
> I *could* pick this up, but seems wrong somehow.
> 
> Greg, is this something you're prepared to merge?  If not, who's the
> g{uy,al}?

What does get_maintainer.pl show?
