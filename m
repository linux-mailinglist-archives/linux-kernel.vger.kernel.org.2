Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1494E42318A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhJEUUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236301AbhJEUT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633465084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxaZm0A5RiVb148Zk0ovgwAZHevyQtKlyjzbRE0x7hs=;
        b=VIDV6aXF8wKrow22FAlfB4z71BOk2ZjgV/toEGVmyPtFkUgxDUmcEhv3K5Wrv/h5lIBOLR
        5dFlD9NSuxpdLIyGFpJ4rivspJxQ/IWL95AwWMMlsIhv87lfK15KmE3hyKMNkR3ipHFyra
        PS398M7fB7mwSJU07fdVVRHjPk4do0c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-JSgCqWHwMjuSPbX4G8K_wA-1; Tue, 05 Oct 2021 16:18:03 -0400
X-MC-Unique: JSgCqWHwMjuSPbX4G8K_wA-1
Received: by mail-qk1-f198.google.com with SMTP id l3-20020a05620a28c300b0045db8137fa9so185189qkp.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oxaZm0A5RiVb148Zk0ovgwAZHevyQtKlyjzbRE0x7hs=;
        b=XLx4HbBWUhWP4AJrkCTqoSJIi4KAD2Vit2B2shuMhSpRP08MHqopknqIfZc7xfXRGL
         mfnnx/EqfKL4BmDxHamZAdpIxt0XUiPAWUTYhLaKdQkgx1XIfrdoEbNVgtH2JzcHxN/m
         ZFIfCdgmN/El/HRQdMM4psVh1HZyNEfAf2Z7S/vbOXbGGQymMFpsw9Z5D39CNMUSwoUn
         fwsSdAJgF7DjVr4033qzEIXyvXhoAjp46dbd4E9mhPzaurca8DvUtNA2Zb2g6RULLacU
         o2lI8JeqJ3RPYmdcADw1gfVnK4ZQRB8BkV5ZIMIxYfQVgnw8MM1S5lPckWcp7PKIJjVQ
         lHzQ==
X-Gm-Message-State: AOAM5328T8d2eHyoX/spEC9V4HclSNeCOFRW1wiADeX12fF4AB16diy+
        p6cHBvTOwah21qoxShjZGgHpC/GaeC4Rwnb4qcY1GcVTO/4aPK0T8ScORe5JjxQovDOU8ELmmIq
        Ikkk7z2NubI8yIvDso2ADd8ju
X-Received: by 2002:a05:6214:1083:: with SMTP id o3mr3388271qvr.57.1633465082678;
        Tue, 05 Oct 2021 13:18:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhlmDWSt1vKMhTvyQkfpeLua81mTegVjb5uYIBGz4vVOXlNezhNFa2iaLTFxbMDzsrrNfBmQ==
X-Received: by 2002:a05:6214:1083:: with SMTP id o3mr3388239qvr.57.1633465082503;
        Tue, 05 Oct 2021 13:18:02 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bj31sm11048711qkb.43.2021.10.05.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:18:02 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:17:58 -0700
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
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Message-ID: <20211005201758.o5eikzp33kfepdag@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:51:56PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +config INTEL_TDX_GUEST
> +	bool "Intel Trusted Domain eXtensions Guest Support"

...

> +	  Provide support for running in a trusted domain on Intel processors
> +	  equipped with Trusted Domain eXtensions. TDX is a Intel technology

I haven't seen this particular punctuation "eXtensions" anywhere.  Intel
documentation writes it as "Extensions".  Better to be consistent.

-- 
Josh

