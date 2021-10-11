Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379364296B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhJKSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhJKSVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633976395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MttXTOG7P9ZAA72SX78ClayBg0KZinyulsAec13x76M=;
        b=FWtGK2MxJETeGxMtNcaDhMNNVDSkPVM7zvfgqMczops2/NkDkraV9CqG/JmgXXW4XDvEUO
        yXvZZYqRGYJ0wEp16p2bMuLNinkfXRyZaRb54Irx30yaubZx0EMQOisHixCUOkLXrQp0BM
        yvGTucSD9dMwZFcR8kmHH0/1YWTuuBY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-4R9t9CPOP6q4SILtDpPn4A-1; Mon, 11 Oct 2021 14:19:53 -0400
X-MC-Unique: 4R9t9CPOP6q4SILtDpPn4A-1
Received: by mail-qt1-f199.google.com with SMTP id l14-20020ac8458e000000b002a7829805b8so3633750qtn.22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MttXTOG7P9ZAA72SX78ClayBg0KZinyulsAec13x76M=;
        b=ssD84gwfSjS3NRcl0PgjhAQ3EY1Ish4JoMGGQPZCcqzbazBVA5aopinEoKv3vHHRGe
         2FlN+GYlJb4TQjjPFy55XH869ePZ6+Lp0CT8TbvHkrOcdFmyYkbpzPeJkF5rRcdh2H9h
         Pv8dTnG4KvKZoLoKXcNnY1Tk+i/8oESD4CxKunx0FVr7H4CJyLzD8F0g5dZkVj4m+0KM
         nGohd6e44XHdG4XXU/bw8VjKazKwOu6gGFQJq9djKAYBfJJSjSHlglR6HwB6xUl+kTqB
         l4LvwQbQVxv6GnEyiFU5mz6d3T5OXxf7tPdTu0ml7pR8nmzJImAMdG9/iqtECUdJ9qU5
         6NBQ==
X-Gm-Message-State: AOAM531uD9JcsPDC+eN553Pnl9hQpbd64K2WBssvmcBOtGCHaMHn8W6D
        +v62JuoWgIBe+apEdCDMzcx/03YEd/qx3arp9D6pRD8wcQV+PZ5AdcL0EloEa6O7010yGM0EKsD
        DJj60kQ1sFg662WL1xxwHkFy1
X-Received: by 2002:ac8:5bce:: with SMTP id b14mr10836178qtb.194.1633976393440;
        Mon, 11 Oct 2021 11:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFVX5robRCsYjhCO4rpkDWlzo+DOZDVwzw/04TSEW8Kouze7DjppfYr32XtldSWHVr6RTt3g==
X-Received: by 2002:ac8:5bce:: with SMTP id b14mr10836140qtb.194.1633976393271;
        Mon, 11 Oct 2021 11:19:53 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u19sm5292644qtx.40.2021.10.11.11.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:19:52 -0700 (PDT)
Date:   Mon, 11 Oct 2021 11:19:48 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v10 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config
 option
Message-ID: <20211011181948.fkt7o2fezmuyynze@treble>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211009053747.1694419-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:37:38PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +config INTEL_TDX_GUEST
> +	bool "Intel Trusted Domain Extensions (TDX) Guest Support"
> +	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
> +	depends on SECURITY
> +	depends on X86_X2APIC
> +	help
> +	  Provide support for running in a trusted domain on Intel processors
> +	  equipped with Trusted Domain Extensions. TDX is a Intel technology
> +	  that extends VMX and Memory Encryption with a new kind of virtual
> +	  machine guest called Trust Domain (TD). A TD is designed to run in
> +	  a CPU mode that protects the confidentiality of TD memory contents
> +	  and the TD’s CPU state from other software, including VMM. TDX guest
> +	  uses virtual X2APIC for interrupt management.

Why does it depend on SECURITY?  It should at least be explained in the
commit message.

-- 
Josh

