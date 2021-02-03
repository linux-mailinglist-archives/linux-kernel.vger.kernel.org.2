Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1919730D970
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhBCMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbhBCMBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:01:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516CC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:00:41 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c84005017455b058bf408.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:5017:455b:58b:f408])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 894E71EC0324;
        Wed,  3 Feb 2021 13:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612353639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iNR8QlX4YDC7YWVJjV9rWOyT5zUrM1pP8pRraf7704c=;
        b=pjo0NJt/YkDWZ9jQFICp9DrZYnm9uzcPyt+kCGI8kOX3skF9da/I82o5V54GyUss1DfVQg
        jxkX8LXCUxY295A9TBZVdHpZ3uf3MmRnoMaWwclsh6O2yvyF6VPBx+ejlacVNsZPYIqB7m
        e6yeQlCl0nfmcr+ucknWNhnhiR79T9U=
Date:   Wed, 3 Feb 2021 13:00:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/19] x86/insn: Add an insn_decode() API
Message-ID: <20210203120037.GA13819@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <9e5d1122-d5ad-93f2-143d-d0386d054e4a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e5d1122-d5ad-93f2-143d-d0386d054e4a@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 09:26:04AM -0600, Tom Lendacky wrote:
> > We could also say that probably there should be a way to say "decode
> > only the first insn in the buffer and ignore the rest". That is all up
> > to the use cases so I'm looking for suggestions here.
> 
> That's the way it works today, right?  One instruction, no matter the length
> of the buffer (assuming the length is long enough to include a full
> instruction)?
> 
> Because the callers of the decode may rely on parsing only the current
> instruction (like SEV-ES), it should probably default to that (although most
> of the call points are being updated so you could supply a boolean to
> indicate one vs many instructions). The caller doesn't necessarily know the
> length of the instruction, so it may provide a buffer of max instruction
> length.
> 
> Also, if you want to parse more than one instruction at a time, wouldn't you
> need to maintain register context within the parsing, I don't think that is
> done today. Or you could chain together some instruction contexts to
> identify each instruction that was parsed?

Yah, let's leave it all to the one who actually needs multiple insn
parsing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
