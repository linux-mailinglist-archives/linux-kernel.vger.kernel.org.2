Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC743220C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhBVUX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhBVUXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:23:24 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF97C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:22:43 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id f3so15299347oiw.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zUxZgcnCvVVMkZxer/qPy4+yli90D8nt9Ux36SsgZs=;
        b=RWQBFkXyeMNOQjeD1Kc3RRJXVGMl+74YDUp15mHVrPVrFqPIzO5GHeGTQltOzbV63o
         ZIZwc381bzxr+hOfu7xK0ZpTJS+QEcA36DpQIJJp9zNGxH2jAJiHXyphz6abXKbbqAY9
         Ag9sTLSRayloTm2xtfgbS/Fumoq+OI5m0VCNwjDCkGwXvhpMdRiWX5hB2XTzZXgy+0Fo
         /WivJH383We+IVL4jo5lybgXDiVoEHGqQEjeYriyAy9JzIdTIi0RW0nRlBo/Pe2fZiNg
         E6AS+9QZ4kfxoL9LqQ5wec6FHBNp1/Ac8+9kYxnkBk/dvKL+esnye86WXfIA+xaD+N4J
         4aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zUxZgcnCvVVMkZxer/qPy4+yli90D8nt9Ux36SsgZs=;
        b=kd2L2D7sDNNpp5sHWUvFK7HYMtU8R7z+umkOw3Hx3p0Er6ePsf1AUCuffGjExL6KV7
         ybd4D8oGneh9mXcsSHLWelkqgXNeBA7+OSBdUADtgsVi9sxzaDj8eJ5Jcqb52AmYLY7V
         ET9+BqqRz+KVaBXJwZqlvSrjn1PgcQissMxPqnZ7AO9/xAgeawYc0a+WC7NO52cDKvyC
         VlUNakCz5P589BRrRP/Mvh3xDHC9krgzyiwvPWx8fUOiw9QxXuPUnyLzxhrG8wtsG8a5
         pAdpfj8IRocR1lsO05fRMPvNMgMXWEwb+0BeH31RfMhXjFX5n64GVSslDT7eaLGgAXWo
         hVMg==
X-Gm-Message-State: AOAM532KjqpydV8GBebNFZsKJJeBvrfunUUUeWUulepkDNatVrgZPSCq
        SVD8fbQ6nbdeLBvnEA956h0=
X-Google-Smtp-Source: ABdhPJyxynC/qUkfM9m2BbNUu+GDqexEdkig67h42a2PSQnnYl4vRIFk9jQHpyhBm0haU5y+2ztEUA==
X-Received: by 2002:aca:3507:: with SMTP id c7mr7877911oia.26.1614025363323;
        Mon, 22 Feb 2021 12:22:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q132sm2393106oif.32.2021.02.22.12.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Feb 2021 12:22:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Feb 2021 12:22:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Add a non-void return for sbi v02 functions
Message-ID: <20210222202241.GA82802@roeck-us.net>
References: <20210204052643.1608586-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204052643.1608586-1-atish.patra@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 09:26:43PM -0800, Atish Patra wrote:
> SBI v0.2 functions can return an error code from SBI implementation.
> We are already processing the SBI error code and coverts it to the Linux
> error code.
> 
> Propagate to the error code to the caller as well. As of now, kvm is the
> only user of these error codes.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
...
>  #else /* CONFIG_RISCV_SBI */
> -static inline void sbi_remote_fence_i(const unsigned long *hart_mask) {}
> +static inline int sbi_remote_fence_i(const unsigned long *hart_mask) {}

Error log:
In file included from arch/riscv/kernel/setup.c:29:
arch/riscv/include/asm/sbi.h: In function 'sbi_remote_fence_i':
arch/riscv/include/asm/sbi.h:150:1: error: no return statement in function returning non-void

Guenter
