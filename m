Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFDA432970
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 23:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhJRWB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:01:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE66C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:59:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0857000d1633cd2c0a2bbf.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:5700:d16:33cd:2c0a:2bbf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B21A1EC04A9;
        Mon, 18 Oct 2021 23:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634594382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iYA10PBrtnHh8XyPBz/qGaA9i7IUWFM3labYK3go0mw=;
        b=DjLf6S8E97AUswe73a8Esv4LdV2rjIpBh41Gm1ZHO/HZrao7AQXZhuMZslxj0ZsBr5Nu1L
        rY3WC7rwgLPOjaXNg/7WjiapcopFbDJsXqnD4qdiy0EzqAxQyn1ikprNqDKUIKYVkOxNBv
        Ie1ckgHOXL5oeYucZ5SG4KHqC2HxeB8=
Date:   Mon, 18 Oct 2021 23:59:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YW3uTfHbooni2iVE@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWaWSmWn6AZ6OLx+@zn.tnic>
 <20211013194251.ndbyj45egz6msl63@treble>
 <1a6220a5-3abd-dea1-4b2f-2acade311236@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a6220a5-3abd-dea1-4b2f-2acade311236@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:05:10PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Any consensus on this?

Well, you can simply not put any comment there now because this patchset
doesn't add those debug options.

The patch which adds them, should add that comment explaining why that
order needs to be the way it is.

In general, I get the impression from review that you add stuff for
future patchsets which only confuses reviewers and instead, you should
simply not do that but do only the required changes, only for the
current aspect of functionality being added.

> I think SME code also talks about future use case in its comment.

No, this has nothing to do with a future use case: you should look at
what that function does and then read that comment again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
