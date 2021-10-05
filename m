Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988FB421B53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJEA7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEA73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:59:29 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D6C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:57:39 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id n17so21790149vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sF9hNK+5Q8kvuTjnhNF2i15pqYB6ARh7CyQsrGGk5Nk=;
        b=3rDZP7rDxkPm4BRicpP7c18tETvV9lhAEStAgfxE784aSkZF8p0I7xRBHZ+kJyrAyg
         iPqFbTTomjZkq30xmNd0Wl6cIv1fp6Zi35lRRIL0gt7ylAlCellwGfQlKyhcdc8wnPXN
         o1ql62CI+cdEz+C53mbFztu/lP/p9vOz4TI4kL05lWmcJl4eITyEFP2NBndsLpKOinEv
         K0T4BXFgPm63yhjj8HwFSaMMcFOBIlCbWCqx/637FnacxHjPD7cdkPgXUckKP18A1E2k
         YZb9vyz2qfeHke+Sx0GoWhAYXZd0oeoHSmjuz14SPf/ckAcaY2JBM6KS7wVO8kHGU5nV
         wLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sF9hNK+5Q8kvuTjnhNF2i15pqYB6ARh7CyQsrGGk5Nk=;
        b=pzVCQr/2+zWV4mgWgobNaeR3NwEUTf0IAnZcGVY1SOPy79MhvbN83ern0Yh05Ek4In
         s59FTHsMSXKghsakrL/gYIUXarUa+1PdZJk3q4UuWnXbYgoA/IGUw3JUhagshfMD+va2
         zUP2u1y3Rhdnun6lFwPBVA2sMskHQSWcNlzO6FyF5YMpDEE7soyNSjFEvd1ArjGSMdjy
         6qe0nheVJWsf8JIIExpPguCc4jd0n2L1GgGuJWgcJVHlKrRcN0842MIAPuYb8Sfx9cT2
         CLQVFGnynIDKJw4FdesAFoN/Frwx7xAWMS8tAnjLQworu+KGEhRkqAaiJM837TctcuKV
         ULeA==
X-Gm-Message-State: AOAM533+dIBI0GlyO0t5duOX0nKJ/BNgZCD5BKCUrwcskGuGYU9Ori5M
        0etxcKg+i8tek5l6j7YKTzDzLTIKfNInMw==
X-Google-Smtp-Source: ABdhPJxM4t0iAKZap7UMdl4qygCi5eAr9HooSKcNeMwHx46JHFIzp9NOtETibJEIQYYuR3phsIxt4g==
X-Received: by 2002:a67:d11e:: with SMTP id u30mr13617063vsi.58.1633395458360;
        Mon, 04 Oct 2021 17:57:38 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h69sm7880300vka.42.2021.10.04.17.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:57:38 -0700 (PDT)
Date:   Mon, 04 Oct 2021 17:57:38 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 17:57:18 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: add rv32 and rv64 randconfig build targets
In-Reply-To: <20210912034538.19404-1-rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        mpe@ellerman.id.au, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-88e4dc9f-726f-4229-942b-083c9bdb61f8@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2021 20:45:38 PDT (-0700), rdunlap@infradead.org wrote:
> Add the ability to do randconfig build targets for both
> rv32 and rv64.
>
> Based on a similar patch by Michael Ellerman for PowerPC.
>
> Usage:
>   make ARCH=riscv rv32_randconfig
> or
>   make ARCH=riscv rv64_randconfig
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
> v2: add missing S-o-b
>
>  arch/riscv/Makefile              |   10 ++++++++++
>  arch/riscv/configs/32-bit.config |    2 ++
>  arch/riscv/configs/64-bit.config |    2 ++
>  3 files changed, 14 insertions(+)
>
> --- linux-next-20210910.orig/arch/riscv/Makefile
> +++ linux-next-20210910/arch/riscv/Makefile
> @@ -141,3 +141,13 @@ install zinstall:
>
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
> +
> +PHONY += rv32_randconfig
> +rv32_randconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/32-bit.config \
> +		-f $(srctree)/Makefile randconfig
> +
> +PHONY += rv64_randconfig
> +rv64_randconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
> +		-f $(srctree)/Makefile randconfig
> --- /dev/null
> +++ linux-next-20210910/arch/riscv/configs/32-bit.config
> @@ -0,0 +1,2 @@
> +CONFIG_ARCH_RV32I=y
> +CONFIG_32BIT=y
> --- /dev/null
> +++ linux-next-20210910/arch/riscv/configs/64-bit.config
> @@ -0,0 +1,2 @@
> +CONFIG_ARCH_RV64I=y
> +CONFIG_64BIT=y

Thanks, this is on for-next.
