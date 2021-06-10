Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41A63A2FED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFJP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:58:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48050 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhFJP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:58:33 -0400
Received: from zn.tnic (p200300ec2f0cf600591105fc6a1dcc4d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:5911:5fc:6a1d:cc4d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0063D1EC047D;
        Thu, 10 Jun 2021 17:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623340596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S6ZFVjibuCZ/SvpDPDx6vKOtAnYSm8apnxn3qMWDZ30=;
        b=KJ2fGTdPkLTeOy2yFr+JwRXvydlsdZampuf0ohyeCCmo4r3CLdJupYMaoeWPXif3m9fq7W
        +1WZ/zVAg6GUXOZ0k96oIAcpGw6tx31x1sGwUe0G4glC/n6KzO0NR92m08oLBfRYvzYvPn
        2vFyaMybIKOA7R6UPwPUilNCa8an6G4=
Date:   Thu, 10 Jun 2021 17:56:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YMI2MtZ/poULESej@zn.tnic>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMIFVh9WpDiUuRsa@zn.tnic>
 <20210610142943.uohw6nzpip5yi4no@box.shutemov.name>
 <YMIjRC7dD4als88Z@zn.tnic>
 <20210610144111.lfqs43xweiaogdic@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610144111.lfqs43xweiaogdic@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 05:41:11PM +0300, Kirill A. Shutemov wrote:
> Yes. You are on CC:
> 
> http://lore.kernel.org/r/9a74fb153bc21dc5cac46e84913b88182f216d1b.1605232743.git.isaku.yamahata@intel.com

Aha, a synthetic flag for the hv functionality, ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
