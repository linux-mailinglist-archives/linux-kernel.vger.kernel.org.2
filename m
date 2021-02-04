Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425B730F346
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhBDMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbhBDMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:37:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B6C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lX7iwFJIwyhAiv1j9hQe0jAQ98de3k2S3cgvATMKuT8=; b=Po+H8FMhRGxCfokUVBTpJeWLFa
        muPLstpAuu/qRn3Q4IBm4oqMpWj5en7Dob4RLTnSP6s1lmU1anfErXTv78BudVgfcePZj1LyTBZw5
        mOb6QXaLMdyhIc42Gk0K8IWqVKKTYWSDtqNCaWxuKlB99aUI9+TWYijLccUK28pbVm8hxSl6m0+t+
        enbPTKjjBwR8RCWkpv6g3lgsRAhMrlajjZRv+ovqrL0eNJh6toFHv/IGqOOAcvCfe4F0bPBDOANKx
        2H7VoIBgBEjJZmRV40YAVzB06vHuNmd1q3XS1XSyIqlOHZn/1EbSLwmeTNcGZsZLuhI2bmpA4HZPs
        dNlkpfJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7drh-000rij-Fj; Thu, 04 Feb 2021 12:36:09 +0000
Date:   Thu, 4 Feb 2021 12:36:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/pgtable-generic.c: optimize the VM_BUG_ON condition
 in pmdp_huge_clear_flush()
Message-ID: <20210204123605.GD308988@casper.infradead.org>
References: <20210203084137.25522-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203084137.25522-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:41:37AM -0500, Miaohe Lin wrote:
> The developer will have trouble figuring out why the BUG actually triggered
> when there is a complex expression in the VM_BUG_ON. Because we can only
> identify the condition triggered BUG via line number provided by VM_BUG_ON.
> Optimize this by spliting such a complex expression into two simple
> conditions.

>  	pmd_t pmd;
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> -	VM_BUG_ON(!pmd_present(*pmdp) || (!pmd_trans_huge(*pmdp) &&
> -					  !pmd_devmap(*pmdp)));
> +	VM_BUG_ON(!pmd_present(*pmdp));
> +	/* Below assumes pmd_present() is true */
> +	VM_BUG_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));

This is not a complex condition.  We're in the huge PMD handling case
and we're looking at a PMD which either isn't present or isn't huge.
It might be useful to print out the PMD in such a case, but splitting
this into the two cases of pmd-not-present and pmd-isn't-huge isn't
particularly useful.

I think you know that, or you wouldn't feel the need to put in a
comment explaining it!
