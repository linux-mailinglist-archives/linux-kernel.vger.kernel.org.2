Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66384006AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350477AbhICUeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:34:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36248 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236047AbhICUeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:34:22 -0400
Received: from zn.tnic (p200300ec2f0d5800d6a7aa80667574a9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5800:d6a7:aa80:6675:74a9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9BAB1EC05D1;
        Fri,  3 Sep 2021 22:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630701200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MAzqKX6VtyCSndmZDNFL0QMi196VzCUfmu+JJoWFdbw=;
        b=qNaW6q+V7k91JL9JauzWHVNzWW7iJ3zAdxB2Ppu90Bk/biE9mqv/LvFP5m28U1EAH3GwgL
        hS4Wq4g6QaSJB/GFxx8T10heAENvfC3UF0Z1mtivAUXtvOro5ydb91h8mUxRuMs4idmHpq
        zBy0Vc0inieQN/Gywh/3xwIedXObLqA=
Date:   Fri, 3 Sep 2021 22:33:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <YTKGs/EaVBWhEbQW@zn.tnic>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YTJn0HOkMd0thT+3@zn.tnic>
 <256d0f5b-3a6d-0912-2edc-44b4a0889c73@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <256d0f5b-3a6d-0912-2edc-44b4a0889c73@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 12:03:56PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Is this new convention?

No, not new:

git grep -E "^#\s+define" *.h

> #ifdefs used in this file does not follow this format.

That's why we fix them so that they do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
