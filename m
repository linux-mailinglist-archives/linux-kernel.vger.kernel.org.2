Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FB331DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCIDtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCIDsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:48:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=mi2jhWBF46upTC7UNzBVvz6aRExTaVgIfhgcOH1XEmM=; b=D/9H6OyddEHUFlmL7GuxWVHhOl
        2GE+QTquj9U9OocpXlnHdnPT7sdDgzPorsV3Klmpd2MpzD0qKQ8TOl46S8dYayK6XzFRdMDCqQhRD
        KiIcY8U+iULYRFxDZo6LAFltEv7teoOQw5913QfHNOh/QN/myZXH2RGAmQ9XYMk4V1FsfAjxWn1KC
        EAtKlPNdUUTloUKnpdmfj0aVe0Ke5lxi/n3zPqwrltkLzHpnmsd4XPkKNgWxIct4bb1kapfM9G3o+
        bzAyzETQr4zhlpuBbKxqXLQ5UKip7Bvrc6tspiqoguSrQuYEXOCt7RFQw4I5dzpAjbsHmNsgEU9Y/
        /WoRbfZA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJTMH-000bwj-U1; Tue, 09 Mar 2021 03:48:34 +0000
Subject: Re: [PATCH] arch: x86: boot: compressed: Fix a typo in the file
 head_64.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nivedita@alum.mit.edu, keescook@chromium.org, jroedel@suse.de,
        ardb@kernel.org, ubizjak@gmail.com, linux-kernel@vger.kernel.org
References: <20210309032038.3182206-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <db632f5a-1d9a-544b-9ec2-8720a6337529@infradead.org>
Date:   Mon, 8 Mar 2021 19:48:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210309032038.3182206-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 7:20 PM, Bhaskar Chowdhury wrote:
> 
> 
> s/performend/performed/

Subject: does not need "arch: " in it. Check git log for other
x86 commits to see how they look.

With that fixed:

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/x86/boot/compressed/head_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index e94874f4bbc1..a8c4095ee115 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -231,7 +231,7 @@ SYM_FUNC_START(startup_32)
>  	/*
>  	 * Setup for the jump to 64bit mode
>  	 *
> -	 * When the jump is performend we will be in long mode but
> +	 * When the jump is performed we will be in long mode but
>  	 * in 32bit compatibility mode with EFER.LME = 1, CS.L = 0, CS.D = 1
>  	 * (and in turn EFER.LMA = 1).	To jump into 64bit mode we use
>  	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
> --


-- 
~Randy
