Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE241AF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbhI1NGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:06:23 -0400
Received: from 8bytes.org ([81.169.241.247]:40054 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235776AbhI1NGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:06:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BA62C208; Tue, 28 Sep 2021 15:04:41 +0200 (CEST)
Date:   Tue, 28 Sep 2021 15:04:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <YVMS5GF/R3mpISWu@8bytes.org>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YVMAgFpGvKgBfx0P@8bytes.org>
 <20fc6806-0c46-15d6-930b-6b4e90dfee6d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fc6806-0c46-15d6-930b-6b4e90dfee6d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:56:03AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> This will only be called when CONFIG_ARCH_HAS_CC_PLATFORM is set by a platform.
> So it won't be called for all platforms.

Yes, but distributions will enable this in their default configs, so the
function call will happen on every Intel machine, even on bare-metal.

