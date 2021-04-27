Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011A036C9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhD0Qpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237539AbhD0Qp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:45:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0515E61182;
        Tue, 27 Apr 2021 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541883;
        bh=1vj9cu0kHhdzIbA8sScJjWpMJqWbUe03VCZq3LRv6Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weF1RvnOwIAVju4+kezSIEuSDpPFYT0uC5BRdYpupkxu5eJ5QxTWz4nDec3SjLibO
         dJnIvgsBj51ekcm+vKSU0GLq7zIE9bgLIf4THD7im8eg8CoJU73eKJAq9/LFax/O16
         82uwKYkMoqYXfQDXKGqgT3djOKbRcdWZbX5XQQ0E=
Date:   Tue, 27 Apr 2021 18:44:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH 085/190] Revert "audit: fix a memory leak bug"
Message-ID: <YIg/eULPfTxCNu+M@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-86-gregkh@linuxfoundation.org>
 <CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_EsgZx3coM8oA@mail.gmail.com>
 <YIBSRx7CiFCm6ccs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIBSRx7CiFCm6ccs@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:26:47PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 12:18:44PM -0400, Paul Moore wrote:
> > On Wed, Apr 21, 2021 at 9:04 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This reverts commit 70c4cf17e445264453bc5323db3e50aa0ac9e81f.
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
> > > Cc: Wenwen Wang <wang6495@umn.edu>
> > > Cc: Richard Guy Briggs <rgb@redhat.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  kernel/auditfilter.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > NACK on this revert.  I've looked at the original patch again this
> > morning, and the original patch still looks correct and doesn't appear
> > to introduce any new faults to the best of my understanding.
> > 
> 
> Thanks for the review, much appreciate it, I'll drop it.

Now dropped.
