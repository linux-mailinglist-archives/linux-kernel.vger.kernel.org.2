Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027BA3DB96C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbhG3Nhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239007AbhG3Nh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:37:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 267C460EFF;
        Fri, 30 Jul 2021 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627652243;
        bh=uLZFMYInw+yxWqWg50OgHWU7KJcnzhlQUZPIzJzg4iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YL7T6ymVdHKNifWkmWLVVHb/Bie3x0Pgs2Y2skNBkWhWLWDggIZYnTLOc1Ej7EG12
         dQihKS7OJZhxCDX+w+4TDmOG6p7tQuBlHtatns6+XDqdPn4P+fYDib89827GDr2Rld
         TYM9g+99qPrKohQI6PKSUp8HCWna4wmxs4xlQS6U=
Date:   Fri, 30 Jul 2021 15:37:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "qiaoyanbo_310@163.com" <qiaoyanbo_310@163.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] kobject: kobject_add_internal cleanup
Message-ID: <YQQAkfGXjdDc/3na@kroah.com>
References: <20210727143212.39142-1-qiaoyanbo_310@163.com>
 <YQEtJkPFDWMSAd/C@kroah.com>
 <3be7ce57.62f6.17af280a47f.Coremail.qiaoyanbo_310@163.com>
 <YQK0JuI1w1zsEHeC@kroah.com>
 <54cc7e43.808a.17af32725d9.Coremail.qiaoyanbo_310@163.com>
 <YQOEl0SQY/WpE1dK@kroah.com>
 <YQP04FoSecPhI+38@ybqiao-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQP04FoSecPhI+38@ybqiao-virtual-machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 08:47:28PM +0800, qiaoyanbo_310@163.com wrote:
> On Fri, Jul 30, 2021 at 06:48:23AM +0200, Greg KH wrote:
> > On Fri, Jul 30, 2021 at 12:44:26AM +0800, qiaoyanbo_310 wrote:
> > > Hi Greg KH,
> > 
> > Sorry, but html email is rejected by the mailing lists.  Please try
> > again after fixing up your email client, and I will be glad to respond.
> > 
> > thanks,
> > 
> > greg k-h
> 
> (Sorry, this is the first time I use the mutt environment to send mail,
> 	shamed on me I know~)
> 
> >Why is this a problem?  What bug is this solving?  Is the code somehow
> >now faster or smaller that can be measured? 
> 
> I don't think the logic of the original code is self consistent.

I no longer even remember what the patch was anymore here, sorry.
That's the problem when emails are not quoted properly :(

> This is not a bug,  but it causes  some unnecessary assignment operations.

Are you sure?  What would set the kobject parent to NULL then?

> This patch is to clean unnecessary assignment operations.

Are you sure there is anything unneeded?  Have you measured the
performance issues here?  What benchmark is affected by this?

thanks,

greg k-h
