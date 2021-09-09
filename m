Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3384044E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350702AbhIIFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350703AbhIIFU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E43C61139;
        Thu,  9 Sep 2021 05:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631164787;
        bh=B4SAHApMAPHV+o8srC8bZZpT4//0AtT8m/RZFLiyaRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHJrqFkZRuypi27v5wVFXNpmTNv75JMrJF2rODli0iDaH1xqgvAYb38+zL57xhjka
         612kZDf0KZqLG0y5LUzAFBjm+mNmh3L/dHnz/Ulv5xmEbD1d3C+YZnW4yIn6RBT0Ee
         1IHEraEKSCTqYCbYr2wKFt/j+UTHZyxdNp3IE3ak=
Date:   Thu, 9 Sep 2021 07:19:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Yu, Lang" <Lang.Yu@amd.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Message-ID: <YTmZXU7myBFjx8/y@kroah.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
 <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi0xkTVYqUpKXSt@kroah.com>
 <DM6PR12MB4250080A69BD3E2DB0050273FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi/UxFCYKqdT34L@kroah.com>
 <DM6PR12MB425003383BBF9FB949D48B0FFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB425003383BBF9FB949D48B0FFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 03:33:51PM +0000, Yu, Lang wrote:
> >Please feel free to add better documentation for the functions if you feel people
> >are getting confused, do not change the existing behavior of the code as it rightly
> >caught it being misused.
> 
> You can find many patches named "convert sysfs scnprintf/snprintf to syfs_emit/sysfs_emit_at".
> or "use sysfs_emit/sysfs_emit_at in show functions". They may think it's better to use syfs_emit/sysfs_emit_at
> given its overrun avoidance.

Yes, and using that in sysfs functions is fine, there is nothing wrong
with this usage.

> But there are still some corner cases(e.g., a non page boundary aligned buf address : ).

I need a specific example of where this has gone wrong.  Please provide
a lore.kernel.org link as I fail to see the problem here.

Are you sure that you are not just abusing sysfs and having more than
one value per file?  Does this mean I need to go audit all of the gpu
sysfs file entries?

thanks,

greg k-h
