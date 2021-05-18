Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26467387014
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346278AbhERC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhERC5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:57:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=HtVYMIJVCcdPMV1ZIQfaVF7WDdZ7Z5IeSQsP+a0c6/Y=; b=Re1ARGvG6OoD/+bc1RstFAz9EW
        xNnEKrivytc77Y5KGJicIPFm19nPLrrmdPOrXjXzB6LhcIEq8f1rZxaXe6e/wMesVdfvjx98MjB+4
        NEx83wvtKdBwzYVGpe1A3kT39kUiDxMTIkJTGPpNFYuO9wzVJWwf6k0aL6tkS0zXCq8+tnt27M03M
        SY7UDnxHSgHvnPiPhYonqqdQi513L1FcNMbO8I9pTsh7wfcvpr6Q1ADabiqUQ0krd9sGEYafqBjST
        9U2sQLQYARD8vSXjX4CY5bItqJ1Uf2KuT2nXD7ApuvcEaRLxjIumOexzVQny+BKeb3bhFchrvAW8K
        M1d5f+BQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lipti-00EHK1-AP; Tue, 18 May 2021 02:55:54 +0000
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
 Forwarding
To:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210517220059.6452-1-rsaripal@amd.com>
 <20210517220059.6452-2-rsaripal@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <20c6fa3d-949d-156a-6d74-89829e3bffdf@infradead.org>
Date:   Mon, 17 May 2021 19:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517220059.6452-2-rsaripal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 5/17/21 3:00 PM, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> 
> Certain AMD processors feature a new technology called Predictive Store
> Forwarding (PSF).
> 
> PSF is a micro-architectural optimization designed to improve the
> performance of code execution by predicting dependencies between
> loads and stores.
> 
> Incorrect PSF predictions can occur due to two reasons.
> 
...

> 
> Kernel parameter predictive_store_fwd_disable has the following values
> 
> - on. Disable PSF on all CPUs.
> 
> - off. Enable PSF on all CPUs.
>        This is also the default setting.
> 
> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/msr-index.h              |  2 +
>  arch/x86/include/asm/nospec-branch.h          |  6 ++
>  arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
>  5 files changed, 108 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..a5f694dccb24 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3940,6 +3940,11 @@
>  			Format: {"off"}
>  			Disable Hardware Transactional Memory
>  
> +	predictive_store_fwd_disable=	[X86] This option controls PSF.
> +			off - Turns on PSF.
> +			on  - Turns off PSF.
> +			default : off.


and as I did earlier, I still object to "off" meaning PSF is on
and "on" meaning that PSF is off.

It's not at all user friendly.

If it's done this way because that's how the h/w bit is defined/used,
that's not a good excuse IMHO.

Hm, it sorta seems to be a common "theme" when dealing with mitigations.
And too late to fix that.

I look forward to h/w that doesn't need mitigations.  ;)

-- 
~Randy

