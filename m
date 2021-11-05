Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA4446062
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhKEIDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhKEIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:03:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1E9C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ASh5/cxvMHIZe869IHe6A6T0W9qjPjOzQamPtFucorg=; b=J0UFHNyu4Ey2GehgPEIFL/0YNp
        O84NA3/ipAguXiZNfYumIL//yNvMDEIqIUROAVfDpoIqiekqxvjZ3jQ6FuGOTzESh2F8szVZe968C
        04seLgQW225Cy0w9e8y2gijmHm9vAo1MCu7Umvh8p6f4zd1D01aAU71Mpcnb5YgQRFgEOUEC8vHkb
        bjkJs/ox0E+yp1lyfqQ5aP+CU6AvKhg8wqNq23CX/Wrpt882jEwgSVYCGNHg21V6xZ1yktMagsdAm
        4+YEQt558FQEXhDBpPZQ6oha+XiCPo7g7vBuazCVFYvMc53sX8NdMnMkwtUfoMTxCzd37xmk4PeKM
        NcpLDLzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miu7g-006Ptw-2V; Fri, 05 Nov 2021 07:59:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B70E59869D8; Fri,  5 Nov 2021 08:58:51 +0100 (CET)
Date:   Fri, 5 Nov 2021 08:58:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 18/22] x86,kvm: Remove .fixup usage
Message-ID: <20211105075851.GJ174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.588957687@infradead.org>
 <0154963b-6bb5-fc33-6a29-bfa57f187c38@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0154963b-6bb5-fc33-6a29-bfa57f187c38@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 07:50:36PM +0100, Paolo Bonzini wrote:

> > +	FOP1E(op, dst) _ASM_EXTABLE_TYPE(10b, 10b, EX_TYPE_KVM_FASTOP)
> 
> There's a ret right after the 10b label, so I think you can just use this:
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 493511efa3dc..f382c03c5954 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -315,7 +315,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  	__FOP_FUNC(#name)
>  #define __FOP_RET(name) \
> -	"ret \n\t" \
> +	"11: ret \n\t" \
>  	".size " name ", .-" name "\n\t"
>  #define FOP_RET(name) \
> @@ -344,7 +344,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  	__FOP_RET(#op "_" #dst)
>  #define FOP1EEX(op,  dst) \
> -	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
> +	FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %esi)
>  #define FASTOP1(op) \
>  	FOP_START(op) \

That's much nicer, thanks!
