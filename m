Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9BE33D5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhCPO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:29:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236337AbhCPO2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:28:32 -0400
Received: from zn.tnic (p200300ec2f0a10000fac71d66926d7f1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:1000:fac:71d6:6926:d7f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B52F51EC01A9;
        Tue, 16 Mar 2021 15:28:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615904908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n7XxFFlXqURpzbVhg67J8XqqabDKpglB9F03flg/7dQ=;
        b=dFNvC/gOAr8ax/u8mWkyYQjWk8H4SoZvHGY3KQhXMmlFp6jxcxEiGA4slnIAh9dlP/bIU2
        K1BRxWXRzCAP+ypemAlfWpw/g6YKgelb/4FncxeUOUS5pyaKS/OeONeZE4/Vd1df3X3qHE
        UPS8kjSLURd3GUowMJVp6fuu1ub+V4s=
Date:   Tue, 16 Mar 2021 15:28:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/x86/kcpuid: Add AMD leaf 0x8000001E
Message-ID: <20210316142825.GB18003@zn.tnic>
References: <20210315125901.30315-1-bp@alien8.de>
 <20210315125901.30315-2-bp@alien8.de>
 <20210316074223.GC49151@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316074223.GC49151@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 03:42:23PM +0800, Feng Tang wrote:
> Also I'm wondering for some basic leaf and extended leaf which
> may has different definition for different vendors, do we need
> to seprate the csv to a general one and vendor specific ones.

Do you know of such?

Because AFAIK vendors own, more or less, each range. Like, Intel owns
the base range and AMD the extended so there should be no conflicts
actually...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
