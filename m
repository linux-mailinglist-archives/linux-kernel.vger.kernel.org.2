Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF143204DC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBTJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhBTJyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:54:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F79164E5F;
        Sat, 20 Feb 2021 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613814818;
        bh=dl+774fHGcdbyVH5z3OnYGxYc2gP7or+T1gxqvYCCQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h26+tNl4jVFe+2uE+m2kokFDl9fwB80U4GuLa2wYdwGZj+kzb6X5TksBTkg1pLNps
         nWyc4G2ZK6X33ZeYajAGyxEybTrtPBDVb6LFkZVfrKleWa7moXfgLHseKl1DIsaRk1
         Lk9nav4HgwUkrGQpvyVXRGbUTX/Na5VL5WPJjgeY=
Date:   Sat, 20 Feb 2021 10:53:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PEIXIN HOU <PEIXIN.HOU@huawei.com>,
        Yanjin <yanjin.yan@huawei.com>,
        "Zhangdianfang (Dianfang, OS Lab)" <zhangdianfang@huawei.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>,
        Huxinwei <huxinwei@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YDDcHpmAWmzQcStD@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
 <YC+AEcuXhPXXtmRB@kroah.com>
 <a0e56fe4-8e85-d8c7-ed63-7a96c0944aaf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e56fe4-8e85-d8c7-ed63-7a96c0944aaf@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 03:02:54PM +0800, Hanjun Guo wrote:
> On 2021/2/19 17:08, Greg Kroah-Hartman wrote:
> > On Fri, Feb 19, 2021 at 04:54:24PM +0800, Hanjun Guo wrote:
> > > Hi Greg,
> > > 
> > > On 2021/1/26 15:29, Greg Kroah-Hartman wrote:
> > > [...]
> > > > 
> > > > I want to see companies _using_ the kernel, and most importantly,
> > > > _updating_ their devices with it, to know if it is worth to keep around
> > > > for longer than 2 years.  I also, hopefully, want to see how those
> > > > companies will help me out in the testing and maintenance of that kernel
> > > > version in order to make supporting it for 6 years actually possible.
> > > > 
> > > > So, are you planning on using 5.10?  Will you will be willing to help
> > > > out in testing the -rc releases I make to let me know if there are any
> > > > problems, and to help in pointing out and backporting any specific
> > > > patches that your platforms need for that kernel release?
> > > 
> > > We(Huawei) are willing to commit resources to help out in testing the
> > > stable -rc releases, and to help to backport patches for stable kernels.
> > 
> > Wonderful!
> > 
> > > 5.10 stable kernel will be used for openEuler [1] kernel and also inside
> > > Huawei. From customer's feedback, it's very important to see the stable
> > > kernel we used to be maintained for 6 years in the community, and we
> > > will use 5.10 kernel for at least 6 years, so we are willing to help
> > > you and help ourselves :)
> > > 
> > > In specific, we will start from the testing work, using HULK robot
> > > (reports lots of bugs to mainline kernel) testing framework to test
> > > compile, reboot, functional testing, and will extend to basic
> > > performance regression testing in the future.
> > 
> > Great!  Do you all need an email notification when the -rc releases come
> > out for the stable trees, or can you trigger off of the -rc stable git
> > tree?  Different CI systems work in different ways :)
> 
> We can trigger the test when you updated the -rc stable git tree,
> by monitoring new commits for the stable branches. So if you push
> all the commits at once for -rc stable branches, then our CI system
> can work well.

I do push to the -rc branches, but those branches are rebased, and I do
"intermediate" pushes as well.  Meaning I push to have CI systems run on
the existing patch queue at times that are not only the "main" -rc
release periods.

Watch the branches for a few weeks to get an idea of how they work if
you are curious.

> > And if you can reply to the -rc release emails with a "Tested-by:" tag,
> > I will be glad to add that to the release commit when that happens to
> > show that you all have tested the release.
> 
> Thanks, will reply "Tested-by:" with -rc releases. We are working on
> setting up the test farm and will report the test results in a week.

Great, thanks!

greg k-h
