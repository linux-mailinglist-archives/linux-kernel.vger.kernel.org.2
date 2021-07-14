Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5453C80EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhGNJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:07:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:54258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238496AbhGNJH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:07:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="271424073"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="271424073"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 02:04:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="430363351"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 02:04:31 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3aob-00DFaO-0v; Wed, 14 Jul 2021 12:04:25 +0300
Date:   Wed, 14 Jul 2021 12:04:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     shruthi.sanil@intel.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <YO6ome7Opd6kjqua@smile.fi.intel.com>
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
 <20210628061410.8009-2-shruthi.sanil@intel.com>
 <20210714024756.GA1355219@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714024756.GA1355219@robh.at.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 08:47:56PM -0600, Rob Herring wrote:
> On Mon, Jun 28, 2021 at 11:44:09AM +0530, shruthi.sanil@intel.com wrote:

> > +  The parent node represents the common general configuration details and
> > +  the child nodes represents the counter and timers.
> 
> I don't think all the child nodes are necessary. Are the counters and 
> timers configurable (say on another SoC)? If not, then a single node 
> here would suffice.

If you may notice the children may have different properties that can't be
known ahead, such as IRQ line. On some platforms it may be this mapping, on
another it maybe different.

With all respect for the simplification I think we can't do it here.

-- 
With Best Regards,
Andy Shevchenko


