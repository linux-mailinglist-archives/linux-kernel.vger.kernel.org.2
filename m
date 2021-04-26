Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6311F36B743
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhDZQyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhDZQyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:54:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99EF661077;
        Mon, 26 Apr 2021 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456007;
        bh=Kqbf0Fdc+wBdqBWw0FXfhp8IboLyLR1zy7dXsAWx1P8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUD6XsUXDiv0jG0Pn1t6NIQwcVB0p8VjMRwcvjnIPVF8WHgfcBsekySjsKLoBSx1k
         ErUj73tnG75nZGGKLNv0f5CRHr8m4gxT+Zg4kyl0HAfB49sxJspWc+rYBzTJVoH0ZA
         CJ5sdv/TYDIVRIlsSV2/t93dyonq0PjVTh9xV6bM=
Date:   Mon, 26 Apr 2021 18:53:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 105/190] Revert "libnvdimm/btt: Fix a kmemdup failure
 check"
Message-ID: <YIbwBGGzVv5RRCT7@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-106-gregkh@linuxfoundation.org>
 <CAPcyv4h6SrYg39NN5WzhiXyD3_FjVW4XVXsK=HUVjWOSPcBaAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h6SrYg39NN5WzhiXyD3_FjVW4XVXsK=HUVjWOSPcBaAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:49:39PM -0700, Dan Williams wrote:
> On Wed, Apr 21, 2021 at 6:08 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This reverts commit 486fa92df4707b5df58d6508728bdb9321a59766.
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
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Upon re-review, this fix still looks good to me, revert is not necessary.

Thanks for the review, I'll drop the revert.

greg k-h
