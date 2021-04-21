Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76136700D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbhDUQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235040AbhDUQ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:27:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93C1C61409;
        Wed, 21 Apr 2021 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619022410;
        bh=+fWm8kUa50XqXMGb9xC/2ssHISS6wpy9ziTFDq0kZ1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJJAk4v6zYhLjMF3z50WJUpFXd8JfEmMJEf6Bald9M0HKvQ4YB9CPPiQ6Cn5DX9Pi
         F7ymDKLsI+9VkBLl3IDZjh4uYvK4Oci94yqEExzg2oOpb2JyjTOvotMTMPYr07j3K7
         JSR6q7m1ezUTHayCkcEmRGMqXsc6x1s7Ga5jhntU=
Date:   Wed, 21 Apr 2021 18:26:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH 085/190] Revert "audit: fix a memory leak bug"
Message-ID: <YIBSRx7CiFCm6ccs@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-86-gregkh@linuxfoundation.org>
 <CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_EsgZx3coM8oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_EsgZx3coM8oA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:18:44PM -0400, Paul Moore wrote:
> On Wed, Apr 21, 2021 at 9:04 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This reverts commit 70c4cf17e445264453bc5323db3e50aa0ac9e81f.
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
> > Cc: Wenwen Wang <wang6495@umn.edu>
> > Cc: Richard Guy Briggs <rgb@redhat.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/auditfilter.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> NACK on this revert.  I've looked at the original patch again this
> morning, and the original patch still looks correct and doesn't appear
> to introduce any new faults to the best of my understanding.
> 

Thanks for the review, much appreciate it, I'll drop it.

greg k-h
