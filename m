Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4736B752
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhDZQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234466AbhDZQ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBF1961104;
        Mon, 26 Apr 2021 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456221;
        bh=/YHXoOpj7ctpoU6CrooqwLuAW507j5yRg1Mn1kvnQ7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rz+JeYrOTwBphA8GpmxrPLd8VR9AO2nEQsx+uk0P5KgOWBpDmtZG2InwgwO51Pt2B
         S/jN7OkB2HSyWz165f1ySQwHGi4fQVsHgA+pXu7nBLzjQlJJpADDmgXV8kSDDTHDH5
         5FSKR0K+A3TDs3q6RerZ46TxKdSXJYgdqH4M+ye8=
Date:   Mon, 26 Apr 2021 18:56:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 123/190] Revert "netfilter: ip6t_srh: fix NULL pointer
 dereferences"
Message-ID: <YIbw2v256QeIl7XG@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-124-gregkh@linuxfoundation.org>
 <20210422212615.GA13017@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422212615.GA13017@salvia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:26:15PM +0200, Pablo Neira Ayuso wrote:
> Hi Greg,
> 
> On Wed, Apr 21, 2021 at 02:59:58PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 6d65561f3d5ec933151939c543d006b79044e7a6.
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
> This patch looks correct, no need to revert.
> 
> If you still prefer to revert it, no problem, I'll recover this fix
> via the netfilter tree later on.

Now dropped from my tree, thanks.

greg k-h
