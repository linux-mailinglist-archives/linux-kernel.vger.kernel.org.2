Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6E35A494
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhDIRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:24:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:32565
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhDIRYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:24:15 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0/2Gc6BBUteEyBzlHelN55DYdL4zR+YMi2QD?=
 =?us-ascii?q?/UZ3VBBTb4ikh9mj9c5rsSPcpT4NVBgb8uyoF7KHRRrnn6JdwY5UBru6WRmjhW?=
 =?us-ascii?q?3AFuBfxK/D5xGlJCHk7O5a0s5bAs1DIfn9F0Jzg8q/wCTQKbYd6eKK+qypmuvS?=
 =?us-ascii?q?pk0FJT1CUK1u4xx0DQyWCCRNNWp7LKAkH5mR7NcvnVSdUEkQB/7WOlA4ReTZ4/?=
 =?us-ascii?q?XEmJX6CCR2ZSIP2U2+yQml77P3CHGjsys2WTkn+9gfzVQ=3D?=
X-IronPort-AV: E=Sophos;i="5.82,210,1613430000"; 
   d="scan'208";a="378242715"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 19:24:00 +0200
Date:   Fri, 9 Apr 2021 19:24:00 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Change the type
 and use of a variable
In-Reply-To: <2106328.ujm4fZfeqs@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2104091923280.17316@hadrien>
References: <20210408111942.19411-1-fmdefrancesco@gmail.com> <YHBg1Sy2509vBtrA@kroah.com> <2106328.ujm4fZfeqs@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Apr 2021, Fabio M. De Francesco wrote:

> On Friday, April 9, 2021 4:12:37 PM CEST Greg KH wrote:
> > On Thu, Apr 08, 2021 at 01:19:42PM +0200, Fabio M. De Francesco wrote:
> > > Change the type of fw_current_in_ps_mode from u8 to bool, because
> > > it is used everywhere as a bool and, accordingly, it should be
> > > declared as a bool. Shorten the controlling
> > > expression of an 'if' statement.
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > >  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > I now have 3 patches, I think, for this same driver, from you, and I
> > have no idea what order they should be applied in.
> >
> > So I'm going to drop them all.  Can you please resend me a patch series,
> > with all of the outstanding patches sent to me from you that I have not
> > applied yet, so that I know which ones to look at and what order to
> > apply them in?
> >
> I just sent in the series of patches you requested. Hope the work is as you
> expected.

If you make multiple patches that touch the same files they have to be in
a series.

julia
