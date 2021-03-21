Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFA34353D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 22:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhCUV5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 17:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhCUV40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 17:56:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575E2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKVzlnXlMJEe8ElFXRtjSh1k6bid7k0NG9SIS5uR8PA=; b=FZAYHZPHPR6Pue1/rnrR5Gngoq
        PzYViBmcz1y0iNsH+IWNLM2pgd1sGeEfLUx4qv4qUmql6HvRQi7bvcskp1tNO8aUhbvlxb4+nvL3+
        NGMmZrR0394lNgG7l/+1mgOHyDytF58BmQlHnzg6dHpwZrS+Ci4ozRWmX8FJcL8i/4E8Usuh/SzmN
        hNb09MB9uRWJKFhAYf6/SHN6aQRlwPZ/CCvSqjqIiMtJpZ14KX57Pj0p+x6uDpvgWT+jvcf+ZYQjg
        vDMOyxGl2hyMbHF6aSWB/HNgN8esOue0uzuxfevalj3RfVGYCkufi10vjOgijZh3/cIE3x4gxjaIq
        WN8SzdLA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lO63R-002Wfn-HO; Sun, 21 Mar 2021 21:56:14 +0000
Date:   Sun, 21 Mar 2021 14:56:13 -0700 (PDT)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry: Fix a typo
In-Reply-To: <20210321201345.994577-1-unixbhaskar@gmail.com>
Message-ID: <cdbd84e4-6099-3ab1-aa44-1f78ab93de1@infradead.org>
References: <20210321201345.994577-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_145613_599994_491A5967 
X-CRM114-Status: GOOD (  13.70  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote: > > s/swishes/switch/
    should be 'switches' 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/swishes/switch/

should be 'switches'

>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> arch/x86/entry/entry_32.S | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 4554a27a2747..c1fe264900e9 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1107,7 +1107,7 @@ SYM_FUNC_END(entry_INT80_32)
>  * Switch back for ESPFIX stack to the normal zerobased stack
>  *
>  * We can't call C functions using the ESPFIX stack. This code reads
> - * the high word of the segment base from the GDT and swishes to the
> + * the high word of the segment base from the GDT and switch to the
>  * normal stack and adjusts ESP with the matching offset.
>  *
>  * We might be on user CR3 here, so percpu data is not mapped and we can't
> --
> 2.31.0
>
>
