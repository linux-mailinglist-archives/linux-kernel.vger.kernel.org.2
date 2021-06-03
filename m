Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A839AA33
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhFCSn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:43:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45860 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCSn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:43:26 -0400
Received: from zn.tnic (p200300ec2f13850043af4c4d530a3258.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:43af:4c4d:530a:3258])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD6D71EC04A6;
        Thu,  3 Jun 2021 20:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622745700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=psd+ZC8Co6XkZKgFq1VAPYa0k/9qp4aEkZyphaqsnvk=;
        b=PquDu7gfhoilzg0av43yBAR9Bl/foF8OonwQEIidmP7ibOdlCb8NsTAgDoJXfaA36xJ9jv
        O/+8gvcM88eeQwaUGnomw1XPrwQqOeCA933ygZGNnLLOCt003HqEvVTiuIfKpJ3hk5XYc9
        gIKLKqqQC2gNq5nBg8a2Ubc/2csR7XM=
Date:   Thu, 3 Jun 2021 20:41:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
Message-ID: <YLkiZFzkSfED3BFB@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <d062aedf-29d9-a83f-a727-109aaf766bf9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d062aedf-29d9-a83f-a727-109aaf766bf9@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sathya,

please trim your mails when you reply, like I've done in this reply.

Thx.

On Thu, Jun 03, 2021 at 11:33:53AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> I assume this file will get compiled for both SEV and SME cases.

Yap.

> Since you are checking for AMD vendor ID, why not use amd_protected_guest_has()?

Because, as Sean already told you, we should either stick to the
technologies: TDX or SEV or to the vendors: Intel or AMD - but not
either or.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
