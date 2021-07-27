Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58E53D7A50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhG0P6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhG0P6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:58:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B86C61B74;
        Tue, 27 Jul 2021 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627401527;
        bh=vUa6Jna0zUTd6Uw7Z4XNACsOiEzakenAQJAeppBnSXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ynqup3Z3gPkMsba2JDfWI8oyZ+MvFIL5skXhmgg/N/YS5WPhlIKLA4AG1Tv0D+4ZL
         V4XnScC2VZnI8GM5eLis2JS/nrBFoKHAzDOmbsXWGLMryjwCygF+DBFQP7Pz2QL/oY
         n41gcTiC5E/y//CoZSYOF/jhAClf7y0DC8DSzk0c=
Date:   Tue, 27 Jul 2021 17:58:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kernelci-members@groups.io
Cc:     "kernelci@groups.io" <kernelci@groups.io>,
        automated-testing@lists.yoctoproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci-tsc@groups.io" <kernelci-tsc@groups.io>
Subject: Re: [kernelci-members] KernelCI working group: Web Dashboard
Message-ID: <YQAtNc4R1K3o6rxb@kroah.com>
References: <f3874e7d-ccfe-4a2d-d054-9b7bf9e8b44d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3874e7d-ccfe-4a2d-d054-9b7bf9e8b44d@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 04:54:46PM +0100, Guillaume Tucker wrote:
> Last year's KernelCI Community Survey[1] showed the importance of
> having a good web dashboard.  About 70% of respondents would use
> one if it provided the information they needed efficiently.
> While other things are arguably even more important, such as
> testing patches from mailing lists, replying to stable reviews
> and sending email reports directly to contributors in a "natural"
> workflow, the web dashboard has been a sticking point for a
> while.
> 
> There have been several attempts at solving this problem, using
> Elastic Stack and Grafana among other things, but there isn't a
> single framework able to directly provide an off-the-shelf
> solution to the community's needs.  In fact, the first issue is
> the lack of understanding of these needs: who wants to use the
> web dashboard, and how?  Then, how does one translate those needs
> into a user interface?  Doing this requires skills that engineers
> who regularly contribute to KernelCI typically don't have.  As
> such, a dedicated working group is being created in order to fill
> this gap.
> 
> The aim is to coordinate efforts and try to follow best practices
> to make steady progress and avoid repeating the same mistakes.
> Most likely, we will need some help from proper web developers
> who aren't part of the usual KernelCI community.  This may be
> facilitated by the KernelCI LF project budget if approved by the
> governing board.
> 
> In order to get started, we would need to have maybe 3 to 5
> people available to focus on this.  It doesn't necessarily mean a
> lot of hours spent but actions to be carried out on a daily or
> weekly basis.  So far we have Gustavo Padovan as our new KernelCI
> Project Manager and a few people have expressed interest but we
> still need formal confirmation.
> 
> 
> Here's a GitHub project dedicated to the new web dashboard:
> 
>   https://github.com/orgs/kernelci/projects/4
> 
> I've created a couple of issues to get started about user
> stories, and some initial milestones as a basic skeleton:
> 
>   https://github.com/kernelci/kernelci-project/milestones
> 
> 
> This is ultimately a community-driven effort to address the needs
> of the kernel community.  Please share any thoughts you may have
> on this, whether you want to add some user stories, share some
> expertise, be officially in the working group or take part in
> this effort in any other way.

How do we "join" the working group?  I'm willing to help out from the
"user who will use this a lot and complain about things that do not
work well" point of view :)

thanks,

greg k-h
