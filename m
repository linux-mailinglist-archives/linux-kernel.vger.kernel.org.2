Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A163B2C92
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhFXKkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232127AbhFXKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624531095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8zOkEqDmKxv2wc98jEmrwn1/qGX8Rt7M/G4D1QmCCQ=;
        b=Li1ctAfTKPjmx28/2Au4q7t43mI/lOhwDX+pOY3pNG/mQZdQgc6OVcJuGvCUYR1han4VxK
        wu24rs2HqEykUxa/AoHV6ZLd+mAPmB0vdlDz96GUzKOeltUbnYlDRlTrg2bKaLG0sF8cQx
        93w21diNAGcQFD4OHArCVqnXyCrWGys=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-bLmf4XzAMSuMdm4kZhvAvQ-1; Thu, 24 Jun 2021 06:38:14 -0400
X-MC-Unique: bLmf4XzAMSuMdm4kZhvAvQ-1
Received: by mail-ed1-f71.google.com with SMTP id j15-20020a05640211cfb0290394f9de5750so2527528edw.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 03:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+8zOkEqDmKxv2wc98jEmrwn1/qGX8Rt7M/G4D1QmCCQ=;
        b=Hc4y5xjvbloxlSB+4nGRZ5wQVtZQtVuFUnT8S0Vhq4TJmcPEFafhcJSPzm0OG5uMhH
         AKcIG0MIB1+iLErJVzE36Q3RM1kps0yHy18+FmvFIQDAY6GxAX+dC0942wuiUHPIzs5t
         ak28mGa0X7PaEVmIqpzrajJKM8t6qKOeliG3uaT2Qx1/1BsrDQvk5KYoxdBttgwktgpP
         FUf8p5Y9UE6J0q0sMt1np7406RdZWd0mzAyvJPU68EAs7MA6ovcLett8BnRai86g8tDe
         oaONy9+tkTRg6OEG//cP2QDdFG2TEKQoi46XLpHykdY8UcmAv73iTgaJNK2R5N9aptCc
         HmIQ==
X-Gm-Message-State: AOAM531b3jSNSUZBGPJmuQtTBTnHseKT/HX1bW/+eiobdqxtgE2gEBOf
        TteBTK22nBES1P/vlBny9mruZuBF92jHeNhH+y87kVBQGi2JhDdDBrtNGFw/Yr5l4P4+boMAAN8
        0YYvgVDmgZtnicORiP2QYn32F
X-Received: by 2002:a05:6402:1d08:: with SMTP id dg8mr6303336edb.299.1624531093044;
        Thu, 24 Jun 2021 03:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI+JaqzEU3/RzVF63EQukSLbrjwL8GzIunmYBe8RjRpEpadfN+nfLVG7sxB/MR0xBEwblQQg==
X-Received: by 2002:a05:6402:1d08:: with SMTP id dg8mr6303320edb.299.1624531092822;
        Thu, 24 Jun 2021 03:38:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l22sm1595366edr.15.2021.06.24.03.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 03:38:12 -0700 (PDT)
Subject: Re: [PATCH RFC] KVM: nSVM: Fix L1 state corruption upon return from
 SMM
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
References: <20210623074427.152266-1-vkuznets@redhat.com>
 <a3918bfa-7b4f-c31a-448a-aa22a44d4dfd@redhat.com>
 <53a9f893cb895f4b52e16c374cbe988607925cdf.camel@redhat.com>
 <ac98150acd77f4c09167bc1bb1c552db68925cf2.camel@redhat.com>
 <87pmwc4sh4.fsf@vitty.brq.redhat.com>
 <5fc502b70a89e18034716166abc65caec192c19b.camel@redhat.com>
 <YNNc9lKIzM6wlDNf@google.com> <YNNfnLsc+3qMsdlN@google.com>
 <82327cd1-92ca-9f6b-3af0-8215e9d21eae@redhat.com>
 <83affeedb9a3d091bece8f5fdd5373342298dcd3.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8945898-9fcb-19f1-1ba1-c9be55e04580@redhat.com>
Date:   Thu, 24 Jun 2021 12:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <83affeedb9a3d091bece8f5fdd5373342298dcd3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/21 10:20, Maxim Levitsky wrote:
> Something else to note, just for our information is that KVM
> these days does vmsave/vmload to VM_HSAVE_PA to store/restore
> the additional host state, something that is frowned upon in the spec,
> but there is some justification of doing this in the commit message,
> citing an old spec which allowed this.

True that.  And there is no mention in the specification for VMRUN that 
the host state-save area is a subset of the VMCB format (i.e., that it 
uses VMCB offsets for whatever subset of the state it saves in the 
VMCB), so the spec reference in the commit message is incorrect.  It 
would be nice if the spec guaranteed that.  Michael, Tom?

In fact, Vitaly's patch *will* overwrite the vmsave/vmload parts of 
VM_HSAVE_PA, and it will store the L2 values rather than the L1 values, 
because KVM always does its vmload/vmrun/vmsave sequence using 
vmload(vmcs01) and vmsave(vmcs01)!  So that has to be changed to use 
code similar to svm_set_nested_state (which can be moved to a separate 
function and reused):

         dest->es = src->es;
         dest->cs = src->cs;
         dest->ss = src->ss;
         dest->ds = src->ds;
         dest->gdtr = src->gdtr;
         dest->idtr = src->idtr;
         dest->rflags = src->rflags | X86_EFLAGS_FIXED;
         dest->efer = src->efer;
         dest->cr0 = src->cr0;
         dest->cr3 = src->cr3;
         dest->cr4 = src->cr4;
         dest->rax = src->rax;
         dest->rsp = src->rsp;
         dest->rip = src->rip;
         dest->cpl = 0;


Paolo

