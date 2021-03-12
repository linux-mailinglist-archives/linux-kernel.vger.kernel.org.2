Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6E339044
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhCLOrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:47:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhCLOrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:47:37 -0500
Received: from zn.tnic (p200300ec2f095300759f96bc38110012.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5300:759f:96bc:3811:12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 551DC1EC0249;
        Fri, 12 Mar 2021 15:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615560455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MfFCSQX6upcoPWfFmtqgYwJe7OQg5nlgBsinNAf4s7U=;
        b=cvAuByi7+xXqXWw+bHT1we1Oln3qP2n2hw+Sz0eZX7h0Ug/Q7HuwD7LX68C/hR/ZhMVwVh
        NVvvYgTMd2uimqy3RrbGG6dNtXMexwzgpMJN7Ywluh3x602HQnCGN9Tok7ITbVlVbcYZlJ
        h2fvFvm/Wl4JlyNCwdlgFfLieXYA7Qw=
Date:   Fri, 12 Mar 2021 15:47:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210312144726.GA22098@zn.tnic>
References: <20210312113253.305040674@infradead.org>
 <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:29:48PM +0100, Sedat Dilek wrote:
> What does this change exactly mean to/for me?

Probably nothing.

I would be very surprised if it would be at all noticeable for you -
it's not like the kernel is executing long streams of NOPs in fast
paths.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
