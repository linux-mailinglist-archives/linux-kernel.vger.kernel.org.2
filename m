Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE03FEF9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbhIBOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345374AbhIBOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630593809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHO5Tzwhao5TiABrZCBAUisQfo436W0ONUMzhgH6h6s=;
        b=BxSroMcTIYvGGurcloBi3/Gy8HT2smMkbMhawo9LdyNrH+OoMXcEuQpqtW4f1tGLVfYN2M
        IGzkPC4KBNmxDZ/Ulk7crT/xQeXUahX87g9dJ8l60/suvU72I0JypwBc2orvQcT8AVG5LF
        kflVBJlblGu5mB3pxWipQfE74o/6GK4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-QbNDn-6oOkWBumbJ4ODUgQ-1; Thu, 02 Sep 2021 10:43:28 -0400
X-MC-Unique: QbNDn-6oOkWBumbJ4ODUgQ-1
Received: by mail-wr1-f70.google.com with SMTP id j1-20020adff541000000b001593715d384so622441wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fHO5Tzwhao5TiABrZCBAUisQfo436W0ONUMzhgH6h6s=;
        b=ounjqBpHpsR2CUa3LBVaLIjpzpMLr5aTAdL2Xy3MUN1LLpx0kr5UZP1z1yet3lfgud
         TRbPGB73d46udWQEeJAk0Rvc23+bkHaWQGR/aAzfwolQ+3ysEQ6ynpAR0nr3fIJss4xS
         8R0HLTtIPNT8BkU71f2j5Gt6+n3pgH30Vtr4+2M9ueD7ZiVuWehzv0z4Z2OKf7aqFoz2
         oAMn6aob3BS1WZ0sfmi8ZNFSoBNgp3yO9QnvdzPXltDC/evuzT+7b3HbzMopfXU++yUz
         IlgzmyUlnhlkI9k/8uJQElTBWppaxJZJCNSzchqQh2JGv/0ZCwD6rU+PLYKBcdRQxRX5
         vM5w==
X-Gm-Message-State: AOAM5325aiVW1/3K++DjNF8z9SYSbEUEzgudFNfm6KB0HsNA2z0Ht7JO
        qn0hJY4s4DRZkdOnc1guDcX68VR4xK+iiIX1jRDxpQjT2NAZVKARjtcK2zLLmD/lzH2c+BTvxpj
        RAKj2jFS5JyBVjKOHtXAa2wmM
X-Received: by 2002:adf:d185:: with SMTP id v5mr4114894wrc.378.1630593807497;
        Thu, 02 Sep 2021 07:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAITxf/zsmp3O/FLDDlzAAMda3pWOdK4AMw/uZTLp2t5nLI+RKcceAMXP4cp6k6aVrvMWRkw==
X-Received: by 2002:adf:d185:: with SMTP id v5mr4114878wrc.378.1630593807374;
        Thu, 02 Sep 2021 07:43:27 -0700 (PDT)
Received: from gator (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p4sm1786988wmc.11.2021.09.02.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:43:27 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:43:25 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 06/12] KVM: arm64: selftests: Add support to disable
 and enable local IRQs
Message-ID: <20210902144325.c3beg3qqnfdwj6um@gator>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-7-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-7-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:06PM +0000, Raghavendra Rao Ananta wrote:
> Add functions local_irq_enable() and local_irq_disable() to
> enable and disable the IRQs from the guest, respectively.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../testing/selftests/kvm/include/aarch64/processor.h  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

