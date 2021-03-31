Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE634FB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhCaIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhCaIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:24:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07318C061574;
        Wed, 31 Mar 2021 01:24:19 -0700 (PDT)
Received: from nazgul.tnic (dynamic-002-247-240-140.2.247.pool.telefonica.de [2.247.240.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67E0A1EC0512;
        Wed, 31 Mar 2021 10:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617179057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GWTbeFil51VPp2N2biMDxqCnfSXDO9wl1knPYykOd2g=;
        b=hnDbUDEqlyig+ElaKoLkpoQv/o9GnXYmiHzY2+epv2YcE9C4knooNjo9b7siCN+7TDwOxY
        LBoOrKLQjna8o8Uo9oIlDI32CvC1xQXPlzUU1Mfdy/aiME1jmF0k3kTbAKe6anw4a5iFt1
        TkmDno7GD4iu68vu3GsiJ0zGTlg0H58=
Date:   Wed, 31 Mar 2021 10:24:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210331082402.GA19389@nazgul.tnic>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:12:25PM -0700, Andy Lutomirski wrote:
> To detect features and control XCR0, we add some new arch_prctls:
> 
> arch_prctl(ARCH_GET_XCR0_SUPPORT, 0, ...);
> 
> returns the set of XCR0 bits supported on the current kernel.
> 
> arch_prctl(ARCH_GET_XCR0_LAZY_SUPPORT, 0, ...);
> 
> returns 0.  See below.
> 
> arch_prctl(ARCH_SET_XCR0, xcr0, lazy_states, sigsave_states,
> sigclear_states, 0);

Right, but I'd simply replace that "XCR0" arch detail, more or less,
with "XSTATE":

ARCH_GET_XSTATE_SUPPORT
ARCH_GET_XSTATE_LAZY_SUPPORT
ARCH_SET_XSTATE or ARCH_ENABLE_XSTATE or so

to denote that this is controlling XSTATE handling while the XCR0 thing
is the control register and when in the future something else does
control that (XCR0[63] is one provision for that) then we're still
on-point with the naming.

> Thoughts?

FTR, I really like the aspect of apps *requesting* handling of
non-legacy, fat states and latter remaining off otherwise in order to
keep the sanity of everyone involved.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
