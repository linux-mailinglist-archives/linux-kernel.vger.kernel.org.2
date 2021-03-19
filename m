Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC1341A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCSKkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhCSKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:40:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:40:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f091e0031f92e39b93e7933.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1e00:31f9:2e39:b93e:7933])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD84F1EC0266;
        Fri, 19 Mar 2021 11:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616150441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QyYzaUcc39j+bPjdua1wzMkbnxXxaoxdtY3xpeCJyB8=;
        b=MT/ocn5rTDfPQs2iKnJSR/4Kk6LsirOhEpYWLRjyR1+VNYolG/33Vx2uDMy5U383pQBrFZ
        O1YyAHeQCnwb+seNwvNjjj8d5kGFvoMWQMzEKewyrGQ43hCNtyfkuffsKUdwfQh6+qCiX/
        O9E8lQAG3VH0DyunYV1WC3hZC08Hi8s=
Date:   Fri, 19 Mar 2021 11:40:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] x86: Add insn_decode_kernel()
Message-ID: <20210319104045.GE6251@zn.tnic>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.458304970@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171919.458304970@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:04PM +0100, Peter Zijlstra wrote:
> Add a helper to decode kernel instructions; there's no point in
> endlessly repeating those last two arguments.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/insn.h        |    2 ++
>  arch/x86/kernel/alternative.c      |    2 +-
>  arch/x86/kernel/cpu/mce/severity.c |    2 +-
>  arch/x86/kernel/kprobes/core.c     |    4 ++--
>  arch/x86/kernel/kprobes/opt.c      |    2 +-
>  arch/x86/kernel/traps.c            |    2 +-
>  tools/arch/x86/include/asm/insn.h  |    4 +++-
>  7 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
