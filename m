Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070CA317188
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhBJUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhBJUmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:42:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ffXXoDs2uln3x+rwTmnLUWxiXxMLbbvRHx5lejL87VU=; b=u8/W/GVB3sqPbA6a2C5XMhKF9q
        SPA9E5ayDFNr7PFF/dyjzxcA2qqzVaL6TkM8oL1KAz8LlX0um54mZrX41jolHpmNEibCeAKdlaq2d
        tvpSD1yB/W6nYHFisAo8FAkYngRpUDYIzdDdjq/T6remdW+F6W4MOKZeV7WfOmlp6g3MX8qoKA1x6
        2z8ZRD2MwO1dNltPLZh0zvFeXWijuGP7JQsrMarX12OIDA8qPXOa/cuyejnh0U3N9/Wr2bsbkwMYu
        V2SxJheMCCqN0iBeoZq4UU04MrswjDopXddw4yEnAfjzxIjyhUE7Uj2ttFqGFdX1TKzxmznnz0ysj
        E1mvA7kQ==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9wJN-00033I-Sr; Wed, 10 Feb 2021 20:42:10 +0000
Subject: Re: [PATCH] arch: x86: kernel: apic: Fix spelling theroretical to
 theoretical in the file vector.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, dwmw@amazon.co.uk,
        maz@kernel.org, peterx@redhat.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209135515.3865988-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e252b372-c726-68aa-2c35-c64e290e9730@infradead.org>
Date:   Wed, 10 Feb 2021 12:42:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209135515.3865988-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 5:55 AM, Bhaskar Chowdhury wrote:
> 
> s/theroretical/theoretical/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  arch/x86/kernel/apic/vector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 3c9c7492252f..aa9d3cf69580 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -1054,7 +1054,7 @@ void irq_force_complete_move(struct irq_desc *desc)
>  		 * of the interrupt on the apic/system bus would be delayed
>  		 * beyond the point where the target cpu disables interrupts
>  		 * in stop machine. I doubt that it can happen, but at least
> -		 * there is a theroretical chance. Virtualization might be
> +		 * there is a theoretical chance. Virtualization might be
>  		 * able to expose this, but AFAICT the IOAPIC emulation is not
>  		 * as stupid as the real hardware.
>  		 *
> --
> 2.30.0
> 


-- 
~Randy

