Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221C5404566
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351202AbhIIGI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhIIGIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F228360F23;
        Thu,  9 Sep 2021 06:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631167666;
        bh=t0iK+sdxllEwEgBTPmQBM+xn0mJiwXrd0TpwzlGAz9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YI7oHCdsfQC7345VYcMaTLHggmFXs9JAVTp/AePcnmRBCe/9+ggUUy4EL8FZGlM4+
         GqBD+p+8ziz7JAizYyw6zKDDB4JDhWWzDtebzK8aaAClS0qwOUm611JxqSnXg0OfO2
         BFaqjPjrOmm9kH6Mr7N7zb4ohNin3L0uPqGGc56U=
Date:   Thu, 9 Sep 2021 08:07:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Yu, Lang" <Lang.Yu@amd.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Message-ID: <YTmksJ0Bq/fEmFQV@kroah.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
 <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <685524a360bc910210cbbb7b13a46ead26ed8a22.camel@perches.com>
 <DM6PR12MB4250AE8DF451484884B657C9FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4250AE8DF451484884B657C9FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 05:52:23AM +0000, Yu, Lang wrote:
> [Public]
> 
> 
> 
> >-----Original Message-----
> >From: Joe Perches <joe@perches.com>
> >Sent: Thursday, September 9, 2021 1:44 PM
> >To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
> ><gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>; linux-
> >kernel@vger.kernel.org
> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs_emit
> >and sysfs_emit_at
> >
> >On Thu, 2021-09-09 at 05:27 +0000, Yu, Lang wrote:
> >> [AMD Official Use Only]
> >
> >this is a public list and this marker is not appropriate.
> 
> Sorry for that.
> >
> >> > -----Original Message-----
> >> > From: Joe Perches <joe@perches.com>
> >> > On Wed, 2021-09-08 at 20:07 +0800, Lang Yu wrote:
> >> > > The key purpose of sysfs_emit and sysfs_emit_at is to ensure that
> >> > > no overrun is done. Make them more equivalent with scnprintf.
> >> >
> >> > I can't think of a single reason to do this.
> >> > sysfs_emit and sysfs_emit_at are specific to sysfs.
> >> >
> >> > Use of these functions outside of sysfs is not desired or supported.
> >> >
> >> Thanks for your reply. But I'm still curious why you put such a limitation.
> >> As "Documentation/filesystems/sysfs.rst" described, we can just  use
> >> scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show functions without
> >> such a limitation.
> >
> >There's nothing particularly wrong with the use of scnprintf as above.
> >
> >The only real reason that sysfs_emit exists is to be able to reduce the kernel
> >treewide quantity of uses of the sprintf family of functions that need to be
> >analyzed for possible buffer overruns.
> >
> >The issue there is that buf is already known to be both a PAGE_SIZE buffer and
> >PAGE_SIZE aligned for sysfs show functions so there's no real reason to use
> >scnprintf.
> >
> >sysfs_emit is a shorter/smaller function and using it could avoid some sprintf
> >defects.
> >
> >> Some guys just try to replace scnprintf with sysfs_emit() or sysfs_emit_at() per
> >above documents.
> >
> >So don't do that.
> >
> >> But sprintf and sysfs_emit/sysfs_emit_at are not totally equivalent(e.g., page
> >boundary align).
> >>
> >> In my opinion, we add a new api and try to replace an old api. Does we
> >> need to make it more compatible with old api?
> >
> >IMO: no.
> >
> But why you said " - show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space. " in Documentation/filesystems/sysfs.rst ?
> 
> Obviously, sysfs_emit() and sysfs_emit_at()  can't cover all the cases in show functions. 

Why not, what usage model can it not cover?

thanks,

greg k-h
