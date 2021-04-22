Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F194367DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhDVJlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235637AbhDVJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:40:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 503C761459;
        Thu, 22 Apr 2021 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619084424;
        bh=hg2LKfc0Wyi7b7Ehdw1UWWlNhpK1vldYp00YBAMkjtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1N2LBNqIxAGfxahHWPJ3ommqi5jNoIoCKtPmxXC98Wn8yhFSJs9uo3EToRi7iSIlG
         jMbsg8ch+/qXLBq2ghUvqSyxVU5RvJkHEscxAD8wnTv05mvIsZ+nHRV53hTT4KEHpX
         xE2i+Ts23ePsEhY/3AJjCRxU2BxXxGehbNvtURZY=
Date:   Thu, 22 Apr 2021 11:40:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 089/190] Revert "PCI: endpoint: Fix a potential NULL
 pointer dereference"
Message-ID: <YIFEhR2r9rF1m779@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-90-gregkh@linuxfoundation.org>
 <20210422093111.GA20094@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422093111.GA20094@lpieralisi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:31:11AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Apr 21, 2021 at 02:59:24PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 507b820009a457afa78202da337bcb56791fbb12.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: commit log and code update]
> 
> Hi Greg,
> 
> first off, thank you for doing this.
> 
> This Cc should be fixed up if we go ahead with the revert (I can
> take the revert via the PCI tree and fix it up myself).
> 
> I totally understand your concern (and the nuisance it is causing), the
> commit we are reverting looked and looks legit - just let me know
> how it is best to handle this please.

I'll fix up all improper Cc: lines, that was my dumb script trying to
catch who was on the reverted patch, when I apply these.

I can take this through my tree, but as you said, if the original commit
here really is fine, that's great, I'll drop this.

Thanks for the review!

greg k-h
