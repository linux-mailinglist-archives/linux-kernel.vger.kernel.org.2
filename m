Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6536B73A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhDZQw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FFCC60FF3;
        Mon, 26 Apr 2021 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619455903;
        bh=2TK2sDoXerXkjnB1KkLcK/SlQ71BMIzEozIoFzv8YOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiiX88io/WLbBvM0yuMWuSUqwuxyLJbnhTxN7nunfdPU+JSLU3Ei6xtWbH+JLsfFb
         4aiZHWvB2X1kIn8+Vh+QY9K7Xfy8234b4/d9jz73XwvNGmXOhNTHU2q6wW+bqNEoli
         jrW3Xi8vS0cMX8p2HTAPm+chr8Y2eMCSF4uYA6kM=
Date:   Mon, 26 Apr 2021 18:51:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH 136/190] Revert "net: thunder: fix a potential NULL
 pointer dereference"
Message-ID: <YIbvnEcKvaMD9rAk@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-137-gregkh@linuxfoundation.org>
 <20210423130006.fuh3hljkhkrpcvd3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423130006.fuh3hljkhkrpcvd3@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 08:00:06AM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 21, 2021 at 03:00:11PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 0b31d98d90f09868dce71319615e19cd1f146fb6.
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
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> +Cc: Sunil Goutham <sgoutham@marvell.com>
> 
> The original patch looks correct to me.

Now dropped, thanks for the review.

greg k-h
