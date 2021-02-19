Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109B331F551
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:15:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhBSHPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:15:23 -0500
Received: from zn.tnic (p200300ec2f046700b7f7c11af57b3c30.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:6700:b7f7:c11a:f57b:3c30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 012101EC030F;
        Fri, 19 Feb 2021 08:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613718882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lc/b9W+3h+xWmr5smQ3gv/hU4hGpEacEf7tLiNc9UJ4=;
        b=cBrDAliCNAldpT8USSGX68Vfw4LADXxTFYS32YBdNC+pTrAmFpHJWtA3OLWLtv7b889Tyv
        GJfy3KuilF6y+CUpZ+XmsW1VSRAFa9Q/LphlY0GfVk4JbJqmfrg7vdlikcWwDzY0EpB+EC
        2ZTlZzwIt2M1+oe6+8XlBmW9Vr4IVY8=
Date:   Fri, 19 Feb 2021 08:14:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, tony.luck@intel.com, pjt@google.com,
        linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        jpoimboe@redhat.com, jikos@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86/retpoline: Compress retpolines
Message-ID: <20210219071439.GA26778@zn.tnic>
References: <20210218165938.213678824@infradead.org>
 <20210218172151.942060087@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218172151.942060087@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:59:40PM +0100, Peter Zijlstra wrote:
> By using int3 as a speculation fence instead of lfence, we can shrink
> the longest alternative to just 15 bytes:
> 
>   0:   e8 05 00 00 00          callq  a <.altinstr_replacement+0xa>
>   5:   f3 90                   pause  
>   7:   cc                      int3   
>   8:   eb fb                   jmp    5 <.altinstr_replacement+0x5>
>   a:   48 89 04 24             mov    %rax,(%rsp)
>   e:   c3                      retq   
> 
> This means we can change the alignment from 32 to 16 bytes and get 4
> retpolines per cacheline, $I win.

You mean I$ :)

In any case, for both:

Reviewed-by: Borislav Petkov <bp@suse.de>

and it looks real nice here, the size:

 readelf -s vmlinux | grep __x86_indirect
 78966: ffffffff81c023e0    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 81653: ffffffff81c02390    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 82338: ffffffff81c02430    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 82955: ffffffff81c02380    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 85057: ffffffff81c023f0    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 89996: ffffffff81c023a0    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 91094: ffffffff81c02400    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 91278: ffffffff81c023b0    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 92015: ffffffff81c02360    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 92722: ffffffff81c023c0    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 97062: ffffffff81c02410    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 98687: ffffffff81c023d0    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 99076: ffffffff81c02350    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
 99500: ffffffff81c02370    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]
100579: ffffffff81c02420    15 FUNC    GLOBAL DEFAULT    1 __x86_indirect_t[...]

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
