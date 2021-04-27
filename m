Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F836C726
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhD0Nm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235652AbhD0Nm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:42:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 778CA6101C;
        Tue, 27 Apr 2021 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530904;
        bh=3R+RHx3G+GRtybh1QK+7rD/kslyPO1r6uGHbIesarDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juph0eE2JareFOXSNrD07kPKxFJpmn40YY9BUzRWaSyYmSWqau54Qva5KIJn+a7HD
         x95OTmP1Hj2vdnShrbjWvW7OpWfJbdc++i+KkRGL2e6pdd2kv42fOZbMRLyXCUMFbF
         +GVDJBvlonHQVqJvKQaHkPWFqJd+Ffb6C9vzsFYI=
Date:   Tue, 27 Apr 2021 15:41:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 024/190] Revert "drm/amdkfd: Fix reference count leaks."
Message-ID: <YIgUlTFJonk12acY@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-25-gregkh@linuxfoundation.org>
 <5c09de50-d013-e5a3-d638-f1ca222a6431@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c09de50-d013-e5a3-d638-f1ca222a6431@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:14:11AM -0400, Felix Kuehling wrote:
> On 2021-04-21 8:58 a.m., Greg Kroah-Hartman wrote:
> > This reverts commit 20eca0123a35305e38b344d571cf32768854168c.
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
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> As far as I can tell, this patch was correct and should not be reverted.

Thanks for the review, now dropped.

greg k-h
