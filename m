Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17F431F53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhJROTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhJROTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:19:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F9AC061796
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:09:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0857009e2a46238f1e0c2c.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:5700:9e2a:4623:8f1e:c2c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E70481EC04C2;
        Mon, 18 Oct 2021 16:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634566157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ld7x0cNN3q6gsNngWIiRpCx5szIAiZbhEoaLlBcezcs=;
        b=i1+69crwiyD82yRWTrY0MjpqQ7/QxLVjXtrM0Pv5+NMZB6RDRZvkKNVDTXHsDx/ilLD4n4
        UfP067rEFtrnaS3Mc9e3xkyv7FOvG1cYRrSNqu9CWBif7GWP4TkmK+g/4UReLKKt41QyB2
        9mGKyZVPJGTohYgonpmmhuSs7OOpsLs=
Date:   Mon, 18 Oct 2021 16:09:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
Message-ID: <YW2ADBdfzK96b6gR@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YV8pE+QYcS/fUe98@zn.tnic>
 <5b7f13b9-6d32-c97c-aaea-4e256a59f90b@intel.com>
 <YW1SNMqBcsdqOCsF@zn.tnic>
 <4f04c6c0-31c6-9293-25c1-ea4bc1722dc8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f04c6c0-31c6-9293-25c1-ea4bc1722dc8@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 07:05:21AM -0700, Dave Hansen wrote:
> It's not a problem.  I think I'd just rather see a splat (oops or
> WARN_ON_ONCE()) than silently returning an error.

Ok, that makes sense too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
