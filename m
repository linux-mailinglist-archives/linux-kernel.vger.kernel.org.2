Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B11A372DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhEDQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231523AbhEDQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620145177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvZzucVTJj9dxsTr6Jb9cUKmM3ASskNG3nrOKSzShTs=;
        b=jG/TUtf+Le+oxntTIxflhgj2wkApuN2Ht5UOu9HGsgEMpEa4Sam9o34hsQFbo3ySWRotpq
        fLfYCiikDuxhM99aaTqXkV/ZVAPGAglcYmHQ2kN5OON99+FkuCyY+BamVtaAF96TNqgMOJ
        ptJUdZ6sc34Lf0+4wPQbIpLdBC/y100=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-KBLsGYPaP0-mY6bjgd_VhQ-1; Tue, 04 May 2021 12:19:36 -0400
X-MC-Unique: KBLsGYPaP0-mY6bjgd_VhQ-1
Received: by mail-ej1-f72.google.com with SMTP id r18-20020a1709069592b029039256602ce8so3336461ejx.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvZzucVTJj9dxsTr6Jb9cUKmM3ASskNG3nrOKSzShTs=;
        b=dVpdxapFDaJ9YF+jMf3FadDvVICsoDmlRVWF1BRAN7eKwPf91+EarxZMczqhmoxJeY
         Yh1gibMKhD2TYBsdfD3QfTbzF5FeXm6j4/HBOYMiXIgG+07dSmATjp4vDkeXQbNZXHXB
         YoIem1RvH+x8eeqUC2afj6f9uKTbPvFWQukslogGUzO9J+Ch1LvtEKgj7H0+vnGA1QmF
         O9WXgCqfori3TtX3AlkNkMpI3MwDQJyyO8apMnju6OAexk55dVK4fDCZgb1nmS2OGrN/
         dBgzPbjS6PPjibod0bHWShaubkK4mFrCQ3dPeLUKxSKO7tn2aYbYYdbo3lLdK/mU8eSt
         mUWA==
X-Gm-Message-State: AOAM530ZVyHlaIZd/GYJ7SrOHdyg6PKR1VM+CPHK8XuOL3o76F3x2HnD
        wy/suwsNMBZqMZnmDrFtCvnXeif9eDKPUjrHteWFAGkRYtcvgXuC52Ip4/ayEdve88HfGRtVk6T
        VedwIoPLLc+zlqS/6xAulj2kC
X-Received: by 2002:a17:906:74c6:: with SMTP id z6mr23116041ejl.13.1620145174248;
        Tue, 04 May 2021 09:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd+ig4AwTg19EHmSE9AuapvGBuOhDPNqevOhLBrOcuT38OfUfNCRLxPATXl7S44ePq1tKwMQ==
X-Received: by 2002:a17:906:74c6:: with SMTP id z6mr23115975ejl.13.1620145173653;
        Tue, 04 May 2021 09:19:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r16sm6213363edq.87.2021.05.04.09.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 09:19:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] KVM: nSVM: few fixes for the nested migration
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Cathy Avery <cavery@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210504143936.1644378-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08d7ea6e-8b90-e606-5dcf-18393bbae9fd@redhat.com>
Date:   Tue, 4 May 2021 18:19:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504143936.1644378-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 16:39, Maxim Levitsky wrote:
> Those are few fixes for issues I uncovered by doing variants of a
> synthetic migration test I just created:
> 
> I modified the qemu, such that on each vm pause/resume cycle,
> just prior to resuming a vCPU, qemu reads its KVM state,
> then (optionaly) resets this state by uploading a
> dummy reset state to KVM, and then it uploads back to KVM,
> the state that this vCPU had before.
> 
> V2: those are only last 2 patches from V1,
> updated with review feedback from Paolo (Thanks!).

Queued, thanks.

Paolo

> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (2):
>    KVM: nSVM: always restore the L1's GIF on migration
>    KVM: nSVM: remove a warning about vmcb01 VM exit reason
> 
>   arch/x86/kvm/svm/nested.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

