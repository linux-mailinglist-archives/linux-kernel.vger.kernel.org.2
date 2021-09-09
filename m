Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D3C404563
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351073AbhIIGIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhIIGIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:08:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 159A560F93;
        Thu,  9 Sep 2021 06:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631167624;
        bh=9i2Chwy6de5kZM0pywnyVGyryhp6TXpufvUJ9hDVQ6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgSUaWubIQIGFahrkP87ELgtGNFeS3iDgNMDJ1s/0zk1WmT2rwz/lcTGSDL2A1vM2
         crwCECRHno6FIDzGCLUtYePQOFXLC0d779vnUj1eA+mh1Je5kBFNd0jSOS7aRym/iN
         9Ql5YZHTPrWq9gmtQxtzOLep1p/SYIm9kPkrGYz0=
Date:   Thu, 9 Sep 2021 08:07:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Yu, Lang" <Lang.Yu@amd.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Message-ID: <YTmkhpB0mFW0RFum@kroah.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
 <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTmc53ZPdDfC4+lz@kroah.com>
 <DM6PR12MB4250436AA392855E4C901A3CFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4250436AA392855E4C901A3CFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 05:59:01AM +0000, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
> >-----Original Message-----
> >From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Sent: Thursday, September 9, 2021 1:35 PM
> >To: Yu, Lang <Lang.Yu@amd.com>
> >Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
> >linux-kernel@vger.kernel.org
> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs_emit
> >and sysfs_emit_at
> >
> >On Thu, Sep 09, 2021 at 05:27:49AM +0000, Yu, Lang wrote:
> >>
> >>
> >>
> >> >-----Original Message-----
> >> >From: Joe Perches <joe@perches.com>
> >> >Sent: Thursday, September 9, 2021 1:06 PM
> >> >To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
> >> ><gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>;
> >> >linux- kernel@vger.kernel.org
> >> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
> >> >sysfs_emit and sysfs_emit_at
> >> >
> >> >On Wed, 2021-09-08 at 20:07 +0800, Lang Yu wrote:
> >> >> The key purpose of sysfs_emit and sysfs_emit_at is to ensure that
> >> >> no overrun is done. Make them more equivalent with scnprintf.
> >> >
> >> >I can't think of a single reason to do this.
> >> >sysfs_emit and sysfs_emit_at are specific to sysfs.
> >> >
> >> >Use of these functions outside of sysfs is not desired or supported.
> >> >
> >> >
> >> Thanks for your reply. But I'm still curious why you put such a limitation.
> >> As "Documentation/filesystems/sysfs.rst" described, we can just  use
> >> scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show functions without
> >> such a limitation.
> >>
> >> But you said that " - show() should only use sysfs_emit() or
> >> sysfs_emit_at() when formatting the value to be returned to user space. " in
> >Documentation/filesystems/sysfs.rst.
> >>
> >> Some guys just try to replace scnprintf with sysfs_emit() or sysfs_emit_at() per
> >above documents.
> >
> >That is just fine in sysfs show() functions.
> >
> >> But sprintf and sysfs_emit/sysfs_emit_at are not totally equivalent(e.g., page
> >boundary align).
> >
> >Which is good, it checks for more error conditions.
> >
> >I fail to understand what problem you have had with this.  What sysfs file was
> >converted and had issues?
> >
> >> In my opinion, we add a new api and try to replace an old api. Does we
> >> need to make it more compatible with old api? Thanks.
> >
> >There is no "old api" here.  People used a wide variety of different things in sysfs
> >file show() functions, now you can just use a single one.
> 
> Yes, replace these things in sysfs show functions to avoid sprintf defects makes life better. 
> But assume users will put a page boundary align buffer address in its' first argument makes life so hard.

Not at all, that is what sysfs requires.

As you have pointed out, someone violated the sysfs rules, and these
functions caught that, which shows that the code is correct and that the
driver needs to be fixed.

thanks,

greg k-h
