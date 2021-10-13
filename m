Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD742C058
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhJMMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhJMMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:45:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068CBC061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:43:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1208001796bb6dc2170571.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:1796:bb6d:c217:571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E2FA1EC0577;
        Wed, 13 Oct 2021 14:43:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634129008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XE8ltkogL3ZloHRvoO7qaVQXnrsFXVLoSwyd6eHml3k=;
        b=l0mYZGO9T4MxiOh2ympBDn8JW88mOlaWNWGzNytTLsdLso+FDLJtPXJsGXIVr7pqu5lhg3
        4kDTvZxoT9n7rPIOVF0zJQo/CdW3XNHdSlZJB6Lz3wTA0GSeBG4nqBYcTkZkE0wVCk7oHh
        lc5TIHbljAuFb5sMbWf3WB2IR7EwZ14=
Date:   Wed, 13 Oct 2021 14:43:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <YWbUbSUVLy/tx7Zu@zn.tnic>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:23:11AM +0700, Ammar Faizi wrote:
> "Figure 3.4: Register Usage" is not the answer, if it were, nolibc.h
> would be broken as it is missing "rdi", "rsi", "rdx" in the clobber list.

It is not about what happens in practice but what the contract is:
syscall argument registers can potentially get clobbered and userspace
should treat them as such. Because if the kernel decides to actually
clobber them for whatever reason and some userspace thing thinks
otherwise, then it is the userspace thing's problem as it doesn't adhere
to the well known ABI.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
