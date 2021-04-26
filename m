Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD136B75B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhDZRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235067AbhDZRAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:00:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 677606127A;
        Mon, 26 Apr 2021 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456361;
        bh=vkIXwAvhXeP7A/ILcKXnyobXvOOAIZBC0XwkfagEdyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqEVRJYSiqO7EU6IfsQg8rhgShjQVz9pz/D4//T+6i7UznmMiCLWlveLRURumKaIZ
         g29ES5jlEi5u/vyxI6bLJMjRJouo4L+BmdZLp4UHfACz0q3XgCkXaX5Xl3RrainWg4
         O9UzXYYKWVkXtr+qiPi0nzjWx7Zu4WkgiQmemQxA=
Date:   Mon, 26 Apr 2021 18:59:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 089/190] Revert "PCI: endpoint: Fix a potential NULL
 pointer dereference"
Message-ID: <YIbxZuKsVFrFh9GX@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-90-gregkh@linuxfoundation.org>
 <20210422093111.GA20094@lpieralisi>
 <YIFEhR2r9rF1m779@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFEhR2r9rF1m779@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:40:21AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 22, 2021 at 10:31:11AM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Apr 21, 2021 at 02:59:24PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 507b820009a457afa78202da337bcb56791fbb12.
> > > 
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > 
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > > 
> > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > Cc: commit log and code update]
> > 
> > Hi Greg,
> > 
> > first off, thank you for doing this.
> > 
> > This Cc should be fixed up if we go ahead with the revert (I can
> > take the revert via the PCI tree and fix it up myself).
> > 
> > I totally understand your concern (and the nuisance it is causing), the
> > commit we are reverting looked and looks legit - just let me know
> > how it is best to handle this please.
> 
> I'll fix up all improper Cc: lines, that was my dumb script trying to
> catch who was on the reverted patch, when I apply these.
> 
> I can take this through my tree, but as you said, if the original commit
> here really is fine, that's great, I'll drop this.

Now dropped from my tree.

greg k-
