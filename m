Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A36836019D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhDOFab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:30:31 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:51640 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhDOFa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:30:28 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 13F5Tc78002350;
        Thu, 15 Apr 2021 07:29:38 +0200
Date:   Thu, 15 Apr 2021 07:29:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210415052938.GA2325@1wt.eu>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
 <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <20210413034346.GA22861@1wt.eu>
 <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic>
 <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415044258.GA6318@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 06:43:43AM +0200, Borislav Petkov wrote:
> On Wed, Apr 14, 2021 at 05:57:22PM -0400, Len Brown wrote:
> > I'm pretty sure that the "it isn't my use case of interest, so it
> > doesn't matter" line of reasoning has long been established as -EINVAL
> > ;-)
> 
> I have only a very faint idea what you're trying to say here. Please
> explain properly and more verbosely what exactly has been established
> where?

What Len is saying is that not being interested in a feature is not an
argument for rejecting its adoption, which I'm perfectly fine with. But
conversely not being interested in a feature is also an argument for
insisting that its adoption doesn't harm other use cases (generally
speaking, not this specific case here).

Willy
