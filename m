Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64D306BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhA1EKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhA1EKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:10:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE9EC061352
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dHjr4+b32n5Ld7CvPJuLb69lRv8a0nSFBG6ooewveCw=; b=Pu8MnbVAcdKDvR/YcI3BgpRv3q
        E6J9lmscP0K0xYhoNznxlgZbCIV59CgK9+XPEo7yR+VPI9hpSD+PoROiPYDAI+vWAkvq2TkRsykPK
        hUq0kB2E1EPuR0ubrf+v0H89sprUXE6hsCB5+JRF2s8vFzC3TlnmFmxuhLC9niG0mCKbucv0Tkd1c
        86+ax2HV65lIRtwGvo+UYZFlco+9HcW6jdZQIkc5OUcOqxLn8W5UVxcfumxs740RKXoWdJYoL9DUF
        k8HHh5my40bzVh2Xd6t6vPPpkcoq6LrsiK7aBNZ6gIzBFW42PUUZHiRBMu+8roYM9KZSe3Cn4mh5k
        ATnJ/djw==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4yRY-00071z-4b; Thu, 28 Jan 2021 03:58:04 +0000
Subject: Re: [PATCH] arch_numa: fix common code printing of phys_addr_t
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20210128035533.23722-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2f945af5-0a44-b546-8e3c-cead8df5878a@infradead.org>
Date:   Wed, 27 Jan 2021 19:57:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210128035533.23722-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 7:55 PM, Randy Dunlap wrote:
> Fix build warnings in the arch_numa common code:
> 

This patch applies to linux-next, not mainline.


> ../include/linux/kern_levels.h:5:18: warning: format '%Lx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
> ../drivers/base/arch_numa.c:360:56: note: format string is defined here
>   360 |    pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
> ../drivers/base/arch_numa.c:435:39: note: format string is defined here
>   435 |  pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
> 
> Fixes: ae3c107cd8be ("numa: Move numa implementation to common code")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  drivers/base/arch_numa.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> --- linux-next-20210125.orig/drivers/base/arch_numa.c
> +++ linux-next-20210125/drivers/base/arch_numa.c


-- 
~Randy

