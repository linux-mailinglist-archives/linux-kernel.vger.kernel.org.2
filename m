Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D590F424756
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbhJFTnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbhJFTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:43:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6480AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:40:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d36003dde9a53b36f1ff2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:3dde:9a53:b36f:1ff2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0DBC1EC04D6;
        Wed,  6 Oct 2021 21:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633549239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qUSaS4Yoocg/qP9Y4HdHnN5lbNf1ZdpM4lJZqF0Z5dI=;
        b=SFzhjwroCwBEmFvYdWj427y9KzWp2C2yrkJntd+8cOYOH2EMzWi32ZyqtbfIekaTd+1ppu
        JLC4ahzm3JlgaiHzIycqxJcDvTs7kBc21pNTZtesnVNv7Ke0NcfH6oPhSRyAdzPlVVRPAO
        ZbazWui5BBUJO8ry59x3sdnUhScocpE=
Date:   Wed, 6 Oct 2021 21:40:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
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
Subject: Re: [PATCH v8 08/11] x86/tdx: Wire up KVM hypercalls
Message-ID: <YV37twhDjtBtHBWF@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211006193440.jgmagja3vynqnnis@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006193440.jgmagja3vynqnnis@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 12:34:40PM -0700, Josh Poimboeuf wrote:
> Hm, I'm still thinking that figuring out a way to convert all the
> cc_platform_has() stuff to normal cpu features -- or at least inline
> wrappers around them -- would be really nice here.  Then this could just
> be a nice fast static_cpu_has().

	cpu_feature_enabled(X86_FEATURE_TDX_GUEST)

provided those don't happen too early...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
