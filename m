Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9F439857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhJYOS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232010AbhJYOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635171396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yBIeDqOkiGFurlFgD43y7wdSJN5RQI+Z9N38wXwm0c=;
        b=fi7aAaBeFfH4Qk8blOaIo3+M1Y3wlqngaQz/TwxqzkIzw6kAAn1FX4JOeeCWo9im0FoGzG
        ZK2qkY1aJQQqCVrgyUPWgXwJQthMYAdRlWQUT4kQnavWJ77N2IU0ptyA9L5cHakK8LXdsH
        aTY+3VZNBGtf3KOQ1FSTJep/v8huTKo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-Kd5JsL9KOHO_ksqaVvIQRg-1; Mon, 25 Oct 2021 10:16:34 -0400
X-MC-Unique: Kd5JsL9KOHO_ksqaVvIQRg-1
Received: by mail-ed1-f71.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so10003909edx.15
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1yBIeDqOkiGFurlFgD43y7wdSJN5RQI+Z9N38wXwm0c=;
        b=iafBlwlGSmFqys1URs453i3HZWnV3H1M20Rza03SP+qfx5EcdIQgVlT7TABDlqSQBn
         m73jZi4A5llid0Si1rj+9uFzi9dnM6GHnB5g79Z/BMb/fLAGAKxnDD7TxkNPaZ/IUa8G
         PA+WMADIyr8AmuE7VjKA/oRPK5ZClYUtf4ztNLE/fQAdDxxFL6CAAbDSHWs9vhrjFRMo
         yzWMsUeBO/7X0wWFL1agLcN+34rHGhLA+36Cl+vZswVpmqaZglKRpXSAlaruSeHJ4RTQ
         YLbOMcNj+uv0i+5WB9DXIIpHIxPbutAfhTS+jAg8honQVK3d43VgmqW3rxgHshbZ0lSD
         DRGA==
X-Gm-Message-State: AOAM532eX7wqAT7Oew7g2BjJj45r/V3pUmR4yww7IppvobUBkx1+IF3k
        gBEz4UsakOCwwSDE84ANf6r6ehL+amsdFnvGzUTGh1x9ov9Ix0bvOTKpNBmq2RZ/WXx19NDCowr
        G+Q4HGLPRTW1UcW2P/uIB/VBV
X-Received: by 2002:aa7:c384:: with SMTP id k4mr20307549edq.281.1635171393295;
        Mon, 25 Oct 2021 07:16:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy0DabLqT08o64mSEkgU1uBZtZezVv5apPrWyd4apSmXmCs+LkrkYQ/fnsjY0W8O5UT62zRA==
X-Received: by 2002:aa7:c384:: with SMTP id k4mr20307513edq.281.1635171393133;
        Mon, 25 Oct 2021 07:16:33 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id bx2sm3600770edb.44.2021.10.25.07.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 07:16:32 -0700 (PDT)
Message-ID: <01b5edae-aaa9-e96d-daaa-197c0c3a0431@redhat.com>
Date:   Mon, 25 Oct 2021 16:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 43/43] KVM: VMX: Don't do full kick when handling
 posted interrupt wakeup
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     James Morse <james.morse@arm.com>,
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
 <20211009021236.4122790-44-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211009021236.4122790-44-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/21 04:12, Sean Christopherson wrote:
> When waking vCPUs in the posted interrupt wakeup handling, do exactly
> that and no more.  There is no need to kick the vCPU as the wakeup
> handler just need to get the vCPU task running, and if it's in the guest
> then it's definitely running.

And more important, the transition from blocking to running will have 
gone through sync_pir_to_irr, thus checking ON and manually moving the 
vector from PIR to RVI.

Paolo

