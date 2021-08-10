Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE73E5B95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbhHJN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:28:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:16224 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235376AbhHJN2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:28:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214886544"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="214886544"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 06:27:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="506142307"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 06:27:42 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mDRn5-007PyS-SM; Tue, 10 Aug 2021 16:27:35 +0300
Date:   Tue, 10 Aug 2021 16:27:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 09/20] Move Intel SCU IPC of pdx86 to intel directory to
 increase readability.
Message-ID: <YRJ+x7s+xYgzme/w@smile.fi.intel.com>
References: <20210810095832.4234-1-hpa@redhat.com>
 <20210810095832.4234-10-hpa@redhat.com>
 <YRJPebbK3uQBU9K8@lahna>
 <CAEth8oE5we991RS12AJdFHtfD4kJkzFd4A0wHdEFKkX-i6kmvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEth8oE5we991RS12AJdFHtfD4kJkzFd4A0wHdEFKkX-i6kmvg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:43:42PM +0800, Kate Hsuan wrote:
> Hi Mika,
> 
> Thanks for your suggestion.
> I'll add them to the patches and resend them again.
> 
> Thank you.

Please, do not top post!

> On Tue, Aug 10, 2021 at 6:06 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > No objections, I think this is good idea but..
> >
> > On Tue, Aug 10, 2021 at 05:58:21PM +0800, Kate Hsuan wrote:
> >
> > .. I suggest to add proper commit message here. Many maintainers ignore
> > patches that don't have one.

> > >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipc.c (100%)
> > >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipcutil.c (100%)
> > >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_pcidrv.c (100%)
> > >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_pltdrv.c (100%)
> > >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_wdt.c (100%)

Besides what Mika said this should follow the example of pmt, like dropping the
intel_scu prefix from the files, but leave it for the module (see Makefile
tricks for the details how to achieve this).

-- 
With Best Regards,
Andy Shevchenko


