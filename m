Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D164441CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhKAOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhKAOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:44:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87215C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uUUawBfqof3MazZFelNAf+4jZ9WvINAWpNw9e92RjoE=; b=FeuCOGrVu8nkciBsbui2puCSHA
        89IKHilpx/fkmRdLIJlqJlNBsNS94j0gMomVdAwptCcpmJYsXW2qkbbnXZKxNDYadEqw+ZF+9/PiH
        O2RqeuRgQZYtn9w4a29lheXPcM5Q1zDXN8K16K+WMJIYkeU2ONWloXtJxY2A22TB4rWp5CG4avYsB
        kDN4itCsCjY9Dl1i+vjJW1WaiHasFB20cVwZckoRPUevBi147E500qYKVhpEL6/YlYDPIzX1ff92O
        ffmZPuSF2m78XHzf0TKJZA3yM05jeqbjxw3qr9O9iQzy9u1qKRIPF3SzcOd4S7Q2rmLUSg/573sVN
        GOrO6hwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhYSq-003pMp-Ex; Mon, 01 Nov 2021 14:39:50 +0000
Date:   Mon, 1 Nov 2021 14:39:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com
Subject: Re: [PATCH] staging: mm: Fix ERROR:do not initialise statics to 0 or
 NULL in memblock.c
Message-ID: <YX/8DKt4I0kf9Eau@casper.infradead.org>
References: <20211101101719.22538-1-kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101101719.22538-1-kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 03:47:19PM +0530, Kushal Kothari wrote:
> The default value of static variable is zero and bool is false so
> not need to set it here.
> This patch fixes this ERROR in memblock.c

Why does the subject line say "staging"?  What tool reports this as an
"ERROR"?

> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
>  mm/memblock.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5c3503c98b2f..57b9153b2278 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -16,7 +16,7 @@
>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
> -
> +#include<stdbool.h>

Why are you including stdbool here?  Why do you not justify it in the
changelog?

