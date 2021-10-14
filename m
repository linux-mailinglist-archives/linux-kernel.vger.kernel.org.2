Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9742D452
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhJNH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJNH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:59:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02ACC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:57:42 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c72004cd8e1678c0b16c3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:4cd8:e167:8c0b:16c3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3ECF21EC03EA;
        Thu, 14 Oct 2021 09:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634198261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RLbTK0HRgG5pyCuStO02HK9+Id9iOaym4Axzlf6nny0=;
        b=ScMbOH7AXJPOCt+bcyatjILnCcnqdxt6B1ahhtXBPsjXlSgSS36bm7Z9dGG7TboUz9IEDO
        MQIYFSvvmO3fgSYwB2ou74z8ucYqRTKtQLq7+jC9X0pETjkmw8ulWLl/8pHr4bpnZ5lWoz
        hKUF9Vz/zluqFpiLc3jpkJNzGdlsu7M=
Date:   Thu, 14 Oct 2021 09:57:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YWfi9JrmaKDCALah@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWaWSmWn6AZ6OLx+@zn.tnic>
 <20211013194251.ndbyj45egz6msl63@treble>
 <87wnmg7bt0.ffs@tglx>
 <20211014002506.2rqkgzrvy5ki2rcw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014002506.2rqkgzrvy5ki2rcw@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:25:06PM -0700, Josh Poimboeuf wrote:
> I think Boris said that's not possible because of some ordering
> reasons which are eluding me (and I didn't have time to investigate).

The obvious one being that CPU caps aren't set yet. And then there was
this wild goose chase about fixup_pointer() and whether the compiler
generates rip-relative addressing to global vars in early boot code
which runs out of 1:1 mapping and could be loaded somewhere else...

So I'm not opposed to doing cap flags - that would get rid of the new
flags but it needs to be done carefully because with early boot, the
devil's in the detail.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
