Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED678322988
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBWLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhBWLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:33:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B89CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hUpc3PXQdAdhb4dQ+7PYKmRaLkX64aDNTI4E/lbC+9M=; b=UZ2n6crrmf4Gormd/ax42K575L
        YfLMMy+N/3teVnN1S0E6b/HEQ5m1xRCXE5LBHWLYvKdA6fBRBtu0ALxJy/UJqvrPwYCsROfnbIKAV
        9nU1cRNjN+gXLn2zC0wScFEDWgcx4O8D58wllQMXbKKKtrC+Ce4vDJ2IYxFumXb2ZsTum3S3ni3O/
        LeNMDNaDcYUGxNSaWMqg+SKKWG08zzjy0Pm/EqvlXOKowhSy/DKpjL1Vd8fjwGBnjZTwItQLtDOQm
        IvPnnuj9nQ8Fv2wPxqLEnqNPkMRczZzqTJCCsNm3WG10AR6P1M2a9imv+rsON54OArKtQhX6G6byX
        Lw12TgYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEVvF-000662-Pj; Tue, 23 Feb 2021 11:32:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38287300DB4;
        Tue, 23 Feb 2021 12:32:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 216AB200E0496; Tue, 23 Feb 2021 12:32:07 +0100 (CET)
Date:   Tue, 23 Feb 2021 12:32:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     zuoqilin1@163.com
Cc:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] include/linux: remove duplicate description
Message-ID: <YDTnt8SDTLJlPlP1@hirez.programming.kicks-ass.net>
References: <20210223092539.941-1-zuoqilin1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223092539.941-1-zuoqilin1@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 05:25:39PM +0800, zuoqilin1@163.com wrote:
> From: zuoqilin <zuoqilin@yulong.com>
> 
> linux/spinlock.h
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>  include/linux/spinlock.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 7989784..732150e 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -43,8 +43,6 @@
>   *
>   *  linux/spinlock_api_up.h:
>   *                        builds the _spin_*() APIs.
> - *
> - *  linux/spinlock.h:     builds the final spin_*() APIs.
>   */

I think not, now the UP comment it incomplete.
