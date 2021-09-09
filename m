Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6D4043CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349781AbhIIC4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 22:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349570AbhIIC4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:56:53 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1658CC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 19:55:45 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b4so436927ilr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=70g9MtOxJ+c9WQaUJGlWTIEgCLNxdZNwZARtMaXCcgM=;
        b=fybdFrS1IowdAXfYbxOXZ3I6iSICWHOoF9IqHePDV3JYI5GmKvgKKa90x5sb5L8SYR
         9szwaRfJMm9JfBRUgGGY3YY12Mjuc+rk2CbaIqEdAE32pvpey8S5NzpVoqHHXoJoizU9
         Y4m0MBUqxSXXIpH97d7OQLDeqGByZe+DbZDDbBDInbxLt8uB2fzneSrc+2gXDZ6qGE7k
         UtVvjlpHQ5cpq/I/6xiR7ftkjaNaD1UCpUlyMn/WeV1wyAJhooWq7AgiBdv15eANHjag
         wv9n6hADOzo+d0E/yh8ZUZBX4YFEHDZJ9eQixJtbt9LixnwUWFrLJ9+yU+ejmrjmnr5b
         qvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70g9MtOxJ+c9WQaUJGlWTIEgCLNxdZNwZARtMaXCcgM=;
        b=Pne/aaiZ4He6iFg5c8paYxQp5gJAM9A2dqnXf+0XtnVHU2IkWd8C3D8RvyjZxwaIK9
         MQfnHeUs0/fpnPcjx5zMoV+RvwyMZTfvEt/OB4r2uwVjHfwb4Yeem41J6WuV9vTVMM2N
         1Wi62PCsLqwizeCE79zwQ2+daWky2TymNZWWjMjyOf3HOdxmPVVTo87cZ6U+eCg+KgaJ
         keuD0h9oz9QK3WkQAx6S+sucw8a8i7aK9uWN0R4Qa6kNHgvr1ZcSHKaIzhl58EUAwPsS
         49ndtkU6h3Fp/00n8rkgMY77hYTTfon4/V8PqJnm887/d0IfVtdrG2dSke9Zo3wfmFie
         LDrw==
X-Gm-Message-State: AOAM533oGlwXEmIJGtd/J1mof59jvtA7sLQReD1KdmRC4AqtlAM7DB1C
        c6WuxXHxOntADYQHOftVxiEMOQ==
X-Google-Smtp-Source: ABdhPJwe5z4yVVGtg+ZHPkN6LiNEnHan8VvEXYzBBzUdrsrQl6RJRGqbPl1NpgQBsDKzC/M6vmVW7Q==
X-Received: by 2002:a92:6907:: with SMTP id e7mr563449ilc.301.1631156144318;
        Wed, 08 Sep 2021 19:55:44 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id a2sm259247ilm.82.2021.09.08.19.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 19:55:43 -0700 (PDT)
Date:   Thu, 9 Sep 2021 02:55:40 +0000
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
Subject: Re: [PATCH v4 03/18] KVM: arm64: selftests: Use read/write
 definitions from sysreg.h
Message-ID: <YTl3rP50dYjvmmDP@google.com>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-4-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-4-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:38:03AM +0000, Raghavendra Rao Ananta wrote:
> Make use of the register read/write definitions from
> sysreg.h, instead of the existing definitions. A syntax
> correction is needed for the files that use write_sysreg()
> to make it compliant with the new (kernel's) syntax.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/aarch64/debug-exceptions.c  | 28 +++++++++----------
>  .../selftests/kvm/include/aarch64/processor.h | 13 +--------
>  2 files changed, 15 insertions(+), 26 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index 96578bd46a85..bed4ffa70905 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -8,6 +8,7 @@
>  #define SELFTEST_KVM_PROCESSOR_H
>  
>  #include "kvm_util.h"
> +#include "sysreg.h"

#include <asm/sysreg.h>, based on comments to 02/18

Otherwise:

Reviewed-by: Oliver Upton <oupton@google.com>

