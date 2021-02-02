Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5A30B64D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhBBEPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhBBEPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:15:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26DDC061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JYD32y2pCYheVKqTUNSoOdE4Gv7Pp5EIyc3LAnDYu5M=; b=U3KBmP9zckJpHWtDV02WPdShFq
        jHnMI4U2XgSYedJhJP/6/MVzO8ZoC/w5ZRuzX77YTejUHTxi58CpUsq20ZR344qTB5iTol5FQlX2B
        4wfFoYrFzTl/7jDTC6GFw+54WVal9VIM/Rbb+GJ6nYL07OMKFvNpB7t/0QxTpEO7EkJ1kOKd14Pdx
        wgE43ssooMjbex4vg5Je4FHWWBs5+v0rqGfdKXX2/Gka7Wu+QRqTHnxv2yzyn2bVVGETUpm+jiH4z
        J5xP3XJH97Dc7RgcYJ/LEJ51FIi6rPTVvqrSFB/bgJpHVWBl92KUsRI3jWRb/SSWmZsd7vtnnSYeM
        X33Fp0uA==;
Received: from [2602:306:c5a2:a380:9e7b:efff:fe40:2b26]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6n55-00Eglh-Au; Tue, 02 Feb 2021 04:14:26 +0000
Subject: Re: [PATCH] dma-mapping: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1612237276-111378-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <bff00a1b-d7bd-0314-f0ee-bef292302b78@infradead.org>
Date:   Mon, 1 Feb 2021 20:14:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612237276-111378-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 7:41 PM, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./arch/powerpc/platforms/ps3/system-bus.c:606:2-3: Unneeded semicolon
> ./arch/powerpc/platforms/ps3/system-bus.c:765:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for your patch, it looks good.

Acked-by: Geoff Levand <geoff@infradead.org>

-Geoff
