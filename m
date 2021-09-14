Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B740A936
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhINIbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhINIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:31:19 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91693C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:30:02 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p24so9260181vsg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SfYqEgYuhGjmpKp+8qsm/+IR4JBWTK40kNQ4OdfOh0=;
        b=csnaULio9miwWi3mxFy1WKWbVSnfdg/nwldFHmBIxPqOz1WLHX3d+SRzVG0rlV4Kyh
         dWZ1DeqZnchItRJwwpNQfoIcxZy1zqmjMtpvHd5UQiyzk8T7LBXYZcy8ncdtcSFd6VwP
         WpyXRbaeLyocF1/lBh577OLssYc79HO3C5y7qJh5MfKa2CrT3Di1pPJBLwpfKFHqdB+R
         j0VUA7cqgozL8BrrNstJeaDIJ/cSunavWhABMoEXg6tNJDqiJppX57fuh754MOiGjd7h
         evvkbHZ4P5v2njaY/Smx5tMZ6Rh8nrOfDR3cMgMH+G3kWgFh6L5oH/W9+9bSFuMZ/Fxa
         m93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SfYqEgYuhGjmpKp+8qsm/+IR4JBWTK40kNQ4OdfOh0=;
        b=uzciV91rymjWZaF+UUA64KO9beuwgzxH8r2l7PPIZLk3CbtBS9dNTZySeA2e09PJ9d
         4h6j75LcMfPJYQoWpTbhAnTrW4XRngIiqTdrczrlPfL7mge6QJ1G//3GDsJFdEBdN5+B
         l+22Sabzie5/MYBpnfq0E9Oow05m1fz7Dg2lHMAG9EUgmzJNfn3OhJenfsMFGOfGkjau
         IUagL1IBxHEYJoGUt7MNcSyutcXL4rzc5zSDj+ThWlvwnCe1mb9tfaIXa5ptoTsp1Rn/
         rmPOVbbemDQHs9k/FGE3slO5F5ZQQbg0b6Y877iEt1bsPADL2bTNLl4E9RIjB2VsXqDf
         4Xxw==
X-Gm-Message-State: AOAM533bcSC6YSvCjq93AWIouW27vrdmiBwaA4RgbUdx4e2Jv3upLz6P
        eKFZ62UGy3YAUFpgzZlvEj7j6YQTwcmUxIoDfkY=
X-Google-Smtp-Source: ABdhPJycHurFqjM9bo5/WXeY2QeFe7n1tG6NRMOd1bUnNb8FyWsi/Rv5pnO7Ag76m5y/XVWj3Z3VA8vOnPUPhMuNAA4=
X-Received: by 2002:a67:ed86:: with SMTP id d6mr5241863vsp.38.1631608201390;
 Tue, 14 Sep 2021 01:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <33c485ee595aff1e19a0e43074da59779f58d105.1631121222.git.greentime.hu@sifive.com>
In-Reply-To: <33c485ee595aff1e19a0e43074da59779f58d105.1631121222.git.greentime.hu@sifive.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Tue, 14 Sep 2021 16:29:50 +0800
Message-ID: <CAFiDJ59nbV_opZRxfsv2kj8ObSguT75GJUKhA6Zd3+BpQOynjw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 15/21] riscv: Add vector extension XOR implementation
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aou@eecs.berkeley.edu, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 1:49 AM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> This patch adds support for vector optimized XOR it is tested in spike and
> qemu.
>
> Logs in spike:
> [    0.008365] xor: measuring software checksum speed
> [    0.048885]    8regs     :  1719.000 MB/sec
> [    0.089080]    32regs    :  1717.000 MB/sec
> [    0.129275]    rvv       :  7043.000 MB/sec
> [    0.129525] xor: using function: rvv (7043.000 MB/sec)
>
> Logs in qemu:
> [    0.098943] xor: measuring software checksum speed
> [    0.139391]    8regs     :  2911.000 MB/sec
> [    0.181079]    32regs    :  2813.000 MB/sec
> [    0.224260]    rvv       :    45.000 MB/sec
> [    0.225586] xor: using function: 8regs (2911.000 MB/sec)
>
> Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/xor.h | 74 ++++++++++++++++++++++++++++++++
>  arch/riscv/lib/Makefile      |  1 +
>  arch/riscv/lib/xor.S         | 81 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 arch/riscv/include/asm/xor.h
>  create mode 100644 arch/riscv/lib/xor.S
>
> diff --git a/arch/riscv/include/asm/xor.h b/arch/riscv/include/asm/xor.h
> new file mode 100644
> index 000000000000..60ee0224913d
> --- /dev/null
> +++ b/arch/riscv/include/asm/xor.h
> @@ -0,0 +1,74 @@


[...]

>
> +extern bool has_vector;
> +#undef XOR_TRY_TEMPLATES
> +#define XOR_TRY_TEMPLATES           \
> +       do {        \
> +               xor_speed(&xor_block_8regs);    \
> +               xor_speed(&xor_block_32regs);    \
> +               if (has_vector) { \
> +                       xor_speed(&xor_block_rvv);\
> +               } \
> +       } while (0)
> +#endif
>
bool has_vector is changed to has_vector() function now, should this
change as well?


Regards
Ley Foon
