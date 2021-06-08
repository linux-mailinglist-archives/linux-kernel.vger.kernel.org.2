Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6249A39FDEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhFHRmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233081AbhFHRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623174057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuTEXUh2y4+eVpi9BE2NLF0/TYZeOk1VrPvZH9w4Lo0=;
        b=VKc4tzxWmHWjURUSwxP/NHO2KD1CX5seNqmu+UFueKUdeV8JJ0TvDStbDc9+GSL0PE2DUE
        c4E2Aw2x0eTReav7QPuj9fLaIG0n43EAeBACD3NEAERaikjIOJ/gI4bSbPyjJ0XCRP5ei0
        3FzTQVF7EVw3DZbTGxkXsaolQXlIp74=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241---TLSilMNuOVvs1A4FIC8Q-1; Tue, 08 Jun 2021 13:40:55 -0400
X-MC-Unique: --TLSilMNuOVvs1A4FIC8Q-1
Received: by mail-wr1-f71.google.com with SMTP id h10-20020a5d688a0000b0290119c2ce2499so4792089wru.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uuTEXUh2y4+eVpi9BE2NLF0/TYZeOk1VrPvZH9w4Lo0=;
        b=JbXsjH7naJnw72B64HujnqOme0Ik7bMX5YQ2z+cwIgApZrV00JGGAS6S6idbVXnaWJ
         CvQatynzbpjAyJCISrLT/tY2v0JSJrv1XRGcSFpgMsD0gYt7fkIPgMA55T9/hbq2JGLJ
         9+3Oz+aOFmyZMr67GYgSS1IUOlOceRzaI/1JkrXqa/iFf0/CXCcd1t80DDYBPudIwr42
         N2Dkbf+Q6PlFYwQiyeicQeE5zPM9bNXAeCBJcCCAQsQnKc8O2zYuKPmNvqwAdj41LeLZ
         tFuf3sPT52qvvlsdBDP9387ehbjJjeril7Xl+VZZ8HgYSG3yC4TmCdZEv6q9gamjmE1G
         mZjQ==
X-Gm-Message-State: AOAM533WTDvMXedDURla8MtsmfsHC2d8sfUL+lrG/VvnP/Ie+p3FiLTP
        QshhUNzR9VecCEOtCLg5WLD9echVaWzgvuqEZgBFfkZ1wABxazhxOOSMAf4W6iWQfAYTdLOEIHy
        IHsOPtodykQYwqC0amG4GMzrA
X-Received: by 2002:a1c:9804:: with SMTP id a4mr23765706wme.34.1623174054279;
        Tue, 08 Jun 2021 10:40:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCg/4Dg2XjHEakG0Gnd75nQyKD/Y6nxzDDphWNa3SRKmaQxg54dFAsRxFHIsqIoOwPd/74gA==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr23765690wme.34.1623174054086;
        Tue, 08 Jun 2021 10:40:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o26sm7824493wms.27.2021.06.08.10.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 10:40:53 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] KVM: X86: Let's harden the ipi fastpath condition
 edge-trigger mode
To:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1623050385-100988-1-git-send-email-wanpengli@tencent.com>
 <1623050385-100988-3-git-send-email-wanpengli@tencent.com>
 <YL+cX8K3r7EWrk33@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a643f94-d159-c1ac-6bd2-cc6b45372630@redhat.com>
Date:   Tue, 8 Jun 2021 19:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YL+cX8K3r7EWrk33@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/21 18:35, Sean Christopherson wrote:
> Related side topic, anyone happen to know if KVM (and Qemu's) emulation of IPIs
> intentionally follows AMD instead of Intel?  I suspect it's unintentional,
> especially since KVM's initial xAPIC emulation came from Intel.  Not that it's
> likely to matter, but allowing level-triggered IPIs is bizarre, e.g. getting an
> EOI sent to the right I/O APIC at the right time via a level-triggered IPI seems
> extremely convoluted.

QEMU traditionally followed AMD a bit more than Intel for historical 
reasons.  Probably the code went QEMU->Xen->KVM even though it was 
contributed by Intel.

Paolo

