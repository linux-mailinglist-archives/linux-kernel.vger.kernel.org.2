Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B916D3A6801
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhFNNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhFNNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:36:27 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B48EC061767;
        Mon, 14 Jun 2021 06:34:10 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i4so15502828ybe.2;
        Mon, 14 Jun 2021 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+SdEsE9+NsUTLittnWGiiMKDOH2BJaHKTxZALGDAWI=;
        b=odDKde/DM6oE49cy3R0RkXQ2Tts09TwaXlTAmv7uXRYwG5gYpH/g9yJ5rRkAsvqA8T
         xX6ciaKwcMQrgy2tZfpjoKSf2tVn+qaFLus4OQzg+hy5GhChOJ+Yq6qPjg3lgm2woGrL
         z9akMmOKCGPSTTM93SBkVMT/EG1jfScimZWgshFW+V580ZYtrG9zaOKy/5V/8qGn++sp
         4umb3xpP+Mq7sdnGVNXEATUAQsL2dyBIN30KN2pdZLkQ1o924eeIYYc+kD6UL3Yuh0Js
         Zcg1Q51H6hSqfOPqXyqfBy3gigJvPWJE/tP4C1SPCwyUACQVzjjx75Ura+bvWmu6wRXY
         VQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+SdEsE9+NsUTLittnWGiiMKDOH2BJaHKTxZALGDAWI=;
        b=cy46teI6CIaTKWxINouon6sqRKhj5preofo3Pa+RbmogJW4uB74bd/gCP20KFGeBAz
         L7i5RdXPtE3X2daAeoohe+/iQ6jadff7NG6pKg7djroZlUBlHM4VDP5d9ng8BQzb3u7p
         v+vbuI541Udln/5exCFFBiMdBcScqXPzEiHpJNjGBvlGtPwfQYaElBEBnoOibdPHwdFo
         koi2fNrLS9HybDsZiDXcgSYTiFOy6kzCSQXox0yEHp9+fagsPHIyKu8LIcBnp5oalYNR
         kSgd7CXZuTAOOgN46RQvhjsL49E25jl2YXeNs9kbS51hxDYEKWTY8qJmgS4BF1/A5JZ0
         xWbA==
X-Gm-Message-State: AOAM532up4FNoNH1X3Z0qDJyTt6cHCBd0tKBpgZPdtUfn7dtZYhdp+lF
        TrW+9dA0/QQdMcK7EyLNuFzkrUMU3DGcOVY4KVk=
X-Google-Smtp-Source: ABdhPJxOuvrD1lbWJO5WRvUKJRABbIIp7EzJ3EsdDZZFObuYxZUwyekjwK6Kgbos33FF8PzqvrZgeDv6CuYhmYlJFzs=
X-Received: by 2002:a25:c016:: with SMTP id c22mr26522386ybf.387.1623677649546;
 Mon, 14 Jun 2021 06:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-3-anup.patel@wdc.com>
In-Reply-To: <20210612160422.330705-3-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 14 Jun 2021 21:33:57 +0800
Message-ID: <CAEUhbmWPUcjXtXveOrYWzfSBq34SO34eM6Fb8HDeT0hfHA2SwA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 02/10] RISC-V: Use common print prefix in smp.c
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:06 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> We add "#define pr_fmt()" in smp.c to use "riscv:" as common
> print prefix for all pr_xyz() statements in this file.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/smp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
