Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D0A36C9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhD0Qxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236611AbhD0Qxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:53:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3568B613D8;
        Tue, 27 Apr 2021 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542370;
        bh=4YWY5GGpHQGx70Au7ckT2mXjimWpsegykY0XngdQwEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGUnrnk5uTK9PR3edPWAinVbq910acHrKWTvM5AllFU3trtglLuL+PUEniV0oZdGI
         BQTtsYR5eY9asoKl91iSRmiEp0gKuL28AaCR9okNkOvfBieTvBBPRuEgkkJ1zs/K6H
         liLi0bJUvBPeKXPASjubm4jPlJfoGydxWH+iuCrg=
Date:   Tue, 27 Apr 2021 18:52:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 116/190] Revert "thunderbolt: property: Fix a NULL
 pointer dereference"
Message-ID: <YIhBYDq3m7XzEhNW@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-117-gregkh@linuxfoundation.org>
 <3821882d-22c4-5dc5-2df9-ae2d5e8fc2a@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3821882d-22c4-5dc5-2df9-ae2d5e8fc2a@namei.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:26:23AM +1000, James Morris wrote:
> On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:
> 
> > This reverts commit 106204b56f60abf1bead7dceb88f2be3e34433da.
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
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/thunderbolt/property.c | 5 -----
> >  1 file changed, 5 deletions(-)
> 
> The original patch looks correct.
> 
> 
> Reviewed-by: James Morris <jamorris@linux.microsoft.com>

Thanks for the review, now dropping this revert.

greg k-h
