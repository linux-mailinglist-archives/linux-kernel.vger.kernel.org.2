Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DAE4044E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350634AbhIIFUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350542AbhIIFUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:20:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EADBC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 22:18:58 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b200so740031iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 22:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+CYFnjvQGu3qEtGCtuJvH4Bp2b8Zt/XnVuPY3zDRm/4=;
        b=iASH6O9lWrdEVAkELUB1zBmanzld5X4HWNeQXJAqq4lnMka+pE0wihP0EZNLG+Dy+8
         W6SPfpydSSrMwC1ldEnMQcQ2aAfiXV9pjugauT1C/yeoYYfo3z39B/61zOyQLd17GKJP
         6Dv57E9J6sge/+PgOd3g6uDp+SypcWMPm2LBSXk9qCCHQr0UhKzxV4+t2+IISw3gLV/c
         6a0a5VVclG8dgvz5n5ud8UQ/AjDjXL/wrCPHtQk0u5w0X/1JPM67/pV79+7NFP6DCyWT
         oEuKEMfPe7ohxC+nb3cByLN2hAZCwAPuUYSf90DB6qFu6yUErJA6M6iNesHjRNL6mZSs
         V4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+CYFnjvQGu3qEtGCtuJvH4Bp2b8Zt/XnVuPY3zDRm/4=;
        b=Xh0HlQOxISzVZH1FYj6TsBBV47Y6yOrzik8fUfu22KOHWm79wQxN3UXaQmc9GgjUe3
         syw5TImbV9THxX9Irm0QzigYLasJDjpk4JiZzmlxdN7WX0U7LrIchI8bzfSni77E+1vk
         k0A5hfVWUp03BL+S6aIUVP7t47AkRfqzlOcXOkzRrKiRZ0xbHUP/FNaK9V1/yjk4fhkI
         bLXATY3KoWfEdUO1Cl5H3uiohrUOYl3rQvk54LA+wL9Z7bUcd5CD5Pov0b9MKmK1ChSC
         L2iTdguQze1bqW8lL+xoLUCMOkm9MvLSdXde8GuwUpauOQX1jCXlzzEO6AOLivdTayEC
         W22Q==
X-Gm-Message-State: AOAM532qISiUTgMNueJ3Na2We+h0Jncll8QIxGdS6/mNl7G3e7uT+Mo6
        Z/trHUG/KaouYgc7ML/n4coYqQ==
X-Google-Smtp-Source: ABdhPJzq92DTfukBJOnIWgAl3htCHd8+vLrGENISalBbgwBC7v97HZRdGs9hOdm2RvVO8uV/scNEeg==
X-Received: by 2002:a6b:8f4e:: with SMTP id r75mr1131550iod.172.1631164737554;
        Wed, 08 Sep 2021 22:18:57 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id z26sm426323iol.6.2021.09.08.22.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 22:18:56 -0700 (PDT)
Date:   Thu, 9 Sep 2021 05:18:53 +0000
From:   Oliver Upton <oupton@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 11/18] KVM: arm64: selftests: Add basic GICv3 support
Message-ID: <YTmZPSEm3Fj6l1PN@google.com>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-12-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-12-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:38:11AM +0000, Raghavendra Rao Ananta wrote:
> Add basic support for ARM Generic Interrupt Controller v3.
> The support provides guests to setup interrupts.
> 
> The work is inspired from kvm-unit-tests and the kernel's
> GIC driver (drivers/irqchip/irq-gic-v3.c).
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   2 +-
>  .../selftests/kvm/include/aarch64/gic.h       |  21 ++
>  tools/testing/selftests/kvm/lib/aarch64/gic.c |  93 +++++++
>  .../selftests/kvm/lib/aarch64/gic_private.h   |  21 ++
>  .../selftests/kvm/lib/aarch64/gic_v3.c        | 240 ++++++++++++++++++
>  .../selftests/kvm/lib/aarch64/gic_v3.h        |  70 +++++
>  6 files changed, 446 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/gic.h
>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/gic.c
>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/gic_private.h
>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/gic_v3.c
>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/gic_v3.h
> 

[...]

> +static void
> +gic_dist_init(enum gic_type type, unsigned int nr_cpus, void *dist_base)
> +{
> +	const struct gic_common_ops *gic_ops;

does this need to be initialized? I haven't tried compiling, but it
seems it should trigger a compiler warning as it is only initialized if
type == GIC_V3.

> +	spin_lock(&gic_lock);
> +
> +	/* Distributor initialization is needed only once per VM */
> +	if (gic_common_ops) {
> +		spin_unlock(&gic_lock);
> +		return;
> +	}
> +
> +	if (type == GIC_V3)
> +		gic_ops = &gicv3_ops;
> +
> +	gic_ops->gic_init(nr_cpus, dist_base);
> +	gic_common_ops = gic_ops;
> +
> +	/* Make sure that the initialized data is visible to all the vCPUs */
> +	dsb(sy);
> +
> +	spin_unlock(&gic_lock);
> +}

