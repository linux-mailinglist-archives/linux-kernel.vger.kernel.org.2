Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0437453FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhKQFFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhKQFF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:05:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A8C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:02:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b12so2086412wrh.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAvRwiJtBRjHFRCmWgOSCR5R03A+VkMxLTTMBvp3xOo=;
        b=GAwv8KZH7QoSza11mCj056EEnvOqtVaHQFo/kLuYCRBcZU1JH4Hq/2IL1WzjLJ6BpO
         Nspwyqrh2//HnesmXMmgpT2dZaCtkaHvEExt4dD4V8EQnuyZF+ehE8jy7/PvfzY8JdpP
         0oGbTDm155zcUW1iLeK7i2p1k6raVw3QOSIA6J7rnYNA5AxfcOGjmvcCOUoO6TMEzWvz
         D4zo4ka6/BC+duGUr0a17+RCW1EAJNMFHgye3vZLTjLqu8b5jtlzjqGuKQk1i7OpS4/n
         /rdHVIm/M6FEt/fJTzKVImD5IX7YnjqN1HZhnolIKr/hvnjL0wwKpRKq2TkiIrTQEBox
         cQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAvRwiJtBRjHFRCmWgOSCR5R03A+VkMxLTTMBvp3xOo=;
        b=8Kq44t+k+FesBuTcEuEkJQXHAdWxOzgHlarzoqD/5Ymjk917L7EmGQSBHdgYCKtO6R
         q4X3GUhT8qiNS9BSpLvI7ok82370+Bc6JUDhmUmpEHXMt9ZrrajIoU6kz/1Yns9Qel5G
         2k43FXTMyEBobzTxYVUJ3qcznwf5atRdp+smOvwyfF53Pjkugu/lbpbtLfzX3IFVozi9
         MwoT5RcQ816QHEziT/7YCWPKwzEOTJ24//PzKvLECwvyYYXOlw9eR33UhNX0F+NuvGMA
         VubLSKemu3YWmSgAMm5g80Y61QSzRJxJaXjOSn+WPNNU1+JLqLyVOnb8RiKJr7w9ZUB8
         08NQ==
X-Gm-Message-State: AOAM531v0T+uO3xdefZ/ZvWnN8Vb8xYc0UBHN9uJxm072NgCbm6xdRCQ
        AYH8PWeeM2ojOweZbWO0gjjgBtJ3U7pzV9n2UKcf2Q==
X-Google-Smtp-Source: ABdhPJzjrfWofPzOBZxD2tEv76Kk7EIV+O42lYkqHli/gBWm8/qTI2cfDKQ7RNWGfhhww3GxDwccPcYXM1XKn0e14eE=
X-Received: by 2002:a5d:4846:: with SMTP id n6mr15849576wrs.249.1637125350274;
 Tue, 16 Nov 2021 21:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20211116163443.88707-1-vkuznets@redhat.com> <20211116163443.88707-5-vkuznets@redhat.com>
In-Reply-To: <20211116163443.88707-5-vkuznets@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 17 Nov 2021 10:32:18 +0530
Message-ID: <CAAhSdy3VTfXmt4ub9SWwFQWwcqCS07WkwXdh6ObOcoZSp5oY=Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] KVM: RISC-V: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     KVM General <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:05 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It doesn't make sense to return the recommended maximum number of
> vCPUs which exceeds the maximum possible number of vCPUs.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Looks good to me.

For KVM RISC-V:
Acked-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Anup Patel <anup.patel@wdc.com>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 26399df15b63..fb18af34a4b5 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -74,7 +74,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>                 r = 1;
>                 break;
>         case KVM_CAP_NR_VCPUS:
> -               r = num_online_cpus();
> +               r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
>                 break;
>         case KVM_CAP_MAX_VCPUS:
>                 r = KVM_MAX_VCPUS;
> --
> 2.33.1
>
