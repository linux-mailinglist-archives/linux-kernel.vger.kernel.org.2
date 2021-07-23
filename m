Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75E3D4189
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhGWTtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231350AbhGWTtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 816E460E94;
        Fri, 23 Jul 2021 20:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627072186;
        bh=mEbNVex0MV4baiJn1vzXJRZ962H3Xgl3nJ2S8pPrXHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+VSTddOjC8+A8m+I0St8amtAisBWFKkZgXbLPgbwmG43VC/UQ3ZDm9FiW0phe5mG
         sYGG58dUVW04WWC9gvSVZJopOBL8KhN3sxEON13TwJxg09Zq8HstOpnrfrkErL4QwV
         nEOU9pcPuWsri1PajO/UdAbS82/OIdF19ouJaEXVBnAHLA2wQCLq7NtsnH6u4XGNu9
         mHqlpl+5oMB3WetMzEifWmsFAnOsuGSOZdcu1+UUKOCYUCiD5FKOAhteoiEGxltKKb
         bCN4PFRqjnEqjResbZYz723M05aXcheEuZOMVP0oWgm191w/uRT6f97/Ytvajz9KXs
         BTHggwP9J3eZw==
Date:   Fri, 23 Jul 2021 13:29:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change fiemap way in printing
 compression chunk
Message-ID: <YPsmuUEoJUGhFm1J@gmail.com>
References: <20210723074928.1659385-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723074928.1659385-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 12:49:28AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When we print out a discontinuous compression chunk, it shows like a
> continuous chunk now. To show it more correctly, I've changed the way of
> printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> info, since it is not in fiemap user api manual.
> 
> Let's assume 16KB compression cluster.
> 
> <before>
>    Logical          Physical         Length           Flags
> 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> 1:  0000000000004000 00000002c0920000 0000000000004000 1008
>   ...
> 9:  0000000000034000 0000000f8c623000 0000000000004000 1008
> 10: 0000000000038000 000000101a6eb000 0000000000004000 1008
> 
> <after>
> 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> 1:  0000000000004000 00000002c0920000 0000000000004000 1008
>   ...
> 9:  0000000000034000 0000000f8c623000 0000000000001000 1008
> 10: 0000000000035000 000000101a6ea000 0000000000003000 1008
> 11: 0000000000038000 000000101a6eb000 0000000000002000 1008
> 12: 000000000003a000 00000002c3544000 0000000000002000 1008
> 
> Flags
> 0x1000 => FIEMAP_EXTENT_MERGED
> 0x0008 => FIEMAP_EXTENT_ENCODED
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> ---
> v3: fix the missing last extent flag issue
> v2: changed the print format
> ---
>  fs/f2fs/data.c | 75 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 42 insertions(+), 33 deletions(-)

I can't understand the code in f2fs_fiemap(), but I tested that my two
compression+encryption tests (xfstest f2fs/002 and Android
vts_kernel_encryption_test) pass reliably when this patch is applied.

Tested-by: Eric Biggers <ebiggers@google.com>

- Eric
