Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F032D30E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbhCDMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:31:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:18161 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240690AbhCDMap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:30:45 -0500
IronPort-SDR: kVUbQgYH6vP8kMpbk5XclbFBC8QJJnj78POVUL5614CUmEPRjZLFbNWr2B4PQWcY2LI3ljN+rl
 uk0ewTKg+m+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187514364"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="187514364"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 04:29:00 -0800
IronPort-SDR: MyS1qiuVVBjxMKRHGD1qN/AzpGStmhOW1+wRiEdy19s5EZwkRQHLdbawfQn6j3sNCeccAp1x+R
 lrnzhnQAwa3g==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507365205"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 04:28:58 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHn67-009sKA-MJ; Thu, 04 Mar 2021 14:28:55 +0200
Date:   Thu, 4 Mar 2021 14:28:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Wang <li.wang@windriver.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] vt: keyboard, fix uninitialized variables warning
Message-ID: <YEDSh/1OScaKWdxL@smile.fi.intel.com>
References: <2973260e-2405-5a70-f9bd-398d3d45346e@windriver.com>
 <1614827448-1594-1-git-send-email-li.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614827448-1594-1-git-send-email-li.wang@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:10:48AM +0800, Li Wang wrote:
> drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
> drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   return ret;
>          ^~~
> drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   kfree(kbs);


Let me add one more comment and summarize altogether:
 - Jiri wants you to have different error code
 - Greg (and I noticed that as well) wants you to add a proper commit message,
   and not just some output of some tool w/o context
 - I want you to send a new version w/o chaining to the previous thread, so
   start new (email) thread every time you send a new version

Waiting for v3 in a separate email thread, thanks!

-- 
With Best Regards,
Andy Shevchenko


