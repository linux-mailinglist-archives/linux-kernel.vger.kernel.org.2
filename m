Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36AC38C8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhEUOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:08:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49434 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhEUOIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:08:11 -0400
Received: from zn.tnic (p200300ec2f0ea400b1711cbbd717391b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a400:b171:1cbb:d717:391b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92DBB1EC05C4;
        Fri, 21 May 2021 16:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621606007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K8BcFfxWlskEBAltLRBqJWeBSRtx5p+D0WcH9Jk0FVo=;
        b=E2c2lgwKuDLGZiRFZ+3E4tapaz56BfvTrVzCzkSgi6rotAZLDtJ16k1VUDhBMwEcfiwltt
        H71Exp944PmIOdg5RZjYbxXC1CUzzUNi817/0lyhbxhjLCvrQA4yz6b0iok6soLIskah7Q
        Yx1dD36vAHJoHidc8HdoZjY9//FJp/A=
Date:   Fri, 21 May 2021 16:06:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] notifier: Return non-null when callback already
 registered
Message-ID: <YKe+ckYQHebPYLBD@zn.tnic>
References: <20210520202033.23851-1-bp@alien8.de>
 <YKeVbsLnAdpVUwAa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKeVbsLnAdpVUwAa@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 01:11:42PM +0200, Peter Zijlstra wrote:
> > @@ -25,7 +25,7 @@ static int notifier_chain_register(struct notifier_block **nl,
> >  	while ((*nl) != NULL) {
> >  		if (unlikely((*nl) == n)) {
> >  			WARN(1, "double register detected");
> 
> That should give a big clue^

Yah, the big cluebat... Was wondering whether to remove it, actually.
But then I'd need to audit all users whether they handle retval
properly. Sounds like a kernelnewbies project to me...

> > -			return 0;
> > +			return 1;
> 
> How about -EBUSY here?

Yah, anthing but 0.

But if we're gonna return -E things, -EEXIST looks like an even better
fit to me...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
