Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01A735B2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhDKJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:26:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKJ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:26:03 -0400
Received: from zn.tnic (p200300ec2f23de002e7d52dd33d8f804.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:de00:2e7d:52dd:33d8:f804])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 485DB1EC0283;
        Sun, 11 Apr 2021 11:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618133146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Gv2RXv40YjtCzlOZL0wWbh/CUOV9xLmCkRj2zzVplVk=;
        b=B8TZtCk0Nin2Q4eI79aiGTGGpP+s2R8svFThA7abtKWL76U7xctlFBDSq+cfAdGljsSGv6
        i7OA5v7e9ZrkNGER+WVJgA567/OUVNOYkvtOhL2SQMk01xwsXgCEayu7RrMqkPqO28cXbj
        8Dy1ScCmlItYak7c0mCqZppR1Z4AEpQ=
Date:   Sun, 11 Apr 2021 11:25:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: pat: Do not compile stubbed functions when
 X86_PAT is off
Message-ID: <20210411092543.GB14022@zn.tnic>
References: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
 <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
 <a2788ff7-c524-52de-3f45-82613410f872@siemens.com>
 <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
 <802cefc7-b475-c6d6-ece7-8232d7f3891d@web.de>
 <20210411091056.GA14022@zn.tnic>
 <7c606ebd-e8d8-0853-bab5-5e77b1359dcc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c606ebd-e8d8-0853-bab5-5e77b1359dcc@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 11:12:32AM +0200, Jan Kiszka wrote:
> The patches are coming from downstream usage, yes,

Ok, for the future, it would be good to mention that in the commit
message so that a committer knows what they're for.

> but I think the solutions are relevant cleanups for upstream as well.

Yeah but you know that we generally don't do "preemptive" fixes like
that. But those are small enough so I don't see a problem...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
