Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B9E3BE923
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhGGOBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhGGOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625666326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7dzRxBxm91wjIPJ9WL8p7wOAJtFPjrAp62go4fmxBM=;
        b=Oab+mbvA78Hvsi7kR2Tw3n1LvenRG+Q+HtuN6b0jc4GspghbELXF6zVieIpxhg2Jr75rBw
        2773RIiqvWJRw0ythgjjq9mSwWc+Vs1zTGQ9eGBtNd1YysOhD+kvlI6P8VgLa0uIg5i6NT
        1B80mJzuH0PY2QTdAtCssNpylLTL4ow=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-piWMsdnTNqKD0SXUHnOh3g-1; Wed, 07 Jul 2021 09:58:45 -0400
X-MC-Unique: piWMsdnTNqKD0SXUHnOh3g-1
Received: by mail-ej1-f72.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso581486ejs.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 06:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7dzRxBxm91wjIPJ9WL8p7wOAJtFPjrAp62go4fmxBM=;
        b=sEK1RgzjuP/AJQbalHHBUlA2q07FaijXOh8+CyT9ZuSafTrAYJrnfZasK8FU6AxRNc
         CMI7WS8MfxMBsyI0xRH3P1SakonvNakbSmcj0uid9AYR4Lc8jmhxx3LY9Ef65bpiNGmw
         9k0rdY8rnyDug/PthGI1cxT87y6E+s0+xg4UxrT7wrWpnmHH1mTBb9QclIbIzRLo1Mar
         Pl0geA2F2dIrhfq94IcAladmxXQ+4X/fR4uN5KhpNYd4/kD/EiSrTWsDNbK1gH215Qcn
         csZn2DtS58A/lMIYH5sZDFbn4LUaE+yqbndCU6HpaIJJWhri17ztZTU5s2ieXwtmnPoz
         1+BQ==
X-Gm-Message-State: AOAM532vdsAOFzHtGw6ikquX+6Id7T2/uPqZ7fiJ34D3tEr4zNFJQ5A3
        7XfSKU+SurnndOqeB4GFJ2o4vMAIevBPzCNMxDPVvXiwwtLl2rrDXlISDDrHp10T2QYZK4nkaJW
        qqepBp63ey893iAGgxhoqGdZA
X-Received: by 2002:a17:907:778a:: with SMTP id ky10mr24219089ejc.32.1625666323677;
        Wed, 07 Jul 2021 06:58:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv4/GKMuuk/PByT1b/oedsUb6euFSbdyt/iajMDhfbbJx/hDlbvK2r52qKQEnfJptk9m8CAg==
X-Received: by 2002:a17:907:778a:: with SMTP id ky10mr24219079ejc.32.1625666323534;
        Wed, 07 Jul 2021 06:58:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z10sm8700548edd.11.2021.07.07.06.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 06:58:42 -0700 (PDT)
Subject: Re: [PATCH 02/10] KVM: x86: APICv: fix race in
 kvm_request_apicv_update on SVM
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>
References: <20210623113002.111448-1-mlevitsk@redhat.com>
 <20210623113002.111448-3-mlevitsk@redhat.com>
 <6c4a69ce-595e-d5a1-7b4e-e6ce1afe1252@redhat.com>
 <43ef1a1ea488977db11d40ec9672b524ec816112.camel@redhat.com>
 <9413056ebbd5997a35b446f2841589973484ba02.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <502391b4-5a5f-6f37-dab6-06ae276a205f@redhat.com>
Date:   Wed, 7 Jul 2021 15:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9413056ebbd5997a35b446f2841589973484ba02.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/21 14:57, Maxim Levitsky wrote:
> 
> Hi!
> Any update? should I use a lock for this?

Yes please, even irq_lock can do.

Paolo

