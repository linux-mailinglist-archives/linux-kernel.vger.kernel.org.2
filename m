Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B432D317
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbhCDMcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:32:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:64847 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240760AbhCDMcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:32:09 -0500
IronPort-SDR: lOpvsh/+pV53UMz3o2yG/WNaMKW5x4AUeTpToiMvqqEhjClm0cNvInu+QzzqlKQJtoKRFvDs1U
 x4OA2YkoChpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166662527"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="166662527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 04:30:22 -0800
IronPort-SDR: OWSWa6ogXrvPlRkhxzoLRrtsDChwVgiPtl8arRcm6dBFZlYospEObzKBpa8eEUV9O+6UnB7gIu
 frS8+tu3N0Xg==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="400589553"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 04:30:21 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHn7R-009sL0-Mn; Thu, 04 Mar 2021 14:30:17 +0200
Date:   Thu, 4 Mar 2021 14:30:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Wang <li.wang@windriver.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] vt: keyboard, fix uninitialized variables warning
Message-ID: <YEDS2QQLrqeSuG6D@smile.fi.intel.com>
References: <2973260e-2405-5a70-f9bd-398d3d45346e@windriver.com>
 <1614827448-1594-1-git-send-email-li.wang@windriver.com>
 <YEDSh/1OScaKWdxL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEDSh/1OScaKWdxL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 02:28:55PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 04, 2021 at 11:10:48AM +0800, Li Wang wrote:
> > drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
> > drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   return ret;
> >          ^~~
> > drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   kfree(kbs);
> 
> 
> Let me add one more comment and summarize altogether:
>  - Jiri wants you to have different error code
>  - Greg (and I noticed that as well) wants you to add a proper commit message,
>    and not just some output of some tool w/o context
>  - I want you to send a new version w/o chaining to the previous thread, so
>    start new (email) thread every time you send a new version
> 
> Waiting for v3 in a separate email thread, thanks!

Last, but not least: add a changelog after the cutter '---' line, so people will know what have you done on the transition from vX to vX+1.

-- 
With Best Regards,
Andy Shevchenko


