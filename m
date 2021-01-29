Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1F308A36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhA2Q2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:28:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhA2Q23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:28:29 -0500
Received: from zn.tnic (p200300ec2f0c9a00bc6c1bcbdaab9684.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:bc6c:1bcb:daab:9684])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B0FB1EC04D3;
        Fri, 29 Jan 2021 17:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611937665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4e86qgr+0O2uLt7u9r31adGnaMdt4pUNUGxNQQ8uQ0I=;
        b=jiVCeiUa/IxTWSmrhS7F68BFTnbxTZd4G1ifeH4/x2/CX9zHdzikiKKvJriE9p5Sbqjsk6
        P2HFCCGPcoeS39iUFc6Ns/h6NKfWQLtAcoynkh7Btzl3mQ1iiySS1rbTp7dL2Gfzzsnu27
        08T8Dr4tgPnjDtmOeNDd0cgnUQZFmzA=
Date:   Fri, 29 Jan 2021 17:27:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>, x86@kernel.org,
        tdevries@suse.de, linux-kernel@vger.kernel.org,
        andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] x86/debug: Fix DR6 handling
Message-ID: <20210129162741.GC27841@zn.tnic>
References: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
 <20210128211627.GB4348@worktop.programming.kicks-ass.net>
 <20210129154109.GA1391@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129154109.GA1391@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 04:41:09PM +0100, Oleg Nesterov wrote:
> This seems to fix the problem reported by Jan, see his test-case below.

Should it be part of

tools/testing/selftests/breakpoints/

?

tglx has one destined for there already, wouldn't hurt to have a second
one:

https://lkml.kernel.org/r/87eei4d4k6.fsf@nanos.tec.linutronix.de

after applying kernel coding style to that one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
