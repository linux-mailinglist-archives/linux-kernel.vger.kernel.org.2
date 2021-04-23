Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5590368C72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhDWFSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWFSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:18:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3A49613E6;
        Fri, 23 Apr 2021 05:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619155051;
        bh=z4RIdF0ldrUyOIs8erovxMNr3VURoAgRZM+niuJbZEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVgb0MUGPkJC3va1j0Gy5xI3UQqw7dIeqrH73jf3i9rtRgV+gSzn5AV3FdvQvBDeC
         G2e7Sj0O3D7J60FrAanJOJ6o6+IsYdjnNKDxE8zwI8MPuY6zERaJgS9tRI/wOEckzs
         kLYYnFxhuhtgQ593Au88DPxpzH2NRFnb31+6hTDY=
Date:   Fri, 23 Apr 2021 07:17:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 123/190] Revert "netfilter: ip6t_srh: fix NULL pointer
 dereferences"
Message-ID: <YIJYZWuBnr8+5/sg@kroah.com>
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

Wonderful, thanks for the review.

> If you still prefer to revert it, no problem, I'll recover this fix
> via the netfilter tree later on.

Nah, I'm dropping anything that reviewers point out is "ok" from this
patch series.

thanks again,

greg k-h
