Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB653FEEE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbhIBNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234188AbhIBNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630590248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRM8lYGUmpsg4gH1Jz3PJxIAnZtJDS7+em5ACTDkhkU=;
        b=QjPcRUqmyKU0TRfpc1WtY2E0oI9voSL5YQt8sUQXITY+gHNOOCIU625KW5WVTTCfLpqumv
        5hE+ybfs+t3MLTbiuRRz1zoTOnHTrSV1kQZ7NtB1XBUsj7ey2KO9DATE3xWEgrKhQWNs0a
        6TVvW8q5M9e0w7s3yItaMekQVezFAiY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-3CVrbb8iPA6qtuXIQjalhA-1; Thu, 02 Sep 2021 09:44:07 -0400
X-MC-Unique: 3CVrbb8iPA6qtuXIQjalhA-1
Received: by mail-qv1-f70.google.com with SMTP id et12-20020a056214176c00b0037279a2ce4cso1557225qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PRM8lYGUmpsg4gH1Jz3PJxIAnZtJDS7+em5ACTDkhkU=;
        b=OpyUT1nVnMtUSf+tHUVdOCaWz8LNvfBAdfQ06R+27z8/WkaUX0VOu1T+YIzyynPz7k
         vUC1hkMhw9H06yUcoTbfxZsMA93wOeyNIArjbMLwTBioEqiomNQbcGf/fwJEHOb792wr
         MfSosTPK7igADb2wnyyc28kESD9z3Q/phRdFiJIvFjxTVVPCoPT/9xQjmOZH64rAcNVJ
         Ym5aSAkvx3qytCIBIi/ZYOA6FsSAn5LUo+UwOu3MImq/thD98UCNYkRrsoJMssVT32CW
         l3HwA66Mhwuug1TfNOsBVeCQFh7eBKWDnrILSmXxx+Un/z0XColP5OBxjqzLHx16+WNL
         d+SA==
X-Gm-Message-State: AOAM530EJr1UN/J68r+BNvCVoUbjmbfjFE0UmQv4TMI7YhI/PnVxvhti
        ALafPl1mkAptNDjjPSqf9M56WPhRHFPS4rveQVbez/2rcjKATJIB9sWXtF2tPTdBFHJx//Q0KGU
        Cr6Vjp9XqoGqY259CThUJdXeo
X-Received: by 2002:ae9:ef48:: with SMTP id d69mr3231879qkg.232.1630590246612;
        Thu, 02 Sep 2021 06:44:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdTmtzmIqhqv1SiL46ML/7VojNuDfGcPgaJcYW31JCHc0kbak0ynOg7JISUhtrJ42VKof4iA==
X-Received: by 2002:ae9:ef48:: with SMTP id d69mr3231851qkg.232.1630590246376;
        Thu, 02 Sep 2021 06:44:06 -0700 (PDT)
Received: from gator (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id w11sm1412416qkp.49.2021.09.02.06.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:44:06 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:44:02 +0200
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
Subject: Re: [PATCH v3 02/12] KVM: arm64: selftests: Add write_sysreg_s and
 read_sysreg_s
Message-ID: <20210902134402.zihdyigplaxm432o@gator>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-3-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-3-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:02PM +0000, Raghavendra Rao Ananta wrote:
> For register names that are unsupported by the assembler or the ones
> without architectural names, add the macros write_sysreg_s and
> read_sysreg_s to support them.
> 
> The functionality is derived from kvm-unit-tests and kernel's
> arch/arm64/include/asm/sysreg.h.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/include/aarch64/processor.h | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)

If we don't replace with an import of arch/arm64/include/asm/sysreg.h

Reviewed-by: Andrew Jones <drjones@redhat.com>

