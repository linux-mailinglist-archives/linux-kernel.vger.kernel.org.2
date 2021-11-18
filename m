Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE06456053
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhKRQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhKRQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:21:31 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE19C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:18:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r130so6541537pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uN/UmyJLSi0l3cbBlFO2ztb0Ka2IeTkhbf5uDX11zJg=;
        b=Jf2HiBNgA7RFW5gnRVgO0QLoM16OxD2Ix0npEpGUNyHeBto2hwoxb7djkqNJkCKNJQ
         ByBlDRJg8UYf7tniV4n2D0BFjQaesADQJT6zDD4S/6ZZzxFMb1WnkZf+P0o3et4mB/nm
         E5uqiSs24dgjIDvQFyTAh34YMqDQYl4jW8cSdlHdPU2XrQgxK9vzrpy338baHYp8b6Bs
         XYCloL4mMS3zmvt9izVE7vr1yQOTVDI3JSCvvaky+NpOWx0bzzNGnA8JodPgxrvPwPoA
         dSIsrK/4/Ko13lPuMD7XrXU9yA04eh8HzDGVqCHRCeJGFNXXsUazVoLA2bxfrpoNDMiO
         IxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uN/UmyJLSi0l3cbBlFO2ztb0Ka2IeTkhbf5uDX11zJg=;
        b=EeNh0vwsykhObSDcA2QEwCWCq1U9HGgLyaG49Jc7FJx9hcEqM2pli24sO4wvPEyTJ8
         kfV8+vJcOjbOCXsZ57QZmxupEHwm/g5LQt0H7gwTHBZwoL5c5Ise/4A3+S7i4B9dwI1E
         fFYJpvL9htmO1gvoCUh1wkoe6eBXFRHCInV7r1z2Vq2wqzQKVWPbIDk/nO+4BZqLNYk1
         jq6BY/QcTjriJZxYjLsiB181cnXBP2KFYTX1K53xGC7Xk+29YDRxNLNr/eQ7WL5a4x1h
         MZQfcaTosuwpUpERjlqrchAkit/KA2wj3kxq83JxsciUdRHrvUJyJz52Ws3z7gxepGCU
         NXtw==
X-Gm-Message-State: AOAM532xGdT7qi7pDDchXalsoNO5GSMMXnN84odnlXcStsxjnfgXdXvK
        0I/w37WZ9t7fc8WxbmbQ8XIxcA==
X-Google-Smtp-Source: ABdhPJz+BPkGN+BaCyqqsDRTEE2zjEfSVMmUxovOZVKwnp6uxPmLpJv4DfRqP4VAs8MYJaVU1K93Dw==
X-Received: by 2002:a63:89c6:: with SMTP id v189mr12280953pgd.23.1637252310465;
        Thu, 18 Nov 2021 08:18:30 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u22sm104416pfk.148.2021.11.18.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:18:29 -0800 (PST)
Date:   Thu, 18 Nov 2021 16:18:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: check PIR even for vCPUs with disabled APICv
Message-ID: <YZZ80rok+NbpI6lJ@google.com>
References: <20211118072531.1534938-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118072531.1534938-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021, Paolo Bonzini wrote:
> The IRTE for an assigned device can trigger a POSTED_INTR_VECTOR even
> if APICv is disabled on the vCPU that receives it.  In that case, the
> interrupt will just cause a vmexit and leave the ON bit set together
> with the PIR bit corresponding to the interrupt.
> 
> Right now, the interrupt would not be delivered until APICv is re-enabled.
> However, fixing this is just a matter of always doing the PIR->IRR
> synchronization, even if the vCPU has temporarily disabled APICv.
> 
> This is not a problem for performance, or if anything it is an
> improvement.  First, in the common case where vcpu->arch.apicv_active is
> true, one fewer check has to be performed.  Second, static_call_cond will
> elide the function call if APICv is not present or disabled.  Finally,
> in the case for AMD hardware we can remove the sync_pir_to_irr callback:
> it is only needed for apic_has_interrupt_for_ppr, and that function
> already has a fallback for !APICv.
> 
> Cc: stable@vger.kernel.org
> Co-developed-by: Sean Christopherson <seanjc@google.com>

For my bits:

Signed-off-by: Sean Christopherson <seanjc@google.com> 
