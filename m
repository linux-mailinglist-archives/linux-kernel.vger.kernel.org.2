Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3458D30E384
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBCTq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:46:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34534 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhBCTq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:46:57 -0500
Received: from zn.tnic (p200300ec2f0c84001e2b7e52dd5f0f2b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:1e2b:7e52:dd5f:f2b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C30F1EC0258;
        Wed,  3 Feb 2021 20:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612381576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEKKyvJGz43IvDdVqV7aI/e19n+mpw7QIIVxLfD/Njw=;
        b=nfl8Er+8YP+P2wBwc0EafylrNAZy4iW5nQJiTlYP1ee/sGCC7kT3dKkh/3WEBYheYl4DXq
        zu9BHAXNRkfYkoEUfNppFMKT2E2s7lqLkH8PhHlW4d+xbdxUbGSQTNECwEtSt1VDwLhP9l
        +rQIB8S8Vf8V2DZvXiV0eZtdR3S11c8=
Date:   Wed, 3 Feb 2021 20:46:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 07/11] x86/fault: Split the OOPS code out from
 no_context()
Message-ID: <20210203194618.GJ13819@zn.tnic>
References: <20210203185517.GH13819@zn.tnic>
 <78B808CF-16E2-4C41-B680-0AFD1428ED4A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78B808CF-16E2-4C41-B680-0AFD1428ED4A@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 11:29:39AM -0800, Andy Lutomirski wrote:
> That function is a lie. It tries to keep the system alive but it
> doesn’t return if it “recovers”. Maybe I should add a comment?

... or rename it?

That schedule() at the end, I dunno if that does anything since we're
going to oops anyway...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
