Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A233C85FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhGNOX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:23:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:33729 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhGNOXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:23:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210170332"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="210170332"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 07:21:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413300245"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 07:20:58 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3fkq-00DLq4-QY; Wed, 14 Jul 2021 17:20:52 +0300
Date:   Wed, 14 Jul 2021 17:20:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     shruthi.sanil@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, kris.pan@linux.intel.com,
        Mark Gross <mgross@linux.intel.com>,
        srikanth.thokala@intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <YO7yxEgdzobD1jeu@smile.fi.intel.com>
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
 <20210628061410.8009-2-shruthi.sanil@intel.com>
 <20210714024756.GA1355219@robh.at.kernel.org>
 <YO6ome7Opd6kjqua@smile.fi.intel.com>
 <CAL_Jsq+4vEfL5ZQzREXU7Mo1AUx1ZbdHTmJDwauEL890O7S7qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+4vEfL5ZQzREXU7Mo1AUx1ZbdHTmJDwauEL890O7S7qg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 08:07:44AM -0600, Rob Herring wrote:
> On Wed, Jul 14, 2021 at 3:04 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Jul 13, 2021 at 08:47:56PM -0600, Rob Herring wrote:
> > > On Mon, Jun 28, 2021 at 11:44:09AM +0530, shruthi.sanil@intel.com wrote:
> >
> > > > +  The parent node represents the common general configuration details and
> > > > +  the child nodes represents the counter and timers.
> > >
> > > I don't think all the child nodes are necessary. Are the counters and
> > > timers configurable (say on another SoC)? If not, then a single node
> > > here would suffice.
> >
> > If you may notice the children may have different properties that can't be
> > known ahead, such as IRQ line. On some platforms it may be this mapping, on
> > another it maybe different.
> 
> What I noticed is it's all the same clock and 1 interrupt for each
> timer can be just a single 'interrupts' property with 8 entries.

This may work.

> Is there a platform that's different or that's a hypothetical? Because
> hypothetically, every aspect of every IP could change. But we don't
> try to parameterize everything in DT. It's a judgement call between
> implying things from compatible and explicit DT properties.
> 
> > With all respect for the simplification I think we can't do it here.
> 
> You can. Any data in DT could be in the kernel. It's a question of
> balance, not can or can't.

Not only, it's also matters of what exactly hardware is: 8 timers or timer with
8 channels. If it's the former one, I prefer to have DT exactly like originally
suggested, otherwise I will agree on your proposal.

-- 
With Best Regards,
Andy Shevchenko


