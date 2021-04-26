Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E982736B780
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhDZRFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235324AbhDZRFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:05:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55AA161077;
        Mon, 26 Apr 2021 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456702;
        bh=cQ90nj8yTRAyvvdXcJiwG4zDTbdFD3yh9hzgR+R23yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHFYdHPpyFcjXmzQ1snnrBVDpQzlcAUa2NunDlJ6mWlweE+j6/mUWBfx8Br+1uifJ
         tTZ4NESCYmevklvRRjGY+5hxtSLPM3/+LdbZjt6xGoQz2MOfnx0WweSpWE9rTlT5H4
         aRhDGR0a8mq7H0/5oHOXrjXCApRn/rNQskksBLSU=
Date:   Mon, 26 Apr 2021 19:05:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        Kangjie Lu <kjlu@umn.edu>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 106/190] Revert "tty: ipwireless: fix missing checks for
 ioremap"
Message-ID: <YIbyvByKD2I8tlUB@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-107-gregkh@linuxfoundation.org>
 <20210421155900.GB7604@twin.jikos.cz>
 <dd0698e1-9b31-53fc-4dd1-da474cd483bd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd0698e1-9b31-53fc-4dd1-da474cd483bd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:57:19AM +0200, Jiri Slaby wrote:
> On 21. 04. 21, 17:59, David Sterba wrote:
> > On Wed, Apr 21, 2021 at 02:59:41PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 1bbb1c318cd8a3a39e8c3e2e83d5e90542d6c3e3.
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
> > 
> > I've reviewed the patch at the time and now again with fresh eyes, but
> > it's IMO a valid fix that would have to be done the same way after
> > revert.
> 
> ACK -- the same opinion here.

Thanks for the review from both of you, now dropped.

greg k-h
