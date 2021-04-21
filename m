Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595113670C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbhDURAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238561AbhDURAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:00:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DC1961454;
        Wed, 21 Apr 2021 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619024401;
        bh=AI77qGzZt23pSQs1t20Tpi5v4FMirrG9O8TqEzMEPNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=17utWtfiQYuQh6bvbdYBFtAKskiDt0Xw/ndDR+wAxmo3izMJVumADT/9Q1aiKJspN
         NDXz5BOe7GxSQaaYAcnM+1GUCTgX8iJPubo9T0LE5vpFOUqnGVFSUSTgY67UArJyn2
         aG4JIS2EVqT0CfztncXnSbQn7+gwJfIZ3jfe5qzI=
Date:   Wed, 21 Apr 2021 18:59:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH 186/190] Revert "virt: vbox: Only copy_from_user the
 request-header once"
Message-ID: <YIBaDvrNVHlNRuXM@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-187-gregkh@linuxfoundation.org>
 <68067532-56e5-c135-7a7e-0743c8e7b2a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68067532-56e5-c135-7a7e-0743c8e7b2a0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:51:24PM +0200, Hans de Goede wrote:
> Hi Greg,
> 
> On 4/21/21 3:01 PM, Greg Kroah-Hartman wrote:
> > This reverts commit bd23a7269834dc7c1f93e83535d16ebc44b75eba.
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
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Ugh what a mess (the whole umn.edu thing).
> 
> I still remember reviewing this patch during its original submission
> and I've reviewed it again this morning when you just send it out.
> 
> And now after letting it sit for a bit I've reviewed it a third time
> and it seems to do what it says on the label / in the original commit
> msg; and if fixes a real, potentially security, issue.
> 
> I'm not sure what the process is for "good" patches in the set
> which you are reverting. I would prefer for this patch to be dropped
> from the set of reveert. But I can also submit a revert of the revert(?)
> once this set of reverts has been merged.

If you have reviewed it, and think it should stay, I will drop the
revert from my patch series.  Other maintainers/reviewers have asked the
same thing for their patches, which is fine.

Anything that I do end up reverting, that was not reviewed, will be
again reviewed by me and others to determine if it is "safe" to come
back in at a later point in time.

So thanks for the review, I'll drop this one.

thanks,

greg k-h
