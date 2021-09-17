Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4240FDB2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbhIQQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234941AbhIQQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631895348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wAFQPGPyFN6MzK3bzK8jBC17iHiKc9AgbxXN8TxrV2g=;
        b=KICIP31qKysYDqkUCXpOyWT88IU95EEAYvmhjYEo1562W4hAUU9vqCUVpgs32L4oNdk7Y7
        Agp38PJuL41XkxTb/l/otjG2OZce9GRubS5gt+08T99gqqDsv4QVNw5+DJyyvfUXh98nmj
        XPDLcjaEqMiUsG+YS9UlXiSaF4CTMQ4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-dMzemHeTOpSV0TMeWWT2LQ-1; Fri, 17 Sep 2021 12:15:47 -0400
X-MC-Unique: dMzemHeTOpSV0TMeWWT2LQ-1
Received: by mail-pl1-f199.google.com with SMTP id bh9-20020a170902a98900b0013af7fdcba9so5193712plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAFQPGPyFN6MzK3bzK8jBC17iHiKc9AgbxXN8TxrV2g=;
        b=F/00++tNkYPgS39cRKFg/ioZzecbQMaNUc4FsPjg2XyM+KZKgIuCoNkOMwGcYcVcE3
         qJRKA9sn4V24QGmXO4y9dKhIrvmiAXkUPHWGqO8sKY8hwpOa95fSNV53lX0AZhtVDj99
         VLP++zrvX+XYR7O+SOxrgQ7OfcZdCaL+d+2dvwykcMC/jJFKXMSlC5KQQYOPYrEOGkNE
         vTi0ygh329t4weHNVHkkrHSs7psDxbkbfxvrordm1UKke0T2/WwhZPzV+ovxdzNDggIz
         YGaFnsUmDUvmOC57z6ACt/AbzpV9F5unigAnK4vpkDrMyOHMtBR8/pGZGMulLc0Y+J/M
         cASA==
X-Gm-Message-State: AOAM532T+SH1tKuuYt5W5yHfVoc5UpTclKnYwRo8hYhrbW+AyM7U/u33
        7HfzuauTrC2cZAhH8ARSJa7Lz86jbYdmKvjHeZLyPfg1oJxbk+Dc7euC04GvAyKu0T4egWjrE0K
        GEQscxLHzpFguffGXFin5LoPuSGW6yUKFIQ3LwpVq
X-Received: by 2002:a17:902:d717:b0:133:a5f6:6be6 with SMTP id w23-20020a170902d71700b00133a5f66be6mr10309170ply.14.1631895346054;
        Fri, 17 Sep 2021 09:15:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOhNz2zbDcVfa/AWoVfQ6vVBkU8H3tVtK9RFm4Mi0iUZKgxzNDBV2Mk++eD7V1IurjLU3QnjPe+x14oLufnf4=
X-Received: by 2002:a17:902:d717:b0:133:a5f6:6be6 with SMTP id
 w23-20020a170902d71700b00133a5f66be6mr10309138ply.14.1631895345720; Fri, 17
 Sep 2021 09:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210914230840.3030620-1-seanjc@google.com>
In-Reply-To: <20210914230840.3030620-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 17 Sep 2021 18:15:34 +0200
Message-ID: <CABgObfYz1b3YO4a9tR02TourLmsnS48RWrOprrsEh=NpbQfjRA@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: x86: Clean up RESET "emulation"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 1:08 AM Sean Christopherson <seanjc@google.com> wrote:
> Add dedicated helpers to emulate RESET instead of having the relevant code
> scattered through vcpu_create() and vcpu_reset().  Paolo, I think this is
> what you meant by "have init_vmcb/svm_vcpu_reset look more like the VMX
> code"[*].
>
> [*] https://lore.kernel.org/all/c3563870-62c3-897d-3148-e48bb755310c@redhat.com/

That assumes that I remember what I meant :) but I do like it so yes,
that was it. Especially the fact that init_vmcb now has a single
caller. I would further consider moving save area initialization to
*_vcpu_reset, and keeping the control fields in init_vmcb/vmcs. That
would make it easier to relate the two functions to separate parts of
the manuals.

I should go back to KVM next week. Context switching with KVM Forum
and Kangrejos this week made everything so much slower than I'd liked.

Paolo

