Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093D636B757
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhDZQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234610AbhDZQ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:59:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F4D611ED;
        Mon, 26 Apr 2021 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456324;
        bh=TDYtU45mdwKAG6HH8mp2/hojrl/T0CnAPY01sAZ/Wa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhhMIydGahjug9vOJgCu9mbkfB7wcR68KYo/b7C1QEUXbFawayDmA7zS6wPgTxntI
         PagCPdS7YEruam85eXy2cf7DxAvr5e0/Balg8k3h+5IM2GcWmjp0BzIGJKPnra8cxn
         CkYMSkxiZka8RW6kF5rrG1tPWnb6wRn+vvfEX9Ks=
Date:   Mon, 26 Apr 2021 18:58:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 103/190] Revert "thunderbolt: property: Fix a missing
 check of kzalloc"
Message-ID: <YIbxQfY6Donan+D7@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-104-gregkh@linuxfoundation.org>
 <20210422112500.GS3511397@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422112500.GS3511397@lahna.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:25:00PM +0300, Mika Westerberg wrote:
> On Wed, Apr 21, 2021 at 02:59:38PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 6183d5a51866f3acdeeb66b75e87d44025b01a55.
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
> 
> This one is a valid, although minor, fix.

Now dropped, thanks.

greg k-h
