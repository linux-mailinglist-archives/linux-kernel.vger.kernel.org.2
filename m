Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD2423E09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbhJFMtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:49:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57486 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238545AbhJFMtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:49:35 -0400
Received: from zn.tnic (p200300ec2f0d360075f221dbc8708d3a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:75f2:21db:c870:8d3a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 695041EC03AD;
        Wed,  6 Oct 2021 14:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633524462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OIi5fQlCiQUmAZsMGAxtcqUTEjX4uAH3bLsnXW/m3AE=;
        b=BL02zMUMndK1m1ADZIZ26PUo6GYsrPkSbrNA7xo5I6gGUl/I0fOJzdYaUcD6md5yQLXuYf
        FnVttnzGb+VEX9lImIoiaKZXqNZYgquYVy1jxRyn52QnkkvYh0rw57y9i36hy0VHzYNplo
        PDBnzP/uRu/o/3GHgVXw+GY1aePpm8g=
Date:   Wed, 6 Oct 2021 14:47:42 +0200
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
Message-ID: <YV2a7h5AKCcTQLsT@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005210423.yfftpxxmj3cjprtv@treble>
 <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
 <20211006034218.ynamwigsvpgad7sr@treble>
 <f15d1b41-e4fb-0203-88f7-dbac3f4e5307@linux.intel.com>
 <20211006050309.ldn5myznmpurnomm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006050309.ldn5myznmpurnomm@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:03:09PM -0700, Josh Poimboeuf wrote:
> I'm not suggesting getting rid of the feature flag.  I'm suggesting
> getting rid of the global variable.  Is there a reason you can't check
> the feature flag instead of checking the global variable?

The reason is that cc_platform_has() is used too early, even before
get_cpu_cap(). So you need to have TDX guest detected even before
feature flags.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
