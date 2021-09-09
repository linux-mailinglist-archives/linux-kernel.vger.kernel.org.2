Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF87D40455F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351024AbhIIGGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhIIGGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAAF161179;
        Thu,  9 Sep 2021 06:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631167521;
        bh=+J4KXjBeG3cAtBstnQyJvR39htCdgo/LRw5guWIeF9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV15742uImo5txCs9urHsllg1qEkqhE26niC0ZUGAnvsHV+9O486KrEZLM0Uts8//
         4HxCGHYy2+XZJGev7MFI8QzDWS1eXl52KM0aBdVriYUK09hXbnC/l9zeC8sjgms6xe
         cMmk8njji8/Tf3rivsNI9C1qyS4G9dd42Rd4b+pY=
Date:   Thu, 9 Sep 2021 08:05:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Yu, Lang" <Lang.Yu@amd.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Message-ID: <YTmkHlzW8yfx9VGg@kroah.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
 <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi0xkTVYqUpKXSt@kroah.com>
 <DM6PR12MB4250080A69BD3E2DB0050273FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi/UxFCYKqdT34L@kroah.com>
 <DM6PR12MB425003383BBF9FB949D48B0FFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTmZXU7myBFjx8/y@kroah.com>
 <DM6PR12MB4250DD8FBA99A7F78B247B17FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4250DD8FBA99A7F78B247B17FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 05:31:40AM +0000, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
> >-----Original Message-----
> >From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Sent: Thursday, September 9, 2021 1:19 PM
> >To: Yu, Lang <Lang.Yu@amd.com>
> >Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
> >linux-kernel@vger.kernel.org
> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs_emit
> >and sysfs_emit_at
> >
> >On Wed, Sep 08, 2021 at 03:33:51PM +0000, Yu, Lang wrote:
> >> >Please feel free to add better documentation for the functions if you
> >> >feel people are getting confused, do not change the existing behavior
> >> >of the code as it rightly caught it being misused.
> >>
> >> You can find many patches named "convert sysfs scnprintf/snprintf to
> >syfs_emit/sysfs_emit_at".
> >> or "use sysfs_emit/sysfs_emit_at in show functions". They may think
> >> it's better to use syfs_emit/sysfs_emit_at given its overrun avoidance.
> >
> >Yes, and using that in sysfs functions is fine, there is nothing wrong with this
> >usage.
> >
> >> But there are still some corner cases(e.g., a non page boundary aligned buf
> >address : ).
> >
> >I need a specific example of where this has gone wrong.  Please provide a
> >lore.kernel.org link as I fail to see the problem here.
> >
> >Are you sure that you are not just abusing sysfs and having more than one value
> >per file?  Does this mean I need to go audit all of the gpu sysfs file entries?
> >
> Indeed, the one value per file rule was broken... Thanks.  

Great, which file is that so we can fix it!

thanks,

greg k-h
