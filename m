Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9136C5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhD0L6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhD0L6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9149F60C3D;
        Tue, 27 Apr 2021 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524657;
        bh=Q/lZVx6RknHVSzMq/slpxI0ZcR/Xu9mAVr2gScGlNAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkm1y87rRpKJyGsXLHAWYB7mFgNRMRJznsmb5H8yRjFfm2EdQmEuOpRNuwO0cBWfg
         DPtdEsiLIoDzlSBC8oCASiDddvSZ69bVdEBcCgii1fWkVAaz1gQVbZBpDM6yY5mf3D
         cgv/8Yz9PWMF7OeQ0GYgM+E028w7aPIB5nq1hYHA=
Date:   Tue, 27 Apr 2021 13:57:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Adam Radford <aradford@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 189/190] Revert "scsi: 3w-9xxx: fix a missing-check bug"
Message-ID: <YIf8LvKoX5ScG2Al@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-190-gregkh@linuxfoundation.org>
 <b27a43bb-36bc-4b9-42de-c39a5b68f96f@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27a43bb-36bc-4b9-42de-c39a5b68f96f@namei.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 05:55:33AM +1000, James Morris wrote:
> On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:
> 
> > This reverts commit c9318a3e0218bc9dacc25be46b9eec363259536f.
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
> > Cc: Adam Radford <aradford@gmail.com>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The original patch here looks valid and necessary.
> 
> Please un-revert.

Now dropped, thanks for the review.

greg k-h
