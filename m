Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168C441B2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbhI1PYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:24:53 -0400
Received: from 8bytes.org ([81.169.241.247]:40190 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241080AbhI1PYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:24:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6623729C; Tue, 28 Sep 2021 17:23:09 +0200 (CEST)
Date:   Tue, 28 Sep 2021 17:22:34 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/11] x86/traps: Add #VE support for TDX guest
Message-ID: <YVMzOsrAHOONG2Ki@8bytes.org>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YVMHmt/cf63w93A+@8bytes.org>
 <63e59789-ce23-6b2b-5ef4-3782e7ddffd6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e59789-ce23-6b2b-5ef4-3782e7ddffd6@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 07:05:40AM -0700, Dave Hansen wrote:
> "Shared" pages can cause #VE's.  The guest must be careful not to touch
> them in the syscall entry path, for example.  But, shared pages are
> untrusted so they're not use for stacks.
> 
> "Private" pages can cause #VE's.  But, only *some* of them.  Before a
> page is accepted, it is in the SEPT_PENDING and a reference would cause
> a #VE.  But, after acceptance, page references either succeed or a TD
> Exit and the hypervisor gets to handle the situation.

Okay, and there is no way for the VMM to replace an already accepted
page with a page in SEPT_PENDING state?
