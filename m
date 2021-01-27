Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD170306188
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhA0RFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:05:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:24111 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235172AbhA0RCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:02:46 -0500
IronPort-SDR: N9aTcGgv5V0lwl6ToUGK3eO6mnIK/Oq7Xk3dkYKNLWAWy4o1JXSbuF1CSbQ9t+qHyYXTrcyHm/
 GeJGt4rHtIdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180243415"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="180243415"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:00:40 -0800
IronPort-SDR: NgjDxMrAnE/dO2jAvetj5T3vVY9RGjj/MdKwwx2Xc1tTEdoPLadHlGTUNoSmhNhBZmiu9cIdH9
 qA0nPTL7bHPw==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="362494884"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:00:37 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Jan 2021 19:00:35 +0200
Date:   Wed, 27 Jan 2021 19:00:35 +0200
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
Message-ID: <20210127170035.GG2542@lahna.fi.intel.com>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
 <20210127112554.3770172-6-lee.jones@linaro.org>
 <CAHp75VcFSQqDqjKCiCxdWyRpDDeMo4H6ELMHX15JSPfpt7nGHQ@mail.gmail.com>
 <20210127161320.GK4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127161320.GK4903@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:13:20PM +0000, Lee Jones wrote:
> On Wed, 27 Jan 2021, Andy Shevchenko wrote:
> 
> > On Wednesday, January 27, 2021, Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  drivers/thunderbolt/path.c:476: warning: Function parameter or member
> > > 'path' not described in 'tb_path_activate'
> > >  drivers/thunderbolt/path.c:568: warning: Function parameter or member
> > > 'path' not described in 'tb_path_is_invalid'
> > >
> > >
> > I think the intention was to describe them in kernel doc format, perhaps
> > you need to add descriptions of the fields?
> 
> For changes like this, I've been working to the following rule:
> 
>  - I'll provide fix-ups; if and only if the author has had a
>  reasonable attempt at providing a conformant kernel-doc header.
> 
> So if the headers are just suffering from a little doc-rot i.e. the
> API has changed, but the doc update was omitted, or most of the
> parameters/members are documented, but some were forgotten about etc,
> or if there are formatting issues, I'll happily take up the slack and
> polish those up a bit.
> 
> However, if no attempt was made, then they get demoted.
> 
> I don't want to get into a situation where authors delicately provide
> weak documentation with the expectation that someone else will come
> along and turn them into conformant docs.
> 
> If authors wish to come back, provide proper descriptions &
> formatting and subsequently re-promote them again, then all power to
> them.

Thanks for pointing these out. I prefer we fix the kernel-docs (add what
is missing) instead. I'll take care of that.
