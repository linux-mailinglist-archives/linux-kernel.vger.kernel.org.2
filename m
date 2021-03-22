Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE731344EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCVSoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:43:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61213C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aU/UwboqgudsLTP0O1Tomg8b4db04KMc5kunvG1cL98=; b=OAU+NuZmisB4PeaGW3wSPyIhyV
        TFe88Xrvc/eDflESCde7TwrX4xBN9LvrNUusCNP5LDzhaDrzRih0s5wSoAdsVDxhSVCHjj+NITnSn
        ljLS01LF4BvNeyCJnn6B0ZeJMfXPi3OgEB/loR4RkyAaiO7UnL4GUYCytMBFWdZBix4XFRIuZqcfc
        84CQ4byq6z7JPHVFILo22mB9JiBxgLwyT3iWoZJyuds36K/wNdqztpLQSvGE4ZmzYpSEbX2zizlPW
        jGU7K/i8/TRguTmwji3KLDCMbinOmgxWi7FsG12sJNc2nZX6NHVa/wuKpPSgKL51ZJccVCr+qSrzB
        Hfv5sjMg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPWD-008vnK-Bs; Mon, 22 Mar 2021 18:43:27 +0000
Subject: Re: [PATCH] arc: include/asm: Couple of spelling fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, vgupta@synopsys.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210322123259.2894194-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c2e269cc-779a-0213-982b-84278efac595@infradead.org>
Date:   Mon, 22 Mar 2021 11:43:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322123259.2894194-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:32 AM, Bhaskar Chowdhury wrote:
> 
> s/interrpted/interrupted/
> s/defintion/definition/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/arc/include/asm/cmpxchg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index 9b87e162e539..dfeffa25499b 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -116,7 +116,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
>   *
>   * Technically the lock is also needed for UP (boils down to irq save/restore)
>   * but we can cheat a bit since cmpxchg() atomic_ops_lock() would cause irqs to
> - * be disabled thus can't possibly be interrpted/preempted/clobbered by xchg()
> + * be disabled thus can't possibly be interrupted/preempted/clobbered by xchg()
>   * Other way around, xchg is one instruction anyways, so can't be interrupted
>   * as such
>   */
> @@ -143,7 +143,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
>  /*
>   * "atomic" variant of xchg()
>   * REQ: It needs to follow the same serialization rules as other atomic_xxx()
> - * Since xchg() doesn't always do that, it would seem that following defintion
> + * Since xchg() doesn't always do that, it would seem that following definition
>   * is incorrect. But here's the rationale:
>   *   SMP : Even xchg() takes the atomic_ops_lock, so OK.
>   *   LLSC: atomic_ops_lock are not relevant at all (even if SMP, since LLSC
> --


-- 
~Randy

