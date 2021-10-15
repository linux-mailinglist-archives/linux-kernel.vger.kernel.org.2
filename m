Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3462E42F682
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbhJOPFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhJOPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:05:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CFFC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 08:03:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om14so7367047pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KXPIz1+6ivp923MPkATJlji46zFojrernQw1lNXrX3U=;
        b=oVQAmkOyAuaFZLQbHGtUmPkWE1hRqZp5CCcQR/+oJORPH6OdQhIWDaYpRCiRTrkDbt
         w07Dd5lFJ0S7P0NM2SK+wbDRNuXampA+CasNYaPsZnCIQmBO6ehCIGmstAqITwbnHNPg
         zpW6Ykt9Hp8yYFYzXfSRla1lcSRp5uGqZ0N53JaUFWyTvjVJOsFqe6KgjwsVDQOLDzSy
         +8TSpc7kWRRLPB3K6k4X1eJIWVD57Tz1PZGM+OZy9syXfsLJBj4j3xc6W5QT/+30VY09
         DLoNzHHfB0v1QqxQcSR3dVOY+sbYT1IQ4v5yeU5GHZQ431PI2bRDnrGiDEZXr2z8kpQg
         eeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KXPIz1+6ivp923MPkATJlji46zFojrernQw1lNXrX3U=;
        b=VFECt0K75EWenC5dM8FSvH8POhJC75Ovg2VJxZE4ip3lf0W0UwS/LKpgBwuBRcyFOJ
         Mg2B/Wzorm/ADEWeh0EK7WCbOKGv6HqBzs6ZJrLoyDHbsldULkZg7DVcZ718XvcQN5XL
         yKFqttMMFGDfjLb3+sACxiDZG79bktBXv5wRdbTOp/uVby5WkRcDbZcGOaSQoMIDaTl2
         2THPklDv3MD5MfFgKUxoU0MKReXuRVtWEQSQEiOvENq0J0jdwVmf3yYnFyGiOjPlSw1t
         eL1Bb+iz4tG4KmfM/tbyQsi1X+nkuWXfpdQV4w3pCN/hAIC5tekljVY4k+44meFBkgcz
         MXbg==
X-Gm-Message-State: AOAM533mbuHOOsRhjvDL4KcCZG2Atz2J98g8BZPcuXCkLYA3EAsN9POR
        wfo2Z7phuhzWDPAjjKMR8Ntk7Q==
X-Google-Smtp-Source: ABdhPJxoQTeBvFoMAx+1gdIIMmnqvQFTf0ckns/jyp1Q2FtIWvxj067w1lS1TGALXruBnkuHbqTOHA==
X-Received: by 2002:a17:90b:4b10:: with SMTP id lx16mr14088375pjb.217.1634310221283;
        Fri, 15 Oct 2021 08:03:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h1sm5519785pfh.183.2021.10.15.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 08:03:40 -0700 (PDT)
Date:   Fri, 15 Oct 2021 15:03:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/11] x86/tdx: Add HLT support for TDX guest
Message-ID: <YWmYSSi6H/G+vXDd@google.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87lf2w6ji2.ffs@tglx>
 <43de3c58-5a55-7dcf-48d4-1474bb1c61e5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43de3c58-5a55-7dcf-48d4-1474bb1c61e5@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021, Sathyanarayanan Kuppuswamy wrote:
> 
> On 10/14/21 2:30 AM, Thomas Gleixner wrote:
> > On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
> > > +/* HLT TDVMCALL sub-function ID */
> > > +#define EXIT_REASON_HLT			12
> > arch/x86/include/uapi/asm/vmx.h:#define EXIT_REASON_HLT                 12
> > 
> > Is there a _good_ reason why this can't be reused?

So, no.  :-D

> As per current use case we can re-use it. Out of all TDX hypercall sub
> function IDs, only Instruction.PCONFIG (65) exit reason id is missing in
> vmx.h. But currently we are not handling it. So we can ignore it for now.

If the kernel proper needs EXIT_REASON_PCONFIG before KVM, just send a patch...
