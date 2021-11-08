Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5630D447CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhKHJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:39:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:2250 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236824AbhKHJjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:39:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="293025770"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="293025770"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 01:36:36 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="469551440"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 01:36:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mk14f-004ccS-Di;
        Mon, 08 Nov 2021 11:36:21 +0200
Date:   Mon, 8 Nov 2021 11:36:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v13] tty: Fix the keyboard led light display problem
Message-ID: <YYjvlb0taamSTElN@smile.fi.intel.com>
References: <20211108054510.4680-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108054510.4680-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:45:10PM +0800, lianzhi chang wrote:
> Switching from the desktop environment to the tty environment,
> the state of the keyboard led lights and the state of the keyboard
> lock are inconsistent. This is because the attribute kb->kbdmode
> of the tty bound in the desktop environment (Xorg) is set to
> VC_OFF, which causes the ledstate and kb->ledflagstate
> values of the bound tty to always be 0, which causes the switch
> from the desktop When to the tty environment, the LED light
> status is inconsistent with the keyboard lock status.
> In order to ensure that the keyboard LED lights are displayed
> normally during the VT switching process, when the VT is
> switched, the current VT LED configuration is forced to be issued.

...

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Shouldn't be here. I haven't suggested the current implementation.
What I had done is proposed changes to one of the previous versions
which was wrong from design perspective and got rejected.

...

> +	/* Xorg will bind a tty, the kb->kbdmode of this tty will be set to 
> +	 * VC_OFF, and this tty will no longer set the keyboard light. If 
> +	 * there is no such restriction, when switching from other tty to 
> +	 * Xorg-bound tty, the tty will set the keyboard light, which is 
> +	 * unreasonable
> +	 */

trailing whitespaces. Had you run checkpatch?
Even Git warns about them when you do `git commit ...`


-- 
With Best Regards,
Andy Shevchenko


