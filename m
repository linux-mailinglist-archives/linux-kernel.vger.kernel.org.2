Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F473D1B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhGVBCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhGVBCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:02:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D8F60FDB;
        Thu, 22 Jul 2021 01:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626918171;
        bh=Y2xTwQc6YUfESJt0St8gmjwX+3UIJoeNHUkqBbZj8n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2gf1zVUCuVjVzKkm8L3v+N3ou/SDemhBhKk1skdhgMpRmfWiZnfcmb2XyNHo8p2Z
         4GuPI8gTKCfbRdSHaFEKtrf9NRZQ/QUrS+GoCHR5I+rjVNSLn+CeHGW7b5mZhNzMTL
         wAqEFwtnhX/U64HKeH5YOEjoy4ML9eO3QOs2AGeMqNChz3Ba9ufLSDXA31vscPCWa5
         HEmcE1cChWgQCMLAuvBtyaEo56KUYpVnm4hQJpw4I3WQMqD7f329rcQ9V9cCu+KjQG
         0HmueBdH5FmHF6tKxuEE009snZqkyGs7UhA93anhKdiAOuXvjKnSnOqdZ83mrqgrvm
         XgppLKrhFWwag==
Date:   Wed, 21 Jul 2021 18:42:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong inflight page stats for
 directIO
Message-ID: <YPjNGoFzQojO5Amr@sol.localdomain>
References: <20210719084548.25895-1-chao@kernel.org>
 <YPi/4kMUAhlRZV3M@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPi/4kMUAhlRZV3M@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:46:26PM -0700, Eric Biggers wrote:
> On Mon, Jul 19, 2021 at 04:45:48PM +0800, Chao Yu wrote:
> > Previously, we use sbi->nr_pages[] to account direct IO, the count should
> > be based on page granularity rather than bio granularity, fix it.
> > 
> > Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
> > Signed-off-by: Chao Yu <chao@kernel.org>

Also, do we have to do this, as opposed to just moving F2FS_DIO_WRITE and
F2FS_DIO_READ out of ->nr_pages[] and into separate counters that are clearly
defined to be per-request?  As Christoph pointed out
(https://lkml.kernel.org/r/YPU+3inGclUtcSpJ@infradead.org), these counters are
only used to check whether there is any in-flight direct I/O at all.  (They're
also shown in /sys/kernel/debug/f2fs/status, but that doesn't really matter.)

As Christoph mentioned, there is a way to avoid needing f2fs_dio_submit_bio()
(which would save a memory allocation for every bio, which can fail).  But it
will only work if the counters remain per-request.

Can we leave these as per-request?

- Eric
