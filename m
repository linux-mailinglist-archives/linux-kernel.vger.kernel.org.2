Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6136C71C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhD0Nib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236257AbhD0Nia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:38:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B95D61029;
        Tue, 27 Apr 2021 13:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530667;
        bh=f714/mxVPDyIYoA4Ef9GhM4ruI0BBHl1iuQpw9yz6gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCf1NdEt+BogXxqbBEHsFvz3kfZ5CLhQcjBEA4F/52kXkHMRtqml6cPzsKUCZ0p4T
         v8n4gbz6AGl0mMd4lQZLWGIIaSNEd463OxFGVMLOmWXHZin5n4AqXwGsun5VQVdbRZ
         wi0dAdAWcGLnH0TnonewRaMhnbNwRewaE4btM2HU=
Date:   Tue, 27 Apr 2021 15:37:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 061/190] Revert "xen/grant-table: remove multiple BUG_ON
 on gnttab_interface"
Message-ID: <YIgTqFPfQo/H0Fgy@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-62-gregkh@linuxfoundation.org>
 <9c52814a-7db1-1989-6fd2-e6d80f9a92ad@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c52814a-7db1-1989-6fd2-e6d80f9a92ad@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:19:14PM +0200, Juergen Gross wrote:
> On 21.04.21 14:58, Greg Kroah-Hartman wrote:
> > This reverts commit d6bd6cf9feb81737f9f64d2c1acf98fdaacebad1.
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
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The reverted patch didn't introduce any issue. I have verified that the
> BUG_ON()s are really impossible to trigger, and even if they would have
> been triggering, they'd be now replaced by NULL dereferences.
> 
> So I believe you can just drop this revert.

Thanks for the review, now dropped.

greg k-h
