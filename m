Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62E36C807
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhD0Ox6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236943AbhD0Oxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:53:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D00061131;
        Tue, 27 Apr 2021 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619535186;
        bh=f5vDH9HIo31vBY9wK97gNzqK2wECV4npOqTI1fC8oG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgZ82gKdBJ2BrNr6DpG0fDiVaL1RwrJiHSMRB85owvZTRx0sJV/P4MecCGW57kgNq
         OHIwNozRXEgnhWkA2GfT5LHu9YTpXP8XUJvFvpp7I99vmcW5ohTxiPqNsGkT/Sodoj
         H2qcoVQaFhhl0olwMITeiua1HVYAo+HIFl5G0nT8=
Date:   Tue, 27 Apr 2021 16:53:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 143/190] Revert "power: twl4030: fix a missing check of
 return value"
Message-ID: <YIglTxK/ODxZZz2g@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-144-gregkh@linuxfoundation.org>
 <20210421161407.jhcy5gp24z3cko4e@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421161407.jhcy5gp24z3cko4e@earth.universe>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:14:07PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Apr 21, 2021 at 03:00:18PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 6f12e46eebf1a7d4fdd66df5e815df96b8f8b1b5.
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
> > Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> Doing another review:
> 
> twl4030 is an I2C connected PMIC, so any read operation can
> result in -EIO. If this happens 's' will not be initialized,
> so without handling the error is_charging will be set to an
> arbitrary state in the following lines. Exiting early from
> twl4030_bci_get_property is ok and other HW read operation
> failures in the same function are exiting early with proper
> error code (as the patch introduced for the only read missing
> this).
> 
> TL;DR: original patch is ok, I suggest to drop the revert.

Thanks for the review, now dropped.

greg k-h
