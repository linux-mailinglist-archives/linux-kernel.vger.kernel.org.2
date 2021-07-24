Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69673D4422
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhGXARp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhGXARm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:17:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9EDC061760
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k1so4911240plt.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OlwUZcWU+zFAtM9hiJyMkmJtbQEHkL3Q1I7IsXb7FPU=;
        b=zk/id2ENEx5PqxL1+6dzRIQTqgm2OzCjl3e1YqmEJmSkUNm7ef5pbGC5CdB5WRfLXZ
         g2z7NXgg7LiMMHyc2IburHwZAWvOYdrfdhRS2IbDkkV+Jif1i0e7avh717Zfe5rmiXYH
         Gr0fL2dOCvNri4/oM0pZ5R3wDdfcohsT01xPjVURvHGAm/P6uOkKitsIrqv2DKineAlk
         WRuIStOxDSwd0pRBgHCYgie8I6y9I5mRHbNNDAJE5W5ZycILrtDuZ0fox6G0izjoy+nQ
         gGvoOR5gDDfDWXEUYh/q0EPIYS8G7XQwtzIZX+6kP2U+4kQB6yi1eggJ0FVnLaDCBX3p
         PBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OlwUZcWU+zFAtM9hiJyMkmJtbQEHkL3Q1I7IsXb7FPU=;
        b=X305OyftmA4lkClJb+pPuSkv0K3OOEf9qN1erwAr9AQ0kBL8UYfI178o6VZHmWCZea
         VdOLZ1gRGEaTXI3E06Oi/axsq2yFwq2rNbEgXIFW5QkHbXEDBnVC4n3LVpgkEYGnj2wI
         RVmZi0km0jP8+ioZrMfSjK0AO03+Oc5shmjWfkpoCNiflHdySC2SkGvRnEpnxPEXt35u
         /9Te7pZcaDgBYjdsIEvs/H5rDzjU/BOt+Yh5J/vBvSHwdVq2OFi3tpWcMvXoR4RDjYzv
         vS8TtQH9WUAIk+isaeZWVoUf4SXjJnOMZYyWKt2jam68sDr7lfIJ5qXjd+Y/nb/3cRKL
         XFBw==
X-Gm-Message-State: AOAM532S9JUIhJlR4I0fl11ALWR1vJM7HHvLIYBUzC1680w++TkngaS0
        dixSil5slZlYErvyZylEUDuYTQ==
X-Google-Smtp-Source: ABdhPJwwuS8XMIz5osqmii+ofeK+AxcFj6tz3jfzu4bBDrPYA1HFkK5Ffq2k+YOf3WwJ52D6argBYg==
X-Received: by 2002:a17:90b:2246:: with SMTP id hk6mr3739863pjb.112.1627088294369;
        Fri, 23 Jul 2021 17:58:14 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 201sm14427514pgd.37.2021.07.23.17.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:58:13 -0700 (PDT)
Date:   Fri, 23 Jul 2021 17:58:13 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Jul 2021 17:52:41 PDT (-0700)
Subject:     Re: [PATCH] riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled
In-Reply-To: <20210706162621.940924-1-linux@roeck-us.net>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-1b892781-2ee8-476b-90b8-44b5cca45cf9@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jul 2021 09:26:21 PDT (-0700), linux@roeck-us.net wrote:
> riscv uses the value of TSK_STACK_CANARY to set
> stack-protector-guard-offset. With GCC_PLUGIN_RANDSTRUCT enabled, that
> value is non-deterministic, and with riscv:allmodconfig often results
> in build errors such as
>
> cc1: error: '8120' is not a valid offset in '-mstack-protector-guard-offset='
>
> Enable STACKPROTECTOR_PER_TASK only if GCC_PLUGIN_RANDSTRUCT is disabled
> to fix the problem.
>
> Fixes: fea2fed201ee5 ("riscv: Enable per-task stack canaries")
> Cc: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 469a70bd8da6..3afb84fa2190 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -486,6 +486,7 @@ config CC_HAVE_STACKPROTECTOR_TLS
>
>  config STACKPROTECTOR_PER_TASK
>  	def_bool y
> +	depends on !GCC_PLUGIN_RANDSTRUCT
>  	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>
>  config PHYS_RAM_BASE_FIXED

Thanks, this is on fixes.  I do an allmodconfig build and haven't seen 
these failures, is there something special I need to do to get this 
working?  I know nothing about GCC plugins...
