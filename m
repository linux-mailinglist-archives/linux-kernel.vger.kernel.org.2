Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4795A33C281
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhCOQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhCOQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:52:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68700C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:52:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id k2so10019704ili.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0fio/Xr/Ly6DyTgEWQynoHoUq6FwgIyQD271+C3RNY=;
        b=UQ19CCehLZ660g3s3UPDiQx535TvUiWgMD5fu/qA3K/dzYjT77TFq13R9EOTAezL9q
         ISwnWhv8I/A1AYTKjs3nImttMkCOF8Wrocgf318Wu0nARlPajUeNMhagGDQeKJ/Qfcy8
         8qhveUh5V9mYbrLh6juQLBttB7iYNlU6XKfrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0fio/Xr/Ly6DyTgEWQynoHoUq6FwgIyQD271+C3RNY=;
        b=pQXPIkFr9LIPDrPkr0zfHro3vSR95gLqZr6s8IUNZefHuGuGSl9Z0rtVE2MY84G55R
         GLdfxhrkNmcBVn6P1qlkZCq/qdBRfYYxmmRIFFTtSexEuGbyAWF9Ukglp4jL/Mb8rFg9
         WeXYaN8XRdR45UVUxx6DAr+iNhCLgJrJuwY2i/wD9eXT2tb85SjglRrxHYlIFy5BLIzx
         SMkdz1WoT5FPcSRyO26R3/guH3XMt9mPLh6eCzdRIyg8igSmcIZtx0AQcQk9E0+V8ppn
         +3rw7kABTr3sdcKT3p7Sc2+636gvS6DvD9HdyHtN3de1tcim3yJQj+hGXBISwNnN7KX1
         tkow==
X-Gm-Message-State: AOAM531llmmQ5eZBafK/t8S5/IZAvFXUgiT6B9dC/zQdPuMXJOG5BR7B
        5J7mnsq4NRuJjVBHox/ms6abf8JEfUJnsFjIUFiy
X-Google-Smtp-Source: ABdhPJxtAb/xjNeIJFH1q/5hHI/w3CXBjeigYEpLIX9eKpoGGREben0fqn6/MiMpnQWd0Va6CG7RJR/CgkxudOaAjcU=
X-Received: by 2002:a05:6e02:1524:: with SMTP id i4mr395752ilu.147.1615827147940;
 Mon, 15 Mar 2021 09:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210315110500.802897-1-anup.patel@wdc.com> <20210315110500.802897-2-anup.patel@wdc.com>
In-Reply-To: <20210315110500.802897-2-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 15 Mar 2021 09:52:17 -0700
Message-ID: <CAOnJCUKnU_dzfT39vnxhwHi9Yea-i7oZ2NmHU4L22rzv8VmW8g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] RISC-V: Don't print SBI version for all detected extensions
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 4:07 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The sbi_init() already prints SBI version before detecting
> various SBI extensions so we don't need to print SBI version
> for all detected SBI extensions.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/sbi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f4a7db3d309e..c0dcebdd30ec 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -577,19 +577,19 @@ void __init sbi_init(void)
>                         sbi_get_firmware_id(), sbi_get_firmware_version());
>                 if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
>                         __sbi_set_timer = __sbi_set_timer_v02;
> -                       pr_info("SBI v0.2 TIME extension detected\n");
> +                       pr_info("SBI TIME extension detected\n");
>                 } else {
>                         __sbi_set_timer = __sbi_set_timer_v01;
>                 }
>                 if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
>                         __sbi_send_ipi  = __sbi_send_ipi_v02;
> -                       pr_info("SBI v0.2 IPI extension detected\n");
> +                       pr_info("SBI IPI extension detected\n");
>                 } else {
>                         __sbi_send_ipi  = __sbi_send_ipi_v01;
>                 }
>                 if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
>                         __sbi_rfence    = __sbi_rfence_v02;
> -                       pr_info("SBI v0.2 RFENCE extension detected\n");
> +                       pr_info("SBI RFENCE extension detected\n");
>                 } else {
>                         __sbi_rfence    = __sbi_rfence_v01;
>                 }
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
