Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C342423217
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhJEUf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhJEUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:35:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED06C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:33:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id np13so504188pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5dtSFl7WWRmL4WU7WeDFV63ladyqofln0naUH2kF9F0=;
        b=Kp/kedHuhaXygwYZN9cEPMecb2DeuzJ/zvmez9wPyvf2ntBJJAEdTcg0om4qoF6ODv
         26o0gqAmCl39mvw4azzU+IQ28cQoGxRQQh1GK/SIbUorx9WhifUFj/9WFFpfeUGJ3UBM
         gUzSyoRRnIGBZ3YuUAAQN1m5IKjgcGJ0sgYtaZu2lB7J1saiGYbHznlg3u5wjA2xVYO8
         /7z2FcvNzEWifEZiAuzkM4lOmEZDOMapPtkzjZXAoG48NVs41iWEGIKxWDnRdFN7VCI7
         KkaItwWoOXkqy2cQ1+uHpnUV+WFSN5hl7jA1wLsdUvx1ru3qLeUh9wleWDbAGObqaWS/
         Aaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dtSFl7WWRmL4WU7WeDFV63ladyqofln0naUH2kF9F0=;
        b=1wRCC57iMEqEpL9GXAXr28ECoKT9nQZsYp5p0RyharbwGEPFJyuXZOm3MkYXzSUGpn
         OHtjlfyMzgsaqTRfXKbSPCUemieUpDdCHxZxia5pVdUL2Bq9JX+1oybA+OywWxhk6wii
         hcnoJvferIl+MSsK4m58PqrA8fx8qAUzGxadVHkDYvU4DC35YCeiHLGDAvoM+sPUSJEF
         0EuMm3vmalnJG5G/DruE4ajwXIuS9ITUaFE/dRwYdRjO5WdV0PkY8tgeFcsgaQPD5W+Y
         MerYs2dUSC/1UkVdDfQhqUOKSC+2so50iX1DvLuOHxqlz4Qxk3w811yNPiYsdalGKFgO
         VFTg==
X-Gm-Message-State: AOAM530XeZGX/EOWQGIYa9pO8jAdqlpKMqvtcH5xZT3c1T9ShuoHNHxL
        D8TMXqmLxWlr1JuK76lPHczusA==
X-Google-Smtp-Source: ABdhPJz5lroVfvQIep6KDWLO5ukxG9n0EydDJ0W2dUv8BweLI7ZJKpSeqNtpboiBFihNjrJW3hs/pA==
X-Received: by 2002:a17:903:31ca:b0:13e:daf1:6a3a with SMTP id v10-20020a17090331ca00b0013edaf16a3amr7183044ple.76.1633466013907;
        Tue, 05 Oct 2021 13:33:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k9sm18586380pfa.88.2021.10.05.13.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:33:33 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:33:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Message-ID: <YVy2mfCyvasXIOYn@google.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005201758.o5eikzp33kfepdag@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005201758.o5eikzp33kfepdag@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021, Josh Poimboeuf wrote:
> On Mon, Oct 04, 2021 at 07:51:56PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > +config INTEL_TDX_GUEST
> > +	bool "Intel Trusted Domain eXtensions Guest Support"
> 
> ...
> 
> > +	  Provide support for running in a trusted domain on Intel processors
> > +	  equipped with Trusted Domain eXtensions. TDX is a Intel technology
> 
> I haven't seen this particular punctuation "eXtensions" anywhere.  Intel
> documentation writes it as "Extensions".  Better to be consistent.

Heh, I suspect that one is my fault.

While we're nitpicking names, it's s/Trusted/Trust Domain Extensions.
