Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901F3DBD43
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhG3Qq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhG3QqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:46:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E49C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:46:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i10so11769841pla.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rO/EzGmYPyA8XUTMvISw3atdtnT8E2AAIAbiAWpsYgo=;
        b=hCHYwRbu4+2P1gFaV8nHVRIVbDfndEFNM3n+tTACYSSWVrk3vOzT1EHqJqfX5Cum4t
         O1P96mQXQmwgXCdJSsq84uEX8KL8V3SxV+zMprWxlyVmhbvMZgMcCIrmLYDoDkjWNbST
         jcy74mfU4zBcyx6tDRIYGcurUS+Tw/RqhPA5010RelPJFXPb8cV+F5Jr4k/1tUrSJzu6
         dh/kMTYS5db31bbQKTUUPGSfSdMzfxlBFxy5yaAmFtDe5Q1mjSanLF596qk3IHBcRb6n
         rp+6VcJjpy9Hx0nuJNDLW+R9ow4V4nRFUWk4ga27imcH8hpGtrBjoI45JV9C34W7pIwN
         QLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rO/EzGmYPyA8XUTMvISw3atdtnT8E2AAIAbiAWpsYgo=;
        b=awi08zXm3DzwP16QyA9dpD7+8Lb5P2DO9qBMwWcUv1W++dTFwUn6N6fVLE9vUStgLr
         UWwkJevoIBIWc6/AohWHUhjmAp1I001FrAdQr2stDBc2or1m+dwooUW7sm9enbVLJSrQ
         Eqg+RHOR5/0gp3/OKUCR1KwYy0R31Ip+VKV80fRZcXzrn/PROm4y6NFWd76T5w/SkZ/Q
         WDIzafPiL3zklbsi+KsB0bm7i3OLPV2VaWG++S6EFVPHQZqdQgBUBym/9R5oVVpx75lf
         LfVpMXXVYThVY75FEs1VZipDjkaWlvz4i5rVW/ZCuwL/pgXZfwwXIevN5N/xZ2P+Ic1g
         vsJw==
X-Gm-Message-State: AOAM531MoZbSwZCnEU/Wp2tIPne/ZFABPRtlk6No9pvbwf05LjIM9QKa
        UEmi4+wWDUlzJ1XXV5RlWwn3Qg==
X-Google-Smtp-Source: ABdhPJyZlykF42tJ9qRmdJPGORNWCt7n8pfBvQHyfhYIMniU+oHLRQfYJYyQJGVM6AiunKJFrQzReA==
X-Received: by 2002:a17:90b:2284:: with SMTP id kx4mr3858140pjb.202.1627663571784;
        Fri, 30 Jul 2021 09:46:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q21sm3397054pgk.71.2021.07.30.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:46:11 -0700 (PDT)
Date:   Fri, 30 Jul 2021 16:46:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Message-ID: <YQQsz/tvrQpqAbpX@google.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730003809.hp3nmqmgyysa45nz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021, Jarkko Sakkinen wrote:
> On Wed, Jul 28, 2021 at 03:19:46PM -0700, Dave Hansen wrote:
> > On 7/28/21 1:46 PM, Tony Luck wrote:
> > > Export a function sgx_is_epc_page() that simply reports whether an
> > > address is an EPC page for use elsewhere in the kernel.
> > 
> > It would be really nice to mention why this needs to be exported to
> > modules.  I assume it's the error injection driver or something that can
> > be built as a module, but this export was a surprise when I saw it.
> > 
> > It's probably also worth noting that this is a sloooooooow
> > implementation compared to the core VM code that does something
> > analogous: pfn_to_page().  It's fine for error handling, but we should
> > probably have a comment to this effect so that more liberal use doesn't
> > creep in anywhere.
> 
> You could also create an xarray to track physical EPC address ranges,
> and make the query fast.

Eh, it's not _that_ slow due to the constraints on the number of EPC sections.
The hard limit is currently '8', and practically speaking there will be one
section per socket.  Turning a linear search into a binary search in this case
isn't going to buy much.

Out of curiosity, on multi-socket systems, are EPC sections clustered in a single
address range, or are they interleaved with regular RAM?  If they're clustered,
you could track the min/max across all sections to optimize the common case that
an address isn't in any EPC section.

static struct sgx_epc_page *sgx_paddr_to_page(u64 paddr)
{
	struct sgx_epc_section *section;
	int i;

        if (paddr < min_epc_pa || paddr > max_epc_pa)
                return NULL;

	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
		section = &sgx_epc_sections[i];

		if (paddr < section->phys_addr || paddr > section->end_phys_addr)
			continue;

		return &section->pages[PFN_DOWN(paddr - section->phys_addr)];
	}

	return NULL;
}
