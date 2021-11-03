Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA81444470
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKCPQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231571AbhKCPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635952405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcjS/U0esOcZt9aUj7QJ/b283I90hVCo2RapOPx/5rA=;
        b=HGFiV6qERFV8CfhHYS7/H9qzRdvTs34XX8F71Lqu2a/MBdd+KZCLf/1fxBTYmoMyWC/iox
        5lNPD/YYPmb9se8yI/H54x/c335HeKzIyNqkGQzp46/7Na9nViuF8UqaYfFgP0UtdyfMcF
        8E4YEQTTIgC1areHilmZ1cR9H2BvIh4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-DilQ9wL3P5uSfLdUwKb2NQ-1; Wed, 03 Nov 2021 11:13:23 -0400
X-MC-Unique: DilQ9wL3P5uSfLdUwKb2NQ-1
Received: by mail-wr1-f70.google.com with SMTP id c4-20020adfed84000000b00185ca4eba36so491948wro.21
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EcjS/U0esOcZt9aUj7QJ/b283I90hVCo2RapOPx/5rA=;
        b=TM57SZ0avqolpD8cbH9C4jRsJYJPS7RPbYesfX0Cc6aXdVIKm2ZXRV6ZEd3x6p86xU
         d8HzVjRkxHzwoYcaM7xutPXt8MkgOdem/dhoComT/AJSRL4NWNw9YinqWLLmprv7kKU9
         KPiccBRPVHuD2Z7Hv4ULHyGFe4ww3QTMBoVHhG28fYjYtxcx1tawloOmbikAefHcvXxo
         zicAAGuOGI3oFpObIFuu1Zs43gKj26f5ZthCEaXhK+IORmJdx8hLCjJAm7Xuph4SAYhP
         xQKWANwm23ev8QFLEnEN45xOXOe1LugarvgiW114fbPEB02Y8sO55hrMcGyehNFzYU3B
         jrsQ==
X-Gm-Message-State: AOAM532beOoU9KLy6GvjxvzMCF/7noCAHVQWy+SE6h1f26ePHdtdIw+v
        bFnCfYVcBTSQ2Lr4Zbul2z86x/nhU/QIKBlBhdoCBzAC+pCGCl0kisZF3QsfXk2ISz2OxJkwii9
        vaFNGeXFhlkU82wAEXYXTuKguIvi/sJoKpEJIWqJYvVmaM5Uz2nUcLK6p4XMpkrLRVbD4kzWeLO
        a8
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr16116872wmq.21.1635952402269;
        Wed, 03 Nov 2021 08:13:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywJOfU5ytKMlivfLi6bw4DBBApAa9fqr7O37GSjz4t8SwMadSRVC41M824DZivE+K+jo0kcg==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr16116832wmq.21.1635952402009;
        Wed, 03 Nov 2021 08:13:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w1sm5574500wmc.19.2021.11.03.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:13:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] KVM: nVMX: Enlightened MSR Bitmap feature for
 Hyper-V on KVM
In-Reply-To: <20211013142258.1738415-1-vkuznets@redhat.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
Date:   Wed, 03 Nov 2021 16:13:18 +0100
Message-ID: <87r1bxmfw1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v2:
> - Renamed 'msr_bitmap_changed' to 'msr_bitmap_force_recalc' [Paolo] and
>   expanded the comment near its definition explaining its limited 
>   usefulness [Sean].
>
> Original description:
>
> Updating MSR bitmap for L2 is not cheap and rearly needed. TLFS for Hyper-V
> offers 'Enlightened MSR Bitmap' feature which allows L1 hypervisor to
> inform L0 when it changes MSR bitmap, this eliminates the need to examine
> L1's MSR bitmap for L2 every time when 'real' MSR bitmap for L2 gets
> constructed.
>
> When the feature is enabled for Win10+WSL2, it shaves off around 700 CPU
> cycles from a nested vmexit cost (tight cpuid loop test).
>
> First patch of the series is unrelated to the newly implemented feature,
> it fixes a bug in Enlightened MSR Bitmap usage when KVM runs as a nested
> hypervisor on top of Hyper-V.
>

Ping?

-- 
Vitaly

