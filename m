Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BFC41E315
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349069AbhI3VOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348834AbhI3VOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F0E61881;
        Thu, 30 Sep 2021 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633036374;
        bh=yQXZF8VLhtq/CkjXPsQUI56gX9vY5VW1oyXGgYiZST4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P39JgiYVF7rygVmQeuG+XvVUfbQGiMh7Xb0ilY0t7zn/ibbAi8vIT6ObkBQIHS3Hu
         CWFpz6uf2qM2liWSzH+BTlpn1EsJ6ilZ9tkF0A+HHWLZpPSV+VfonlgRMFen3CsrMX
         osa/dhAhNWV81Cn4/SC/mQJs/El+aFl/Yn4rn2JffW2YXTnqqcjPLmKmDJS/Nz/mF3
         o6tFpByalXRZ/Ekb94wAYi4NGx64/KKfiro2g/TAucCPI9AlysSSw8RGJ2cyOEvL0i
         DzkjzW+GgF7LRme+ZehgOVbGoVIqp1+yGMYIR1WGNvBojPdAybVI53DJ8sl5JaCVqy
         MshIgRuwMX+xw==
Date:   Thu, 30 Sep 2021 14:12:52 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memblock: Neaten logging
Message-ID: <YVYoVNFBMER4bjrT@kernel.org>
References: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Sep 29, 2021 at 09:43:14PM -0700, Joe Perches wrote:
> Use more typical kernel logging styles.
> 
> o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt

I don't see it as an improvement. On the contrary, the output becomes
somewhat tautological:

memblock: memblock_reserve: smp_scan_config+0xa5/0xe9: [0x00000000000f5a60-0x00000000000f5a6f]
memblock: memblock_reserve: smp_scan_config+0xbc/0xe9: [0x00000000000f5a70-0x00000000000f5b83]
memblock: memblock_reserve: setup_arch+0x5d8/0xbcd: [0x0000000002e00000-0x0000000002e10fff]
memblock: memblock_add: e820__memblock_setup+0x5e/0x76: [0x0000000000001000-0x000000000009fbff]
memblock: memblock_add: e820__memblock_setup+0x5e/0x76: [0x0000000000100000-0x00000000bffdcfff]
memblock: memblock_add: e820__memblock_setup+0x5e/0x76: [0x0000000100000000-0x000000013fffffff]

And the output of memblock_dump_all() is perfectly fine without the prefix.

> o Neaten memblock_dbg to use %s: %pS: to output __func__ and caller
> o Convert existing uses of pr_<level> and memblock_dbg appropriately
> 
> Logging output is now always prefixed with 'memblock: '
> Debugging output is now prefixed with 'memblock: ', function and caller
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  mm/memblock.c | 59 ++++++++++++++++++++++++++---------------------------------
>  1 file changed, 26 insertions(+), 33 deletions(-)

What is the base commit for this patch?
It seems it missed a pr_warn in memblock_cap_memory_range()...
 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 184dcd2e5d99..405335c966a8 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c

-- 
Sincerely yours,
Mike.
