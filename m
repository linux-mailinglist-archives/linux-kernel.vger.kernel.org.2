Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6372E449CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 21:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhKHURc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 15:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbhKHUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:17:26 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D718C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 12:14:42 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y16so2713321ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWWZbv1VXbeiAIfJ9egbHayb1S7Nhsd/riY822fMbFM=;
        b=Afw7Z+AbCOWHXWeJR2umxo7zaJcZYAZ9IUzuhdm1uwyKjOAowlsfexwtQZijnlDMpJ
         Hbaokol5Z4xYyi47EBgEF7Ydbm+G/pF7x2qpHfhyJxszqyg3ywP0yt0AByDsMqOk02vW
         WydLb8+7qmXTQgEeQv/ysvc0IhMH2YadWe0ucUFt1WJu2F6P4BqE5f5yriQ2uPCiMH5U
         N8gAl2g8HpmHLM0uiOaBp/82MfSe8etmsceBUNTiEHZRS1NR/Bc9hMDOqyWbRS64pHBi
         9jy7ouEcuv47UxFbv4EJwiZ0LY3RKS2/Ges5jdCcdtBB5gg88L0d80/yZnTqwh0fVuQW
         Davg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWWZbv1VXbeiAIfJ9egbHayb1S7Nhsd/riY822fMbFM=;
        b=hxsMmPkJ5GDPxtiRFw9GWKwuviDPVBdKKfAkeRZ1uivZGSTgN6Oy7KFEsJDb/gDrGp
         73Dk6GQjO8nu1fkbslb76QxwlLUy03xg1ZgxK5/LDthp/iEI/DybqXqb7GEU7RG0tzvL
         emDaRNtvqSdMAjk7swDsoT+Fw2r2DBZKgNxStdv2NKZHDseOqjfiqbMLBsv4+ubndPQB
         K/RlYiZqiKtLUd3wF6S8kYm197Xg+QTGEP52F2DsFT2a24d3KJ/oPW11MmL5S2giYMjy
         r30fJ/Z4h7Nm24yjI6a+XvHweg+lZkjs8AniC910ceHfnpxAYmYg8t6vKBgeB4uja3HM
         3ZEQ==
X-Gm-Message-State: AOAM5333u7fA1L+NCQCSLrJfqWGRqhw+AwSxfTi0i6bFtVt2IHu5/DYd
        OHtbZYG6o/1U1EEMw/knsMuNu9GIch/Z0osB0szxIQ==
X-Google-Smtp-Source: ABdhPJxSSR8dl6zsHr9SQ3XA917DshRRXfDJnv7hmezMxKWDafEBgyx7sWpCsmnqswtVFX5d454iux9XNdQ50k78sxE=
X-Received: by 2002:a05:6638:1923:: with SMTP id p35mr1428832jal.16.1636402481497;
 Mon, 08 Nov 2021 12:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20210913135745.13944-1-jgross@suse.com> <20210913135745.13944-2-jgross@suse.com>
In-Reply-To: <20210913135745.13944-2-jgross@suse.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 8 Nov 2021 12:14:30 -0800
Message-ID: <CANgfPd-DjawJpZDAFzwS54yukPSsUAU+rWsais2_FCeLCZuY0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/kvm: revert commit 76b4f357d0e7d8f6f00
To:     Juergen Gross <jgross@suse.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 7:51 AM Juergen Gross <jgross@suse.com> wrote:
>
> Commit 76b4f357d0e7d8f6f00 ("x86/kvm: fix vcpu-id indexed array sizes")
> has wrong reasoning, as KVM_MAX_VCPU_ID is not defining the maximum
> allowed vcpu-id as its name suggests, but the number of vcpu-ids.
>
> So revert this patch again.
>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

The original commit 76b4f357d0e7d8f6f00 CC'ed Stable but this revert
does not. Looking at the stable branches, I see the original has been
reverted but this hasn't. Should this be added to Stable as well?

> ---
>  arch/x86/kvm/ioapic.c | 2 +-
>  arch/x86/kvm/ioapic.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index ff005fe738a4..698969e18fe3 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -96,7 +96,7 @@ static unsigned long ioapic_read_indirect(struct kvm_ioapic *ioapic,
>  static void rtc_irq_eoi_tracking_reset(struct kvm_ioapic *ioapic)
>  {
>         ioapic->rtc_status.pending_eoi = 0;
> -       bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_ID + 1);
> +       bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_ID);
>  }
>
>  static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic);
> diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
> index bbd4a5d18b5d..27e61ff3ac3e 100644
> --- a/arch/x86/kvm/ioapic.h
> +++ b/arch/x86/kvm/ioapic.h
> @@ -39,13 +39,13 @@ struct kvm_vcpu;
>
>  struct dest_map {
>         /* vcpu bitmap where IRQ has been sent */
> -       DECLARE_BITMAP(map, KVM_MAX_VCPU_ID + 1);
> +       DECLARE_BITMAP(map, KVM_MAX_VCPU_ID);
>
>         /*
>          * Vector sent to a given vcpu, only valid when
>          * the vcpu's bit in map is set
>          */
> -       u8 vectors[KVM_MAX_VCPU_ID + 1];
> +       u8 vectors[KVM_MAX_VCPU_ID];
>  };
>
>
> --
> 2.26.2
>
