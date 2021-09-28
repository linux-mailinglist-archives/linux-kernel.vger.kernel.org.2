Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3060C41AFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhI1NUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:20:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240669AbhI1NUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:20:33 -0400
Received: from zn.tnic (p200300ec2f13b20058b29c6ae6f5cd57.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:58b2:9c6a:e6f5:cd57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E4641EC06F0;
        Tue, 28 Sep 2021 15:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632835132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LjcqAr6iC5eAZQwo8NZC/xi/L1XaohYMz5bx+mVoIPM=;
        b=LobFhPA/kuaLJzh1ln3hzQmeEEf9bDCR/ekZM07TTqfUTgWHGQtRC7c+GxzMNk6vC7nNXp
        m7qXnk0OBnqqBFJAMRRkEuLPUfo23UvStV7pOc4Vuid6dkdQqYatiuz8vnIog6EkvXFXCj
        rSW6GTWFxLI6QXsXv/4QyokHieCRNpI=
Date:   Tue, 28 Sep 2021 15:18:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/11] x86/tdx: Add protected guest support for TDX
 guest
Message-ID: <YVMWNhSUc8nNpBn/@zn.tnic>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YVMAgFpGvKgBfx0P@8bytes.org>
 <20fc6806-0c46-15d6-930b-6b4e90dfee6d@linux.intel.com>
 <YVMS5GF/R3mpISWu@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVMS5GF/R3mpISWu@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 03:04:36PM +0200, Joerg Roedel wrote:
> Yes, but distributions will enable this in their default configs, so the
> function call will happen on every Intel machine, even on bare-metal.

The result of whether the guest is a TDX needs to be cached and queried
instead anyway:

https://lkml.kernel.org/r/YVL4ZUGhfsh1QfRX@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
