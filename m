Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D186436C78B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhD0OK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236342AbhD0OK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23E90613CA;
        Tue, 27 Apr 2021 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619532582;
        bh=Qy/ZBF+X1qwMDiaor+gbFTzPhrTCrkcHfVRI/xKGCDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaOfjFcexAjl/Ijv+Cgq5SPcAtWNj51d4JOzbAr0dMZG8y5bZLP4YmNaiwEhOPDvS
         6fHhZ92js0LtIMnjMJvoU1fYVJkWDxfdXGlJlcMqAyWncsmJkFOjCN0e9GYs6W2tov
         rJcHIzPj4UCOhw3btn/spxQCGDN7xrSHn0Wk2cUg=
Date:   Tue, 27 Apr 2021 16:09:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH 087/190] Revert "udf: fix an uninitialized read bug and
 remove dead code"
Message-ID: <YIgbI5VgT6MBFvUO@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-88-gregkh@linuxfoundation.org>
 <20210421135533.GV8706@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421135533.GV8706@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:55:33PM +0200, Jan Kara wrote:
> On Wed 21-04-21 14:59:22, Greg Kroah-Hartman wrote:
> > This reverts commit 39416c5872db69859e867fa250b9cbb3f1e0d185.
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
> > Cc: Wenwen Wang <wang6495@umn.edu>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Hi Greg!
> 
> I'm pretty confident this particular report & fix was valid (in fact it was
> me who suggested the particular change). So I don't see point in reverting
> it...

Thanks for letting me know, now dropped.

greg k-h
