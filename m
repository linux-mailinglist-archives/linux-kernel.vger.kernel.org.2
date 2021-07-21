Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A13D1945
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGUUzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGUUzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:55:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94D5B6124C;
        Wed, 21 Jul 2021 21:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626903344;
        bh=NSU/Wk43fEadjSCOVyueEa4XZr2Xp3CLiVyUfxIDmmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhxUps9b4AjEIN1swnEP77sK907y5GqVD+twrZhiGtb3BBvuwRicnwbJqfHm+a1jd
         8pAXldct9Om/D841qLJ38d8dQV8ZAusV7eMCx7HT7KlEWnx12s2yO9gZnv9qed7761
         N72UHjPqBfjK8fgAkIaYjc3q/6OWTkNs2eKtfxhPePIIaYLRb5pmad/CALHqLNIzLg
         4qReh6ZsfnVDb/PpYEzJ6e5gaOV0uB6PogiiM7DQ/Y2heSM3aQnu5R+aPKFNL63/J6
         cmup9TLM9QjrUZmF1KROnVYoyMriGvFR6Rcl9c2jRfvSfcT8bxH0B658xsZypcb/Ts
         IzTVVT5QvY95Q==
Date:   Wed, 21 Jul 2021 14:35:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change fiemap way in printing
 compression chunk
Message-ID: <YPiTLwB3d8BWSKje@gmail.com>
References: <20210721072048.3035928-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721072048.3035928-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:20:48AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When we print out a discontinuous compression chunk, it shows like a
> continuous chunk now. To show it more correctly, I've changed the way of
> printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> info, since it is not in fiemap user api manual.
> 
> 0: 0000000000000000 0000000000000000 0000000000001000 1008 (M/E)
> 1: 0000000000001000 0000000f15c0f000 0000000000001000 1008 (M/E)
> 2: 0000000000002000 0000000000000000 0000000000002000 1808 (M/U/E)
> 3: 0000000000004000 0000000000000000 0000000000001000 1008 (M/E)
> 4: 0000000000005000 0000000f15c10000 0000000000001000 1008 (M/E)
> 5: 0000000000006000 0000000000000000 0000000000002000 1808 (M/U/E)
> 6: 0000000000008000 0000000000000000 0000000000001000 1008 (M/E)

Please label these columns.

Anyway, this doesn't appear to work quite in the way I had in mind.  With this
patch, what I'm seeing is:

$ head -c 16384 /dev/zero > file; xfs_io -c "fiemap -v" file
file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..7]:          0..7                 8 0x1008
   1: [8..15]:         2683128..2683135     8 0x1008
   2: [16..31]:        0..15               16 0x1809

So, working in 512-byte sectors, the logical sectors 0-31 are stored as one
compressed cluster in the 8 physical sectors 2683128-2683135.

The problem is, with this patch these physical sectors are reported at logical
sectors 8-15 instead of 0-7.  Obviously, this isn't particularly well-defined,
but I thought it was logical for the physical blocks to be associated with the
first logical blocks.  That is what the tests I've written (xfstest f2fs/002,
and the Android vts_kernel_encryption_test) assume.

Is there any particular reason why you wouldn't report instead:

   0: [0..7]:         2683128..2683135     8 0x1008
   1: [8..31]:        0..23                8 0x1809

- Eric
