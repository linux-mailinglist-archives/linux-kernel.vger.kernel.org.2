Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32E432BD4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449698AbhCCPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:44:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:20459 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237782AbhCCKxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:53:15 -0500
IronPort-SDR: pfCIaL200cCy0si9yOiesnfVXT+Gu920zQdrPNS9A7mAbYT7qe+6WBh46IX66ahqp3V7gxfmW/
 pHSblEyfMXfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="187255287"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="187255287"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:24:29 -0800
IronPort-SDR: /SXYgLE/JxxIR7g+UJMSVtdL8YUFNeDan3/3G1r7Ry5hUeaSLrkyyelVLnigKdaqgx6Dguk3mC
 yUwlhWOUH/PQ==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383902890"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:24:28 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHMnx-009amt-Bb; Wed, 03 Mar 2021 10:24:25 +0200
Date:   Wed, 3 Mar 2021 10:24:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Wang, Li" <li.wang@windriver.com>, jirislaby@kernel.org,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: keyboard, fix uninitialized variables warning
Message-ID: <YD9HufAwwxK2jZwD@smile.fi.intel.com>
References: <1614747572-3295-1-git-send-email-li.wang@windriver.com>
 <YD83RFqtKVB2pA9H@kroah.com>
 <5f05c3c2-6c72-140f-fd56-cd9ec1c7c4a1@windriver.com>
 <YD89HVVBREVdqdpJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD89HVVBREVdqdpJ@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:39:09AM +0100, Greg KH wrote:
> On Wed, Mar 03, 2021 at 03:33:23PM +0800, Wang, Li wrote:
> > On 3/3/2021 3:14 PM, Greg KH wrote:
> > > On Wed, Mar 03, 2021 at 12:59:32PM +0800, Li Wang wrote:
> > > > drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
> > > > drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >    return ret;
> > > >           ^~~
> > > > kernel-source/drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >    kfree(kbs);
> > > >    ^~~~~~~~~~
> > > > 
> > > > Signed-off-by: Li Wang <li.wang@windriver.com>
> > > > ---
> > > >   drivers/tty/vt/keyboard.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > > > index 7763862..3e73d55 100644
> > > > --- a/drivers/tty/vt/keyboard.c
> > > > +++ b/drivers/tty/vt/keyboard.c
> > > > @@ -2049,8 +2049,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> > > >   {
> > > >   	unsigned char kb_func;
> > > >   	unsigned long flags;
> > > > -	char *kbs;
> > > > -	int ret;
> > > > +	char *kbs = NULL;
> > > > +	int ret = -EINVAL;
> > > >   	if (get_user(kb_func, &user_kdgkb->kb_func))
> > > >   		return -EFAULT;
> > > What compiler is providing these "warnings"?
> > > 
> > > Turns out it is impossible to hit, so this isn't actually fixing
> > > anything...
> > 
> > I tested it with gcc 8.2 for arm
> > 
> > for runtime codes view, indeed it is impossible to hit.
> > 
> > but for compiler view, gcc should give 'used uninitialized' warning, too.
> 
> Odd that no other compiler version does this right now, perhaps upgrade
> to a newer version of gcc?  8.2 is really old :(

But it's still supported. I think I can see why. We have a switch case without
default, and probably that's how it makes that happen. So, the proper fix is to
add default section AFAICT.

-- 
With Best Regards,
Andy Shevchenko


