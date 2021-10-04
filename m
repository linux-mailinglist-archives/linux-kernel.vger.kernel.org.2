Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A518F4207AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJDJAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhJDJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633337912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x988Ui+c+vfAAmLIqziJI6EexnnYwYLQ/x9zWNbOLdg=;
        b=TwNXIYYtUWclrH3r8p9pnqA2TMyC3lFM2awpjYUTLsgysWotTzNgV87KHX/pF2bNBn81Ux
        7jWHhIoiQsM85cHOUPaqTR5FvpkYn1rBenkt51AJ6TmjqgDhjUYCrO93HWo+KmylzotKwT
        IydCflgSi6CBMmAB1+gSbTeDS3gDCvk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-RcIQZaKnOeyGTL3zY011ew-1; Mon, 04 Oct 2021 04:58:31 -0400
X-MC-Unique: RcIQZaKnOeyGTL3zY011ew-1
Received: by mail-ed1-f69.google.com with SMTP id ec14-20020a0564020d4e00b003cf5630c190so16597253edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x988Ui+c+vfAAmLIqziJI6EexnnYwYLQ/x9zWNbOLdg=;
        b=uvp3nV7Djx+WWBM3ByLyUVH4qCoyMoeRXZ9GM9lTWzJ2mgArhELfDPgNmxGqytj+DG
         UZxV5RMLsKVI//yHGVkHw5mBrNkHXU9lcUx1P8NvxnNwdNY4ihJlsrwp76T01YbrOOMB
         Q0zj9LHj3rkI0xqeRLEFTefMbMvJCy+FEfhMUdIbjRj5OicHi0h14pc65JzUbAsXuKoD
         AnK97vqedWzCfcn64Tm2pXtQUAQYK680Cbx7lZLLGjH/hAVtipnQrMKaYOnUAEPnThQa
         Kq4lfTFiflXCyRe8poo72uJgS9hUL2lxFfFLbYTu/KLCENY9xOTN04Yfk5DGavYD1fBT
         mEBw==
X-Gm-Message-State: AOAM533g2d3EbgtmXKckRRwOaV6JLXikRHo7lCRNbo7cbOoIkDkLnP39
        w9rmwxBEjfs/QGNmhshUW7t2+axj7eqg1K9nue4WIiTSrEs52pwyKTDgNA+Oc/ETr48ScHW0qK4
        JEVyWCdG3WTFvRDtjR6oZr9Ae
X-Received: by 2002:a50:ff14:: with SMTP id a20mr16824386edu.81.1633337910598;
        Mon, 04 Oct 2021 01:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3qfHpLJuyjpb6MtwvFvqa3LKkfmelPlkrd/kMPhmqTdP8vX0VHFbEmy8mw+EaIFZUIu92UA==
X-Received: by 2002:a50:ff14:: with SMTP id a20mr16824362edu.81.1633337910414;
        Mon, 04 Oct 2021 01:58:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id s3sm6209175eja.87.2021.10.04.01.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 01:58:30 -0700 (PDT)
Message-ID: <5cadb0b3-5e8f-110b-c6ed-4adaea033e58@redhat.com>
Date:   Mon, 4 Oct 2021 10:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v20 00/17] KVM RISC-V Support
Content-Language: en-US
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Alexander Graf <graf@amazon.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210927114016.1089328-1-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210927114016.1089328-1-anup.patel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/21 13:39, Anup Patel wrote:
> This series adds initial KVM RISC-V support. Currently, we are able to boot
> Linux on RV64/RV32 Guest with multiple VCPUs.
> 
> Key aspects of KVM RISC-V added by this series are:
> 1. No RISC-V specific KVM IOCTL
> 2. Loadable KVM RISC-V module supported
> 3. Minimal possible KVM world-switch which touches only GPRs and few CSRs
> 4. Both RV64 and RV32 host supported
> 5. Full Guest/VM switch is done via vcpu_get/vcpu_put infrastructure
> 6. KVM ONE_REG interface for VCPU register access from user-space
> 7. PLIC emulation is done in user-space
> 8. Timer and IPI emuation is done in-kernel
> 9. Both Sv39x4 and Sv48x4 supported for RV64 host
> 10. MMU notifiers supported
> 11. Generic dirtylog supported
> 12. FP lazy save/restore supported
> 13. SBI v0.1 emulation for KVM Guest available
> 14. Forward unhandled SBI calls to KVM userspace
> 15. Hugepage support for Guest/VM
> 16. IOEVENTFD support for Vhost
> 
> Here's a brief TODO list which we will work upon after this series:
> 1. KVM unit test support
> 2. KVM selftest support
> 3. SBI v0.3 emulation in-kernel
> 4. In-kernel PMU virtualization
> 5. In-kernel AIA irqchip support
> 6. Nested virtualizaiton
> 7. ..... and more .....

Looks good, I prepared a tag "for-riscv" at 
https://git.kernel.org/pub/scm/virt/kvm/kvm.git.  Palmer can pull it and 
you can use it to send me a pull request.

I look forward to the test support. :)  Would be nice to have selftest 
support already in 5.16, since there are a few arch-independent 
selftests that cover the hairy parts of the MMU.

Paolo

