Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5277D4539C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhKPTHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:07:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38804 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239717AbhKPTHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:07:39 -0500
Received: from zn.tnic (p200300ec2f1b8100142ca11f4b264b2f.dip0.t-ipconnect.de [IPv6:2003:ec:2f1b:8100:142c:a11f:4b26:4b2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 255FA1EC056D;
        Tue, 16 Nov 2021 20:04:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637089481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SqpdCHyPqdoFFnBbrhk6OQ+kXnHQNVVSP7gRJQ9Prs0=;
        b=QJ5D9flKeohto9+pBgWPC/NClITgLW9sWjdhNr8QKS6SzrUft8qpOezwlg4dt6H4+90BTY
        6E2g47IPcXUYBaOf33hOVU+RCh4oct49AOsjfwNx+by3CDtTE+eOXmfn3fQAbiiesUoEFM
        p9je6nAo0ipA2YlL0ab22dgU/TLxbFk=
Date:   Tue, 16 Nov 2021 20:04:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 03/23] x86,copy_user_64: Remove .fixup usage
Message-ID: <YZQAwUydf+1GJ5eC@zn.tnic>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.068505810@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110101325.068505810@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:01:05AM +0100, Peter Zijlstra wrote:
> Place the anonymous .fixup code at the tail of the regular functions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/lib/copy_user_64.S |   32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
