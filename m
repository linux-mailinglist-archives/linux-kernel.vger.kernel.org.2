Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65A36C825
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhD0O6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0O6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2987761131;
        Tue, 27 Apr 2021 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619535488;
        bh=7kiAK0hH+Ic9Dn5pkyTBq9Vmhy5TBHc/i5nANk+/S8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fA8tkl+Eqk9UKTB6NndeCJlOUT5UyoLaXqoRDs0UClBGeVlCgNEteg1wrIYzwCKeO
         ig4/CCRaeDiOVdwGmgFCzy46CW9rWnd63rK1p/Bg9t9M4HCuzNsCOjual/aJ/b7oK9
         rPtf/TT9hrYLVKN/diyg7nqSjUfUPhuBwlRzEHus=
Date:   Tue, 27 Apr 2021 16:58:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 053/190] Revert "ecryptfs: replace BUG_ON with error
 handling code"
Message-ID: <YIgmfj5C24bCfsap@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-54-gregkh@linuxfoundation.org>
 <YIBM8hiBLFO+JJr/@zeniv-ca.linux.org.uk>
 <20210421161329.GD4991@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421161329.GD4991@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:13:29AM -0500, Tyler Hicks wrote:
> On 2021-04-21 16:04:02, Al Viro wrote:
> > On Wed, Apr 21, 2021 at 02:58:48PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 2c2a7552dd6465e8fde6bc9cccf8d66ed1c1eb72.
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
> > 
> > FWIW, commit message on the original (
> > ecryptfs: replace BUG_ON with error handling code
> > 
> > In crypt_scatterlist, if the crypt_stat argument is not set up
> > correctly, the kernel crashes. Instead, by returning an error code
> > upstream, the error is handled safely.
> > 
> > The issue is detected via a static analysis tool written by us.
> > 
> > Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > Signed-off-by: Tyler Hicks <code@tyhicks.com>
> > )
> > really stinks.  First, the analysis: condition being tested is
> > (!crypt_stat || !crypt_stat->tfm
> >                || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
> > and their patch replaces BUG_ON() with return of -EINVAL.  So the
> > only thing their tool had detected the presence of BUG_ON().
> > Was it grep, by any chance?  
> > 
> > IOW, the commit message is "we'd found BUG_ON(); let's replace it
> > with returning some error value and hope everything works.  Whaddya
> > mean, how do we know?  Our tool [git grep BUG_ON, that is] says
> > it's there and look, it *is* there, so if it's ever reached there'll
> > be trouble.  What, assertion that returning an error will be handled
> > safely?   'Cuz we saiz so, that's why"
> > 
> > 
> > It *is* functionally harmless, AFAICS, but only because the condition
> > is really impossible.  However,
> > 	* it refers to vague (s)tool they'd produced, nevermind that
> > all they really do is "find BUG_ON(), replace with returning an error".
> > 	* unlike BUG_ON(), the replacement does *NOT* document the
> > fact that condition should be impossible.
> > IMO either should be sufficient for rejecting the patch.
> 
> I agree that it was not a malicious change. There are other places
> within the same function that return -EINVAL and the expectation is that
> errors from this function should be handled safely.
> 
> That said, I can find no real-world reports of this BUG_ON() ever being
> a problem and I don't think that there's any actual need for this
> change. So, I'm alright with it being reverted considering the
> circumstances.
> 
>  Acked-by: Tyler Hicks <code@tyhicks.com>

Thanks for the review, I've update the commit log message and added your
ack here.

greg k-h
