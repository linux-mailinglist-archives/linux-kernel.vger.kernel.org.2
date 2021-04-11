Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7227335B640
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhDKREU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 13:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhDKRET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 13:04:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04BFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:04:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f23de00ab5e07665a016ca6.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:de00:ab5e:766:5a01:6ca6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F15521EC0537;
        Sun, 11 Apr 2021 19:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618160640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Fj6oUZT32RkTbK+v7PliIl6WkDBGmBT6G8FTqlcuAV0=;
        b=Ok85F3sdfr9rP/rnpttdKpi5qwOBR2xrQzk90m5KzPNUfpSRDN2g4AZVgd+oSzxRGpB64f
        nxJZmNlNWXGgV/t1nPPWi5DSd1qwRb2tGhYhkOxi+013iMCNAFHbU93+mBiZMcQe6S0rm5
        1Zi7xNNtLuRPYsAhy9vRIqxHb6BeqOM=
Date:   Sun, 11 Apr 2021 19:03:57 +0200
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
Message-ID: <20210411170357.GD14022@zn.tnic>
References: <20210411164342.GL3762101@tassilo.jf.intel.com>
 <C7F7BE8D-562B-4BC3-A209-8EDD7DAF0AAA@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C7F7BE8D-562B-4BC3-A209-8EDD7DAF0AAA@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 09:57:20AM -0700, Andy Lutomirski wrote:
> Working around a kernel bug. The workaround only worked on AMD
> systems. The correct solution was to fix the kernel bug, not poke
> MSRs.

Do you remember which program(s) and where I can get them to have a
look?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
