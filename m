Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899AA36C5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhD0L5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhD0L5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:57:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2045360FE3;
        Tue, 27 Apr 2021 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524609;
        bh=w5z4Z0ksKFcLY9wxxXF0/s+8ID0kwuM+ji3LZeOd2vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2dPmE0UjhIUnv4FOQ5tbsQ6o+iszB/gvAhMb+RJt2B15tDs2c2dB8+C1EFko2I3u
         9FLLzeQrqoPVU4on0JINgeV71FtjWqs8Jgh0mKL4LBoFYT6D3Zjv3IxrMnH63qqWCd
         YSgt5VDum8CrmvCfVdBx0NBFynOfZpoHe2uXc+hA=
Date:   Tue, 27 Apr 2021 13:56:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 182/190] Revert "ethtool: fix a missing-check bug"
Message-ID: <YIf7/+BW10ZptiSA@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-183-gregkh@linuxfoundation.org>
 <bbf9a32a-fcb6-2aa9-2f39-ba384be1f5a0@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf9a32a-fcb6-2aa9-2f39-ba384be1f5a0@namei.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:03:53AM +1000, James Morris wrote:
> On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:
> 
> > This reverts commit 2bb3207dbbd4d30e96dd0e1c8e013104193bd59c.
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
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  net/ethtool/ioctl.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> The original patch looks valid and fixes a race.

Thanks for reviewing, now dropped.

greg k-h
