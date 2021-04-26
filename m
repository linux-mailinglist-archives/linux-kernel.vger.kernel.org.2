Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0016736B754
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhDZQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234257AbhDZQ65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:58:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29C2961103;
        Mon, 26 Apr 2021 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456294;
        bh=F8xQ3mpzqZ3EppuZc0TQzTwd6cq6hcMvKw09nqk1mU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOA25+OPBaQEq3uEgt1G3aUvUiiif9U998T2nwEE0VqtkYWqYhWLEkAxObXLRXy+N
         8of9fjALnV//WbYYz5nApXaHMUp7DNgOaXLZlW+NfP7byKXH9tg6/FPqN40poM0oln
         lCJPutXcbmk09purZPeec+xlpagyFRtzInD5dbV4=
Date:   Mon, 26 Apr 2021 18:58:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 115/190] Revert "thunderbolt: Fix a missing check of
 kmemdup"
Message-ID: <YIbxI5ANTpUgolKy@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-116-gregkh@linuxfoundation.org>
 <20210422113012.GT3511397@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422113012.GT3511397@lahna.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:30:12PM +0300, Mika Westerberg wrote:
> On Wed, Apr 21, 2021 at 02:59:50PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit e4dfdd5804cce1255f99c5dd033526a18135a616.
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
> This one too is valid.

Now dropped, thanks.

greg k-h
