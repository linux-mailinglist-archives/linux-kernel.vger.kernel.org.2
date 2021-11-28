Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5246046E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 06:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhK1Fhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 00:37:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:36791 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhK1Ffk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 00:35:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="299208807"
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="299208807"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 21:32:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="458707260"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 21:32:25 -0800
Date:   Sat, 27 Nov 2021 21:32:24 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/auxiliary_bus: Clarify auxiliary_device
 creation
Message-ID: <20211128053224.GU3538886@iweiny-DESK2.sc.intel.com>
References: <87k0hq2oxc.fsf@meer.lwn.net>
 <20211102225310.3677785-1-ira.weiny@intel.com>
 <YaEIdmRV2A1yclub@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaEIdmRV2A1yclub@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:16:54PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 02, 2021 at 03:53:10PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The documentation for creating an auxiliary device is a 3 step not a 2
> > step process.  Specifically the requirements of setting the name, id,
> > dev.release, and dev.parent fields was not clear as a precursor to the '2
> > step' process documented.
> > 
> > Clarify by declaring this a 3 step process starting with setting the
> > fields of struct auxiliary_device correctly.
> > 
> > Also add some sample code and tie the change into the rest of the
> > documentation.
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V1:
> > 	From Jonathan
> > 		Fix auxiliary spelling
> > ---
> >  Documentation/driver-api/auxiliary_bus.rst | 77 +++++++++++++++++-----
> >  1 file changed, 59 insertions(+), 18 deletions(-)
> 
> Can you please resend the whole series, trying to just resend one patch
> in the middle is horrible for our tools and to try to figure this out.

Sorry I did not realize this was an issue.  Other maintainers have been ok with
this because I think B4 works fine with this?

> 
> Would you like to have to unwind this?  Please make it simple for
> maintainers to review and if ok, apply your changes.

Regardless, I was planning on resending this as part of the c files as you
requested before.  Did you still want me to make that conversion?

Or I can resend this and make the c conversion as a follow on patch?

Ira

> 
> thanks,
> 
> greg k-h
