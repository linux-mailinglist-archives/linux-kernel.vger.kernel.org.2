Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4095043CCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbhJ0O7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237296AbhJ0O7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635346629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kiv1BZf6xFogujw6ml5Mx2cj+xKDQFeYDEEPX1GMOs=;
        b=A/5DhUG7viz9Q20XNQp3R6VBeocsmcHHxyZnXNKlXb2LeOhxQD3FBuD/IHfg64yyzpTE88
        Yd8E9nyDnQNDrL+TNML6kaLLWBbIi9CoNgujO3/B3q1sUlM+l6HfFeY3ZfaIrwEUtixyJM
        rsyKtuYm24TO6HmYojVtsAYztUdbfaM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-j3wZ0yMQOlmC7TFLszKgDQ-1; Wed, 27 Oct 2021 10:57:07 -0400
X-MC-Unique: j3wZ0yMQOlmC7TFLszKgDQ-1
Received: by mail-ed1-f69.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so2527558edj.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1kiv1BZf6xFogujw6ml5Mx2cj+xKDQFeYDEEPX1GMOs=;
        b=Y6OQRJqZoCbl9TVJKVAwD09WcsqwgmENFMQ+LBNLB9+N7W2fteBNddl54QeyA9q5+K
         E9xnBWRKdNd66/UDVOGiXOzIEs0qzjl8Lpl8EEvHjWSAbVvjEdy7AYUY4Q/Hj2ycW8tE
         AHfP2k80isPQRS3flPM6amivIuIZuFt5ctrW7xBBdt/UdsBUIf793pFh24Qbr7tmv1G9
         PNjOdnv9rQkG8I1NkRWJXKd2BvpExEjFoH7lm/4CEd00B16Yg0Z4No3OHi1xuRfBg5bT
         nrbAfoFIPTMACCaJoRTipRu4d2rmq8IsDojkOVjuSxFn4H3Tb5hJVfh11AQtCBageTbs
         Hkrg==
X-Gm-Message-State: AOAM533WfOOqULM48/sPa2ZglBghGDIkgl38eUI1TFc/POz5AnbuKsdI
        xv6fUjTNi5pNqS3o6QFQj+c/aw/j8fdFpdZpZV8dzuYqS3C2MdwGZwG03W/MGSF/vrXrdKvet/a
        ONfqPeYRv4ksVSUvoniMTwe9p
X-Received: by 2002:a17:907:7d94:: with SMTP id oz20mr38999431ejc.98.1635346626749;
        Wed, 27 Oct 2021 07:57:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytn7bu+kBLh9LVQ/1pex7gMJDdz0Rr/buTYBO2a2VZJzJDbs6skZyshVLbERw1F1K5YyM70Q==
X-Received: by 2002:a17:907:7d94:: with SMTP id oz20mr38999381ejc.98.1635346626512;
        Wed, 27 Oct 2021 07:57:06 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t15sm67707ejx.75.2021.10.27.07.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 07:57:05 -0700 (PDT)
Message-ID: <ecec4d7d-13dd-c992-6648-3624d7c14c24@redhat.com>
Date:   Wed, 27 Oct 2021 16:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 00/43] KVM: Halt-polling and x86 APICv overhaul
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <614858dd-106c-64cc-04bc-f1887b2054d1@redhat.com>
 <YXllGfrjPX1pVUx6@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXllGfrjPX1pVUx6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/21 16:41, Sean Christopherson wrote:
> The other thing I don't like about having the WARN in the loop is that it suggests
> that something other than the vCPU can modify the NDST and SN fields, which is
> wrong and confusing (for me).

Yeah, I can agree with that.  Can you add it in a comment above the 
cmpxchg loop, it can be as simple as

	/* The processor can set ON concurrently.  */

when you respin patch 21 and the rest of the series?

Paolo

