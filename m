Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB2340CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCRSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCRSUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:20:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=KP81uY4onDw0bh1XsdPSUFPtpyk5GLIlqnt4BBVu1mw=; b=GWiqVZhXXRY89S6Pg1EfAma2J8
        63Kj+G2FZVAjCUU4gc9vnU+/6wlbEjcCOpNNa+fmWRmAYubYOXtaLGXfQ4zyRfQVkL0cO9WPXW70t
        hagEgn6tJe5yzkja4rweuGjpHKrshpYDlvnn+hyKD1vBImW636zGHKSKFHl6ZDekhc6gbzaFcOFdF
        bTibaTV5b4dmiZ/U35dK/tiggNXVSD0IK8l4zNJRNLQAMOa39JMdCxyFNBu5r2uwIQ4K1ncpexiHJ
        yVyxzJy+UYKClHPxop1qybL119AJpvGQOtLpHK8Li6ySQRRSYotEwpoenzQGHBJy1LcBix5cXPI38
        9PW+7sEQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMxFX-003LDe-RF; Thu, 18 Mar 2021 18:20:07 +0000
Subject: Re: [PATCH] mm: Few spelling fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        akpm@linux-foundation.org, rppt@kernel.org, peterz@infradead.org,
        tsbogend@alpha.franken.de, will@kernel.org, maobibo@loongson.cn,
        linux-kernel@vger.kernel.org
References: <20210318065831.9601-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <302bb00b-df7b-970a-1c47-b48a56c7a526@infradead.org>
Date:   Thu, 18 Mar 2021 11:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318065831.9601-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 11:58 PM, Bhaskar Chowdhury wrote:
> 
> Few spelling fixes throughout the file.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  include/linux/pgtable.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5e772392a379..4fcefd553a5c 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -852,7 +852,7 @@ static inline void __ptep_modify_prot_commit(struct vm_area_struct *vma,
>   * updates, but to prevent any updates it may make from being lost.
>   *
>   * This does not protect against other software modifications of the
> - * pte; the appropriate pte lock must be held over the transation.
> + * pte; the appropriate pte lock must be held over the transition.

I think that should be                                    transaction.

>   *
>   * Note that this interface is intended to be batchable, meaning that
>   * ptep_modify_prot_commit may not actually update the pte, but merely

Other changes are OK.


-- 
~Randy

