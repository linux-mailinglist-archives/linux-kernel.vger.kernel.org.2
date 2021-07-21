Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444CC3D183F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhGUT6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:58:46 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32844 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGUT6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:58:45 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 16LKdGOJ027470;
        Wed, 21 Jul 2021 22:39:16 +0200
Date:   Wed, 21 Jul 2021 22:39:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nolibc and __attribute__((__unused__))
Message-ID: <20210721203916.GC27330@1wt.eu>
References: <20210721203349.GA3209274@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721203349.GA3209274@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul!

On Wed, Jul 21, 2021 at 01:33:49PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> My guess is that I should ignore the following checkpatch complaint on
> the assumption that checkpatch doesn't realize that this is not built
> as part of the Linux kernel.  But if my guess is incorrect, please let
> me know, as it is a trivial change to make.
(...)
> WARNING: __always_unused or __maybe_unused is preferred over __attribute__((__unused__))
> #24: FILE: tools/include/nolibc/nolibc.h:2246:
> +static __attribute__((unused))

Yes you're totally right, we try to keep both trees in sync by minimizing
the differences between the two, so as long as that doesn't become a
problem I prefer to keep the warning than having to manually apply
future patches due to context differences.

Thanks!
Willy
