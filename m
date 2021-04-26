Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA736B740
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhDZQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234526AbhDZQxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57384610FC;
        Mon, 26 Apr 2021 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619455970;
        bh=a8bXwKNVfqiXP8offqu9xfQziliz2NPhF+96ihB2JQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1JcqTyT950pFKG5+bgsK+rKLAoV6ovLVoDw9c7h27qyoq2QeXkgSO+kyVakMnvYKd
         zEBGGb2HO4VEhOScQ4A6sT8yKwQ6O5Wrqop4+nZ5nWbzNFnstmy5p2SQKw0PuO/LZt
         vEq1X4wli2C1NwCokuleIm5YSWvVIWk9rBcgcBy4=
Date:   Mon, 26 Apr 2021 18:52:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 112/190] Revert "libnvdimm/namespace: Fix a potential
 NULL pointer dereference"
Message-ID: <YIbv30JA9nzFX6yW@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-113-gregkh@linuxfoundation.org>
 <CAPcyv4jkEn0JoT7Ha36-janNC3UfV4OLGzYFc=Fxe5Gh9u_wCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jkEn0JoT7Ha36-janNC3UfV4OLGzYFc=Fxe5Gh9u_wCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:57:00PM -0700, Dan Williams wrote:
> On Wed, Apr 21, 2021 at 6:08 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This reverts commit 55c1fc0af29a6c1b92f217b7eb7581a882e0c07c.
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
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Upon re-review this change still looks correct, no need for a revert.

Revert is dropped, thanks for the review.

greg k-h
