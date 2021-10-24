Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E18438C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 00:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhJXWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 18:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhJXWzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 18:55:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FEFB6054F;
        Sun, 24 Oct 2021 22:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635115961;
        bh=XL2kGwv7URrX3Lgh3qNg8uYi95eukKlwRa1CsbHhvIQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U4KWkTcLCjFaWs7u5Blv+H7KuE3jojTP8ZkVZkOGw0TOJG0jG+5uPRhGuBL5RIbww
         P5gEDDEOVjmV+a4YwqLYBJoLjI1gYYpVYlE8iLmgVGGUwFLAWTMTX6nrMpbFU3Ji7Q
         kcKCy3vzoXeyFuFllpLi20dnMkuDCqvp2Kdu5rKotCR2eVKIyxWOAaOjy1bcK6zQim
         i3wKkrkQl4tgBVGkH24GHlVZD3588ZCatF1siD0ERFRlC+4MtYlqXUCua40V0V7gXa
         VOfCgLcejrx+KqzuRL17p0/FpmghzRdh19rzVKAeqrD86wo61Av5al1L5DAiF7HZc2
         ZT5AwXH+LoN5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D233F5C0BF4; Sun, 24 Oct 2021 15:52:39 -0700 (PDT)
Date:   Sun, 24 Oct 2021 15:52:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Peter Cordes <peter@cordes.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nolibc fixes marked for -stable
Message-ID: <20211024225239.GJ880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211024172816.17993-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024172816.17993-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 07:28:13PM +0200, Willy Tarreau wrote:
> Hi Paul,
> 
> here are a few fixes for nolibc. Ammar Faizi figured that the stack was
> not properly aligned on x86_64, it was aligned for after the call instead
> of before due to my misunderstanding of the spec. This made me check i386
> and I got it wrong there as well. Others are OK as they do not push but
> switch pointers on a call. The problem is essentially detected when using
> SIMD instructions (either voluntarily or when the compiler does it on its
> own).
> 
> A second (less important) issue is that I thought that it was up to the
> userland code to truncate the code passed to exit() to 8 bits while it's
> the kernel that does it. The difference is subtle but is visible in strace,
> and this was reported by Ammar as well. This time it affected all supported
> archs.
> 
> This series is based on 5.15-rc6. I marked them for backport to stable,
> just in case anyone uses nolibc for bisecting bugs.
> 
> Thanks!
> Willy

Queued for v5.17, thank you both!

							Thanx, Paul

> Ammar Faizi (1):
>   tools/nolibc: x86-64: Fix startup code bug
> 
> Willy Tarreau (2):
>   tools/nolibc: i386: fix initial stack alignment
>   tools/nolibc: fix incorrect truncation of exit code
> 
>  tools/include/nolibc/nolibc.h | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> -- 
> 2.17.5
> 
