Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C630DF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhBCQC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:02:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56310 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhBCQB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:01:58 -0500
Received: from zn.tnic (p200300ec2f0c8400c151208e8a6ffcb8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:c151:208e:8a6f:fcb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44BE81EC047F;
        Wed,  3 Feb 2021 17:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612368075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+AprxhwyzG9B2UiU6SqTBAQoAlPTVDpkIQvbWFeVEFk=;
        b=McyA79F7siBMg0VIW9zEIRNH6TxCrIlDYm9X+1DPkbH/3b/BntRvetSSqqSLfZH9QUCYPt
        l+f+IFoGS1vYAa5lwSSr+gQmfCdvVW8LqKykFmotK9wVlMlbMmCafPs4c/U0ND9xddkSBa
        hBSxVA9NPcIJ5Io6F/KlavII1hZjTbA=
Date:   Wed, 3 Feb 2021 17:01:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 06/11] x86/fault: Improve kernel-executing-user-memory
 handling
Message-ID: <20210203160117.GF13819@zn.tnic>
References: <cover.1612113550.git.luto@kernel.org>
 <05e787a0d0661d0bfb40e44db39bf5ead5f7e4ef.1612113550.git.luto@kernel.org>
 <20210201090840.GB3229269@infradead.org>
 <CALCETrWh7VzmSJLN5A2+rLsFnXAd6NVy9SmXJ-XB6FcTcg3yUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWh7VzmSJLN5A2+rLsFnXAd6NVy9SmXJ-XB6FcTcg3yUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:00:37PM -0800, Andy Lutomirski wrote:
> I defer to Boris as to exactly what condition we should check here.

Same as for erratum #91:

https://lkml.kernel.org/r/20210201203146.GC14590@zn.tnic

A single helper containing that check is probably a good idea.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
