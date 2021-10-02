Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0341FB9B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhJBMJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:09:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:28615 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233042AbhJBMJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:09:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205832693"
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="205832693"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 05:07:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="710684189"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 05:07:52 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWdnx-007ieX-CL;
        Sat, 02 Oct 2021 15:07:49 +0300
Date:   Sat, 2 Oct 2021 15:07:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N
 UART
Message-ID: <YVhLlemYolQg44Uh@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
 <YVdP9PwNrjmKxKac@google.com>
 <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
 <20211002032810.3729-1-redecorating@protonmail.com>
 <YVg8vsdU89wjC9/7@smile.fi.intel.com>
 <20211002111221.1c3076f3@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002111221.1c3076f3@localhost>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2021 at 11:12:26AM +0000, Orlando Chamberlain wrote:
> On Sat, 02 Oct 2021 21:04:30 +1000
> "Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:

...

> > Besides that you are posting patches as continuation of the thread.
> > It may be problematic for some tools, like `b4`, although I dunno if
> > Lee is using such tools.
> 
> I'll make a v4 with the reviewed-by line. I'll make it a reply to the
> first version of the patch, and hopefully that'll be the first place
> tools like `b4` look.

Just make sure that you have --thread _disabled_ by default.
Linking to an (existing) thread, to whatever the point in it,
is still problematic.

(I dunno if you need to send a v5 because of that, I hope it's not needed)

-- 
With Best Regards,
Andy Shevchenko


