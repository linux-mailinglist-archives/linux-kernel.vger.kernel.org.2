Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2E3D791D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhG0Oxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:53:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:59456 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhG0Oxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:53:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="298036781"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="298036781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 07:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="416901405"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2021 07:53:42 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.160])
        by linux.intel.com (Postfix) with ESMTP id EAA3A58086A;
        Tue, 27 Jul 2021 07:53:41 -0700 (PDT)
Message-ID: <00527c09b0d4f22652f9cd5c2fde4e091df2d610.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86/intel: Move Intel PMT drivers to new
 subfolder
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Joe Perches <joe@perches.com>, hdegoede@redhat.com,
        mgross@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Tue, 27 Jul 2021 07:53:41 -0700
In-Reply-To: <45ccb9e8c610678e72f461b1e9d61de0a4c9bc79.camel@perches.com>
References: <20210727022550.3083745-1-david.e.box@linux.intel.com>
         <45ccb9e8c610678e72f461b1e9d61de0a4c9bc79.camel@perches.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-26 at 20:36 -0700, Joe Perches wrote:
> On Mon, 2021-07-26 at 19:25 -0700, David E. Box wrote:
> > Move all Intel Platform Monitoring Technology drivers to
> > drivers/platform/x86/intel/pmt.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -9494,7 +9494,7 @@ INTEL PMT DRIVER
> >  M:     "David E. Box" <david.e.box@linux.intel.com>
> >  S:     Maintained
> >  F:     drivers/mfd/intel_pmt.c
> > -F:     drivers/platform/x86/intel_pmt_*
> > +F:     drivers/platform/x86/intel/pmt/*
> 
> Unless you are suggesting you are not maintainer of any files
> in any subdirectories below this directory, you should not use
> a *
> 
> F:      drivers/platform/x86/intel/pmt/

Ack

> 
> > diff --git a/drivers/platform/x86/intel/Makefile
> > b/drivers/platform/x86/intel/Makefile
> []
> > @@ -7,3 +7,4 @@
> >  obj-$(CONFIG_INTEL_CHT_INT33FE)                += int33fe/
> >  obj-$(CONFIG_INTEL_SKL_INT3472)                += int3472/
> >  obj-$(CONFIG_INTEL_PMC_CORE)           += pmc/
> > +obj-y                                  += pmt/
> 
> This seems odd.  Perhaps:
> 
> obj-$(CONFIG_PMT_CLASS)                         += pmt/

This would work.

Thanks


