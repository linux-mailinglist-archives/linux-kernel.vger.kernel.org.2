Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4874043D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 05:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbhIIDDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 23:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhIIDDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 23:03:43 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFCC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 20:02:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x10so443478ilm.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 20:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lS2TfPmFq21WQA7kbI98jf7rDXgRBmsiJwAOxbyrVAE=;
        b=E1i9dzXY8FPZ0L+1tJuVo2J7zoe5PQ5Nbe26IR98lKFC/EFy7vzC7ItaFodLhxWHl5
         BC4MTyEER+lWdRHF8GluZ4XPAsX77Y+uxxjgW7B0b6PFqGUtBUANxTpziKk66rKP/ew6
         VcaQtkDrk4p2eK7xJNcdBzliel9JDBPZ7I3YlVvLU8hPNUntp+0+M05YxBLrcpplsf3q
         cZgexH9nLdpb6A98a4Aenh2/cOrv6xIM7meGszXq9kjMA7T7kfXMkRpLzHb+lIpMG+1O
         VO5oLmDy9I5apJ/bpHQNuvc1a4GjsOk3zXsn4WiD+2QmOwTV1OD9GvzLQOqKkP7Dx9lC
         zgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lS2TfPmFq21WQA7kbI98jf7rDXgRBmsiJwAOxbyrVAE=;
        b=POouhLvgCnCXjiUnlI75upEs1jEiwC/XzI9N1TCBO8BMWK1K0Me8Upvdw3Q2JT4ctX
         xmtKpYn+YNwjHohPq9KtwmB/1q/gVZdOBr6VuSyD2peRkT1TO1v6T1DnscRPo7JCVmbI
         lG4eNqwqkzvalpSVGf/7F/8Ey4CAt2vP2lfGZMPh8E0BzEbUP4Z7l9g8blm2bfIQDGXC
         4vh9V8t6il5Ofi5CTpIB/+a9qYy2OoBgZJwZluJ3uQE2W/gEpJ8y+Iq2fnC53knYhtsh
         SqRsh8lGngqI2upNeFw+8fDkpgYvtTIfeBHzgUgWc+wthU7QR6JaYb2JO3P6CHEaJD2X
         C7ow==
X-Gm-Message-State: AOAM531UnRwN8Fr26X4GPGuFyRUv26qBIGSaRQwVncaNrZuvrckfdpv4
        30aUmiFew2JulJAVumhIhFxyKg==
X-Google-Smtp-Source: ABdhPJxnO3Xpf1rxt3cvGCIm05a/BPHERWpzorX/jlAxyWQB/SDLCIR3d7u6J9mGOmi/1JVTQda6Jw==
X-Received: by 2002:a92:c605:: with SMTP id p5mr594556ilm.53.1631156554045;
        Wed, 08 Sep 2021 20:02:34 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id s1sm282250iln.12.2021.09.08.20.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:02:33 -0700 (PDT)
Date:   Thu, 9 Sep 2021 03:02:29 +0000
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
Subject: Re: [PATCH v4 04/18] KVM: arm64: selftests: Introduce
 ARM64_SYS_KVM_REG
Message-ID: <YTl5RQjJ0EFmhUlG@google.com>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-5-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-5-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,

On Thu, Sep 09, 2021 at 01:38:04AM +0000, Raghavendra Rao Ananta wrote:
> With the inclusion of sysreg.h, that brings in system register
> encodings, it would be redundant to re-define register encodings
> again in processor.h to use it with ARM64_SYS_REG for the KVM
> functions such as set_reg() or get_reg(). Hence, add helper macro,
> ARM64_SYS_KVM_REG, that converts SYS_* definitions in sysreg.h
> into ARM64_SYS_REG definitions.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/include/aarch64/processor.h      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index bed4ffa70905..ac8b63f8aab7 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -26,6 +26,20 @@
>  
>  #define ID_AA64DFR0_EL1         3, 0,  0, 5, 0
>  
> +/*
> + * ARM64_SYS_KVM_REG(sys_reg_id): Helper macro to convert
> + * SYS_* register definitions in sysreg.h to use in KVM
> + * calls such as get_reg() and set_reg().
> + */
> +#define ARM64_SYS_KVM_REG(sys_reg_id)			\

nit: KVM_ARM64_SYS_REG() perhaps? Dunno which is more readable.

> +({							\
> +	ARM64_SYS_REG(sys_reg_Op0(sys_reg_id),		\
> +			sys_reg_Op1(sys_reg_id),	\
> +			sys_reg_CRn(sys_reg_id),	\
> +			sys_reg_CRm(sys_reg_id),	\
> +			sys_reg_Op2(sys_reg_id));	\
> +})
> +

Could you also switch all current users of ARM64_SYS_REG() in the KVM
selftests directory in this commit? You can also drop the system
register encodings defined in processor.h

--
Thanks,
Oliver
