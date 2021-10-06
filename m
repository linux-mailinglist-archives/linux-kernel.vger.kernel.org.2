Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD80742400E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhJFO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhJFO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:28:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7CC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:26:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d3600bd612f435519a27c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:bd61:2f43:5519:a27c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DE4A1EC0298;
        Wed,  6 Oct 2021 16:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633530399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c8HncWWjkOCJNcpjE65wOxQUt6zKO4hMGVTQYopo1WA=;
        b=Jxm0jSgA1kXDGfU8E47pMjxPbBEAEcwhGDbMaVK6xXqoBuHo0g0+wZliN9SfAaNjIqCch+
        ClMv885IY4Wt8sjnmfunh1w8z2l814pjsgc2RB7BHnLWWN/TDDpUpN+k7nWJ60HVG/2c9M
        u0yLCuBeAiUJO5TGXN5l2zvJFwJWFok=
Date:   Wed, 6 Oct 2021 16:26:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YV2yGTSSBDet5mtC@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005210423.yfftpxxmj3cjprtv@treble>
 <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
 <20211006034218.ynamwigsvpgad7sr@treble>
 <f15d1b41-e4fb-0203-88f7-dbac3f4e5307@linux.intel.com>
 <20211006050309.ldn5myznmpurnomm@treble>
 <YV2a7h5AKCcTQLsT@zn.tnic>
 <20211006141105.offh3fqhyupzqs7v@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006141105.offh3fqhyupzqs7v@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 07:11:05AM -0700, Josh Poimboeuf wrote:
> Ok.  At least it sounds like cc_platform_has() needs a comment stating
> that caps can't be relied on, and why.

I thought about turning the hunk here:

https://lkml.kernel.org/r/YVL4ZUGhfsh1QfRX@zn.tnic

into a patch. But since we won't be using caps there, it would look
weird so I guess a comment's fine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
