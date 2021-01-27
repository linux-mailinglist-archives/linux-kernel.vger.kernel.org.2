Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7130617F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhA0RCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:02:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:11032 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235062AbhA0Q7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:59:18 -0500
IronPort-SDR: P9puhb/K0TDbduXQgmWFrOii9AF+U0RT62RCdoKv7xPA9NEZ81e2fK0Am54YW8vreAQ/mEkVf1
 MO8IUARr+MIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167772018"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="167772018"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 08:57:25 -0800
IronPort-SDR: I4el8xmHYZELqL1CYc5tt8+nJ6FrWnjMuiNuFsvonPmHzzDhQq1XUrTCFczG/ZO0Av3l9CkMkL
 79kpC13/bPAQ==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="362493764"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 08:57:22 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Jan 2021 18:57:18 +0200
Date:   Wed, 27 Jan 2021 18:57:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 01/12] thunderbolt: dma_port: Remove unused variable 'ret'
Message-ID: <20210127165718.GF2542@lahna.fi.intel.com>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
 <20210127112554.3770172-2-lee.jones@linaro.org>
 <CAHp75VdnvG75bTZ9Zqpn=pm0_KNwK0GGBGGjZv1DpSY-6Ef_Xw@mail.gmail.com>
 <20210127161916.GL4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127161916.GL4903@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 27, 2021 at 04:19:16PM +0000, Lee Jones wrote:
> On Wed, 27 Jan 2021, Andy Shevchenko wrote:
> 
> > On Wednesday, January 27, 2021, Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  drivers/thunderbolt/dma_port.c: In function ‘dma_port_flash_write_block’:
> > >  drivers/thunderbolt/dma_port.c:331:6: warning: variable ‘ret’ set but
> > > not used [-Wunused-but-set-variable]
> > >
> > >
> > Is it scripted somehow?
> 
> A script opens up the file on the warning line.
> 
> The patch is hand-written.
> 
> > Because I am not sure we are okay to simply drop the assignment.
> 
> I've been careful not to change the semantics of the code.
> 
> The return value has never been checked since the driver's inception 4
> years ago.
> 
> However, if this is an oversight and the intention was to check the
> value and error-out during a failure condition, I can make that
> happen.
> 
> I would need a nod from the author before I make such a change.

It's actually an oversight from my side. It should do something like:

  if (ret)
  	return ret:

there. Feel free to fix it up :)

Thanks!
