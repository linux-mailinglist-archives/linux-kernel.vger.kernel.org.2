Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB33E91BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhHKMlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:41:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:55612 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhHKMlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:41:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="215140331"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="215140331"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 05:41:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506927791"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 05:41:17 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mDnXi-007p9m-O4; Wed, 11 Aug 2021 15:41:10 +0300
Date:   Wed, 11 Aug 2021 15:41:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 00/20] Move Intel platform drivers to intel directory to
 improve readability.
Message-ID: <YRPFZsimSiSfLWqK@smile.fi.intel.com>
References: <20210810095832.4234-1-hpa@redhat.com>
 <CAHp75Vde0yWoKh4KOP46iwXK6SBAcw1Y7Snw4PWoi1HRspHJDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vde0yWoKh4KOP46iwXK6SBAcw1Y7Snw4PWoi1HRspHJDQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 04:23:57PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 10, 2021 at 4:20 PM Kate Hsuan <hpa@redhat.com> wrote:
> >
> > All the intel platform specific drivers are moved to intel/.
> > It makes more clear file structure to improve the readability.
> 
> Thanks for doing this!
> I'll review it later on (this or next week), meanwhile can you rebase
> it on top of PDx86 for-next?

Okay, most of the basic comments were given by a few people already, I'll wait
for v2.


-- 
With Best Regards,
Andy Shevchenko


