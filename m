Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8597535C8C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbhDLOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbhDLOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:32:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC96C061574;
        Mon, 12 Apr 2021 07:31:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f052100b992cfc3eab27929.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2100:b992:cfc3:eab2:7929])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 859EB1EC03A0;
        Mon, 12 Apr 2021 16:31:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618237901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Drxp9AwmCgzA/Iszpvwrzfn9ABJRPDxoumDeD2kDwN0=;
        b=Q7DrDWatKFZgNJBHP4Qx/QznmbVTPC09Oxn/rLikYikgm5ESUgyZ9nv+jmO5tKlGpYu9Ba
        4BNTO9HquC5hp9c/AbTXnzd3Bz1o/F5bTf828MHOEK9nZD2LXxQIQ+UieBuwn0pk4GBZep
        j/3SmxTJ6kkkyWwd8fdnJ40mROyoVuk=
Date:   Mon, 12 Apr 2021 16:31:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210412143139.GE24283@zn.tnic>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 04:19:29PM +0200, Florian Weimer wrote:
> Maybe we could have done this in 2016 when I reported this for the first
> time.  Now it is too late, as more and more software is using
> CPUID-based detection for AVX-512.

So as I said on another mail today, I don't think a library should rely
solely on CPUID-based detection of features especially if those features
need kernel support too. IOW, it should ask whether the kernel can
handle those too, first.

And the CPUID-faulting thing would solve stuff like that because then
the kernel can *actually* get involved into answering something where it
has a say in, too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
