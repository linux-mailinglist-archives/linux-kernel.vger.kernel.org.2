Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8674342FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTBhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:37:34 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:37623 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhJTBhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:37:33 -0400
Received: by mail-qk1-f174.google.com with SMTP id bl14so1805114qkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUYSv1Ml+e5O/S44qXhwpad8q6ZJhXnlabD5d8PHlfE=;
        b=CXryR7g3dGaL2kDaGMVYpppQii4xp6wWrh2N1D5Hy65l7BL6ePltpNTd5VBL0KQrEK
         LMvLllxPFB1+J4QYw948THnsK+LFvzqn4UsdS9YA40h57jFybqR2iMRILg140b1sMiWC
         cp9vPoaAYqsl0DyATeZ161hEfXxE4vtEnqbYhVLwitE3P+dhCeN/jKqbbHkAvBh/X+nA
         Yk7zRjVpidYwD7CV7DZ0xc5tJVSC/JjQJ7t5bS3RLU1OL6eUgV+Gfnx7caXOyCc+eGrA
         Ez5oKnikR88PiWqeu8kWe8mYXUGZzGQJ70y6oI9ZIK1BIgL7GvZmffHEtri7NODAHAmz
         mgFQ==
X-Gm-Message-State: AOAM5324wQvQVzFtZwNe+83CW1ns8ilCET4Z3GbRAuPo/ZsHfj/bkOi/
        fVnNCRWo/W0aP8QxpfCxDW8W2uQpfLs=
X-Google-Smtp-Source: ABdhPJwyK9YiZehEkZ5t+5faCORMLw1cBGFisUMNtDnijrJUyauzMA167TmI14GcPSwf8czYaXnKHQ==
X-Received: by 2002:a05:620a:41a:: with SMTP id 26mr3019069qkp.151.1634693719267;
        Tue, 19 Oct 2021 18:35:19 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id j14sm314009qtq.36.2021.10.19.18.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 18:35:18 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id r15so1780962qkp.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:35:18 -0700 (PDT)
X-Received: by 2002:a37:c12:: with SMTP id 18mr3064225qkm.12.1634693718152;
 Tue, 19 Oct 2021 18:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211019023241.17466-1-Meng.Li@windriver.com>
In-Reply-To: <20211019023241.17466-1-Meng.Li@windriver.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 19 Oct 2021 20:35:06 -0500
X-Gmail-Original-Message-ID: <CADRPPNRVAqptuD_cf+vtcD4UBbL+2uT0fjnw14QS=8_tpt1bjQ@mail.gmail.com>
Message-ID: <CADRPPNRVAqptuD_cf+vtcD4UBbL+2uT0fjnw14QS=8_tpt1bjQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: fsl: dpio: instead smp_processor_id with raw_smp_processor_id
To:     Meng.Li@windriver.com
Cc:     Roy Pledge <Roy.Pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 9:46 PM <Meng.Li@windriver.com> wrote:
>
> From: Meng Li <Meng.Li@windriver.com>
>
> When enable debug kernel configs,there will be calltrace as below:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> caller is debug_smp_processor_id+0x20/0x30
> CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.10.63-yocto-standard #1
> Hardware name: NXP Layerscape LX2160ARDB (DT)
> Call trace:
>  dump_backtrace+0x0/0x1a0
>  show_stack+0x24/0x30
>  dump_stack+0xf0/0x13c
>  check_preemption_disabled+0x100/0x110
>  debug_smp_processor_id+0x20/0x30
>  dpaa2_io_query_fq_count+0xdc/0x154
>  dpaa2_eth_stop+0x144/0x314
>  __dev_close_many+0xdc/0x160
>  __dev_change_flags+0xe8/0x220
>  dev_change_flags+0x30/0x70
>  ic_close_devs+0x50/0x78
>  ip_auto_config+0xed0/0xf10
>  do_one_initcall+0xac/0x460
>  kernel_init_freeable+0x30c/0x378
>  kernel_init+0x20/0x128
>  ret_from_fork+0x10/0x38
>
> Based on comment in the context, it doesn't matter whether
> preemption is disable or not. So, instead smp_processor_id()

s/instead/replace/g

> with raw_smp_processor_id() to avoid above call trace.
>
> v2:
> Remove the preempt_disable/enable() protection, instead smp_processor_id
> with raw_smp_processor_id.

The revision history information should go after the "---" below.

>
> Fixes: c89105c9b390 ("staging: fsl-mc: Move DPIO from staging to drivers/soc/fsl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

I helped to fix the issues I mentioned.  Applied for fix.  Thanks.

> ---
>  drivers/soc/fsl/dpio/dpio-service.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 19f47ea9dab0..3050a534d42c 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -59,7 +59,7 @@ static inline struct dpaa2_io *service_select_by_cpu(struct dpaa2_io *d,
>          * potentially being migrated away.
>          */
>         if (cpu < 0)
> -               cpu = smp_processor_id();
> +               cpu = raw_smp_processor_id();
>
>         /* If a specific cpu was requested, pick it up immediately */
>         return dpio_by_cpu[cpu];
> --
> 2.17.1
>
