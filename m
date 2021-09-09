Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03D240450A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350759AbhIIFfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350756AbhIIFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:35:52 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2EC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 22:34:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j18so787971ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 22:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y2Hl2l4cxBWAmvma6OCIzHq+HL4honh1QiJPwU9rasU=;
        b=h0trGScMtT5bQc/2VuAgPUXIbyF8zoHK/m2lOVQQC7tyT0+N9vwYgAYl0C7N+3clR9
         9GhxGKDa0YmXUs7zbK+2egOPre9sEsGTgq6ZZ9vBfRp67UeT8J4VCDFJvbSMCvfYQkL4
         dJsIjN5VShAqkQxXN04P6nXY7quSg4zza2QawEf9RSHqbuiuhDkcTW32Do2SizpJ7QRC
         cb26MSQiRsktbLZ+9DGCB8pAeUbvrDxFMRCqaK9WNqBQ8ZpiOZGNpX9AkIx4B2QjGgfP
         LzVyTeBWH9iuO1vBdsL8zYB5iMC96Sb/LGZeIVJqS19WCm3v+Y7CuSIQN7ZZrdgw6Efn
         cNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y2Hl2l4cxBWAmvma6OCIzHq+HL4honh1QiJPwU9rasU=;
        b=12cCVX0xjYTMGgcpl20RycJUsHTvJIAK+SHSuVwQG0u24LRgXke8Ut6eu67HjWbWWz
         WQ477dpUKzS7kXlwEjv9JMwDb7LLbHncXofHnz5/OV9/ymPJaM8CD9dJwRHkk3zTbvT7
         ZIZpJ/XPB3srWkpK1yAny11qebpGEb6ZwDv470TUw3x+wfjGaCzOy0YjRe/4sgWVSZ9O
         /SllxECxHG+Jfm91jmeHv83SedoOF7DZWlNdiLuum2X97ifN1lqld5qtmhXtNp5Yz8TI
         HVfuZVYn30HUFgZRcRrUZKFHv+xTojFXClkVPa0RBQFvLPXXkTxG/JdW8O1ZM1b5ZkEq
         Zu6w==
X-Gm-Message-State: AOAM532AGIpEmfe49IgBHs1A7KKLg9jDMVBrcGMAipo1zK2j54Rots6q
        t56Wr8drAbe6mjcJ/y6Fqux89g==
X-Google-Smtp-Source: ABdhPJwNOgynlp5UJ/IiTJl67bZenp2a5LYW9EGf/gzrp3rUUolZcWeZIJhwxhwOFZMFl5RRTaQTXA==
X-Received: by 2002:a05:6638:1613:: with SMTP id x19mr1279010jas.77.1631165682590;
        Wed, 08 Sep 2021 22:34:42 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id z10sm409971ill.69.2021.09.08.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 22:34:42 -0700 (PDT)
Date:   Thu, 9 Sep 2021 05:34:38 +0000
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
Subject: Re: [PATCH v4 17/18] KVM: arm64: selftests: Replace ARM64_SYS_REG
 with ARM64_SYS_KVM_REG
Message-ID: <YTmc7s5hdAuN5PPy@google.com>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-18-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-18-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:38:17AM +0000, Raghavendra Rao Ananta wrote:
> With the introduction of ARM64_SYS_KVM_REG, that takes the
> system register encodings from sysreg.h directly, replace
> all the users of ARM64_SYS_REG, relyiing on the encodings
> created in processor.h, with ARM64_SYS_KVM_REG.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/aarch64/debug-exceptions.c     |  2 +-
>  .../selftests/kvm/aarch64/psci_cpu_on_test.c     |  3 ++-
>  .../selftests/kvm/include/aarch64/processor.h    | 10 ----------
>  .../selftests/kvm/lib/aarch64/processor.c        | 16 ++++++++--------
>  4 files changed, 11 insertions(+), 20 deletions(-)

I would probably just squash this into the patch that introduces the
ARM64_SYS_KVM_REG macro.

--
Thanks,
Oliver
