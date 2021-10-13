Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7842CA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhJMTpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhJMTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634154178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLgCICPGHltNgLd34NJw9mrXeA56LXJmw5+6xj90sIQ=;
        b=GFL11fLIOia7yk+TvJNpVs8VHqvygY7p/sUlinNu1PvZY6Yj+2/0e0crgUqTZOfPGIpUl9
        iCcDJK2HD2ebfqsu4wWDYpj0u3oOQfc1l04YGeo+3lvnSh97CJdjFJiclr56+oM/kfMWF/
        i89zyL7unwpbpsB8l3+uYBdl6gvEzXA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-_gQzZEGFMb2V4pTMPAOfYQ-1; Wed, 13 Oct 2021 15:42:57 -0400
X-MC-Unique: _gQzZEGFMb2V4pTMPAOfYQ-1
Received: by mail-qk1-f200.google.com with SMTP id q5-20020a05620a0d8500b0045edb4779dbso2757517qkl.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MLgCICPGHltNgLd34NJw9mrXeA56LXJmw5+6xj90sIQ=;
        b=jQwOC6bAfkbu6OR+YY8DbPCRX7oWnrl2kKPg12IXBUQEvRGQ7+CkaBcrFD9V0F8cB2
         Gg8JtqxIdLOe8swf6lrPZd74sdc7hSS0aRQW26iEa5pXJhfCenq4fFIWgIevCYAbTTGT
         AWFkx8y5nrIoEDCEedFQJbKQQWSPEn9zqo158A3YQOQI3pQ+Q0XZYNxPpM53Y40umlgU
         zsvfwYn7/OKnINTMrQ6fZmgUGmrFBZUnBf+hC5cC8FVAtCYL1dcxIbZUwtwRGihRklsE
         G+cUzqNuBg5y9EOWVoLZ6Ypr3syularmcqpT53t42jg44VUe08w6YudsvCMlrgeNW/3T
         gomQ==
X-Gm-Message-State: AOAM5307mrimn+Jux7HzuoGw9vtsTBgH8sBwISES2AapEeS0adC5RWzV
        fqhPtZ0IqQkz/QK8b/aQtFvrBabFEOg8AoHhfAjKVjSynLuBFlzGcaODDYeQOsRKkl+mvJhjOJ1
        Rga5rIxy+Ad2JcPOzdyik6EL9
X-Received: by 2002:a05:622a:11d5:: with SMTP id n21mr1610744qtk.112.1634154176631;
        Wed, 13 Oct 2021 12:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytCjzutAooXnyBRPFpGt4KSETrYhqbWsvLvNfo5VhMroz18P9TD+YWckvDQnD7mCDSFrxjPg==
X-Received: by 2002:a05:622a:11d5:: with SMTP id n21mr1610704qtk.112.1634154176380;
        Wed, 13 Oct 2021 12:42:56 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c7sm267452qke.78.2021.10.13.12.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:42:56 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:42:51 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
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
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <20211013194251.ndbyj45egz6msl63@treble>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWaWSmWn6AZ6OLx+@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWaWSmWn6AZ6OLx+@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:18:18AM +0200, Borislav Petkov wrote:
> On Fri, Oct 08, 2021 at 10:37:39PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > @@ -500,6 +501,14 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
> >  
> >  	copy_bootdata(__va(real_mode_data));
> >  
> > +	/*
> > +	 * A future dependency on cmdline parameters is expected (for
> > +	 * adding debug options). So the order of calling it should be
> > +	 * after copy_bootdata() (in which command line parameter is
> > +	 * initialized).
> > +	 */
> 
> Plain and simple:
> 
>         /*
>          * Keep this after copy_bootdata() so that TDX cmdline options can take
>          * effect.
>          */

But there are no actual TDX cmdline options in this patch set, which is
why I originally asked for clarification in the comment.

> > +	tdx_early_init();
> > +
> >  	/*
> >  	 * Load microcode early on BSP.
> >  	 */
> > diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> > new file mode 100644
> > index 000000000000..88bf12788684
> > --- /dev/null
> > +++ b/arch/x86/kernel/tdx.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2020 Intel Corporation */
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt)     "tdx: " fmt
> > +
> > +#include <asm/tdx.h>
> > +
> > +bool is_tdx_guest(void)
> > +{
> > +	static int tdx_guest = -1;
> 
> Put that one at the top of the file because such static variables do not
> belong among the automatic function vars.

I disagree, this prevents confusion and misuse by making it clear that
the scope of the static variable is limited to this function.

-- 
Josh

