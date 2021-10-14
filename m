Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5642DDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhJNPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbhJNPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:13:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61BDC02B778
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:04:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so7150590pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ViLn2s+OJ8aEqQHXLhbDBLN6Hy2Bs5h/+6v4MXjWTXM=;
        b=XOua68fh9tLvHmcYnAgYSWqxgFxFIfL0sHuHmZx3b8TngSL3KL3cGZdnRhAM6jn9IZ
         nYaHSKBbdoQyUjdK9WmeAcTrpD+5HRc8fx05uVszJc755t7FEjD+20deJLOTbB9NTeMy
         rri3f/OLHQJ67FTokQj+XToauia8ja1+WE0h6pFEEgQhZO+JHJgRXUTLg+TXqMdoQx0v
         CuJFeZ+Oa6BJ8DYmjNKUSjsmEHMMOzkCXIWt1rBAdeP6e2SjNfV+sJMRCcEyWHDXuetR
         KXQFUcT/P+nbZ3dLZsG7WzccIb/3HEUD2z1odIrX7Db2dEfHrZSI4dBVE/ZW9q+e3NqV
         vEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ViLn2s+OJ8aEqQHXLhbDBLN6Hy2Bs5h/+6v4MXjWTXM=;
        b=K7JcYlHwhSiDU+ftv/r8+dVAV4oIALfuHFH5QJFJahwWW6oPGQ81FxiaRtxZyzxRss
         /qvKKThf36V/Fn23egfhNd+WciyQjx3lAztxtMRyQdrcCPSka2VACp4rRnQdwgjSpE54
         fEl3sN1ifW4NyN69SiMLUSjNVebLnM+xUg541+MCtO4I+oo3OAS1hqNVo9n88cqsrjwE
         RXYYxyjd6nqFxhOsK5Jn1kzS+Ujn8Nuob0ab9Fpgg9adIjc3WV3P3rGbgfH17bWkD7lq
         MBZ+MmmzPAYsooVL4unpu3wVa3RGLRBrMuUYQ8uc0y1gsOn/QspcuB89Gh9KUDH6d+Fl
         OrkQ==
X-Gm-Message-State: AOAM5301QbVlhpQt16Bk1ZwERdqtItfErFIavVZ5if8DRCi0lL7OPnEv
        0DvgDp5tl+uXyJpU9jULUTaelg==
X-Google-Smtp-Source: ABdhPJyn72L8xqEAgERemRDLP5ed/I4NiRgu90R+Mli5y/Ha/AFfJZfoVwrrGQfn63oV8rbg/z6rOQ==
X-Received: by 2002:a17:90a:d486:: with SMTP id s6mr6734468pju.122.1634223869975;
        Thu, 14 Oct 2021 08:04:29 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l19sm2661401pff.131.2021.10.14.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:04:28 -0700 (PDT)
Date:   Thu, 14 Oct 2021 15:04:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] x86/split_lock: Fix the split lock #AC handling
 when running as guest
Message-ID: <YWhG+UcaRyNptzw9@google.com>
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005230550.1819406-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWdB+rGPWDIVzuBY@google.com>
 <38a70cf2-1849-97fd-82a2-10ce64c6be8c@linux.intel.com>
 <71884ac9-6da3-e75d-af1e-f8f24a7562cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71884ac9-6da3-e75d-af1e-f8f24a7562cb@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021, Xiaoyao Li wrote:
> On 10/14/2021 5:32 AM, Sathyanarayanan Kuppuswamy wrote:
> > + Xiaoyao
> > 
> > On 10/13/21 1:30 PM, Sean Christopherson wrote:
> > > On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
> > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > 
> > > > If running as guest and hypervisor enables
> > > > MSR_TEST_CTRL.SPLIT_LOCK_DETECT during its running, it can get split
> > > > lock #AC even though sld_state is sld_off.
> > > That's a hypervisor bug, no?  The hypervisor should never inject a fault
> > > that the guest cannot reasonably expect.
> 
> What if hypervisor doesn't intercept #AC and host enables SPLIT_LOCK_DETECT
> during guest running? That's exactly the case TDX is facing.

That's a hypervisor bug.  Since it sounds like the TDX Module buries its head in
the sand for split-lock #AC, KVM should refuse to run TDX guests if split-lock #AC
is enabled.  Ideally the TDX Module would provide support for conditionally
intercepting #AC, e.g. intercept and re-inject "normal" #AC, and exit to the VMM
for split-lock #AC.  That would give VMMs the option of enabling split-lock
detection in fatal mode for guests.
