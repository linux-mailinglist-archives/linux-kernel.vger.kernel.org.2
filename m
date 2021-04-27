Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39F36C724
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhD0Nlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235652AbhD0Nln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:41:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC199613D1;
        Tue, 27 Apr 2021 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530860;
        bh=3OwuNzi/3p8g5rvYpkJeU0dXgNB6dHXSteBlKa9/Mzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7SZfOv00m648lDCgS+FKgn+gPJsf1uHcbY0vgRcWS8ISYYlyl1nonS+yoM14t2MX
         aVdFOS2A8UH8luFfRRc5uhX1Xl7IlAI9QafWgDHSQHNpIgxYC4SJjFFHbD5mL6bvWk
         VvQFeyaYG58Mx5Su8pAeu+nF7HJgNmSSMowaQM3s=
Date:   Tue, 27 Apr 2021 15:40:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Quan, Evan" <Evan.Quan@amd.com>, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 022/190] Revert "drm/radeon: Fix reference count leaks
 caused by pm_runtime_get_sync"
Message-ID: <YIgUacSD2nVPL24c@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-23-gregkh@linuxfoundation.org>
 <MN2PR12MB4488CE1D9E2133F4110D131EF7479@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488CE1D9E2133F4110D131EF7479@MN2PR12MB4488.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:08:05PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Wednesday, April 21, 2021 8:58 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Quan, Evan
> > <Evan.Quan@amd.com>; Aditya Pakki <pakki001@umn.edu>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 022/190] Revert "drm/radeon: Fix reference count leaks
> > caused by pm_runtime_get_sync"
> > 
> > This reverts commit 9fb10671011143d15b6b40d6d5fa9c52c57e9d63.
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
> > Cc: Evan Quan <evan.quan@amd.com>
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> AFAICT, this patch is correct or at least does no harm.  Handling of pm_runtime_get_sync() errors in the kernel seems to be inconsistent at best.

Thanks for the review, I'll drop this revert from the tree.

greg k-h
