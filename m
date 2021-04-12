Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E803C35C2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbhDLJwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:52:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51902 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238266AbhDLJht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:37:49 -0400
Received: from zn.tnic (p200300ec2f0521005a03b79cec231ba7.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2100:5a03:b79c:ec23:1ba7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D23B91EC0283;
        Mon, 12 Apr 2021 11:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618220248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7iVljervZjDqz9AaJl4SR3GBbEmbAb3i5CdiLL2u+rg=;
        b=e7Mcjvv0Ky2ydmdDgBdhLmgfdYA8MkRdKVEWil1RMc9wMGZrm6lmxlJExF/yMDPjTcB1F3
        UUlujeGbVSLSyPndW1GLsOuVoN4q9g7LRfveX9iDwa6acjvFtbkF44niW9PM3xcxBYX39J
        pnbULRwUmzgdjB2/qNK68adSHepepb8=
Date:   Mon, 12 Apr 2021 11:37:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
Message-ID: <20210412093728.GA24283@zn.tnic>
References: <20210411164342.GL3762101@tassilo.jf.intel.com>
 <C7F7BE8D-562B-4BC3-A209-8EDD7DAF0AAA@amacapital.net>
 <20210411170357.GD14022@zn.tnic>
 <CALCETrX-WvuK0hC21Zes6auU9gM702wd0fV2FyP9ha-ma3=71g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrX-WvuK0hC21Zes6auU9gM702wd0fV2FyP9ha-ma3=71g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 04:21:21PM -0700, Andy Lutomirski wrote:
> https://bugs.winehq.org/show_bug.cgi?id=33275#c19
> 
> I sure hope no one is still doing this.

Aha, IRET with rFLAGS.NT set. At least it is only an ad-hoc program to
fix this particular issue and I hope too it hasn't propagated somewhere
else.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
