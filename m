Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5444592A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhKDSDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:03:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234029AbhKDSD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:03:29 -0400
Received: from zn.tnic (p200300ec2f0f2b00d41ed3305b1ea114.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:d41e:d330:5b1e:a114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5635A1EC0521;
        Thu,  4 Nov 2021 19:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636048850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JRN1wnmb72V2+aOEZgc4zMu+7diDFEtY3HFFtJI0eMo=;
        b=mfhPIi+brEbAvzMbXqyoLhqDsB04W4L4PyqHGInFRz5+aSAs1k5tu/jW5NMS9VWsLcnG97
        nQheq4X+DE38xoEVG9u19oJ4eD4TG+dR0+vX7RU+YZssk2pwdvp4zJxtvoKor3qUY7dOM0
        M1o6TRH1uEjDZorxPaqDPYK3qwD7Wig=
Date:   Thu, 4 Nov 2021 19:00:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [RFC][PATCH 02/22] x86,mmx_32: Remove .fixup usage
Message-ID: <YYQfy2CNYyXO4KLV@zn.tnic>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.625383149@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165524.625383149@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:31PM +0100, Peter Zijlstra wrote:
> This code puts an exception table entry on the "PREFIX" instruction to
> overwrite it with a jmp.d8 when it triggers an exception. Except of
> course, our code is no longer writable, also SMP.
> 
> Replace it with ALTERNATIVE, the novel
> 
> XXX: arguably we should just delete this code

Yah, might as well.

Wikipedia says the last AMD CPU which supports 3DNow is A8-3870K which
is family 0x11, i.e.,

1. a real rarity
2. it is pretty much obsolete
3. even if not, it can do AMD64
4. and even if people who have it, wanna run 32-bit, they can use the
normal memcpy, i.e., CONFIG_X86_USE_3DNOW=n should work there

In our case, it is a bit different, though:

config X86_USE_3DNOW
        def_bool y
        depends on (MCYRIXIII || MK7 || MGEODE_LX) && !UML

MK7 is K7 - that is practically dead.

The only thing I have no clue about are those cyrix and geode things and
whether they're still actively used in some embedded gunk.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
