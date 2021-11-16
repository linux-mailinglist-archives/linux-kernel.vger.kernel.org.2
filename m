Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC33C452EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhKPKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233795AbhKPKHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:07:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A496152B;
        Tue, 16 Nov 2021 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637057051;
        bh=HFL0Gw1RVO32KPabNgK9ghbEvylzrRiWzcYgj8e+oDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4cm7xF1rEIxsuQafQtnK18GJwO38WxptPtsHov6hg1Mwd2/e4i+L0OPiGCtiw2D0
         8k7l5MWn9SK74kcD7m50Z1I4Y0mSnp+4gR2nd320npBdlkxHPO6mY9JiyJOY+ASGX8
         bm6mFtcdnG2JyernNFvxML+l/ULiPclC5b3PIUsy6SBcd2Qf29cUAxw2o0wmDCjWMe
         JyMcWU3sCcThI9R++1pXtMan4rUnr4u99QKo7CWhN1OeaFkxgU17mNN5W6mR+L+J8G
         PuMg64KXXWmfpDo7RQHc9RN4lOWDfcQzgSDMU5AmAHMZPI9wcgm4kV65qh1p+GuGO5
         1eqvAWxIrqIpA==
Date:   Tue, 16 Nov 2021 10:04:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] scripts/sorttable: Unify arm64 & x86 sort functions
Message-ID: <20211116100406.GA9851@willie-the-truck>
References: <20211108114220.32796-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108114220.32796-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:42:20AM +0000, Mark Rutland wrote:
> The format of the arm64 and x86 exception table entries is essentially
> the same as of commits:
> 
>   46d28947d9876fc0 ("x86/extable: Rework the exception table mechanics")
>   d6e2cc5647753825 ("arm64: extable: add `type` and `data` fields")
> 
> Both use a 12-byte entry consisting of two 32-bit relative offsets and
> 32 bits of (absolute) data, and their sort functions are identical aside
> from commentary, with arm64 saying:
> 
>    /* Don't touch the fixup type or data */
> 
> ... and x86 saying:
> 
>   /* Don't touch the fixup type */
> 
> Unify the two behind a common sort_relative_table_with_data() function,
> retaining the arm64 commentary.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  scripts/sorttable.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
