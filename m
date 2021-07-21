Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257783D1869
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhGUUM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhGUUM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:12:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BC5E61009;
        Wed, 21 Jul 2021 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626900813;
        bh=JiNPZd7x+ZW3q+WJi5WzXoV5lzVRTeUlPrjAfDZ7D1w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AjqRPMCBTzQrIh9polLeyg5QcfGNm7qcEWTv/sWWxUKr8C7k5yP/QgDrt+lSHPjAq
         V9QpfaWR8x1b/Z2w7KLKv+SrjM1hECten1OuI7q0bNxVh/HJllVhNmTSXi+C2+lKIr
         6vTo9BNA+UL7VZ0BAcjiobfu35BCCzYS0lsiQmkyv4fOas+qFzsvuBcUD8M1KMaCiS
         SRWJ2kf4kMTmmD23gpFbHKyIXWaX5EaEsuE89J44p6GYiFPmwvcTPWl0/hpEP33Dy1
         bpIpNeOseVBhn08zlUCZptfXa/CID1OOzZAUGxf5f0lw+3atZNuFkMxDJP/4PJlzHn
         DWKxbmn8D3egQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 26F635C09A4; Wed, 21 Jul 2021 13:53:33 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:53:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nolibc and __attribute__((__unused__))
Message-ID: <20210721205333.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721203349.GA3209274@paulmck-ThinkPad-P17-Gen-1>
 <20210721203916.GC27330@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721203916.GC27330@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:39:16PM +0200, Willy Tarreau wrote:
> Hi Paul!
> 
> On Wed, Jul 21, 2021 at 01:33:49PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > My guess is that I should ignore the following checkpatch complaint on
> > the assumption that checkpatch doesn't realize that this is not built
> > as part of the Linux kernel.  But if my guess is incorrect, please let
> > me know, as it is a trivial change to make.
> (...)
> > WARNING: __always_unused or __maybe_unused is preferred over __attribute__((__unused__))
> > #24: FILE: tools/include/nolibc/nolibc.h:2246:
> > +static __attribute__((unused))
> 
> Yes you're totally right, we try to keep both trees in sync by minimizing
> the differences between the two, so as long as that doesn't become a
> problem I prefer to keep the warning than having to manually apply
> future patches due to context differences.

Very well, and I will continue to ignore this sort of warning from
checkpatch for nolibc files.

							Thanx, Paul
