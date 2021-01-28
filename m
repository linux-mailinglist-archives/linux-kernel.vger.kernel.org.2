Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E230718C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhA1IbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:31:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:37734 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhA1I3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:29:54 -0500
IronPort-SDR: 5OriQUQGZc7M18PzjwlJW9sDFkrlaIC0NTcDBMv93ErkBQlZRrulJEuRJoqqPVvqI+GwpL8c8T
 OFoGIReOgmnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="199029920"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="199029920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 00:27:49 -0800
IronPort-SDR: 5KIutGBVdEdhwcBIZJmBienU2TfniqqJ6ZndXU7wtRG79bNzvox4j9KUuhfE7N/7Boh2IVkazP
 g4kzSZ3HuOcw==
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="430433640"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 00:27:46 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Jan 2021 10:27:43 +0200
Date:   Thu, 28 Jan 2021 10:27:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 05/12] thunderbolt: pa: Demote non-conformant kernel-doc
 headers
Message-ID: <20210128082743.GP2542@lahna.fi.intel.com>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
 <20210127112554.3770172-6-lee.jones@linaro.org>
 <CAHp75VcFSQqDqjKCiCxdWyRpDDeMo4H6ELMHX15JSPfpt7nGHQ@mail.gmail.com>
 <20210127161320.GK4903@dell>
 <20210127170035.GG2542@lahna.fi.intel.com>
 <20210128082330.GC4774@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128082330.GC4774@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:23:30AM +0000, Lee Jones wrote:
> On Wed, 27 Jan 2021, Mika Westerberg wrote:
> 
> > On Wed, Jan 27, 2021 at 04:13:20PM +0000, Lee Jones wrote:
> > > On Wed, 27 Jan 2021, Andy Shevchenko wrote:
> > > 
> > > > On Wednesday, January 27, 2021, Lee Jones <lee.jones@linaro.org> wrote:
> > > > 
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > >
> > > > >  drivers/thunderbolt/path.c:476: warning: Function parameter or member
> > > > > 'path' not described in 'tb_path_activate'
> > > > >  drivers/thunderbolt/path.c:568: warning: Function parameter or member
> > > > > 'path' not described in 'tb_path_is_invalid'
> > > > >
> > > > >
> > > > I think the intention was to describe them in kernel doc format, perhaps
> > > > you need to add descriptions of the fields?
> > > 
> > > For changes like this, I've been working to the following rule:
> > > 
> > >  - I'll provide fix-ups; if and only if the author has had a
> > >  reasonable attempt at providing a conformant kernel-doc header.
> > > 
> > > So if the headers are just suffering from a little doc-rot i.e. the
> > > API has changed, but the doc update was omitted, or most of the
> > > parameters/members are documented, but some were forgotten about etc,
> > > or if there are formatting issues, I'll happily take up the slack and
> > > polish those up a bit.
> > > 
> > > However, if no attempt was made, then they get demoted.
> > > 
> > > I don't want to get into a situation where authors delicately provide
> > > weak documentation with the expectation that someone else will come
> > > along and turn them into conformant docs.
> > > 
> > > If authors wish to come back, provide proper descriptions &
> > > formatting and subsequently re-promote them again, then all power to
> > > them.
> > 
> > Thanks for pointing these out. I prefer we fix the kernel-docs (add what
> > is missing) instead. I'll take care of that.
> 
> Are you planning on actually using this?

Yes, eventually :)

> I don't see a Doc link for these functions in Mainline:
> 
>   `git grep kernel-doc:: | grep thunderbolt`

There is not one now but I would like to have the kernel-docs at least
in correct format so we can add the link later.
