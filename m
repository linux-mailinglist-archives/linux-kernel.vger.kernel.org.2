Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD54397D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhJYNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhJYNut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635169706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rAI1rvJIZVwx71e91km04CwkX5jtmNRsQSKYM+y4LQM=;
        b=RcUN7h3/KVcwB6CG2nyXxa0de24df0g3VfDOZrfqH/ynGLyLyDFmXnYkvZkf3l/Xy192Bw
        RupD1Y+KicOlz2O5kjHiwx3bttaThZ8ePhvcgYr++8Hf/XUpwmyXUFODZ+DX+NCwXtd/Hm
        eQB4dxnagmpWvuZtwsyzT1JmL8TEMXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-C9xeyPrCMrmlJV_ui2mvyA-1; Mon, 25 Oct 2021 09:48:24 -0400
X-MC-Unique: C9xeyPrCMrmlJV_ui2mvyA-1
Received: by mail-wm1-f69.google.com with SMTP id z20-20020a05600c221400b0032cb38a76a9so2438wml.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rAI1rvJIZVwx71e91km04CwkX5jtmNRsQSKYM+y4LQM=;
        b=viwwagiRrbZJ8tcNE2oDTDH1JTm6/Skpn22jEKwhHM/8OWcwBkCb65QEkSXUBlBKTu
         w3iFf5zYVz7NJ4+KUBuOqYdHYtji6vJ6TzKU5JkWuKYTiuK0tku3K4UhuJIb6yeaXwYM
         VnF2OOv0WMpWET+hir45AlB9zjWx0YtGGBTUBH+HscLiSSF5N9gv2YxvOrjJlsLO4+/J
         SdnP4aLRG1pj+JQQBWw+YJJQ5NJ3TZqNigiiiXhUFysIFeukt51BajhYKtTTrVB4jQOg
         7QYVeDmVI8QHq6D7uWSAcYzab861qxXzPKsc8CEK/B4OjznCnfsPPo6l40hyrHjwi0jP
         AmxA==
X-Gm-Message-State: AOAM5334DIOzx8FGiiGs7R/yMAKvwO/bruAfcwBTv2Lv2sgpH3PIysL4
        7Ylp+iSirqGpnsjo2ATIjEEYlzeTcRWoZ9Hzc/mIP+dh6D3i4rJj6zO6WKlhlcJMYi4OKs9ZsfF
        9mlypzGhorxNdlB2cavHLXGCN
X-Received: by 2002:adf:d1ee:: with SMTP id g14mr24355622wrd.264.1635169703586;
        Mon, 25 Oct 2021 06:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvh4UiZag1iqCL0Yxmhmh7ghHaPzeCY1G7nZe+NYuublJxNb7HJYi3GJafbpt4P4VqHirR5w==
X-Received: by 2002:adf:d1ee:: with SMTP id g14mr24355558wrd.264.1635169703285;
        Mon, 25 Oct 2021 06:48:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m12sm3661638wrq.69.2021.10.25.06.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 06:48:22 -0700 (PDT)
Message-ID: <1537b693-80ee-4f9e-2c4e-6e1c62ccca92@redhat.com>
Date:   Mon, 25 Oct 2021 15:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 20/43] KVM: VMX: Skip Posted Interrupt updates if APICv
 is hard disabled
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
 <20211009021236.4122790-21-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211009021236.4122790-21-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/21 04:12, Sean Christopherson wrote:
> +	/* Nothing to do if PI.SN==0 and the vCPU isn't being migrated. */
>   	if (!pi_test_sn(pi_desc) && vcpu->cpu == cpu)
>   		return;

This does not quite say "why", so:

         /* Nothing to do if PI.SN and PI.NDST both have the desired value. */

Paolo

