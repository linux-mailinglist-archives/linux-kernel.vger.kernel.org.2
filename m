Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FD433CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhJSRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhJSRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:08:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FDC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:05:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so362941pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dhgc7X/gBnEpv5sdM1TviQYfdTxsBoQA8Ow6mCcV/mk=;
        b=AEwxncFNWsQo91KKTgE1pw98+O6Y6y0qJdCgP59Xv15sTtUgafGnJnsegSJN/6FfpI
         QOlGIWWdb1IWScBvSanumTvoxTi2WXKMIR2HBj9b8Uz/8fJxwOoYKYcG6xu67jx5EXTn
         wA4xiUKcI3VNr6kNF1bJuBF3ch9OFo1JE7tCj4Zr5o7da6YfWVkH1pck+5ZnGqIeh+iw
         66qBnuLu67B/BmFMe+V1dL1yU1XvpYuhpzA3OI9jIQ3OvRYTYuA4Il6GZpOgU5FzZ3Xx
         DRAUO90K9rMw/Lqhe0Mm1SipTO6ClNK5nBIIjeS1hN1U2Ts73MSIavQSiT9YODg6acvy
         RUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dhgc7X/gBnEpv5sdM1TviQYfdTxsBoQA8Ow6mCcV/mk=;
        b=rKjxfVN+jtLIBrtgHz8INEewQVJ22sFTLbihr3+6pG3xiVt9sBEInaqKhezmyC7FN5
         1KRompK7cosIhPczyoa0kzLL0oH0QWluk5yOIDC6/eAWMzGcg/jY5fDt2THK0z7dju6W
         d4epteSk1k2ChyxPpwp20As1STSAHyjeNmD1z0mFbiBP4m/H/bzWs7/EdDxlkIyDLtGy
         lyQKQxEFyDoKIs1sZuF4pT2g7UGFYCBcFTcizt0ZPOREh8cD3rgT0+iYDs/FSzGrGMZ7
         dgYWSkg8ZE0AActvS2pz8rXRSvO6iPkO+0/6hII0F0mHa3vQm8OE5U+G5+VM6PZV6c11
         uH8Q==
X-Gm-Message-State: AOAM533c+YEUdbYKu/CRgcIelgVjyXC4ReWD/nlEvGsbJvaQ0g1yD5QG
        OzsYA36ipB9oZZTd6Bhh4aXweQ==
X-Google-Smtp-Source: ABdhPJxTxyKiO6N70mAz7RKEshK28Fj7jJA9XTer0vPp319bIvSVawfu/sogQLU0ELLPaoXJgjz3SA==
X-Received: by 2002:a17:90a:9f44:: with SMTP id q4mr1231910pjv.136.1634663150914;
        Tue, 19 Oct 2021 10:05:50 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u2sm16465047pfi.120.2021.10.19.10.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:05:50 -0700 (PDT)
Date:   Tue, 19 Oct 2021 17:05:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Message-ID: <YW766qk0W6K5rhrU@google.com>
References: <20210901084004.5393-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901084004.5393-1-chenyi.qiang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021, Chenyi Qiang wrote:
> It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
> this kernel has been kexec'd from a kernel that enabled bus lock
> detection.

This feels like the kernel should explicitly zero out the entire MSR somewhere
in the generic boot flow.  E.g. something like this somewhere.

#ifndef CONFIG_X86_DEBUGCTLMSR
	if (boot_cpu_data.x86 < 6)
		return;
#endifa

	wrmsrl(MSR_IA32_DEBUGCTLMSR, 0);
