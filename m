Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE133E981D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhHKS7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231983AbhHKS6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FFD2610A3;
        Wed, 11 Aug 2021 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628708308;
        bh=vdYvbtM2dGDht3rO6eGEM9yfvtq8RxVaXP3rzYQ5CAE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tWOYCgNyiMgVvgDnqmyQVIkWrT076yCF7mKr6+NmLhiVG43Dnsi9g74L87u7y1fEs
         RhMCt+eiqL/Q+hcDxSs/DqxTVtRhEv1ZF9rsdMF1E5p3trb2NjTL1DnWUUKtnRiJsS
         UzplKrOEmK/hZXCONNGHE18LbpQ1eqoWyfvX2O82vIHf/hC5nS6VvvIzRPM+7VIVlW
         fomcZ9armD8piHy67WrDgxSdVBUIh7btTtUjOAA9NrYZE7E4bVpksaL0H1w6KXZGHw
         Wei0Vx3tNvZO0HqS5C/TpwAQ35YNv1WNCCpf8mzHLQ7IE1Qp/LflzX6bYy4MY+0Hzv
         50hGcJIgaSOjQ==
Subject: Re: [PATCH 07/18] ARC: ioremap: use more commonly used PAGE_KERNEL
 based uncached flag
To:     Mike Rapoport <rppt@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-8-vgupta@kernel.org> <YRNdiDnMjQ2hKzIV@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <07c12487-dc65-9d2a-71a5-65b47c98a460@kernel.org>
Date:   Wed, 11 Aug 2021 11:58:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRNdiDnMjQ2hKzIV@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 10:18 PM, Mike Rapoport wrote:
>> -	return ioremap_prot(paddr, size, pgprot_val(PAGE_KERNEL_NO_CACHE));
>> +	return ioremap_prot(paddr, size,
>> +			    pgprot_val(pgprot_noncached(PAGE_KERNEL)));
> But this becomes _PAGE_CACHEABLE now. What did I miss?

We now use pgprot_noncached()

arch/arc/include/asm/pgtable.h:30:#define pgprot_noncached(prot)        
(__pgprot(pgprot_val(prot) & ~_PAGE_CACHEABLE))

-Vineet
