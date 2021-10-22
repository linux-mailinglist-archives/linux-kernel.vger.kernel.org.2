Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085EA4370AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 06:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhJVENJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 00:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJVENI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 00:13:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF33060F57;
        Fri, 22 Oct 2021 04:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634875851;
        bh=QyZL9W/6ytGcnqJMMI8sTVuNsfb6f0JQcPPuhblTTNQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=WCs06ovZTud7dEx+BR775sR4f1NSdaLnCmLCEq7RjGkdwTHgbJvEU7zjGtUJZG26P
         35Mz3ME7AT23yA6hwTlaFzkiu8DiHoHPjnSQcKX0QDDXNasas6dnwwQpLg/QbDXbP5
         nShGEJlCw7BAR8w/2ualLJBV8F1Z1Z7jBYWAzmM8RleNwBJkycJPZ70SIQzCkvO65L
         4uDqE7fgoteR3wz77shWHSpIaOzr9eWmYsxaAG+6Xv/GeT7ARKce9j+gmGiZxFtXAB
         BcnYS7f8fmaEf53jDefHIKB/BeYd/CwjIYY0zM1prg3TkCRgEpgXalku+oOj4PNVGW
         Zkphh1vOAz1ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8E7085C0C54; Thu, 21 Oct 2021 21:10:51 -0700 (PDT)
Date:   Thu, 21 Oct 2021 21:10:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: FYI, RCU, sequence locks, and Rust
Message-ID: <20211022041051.GA234258@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On the off-chance that this is useful for you guys for sequence locking,
here is the stance I intend to take for Rust wrappers for RCU APIs:

1.	My first reaction to submission of Rust wrappers for the RCU
	API will be to ask hard questions about the possibility of
	higher-level APIs.

2.	If higher-level APIs are infeasible, I will look carefully at
	which RCU use cases are supported by the proposed wrappering. I
	am working to improve documentation of the range of RCU use cases
	in order to help submitters to do this as well. (This work will
	likely be helpful elsewhere as well.)

3.	Again, if higher-level APIs are infeasible, I will look carefully
	at how the Rust wrappers are helping to find bugs. This will
	clearly require me to continue learning Rust, as this requires
	me to have a detailed view of Rust's ownership mechanisms and how
	things like reference-counting use cases work around limitations
	in these mechanisms.

This procedure should help buy the time required for me to learn more
about the Rust language and for the Rust community to learn more about
RCU and its many use cases.

Your sequence-locking mileage may vary, but one thing that sequence
locking has in common with RCU is read-side critical sections that are
a bit different than Rust seems to expect.

More information here:

	https://paulmck.livejournal.com/62436.html
	"So You Want to Rust the Linux Kernel?"

And more specifically, here:

	https://paulmck.livejournal.com/65341.html
	"TL;DR: Memory-Model Recommendations for Rusting the Linux Kernel"

Again, on the off-chance that this is helpful.

							Thanx, Paul
