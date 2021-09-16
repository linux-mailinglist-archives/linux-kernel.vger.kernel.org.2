Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3532F40EAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbhIPTI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347476AbhIPTIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:08:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A6C0613A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:06:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f11c600a255bc81368aa6d8.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:c600:a255:bc81:368a:a6d8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1F741EC02DD;
        Thu, 16 Sep 2021 21:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631819213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yQsb5zTzN7+q1JBlshNJrgHZ+s2ohsiGBIs1h0SMgGM=;
        b=j7w6alr5afrOdWYg58+CHrtTsR58uWYjRXMn9Meyovca295E5b1Jkj9sEmZ89K5/tpA4/T
        zNFGdF6fVmnkaSuQnF+UmesYXdEqBJP9SCGsqB0g2pfH+IK7bIeyvwqvBRkuqcSHa9gxrW
        cITaaF8zNevtAxdoW7EPx1f9vyfSX+8=
Date:   Thu, 16 Sep 2021 21:06:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/12] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
Message-ID: <YUOVzLh4V+ZVB+k/@zn.tnic>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <645f6e73-1211-5ee2-07f7-cf4023358706@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <645f6e73-1211-5ee2-07f7-cf4023358706@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:44:48AM -0700, Dave Hansen wrote:
> How did this end up out of line?  This means that if you compile-time
> enable support for even *one* "cc" platform, you can't optimize the
> calls away.  This ends up being at *LEAST* two calls, just to get an
> unconditional "false".  That just seems silly.
> 
> I know this is a comment more about the cc_platform_has() series that
> this one, but this compounds the problem.

Posting here too for the wider audience - follow this thread pls:

https://lkml.kernel.org/r/9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
