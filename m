Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4673533240D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCIL25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:28:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:25331 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCIL2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:28:24 -0500
IronPort-SDR: KSVuzFdphFmLRYJQX7IlX3uVqJQCEPF0YjXzZfvqRReRozzQms0HCt88FSqeGC2MG7gAXJkDAv
 o1ecn9PEonow==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273241164"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="273241164"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 03:28:24 -0800
IronPort-SDR: 3GlejSP8yiKyH1HqVrLZz6II0OF0IB2bYYuU+h5mQXd0jz8begLZCd/1eXuCQUzmSijMnC/ZDa
 esqJjBG0kQxg==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="386196367"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 03:28:22 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJaXD-00B2sa-Og; Tue, 09 Mar 2021 13:28:19 +0200
Date:   Tue, 9 Mar 2021 13:28:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/7] pps: clients: gpio: Bail out on error when
 requesting GPIO echo line
Message-ID: <YEdb0z/SJLknJlrp@smile.fi.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
 <YDkp5Jh8ZXWgr+zl@smile.fi.intel.com>
 <YEdSVD+hU+Il5W/7@smile.fi.intel.com>
 <ca333fca-e2d2-c2fd-fa4f-8238ccef1be1@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca333fca-e2d2-c2fd-fa4f-8238ccef1be1@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 11:51:58AM +0100, Rodolfo Giometti wrote:
> On 09/03/21 11:47, Andy Shevchenko wrote:
> > +Cc: Greg
> > 
> > On Fri, Feb 26, 2021 at 07:03:32PM +0200, Andy Shevchenko wrote:
> >> On Tue, Feb 16, 2021 at 01:31:48PM +0200, Andy Shevchenko wrote:
> >>> When requesting optional GPIO echo line, bail out on error,
> >>> so user will know that something wrong with the existing property.
> >>
> >> Guys, any comments on this series?
> > 
> > Greg, seems PPS maintainer keeps silent, can I route this series thru one of
> > yours tree (resend implied)?
> 
> I'm sorry but I suppose I missed this patch... -_-'

Entire series (7 patches) has been Cc'ed to you :-)

> Can you please resend it to me?

Okay, I will resend with Greg included just in case.

Done!

For the future, I recommend to switch to b4 tool (most likely already in your
Linux distribution), so

0/ Install b4 tool (if not yet in distro: `pip install b4` should work)
1/ Find message ID for the thread, for example,
	20210216113154.70852-1-andriy.shevchenko@linux.intel.com (v1)
	20210309112403.36633-1-andriy.shevchenko@linux.intel.com (v1 resend)

2/ `b4 am -s $MESSAGE_ID`, replace $MESSAGE_ID with one of the above
3/ it will download a mailbox that you may apply with `git am ...`

-- 
With Best Regards,
Andy Shevchenko


