Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A11E3FF1E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346489AbhIBQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346369AbhIBQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:57:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B0BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:56:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fs6so1765655pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Qgo5364SnUWK2dNQ5Zfdn6/xMGj0/q4OzZE+MW9D64=;
        b=Evzzbucq1EgSUqQiruSqadL7VBZWvcldiKDimfrvXEg2S2TIo8Qi7uQJNX4b6v0/10
         amVv7sNRRqnhTCHLFKdhLz4k2XZdMlH5DoUJtSQuUFXB8cyLL3Gfh1JDVUtpwmRcAW8n
         erExgzMPh+2aOt1IQneL1CT0RB5brkkoCorwcFsSEtSBRh8J31DpoWmB5zCZbsCkPMYJ
         PiTP1GUacJKMTHmMt3RgZdaj1U+nm29ZX8mnsDEXSX0v15aqK9zJjo+wWokpp1taEA67
         6bJ4VywXke3JWSDCw3ZJh9mEixqfMlBrvKB8mNPKm+yJ6beIMIcDjnHqz8jN8Sam+ve8
         0eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Qgo5364SnUWK2dNQ5Zfdn6/xMGj0/q4OzZE+MW9D64=;
        b=kT2KRrjiFrM1MAgI92f2MeBTvJvY09zEL3jgst5e06FexjGNcQM1Y5+s2lO0a2834V
         3Z/qazDlcfuHBPHaKfolXOy0phrNjw1Ejn56B9w+2B3oDg8DYntEzm2gwZu+z/CgbbBy
         j+YgjTy6aePXSdG/46ifiwjbpixU2msBhRCJ5wOZG2A7q2XYH1PApKqJOOmHX0tSbBud
         PAW5vPranWjSoVl+iiiuDo/0wYKgOvlicDvlRCvNwuMCJJRlndOjrMQ/WXeA/GxJkhDO
         1IJiLNRf9swDpSy/YqEf597Pnraoh4XV+JbmxJUO3awroI79MMshY+uVCMd504G6cOVR
         YcXQ==
X-Gm-Message-State: AOAM53186XBmbi8kUDNOrjuISut5z9qXas2K0YcC708cPIuLryeSrUNd
        rp9aoveeo7DVly54su/2hOLqfA==
X-Google-Smtp-Source: ABdhPJz7WaOCKKUUXKC5QJrEjYscQ8+A1ETyUmwukoerUYpRIYH60c0efD2qdHXWwPpJG40jHiDkyQ==
X-Received: by 2002:a17:90a:588f:: with SMTP id j15mr5059145pji.177.1630601813323;
        Thu, 02 Sep 2021 09:56:53 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v190sm2968216pfv.166.2021.09.02.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:56:52 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:56:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 2/6] KVM: x86: add force_intercept_exceptions_mask
Message-ID: <YTECUaPa9kySQxRX@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-3-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811122927.900604-3-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming this hasn't been abandoned...

On Wed, Aug 11, 2021, Maxim Levitsky wrote:
> This parameter will be used by VMX and SVM code to force
> interception of a set of exceptions, given by a bitmask
> for guest debug and/or kvm debug.
> 
> This is based on an idea first shown here:
> https://patchwork.kernel.org/project/kvm/patch/20160301192822.GD22677@pd.tnic/
> 
> CC: Borislav Petkov <bp@suse.de>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 3 +++
>  arch/x86/kvm/x86.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fdc0c18339fb..092e2fad3c0d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -184,6 +184,9 @@ module_param(force_emulation_prefix, bool, S_IRUGO);
>  int __read_mostly pi_inject_timer = -1;
>  module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
>  
> +uint force_intercept_exceptions_mask;
> +module_param(force_intercept_exceptions_mask, uint, S_IRUGO | S_IWUSR);

Use octal permissions.  This also can't be a simple writable param, at least not
without a well-documented disclaimer, as there's no guarantee a vCPU will update
its exception bitmap in a timely fashion.  An alternative to a module param would
be to extend/add a per-VM ioctl(), e.g. maybe KVM_SET_GUEST_DEBUG?  The downside
of an ioctl() is that it would require userspace enabling :-/
