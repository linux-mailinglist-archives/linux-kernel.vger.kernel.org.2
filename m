Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B708836C725
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhD0NmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235652AbhD0NmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:42:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0B7F613DE;
        Tue, 27 Apr 2021 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530879;
        bh=rjcqJaju1wQeCaC7HgN3TSsr7AuSNfP83LweYMl3wo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+QKY/xbz09n4pdDyJxAa3L7Q4AlK/sMI/CBpV2URxIKnrZ68VxIxyaqSpoSlUTLQ
         7az3E3Q+gPEm+pwrqw8Z22ERkgScg7qJcBmmDv59njb9mQbY6lyuK9RHzgf8ntUPyp
         y2aPwMqXiZDk8Lx6VRf+W4P7b26EWdaJrcFW6//k=
Date:   Tue, 27 Apr 2021 15:41:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 023/190] Revert "drm/radeon: fix multiple reference count
 leak"
Message-ID: <YIgUfCZUlybjNFvC@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-24-gregkh@linuxfoundation.org>
 <MN2PR12MB44889F62CD7F3EAC7572AEA2F7479@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB44889F62CD7F3EAC7572AEA2F7479@MN2PR12MB4488.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:07:14PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Wednesday, April 21, 2021 8:58 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Aditya Pakki
> > <pakki001@umn.edu>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: [PATCH 023/190] Revert "drm/radeon: fix multiple reference count
> > leak"
> > 
> > This reverts commit 6f2e8acdb48ed166b65d47837c31b177460491ec.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in
> > "bad faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a paper
> > published at the 42nd IEEE Symposium on Security and Privacy entitled,
> > "Open Source Insecurity: Stealthily Introducing Vulnerabilities via Hypocrite
> > Commits" written by Qiushi Wu (University of Minnesota) and Kangjie Lu
> > (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from the
> > kernel tree and will need to be re-reviewed again to determine if they
> > actually are a valid fix.  Until that work is complete, remove this change to
> > ensure that no problems are being introduced into the codebase.
> > 
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> AFAICT, this patch is correct or at least does no harm.  Handling of pm_runtime_get_sync() errors in the kernel seems to be inconsistent at best.

Thanks for the review, now dropped.

greg k-h
