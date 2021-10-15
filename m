Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B65E42F974
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhJORBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233725AbhJORBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634317153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrxAxlOACWR0Z4cI7skuHhl8Vbh5voHrbzYS4o875p4=;
        b=IFupHy+v8/F4m/fbnJLhoiK7sTpQrntkRy+ywhpZA5rvoFUkGcI00dUPm/aW4XzikOw6tP
        rWrYeEJe2X8s8KM3+JSVtHWwudlw966afrvDrqeVNH3NjN33qITijy7tf1RYSmmZHAVVCK
        xb9WP1xjd2ti0RXC/Dqr4RV5TyANK0I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-fus8Y4nrMiehy3dX-Lcm7A-1; Fri, 15 Oct 2021 12:59:12 -0400
X-MC-Unique: fus8Y4nrMiehy3dX-Lcm7A-1
Received: by mail-wr1-f72.google.com with SMTP id h99-20020adf906c000000b001644add8925so2982067wrh.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=lrxAxlOACWR0Z4cI7skuHhl8Vbh5voHrbzYS4o875p4=;
        b=BtInJyIdXwvrL6ytSMQzUOWZpJjV739ceupxPd1x74fAIlcsNuorIVgKCdFxr3whfT
         JScaOa0ggvXWz2H8bj9Qvjut9bgFvBNRdpg2PryDJd90vSAcDOxJudzJ/w8uSWJIa4XG
         hq7aCXkf1v/H6njAvJof3IMYtSVw/rzFLrfWPYuBS8y5mlgCs2GXlFffQQQnrOe2hdVp
         WU0Soh40qxJcEuMHzKfJotpY6Rl6BfBYJpiTXcmMAZc0xzEVg1oMVQP0mR0uJMY/jZkB
         fpY8ekn0B6pTaO1SsGuDCyHU2xMuBOALdjPHGJW9kwwCTwjKoUmItwrYZazOodiSYZJ/
         baJg==
X-Gm-Message-State: AOAM532thDLOZQ4/jguai15+iQI3Mxvd83hVe2vZJkm344i6zbDvyvY9
        tVkSa7EZThmtfybAQ+joPHr2msGbgSEmLVESK1bJ1Ojg5eK+B66zExKaev1HjDMm4vdigzrAJ5g
        fUp/Ji99kRVa4asEXzg7jN7N4
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr13691670wmb.160.1634317150589;
        Fri, 15 Oct 2021 09:59:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhkgyEcPKV58AXnDGKmza3ea/Iqy+Jm8x8J3z5OGPGZO87bUmKrrTnJ8R5J4ictZjZLz+goQ==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr13691656wmb.160.1634317150424;
        Fri, 15 Oct 2021 09:59:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id e1sm5655215wru.26.2021.10.15.09.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:59:09 -0700 (PDT)
Message-ID: <a8a9227b-72ea-e31e-2221-e616fc32de67@redhat.com>
Date:   Fri, 15 Oct 2021 18:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v10 01/11] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211009053747.1694419-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.21 07:37, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
> other VM guest types, features supported under CONFIG_PARAVIRT
> are self sufficient. CONFIG_PARAVIRT mainly provides support for
> TLB flush operations and time related operations.
> 
> For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
> most of its requirement except the need of HLT and SAFE_HLT
> paravirt calls, which is currently defined under
> COFNIG_PARAVIRT_XXL.
> 
> Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
> like platforms, move HLT and SAFE_HLT paravirt calls under
> CONFIG_PARAVIRT.
> 
> Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
> break any functionality for current users of CONFIG_PARAVIRT.
> 
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> 

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

