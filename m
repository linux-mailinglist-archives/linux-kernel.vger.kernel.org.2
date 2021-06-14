Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2A3A6807
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhFNNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:37:34 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:38683 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhFNNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:37:30 -0400
Received: by mail-yb1-f177.google.com with SMTP id m9so15476656ybo.5;
        Mon, 14 Jun 2021 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jjeb2VBZlHsMDUPadrsr3uON+trO752pZHCWpt5WtHQ=;
        b=PJ35xyFVTzv/+suvuO3wLsMl2ome1H3nJs2WPwL2tfdai6MF4Xr4Tzp3NkbBDZQ6px
         jrdeZmfji2yZz2nerme9LNjHMAnISVHEnuRsGYTkOG6EHitziq7JyfhhE+NDsQZ2WW32
         +J2zSlMcIl0/D9BdQDMZ3WeEmIYCUYx2aCtlwn/HCOXbhIS9qHFVnEJXB5USYQ0paxqi
         8nK/0Q0LVJe99gEDWJ3EMk+tcUBubZ5tPAJCcBBy0534cSTi0+C7YqI5USQxoSowbjH7
         yrLYRH/AE92rqXJ9ad6ZdJTKL2pLfLSKsUCOAVxDs8N8UhkiVPf6BcTGpF6wCVY5tA+6
         kPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jjeb2VBZlHsMDUPadrsr3uON+trO752pZHCWpt5WtHQ=;
        b=pGlifrfIciaQ0P+kLJ/fLVSHVvC7Tnpb/18hWRwSMXr6NgMIDNk6jBLpS6T6AZRL7p
         E7e8qEwWxMEKDvOORwrW2f7CrZf9t9ndG1EaszvhmR335UmxfnI4zNqyAYQInEDIn3HC
         HIYTINpseCBaCa5YL/QYGnqsINH0PFnErTvfnEVjgjCUJPUTxcTQ4spNpmQuMe2Fd9dn
         CqjWs/1PSrTxqjLg+nyts19mpZJsBiM1TrHA5dtO2QQLEcf2oDrUw9waufLPDSEtU4sb
         vvrXeer5Fvna1z3WBkz2rVWtiorsHGGJYCNwgA1yTF/3jWvRFQKXseClSkh7hzE+oxjV
         s1Ag==
X-Gm-Message-State: AOAM533sy30NqDRjNlf9HNLb5Wy6sVJNUYYarwn7hZ9pGoPEkktmMjQI
        e+u0VqFspidFZjiYpGipyoN1ZIWXI2zzWe3Z920=
X-Google-Smtp-Source: ABdhPJyFwHZpRU74JDJMgDYk1WERGTnTqTksGdZ8EaZrxK/tuJc0NHSS3jIS9xxtboEFCHv0OKpxB7UkBau+FvUFGTA=
X-Received: by 2002:a25:b8c:: with SMTP id 134mr24998511ybl.332.1623677667645;
 Mon, 14 Jun 2021 06:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-11-anup.patel@wdc.com>
In-Reply-To: <20210612160422.330705-11-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 14 Jun 2021 21:34:15 +0800
Message-ID: <CAEUhbmUGSWOS7iG209BqTWBgTc63xPm1L_0xNBhKXVnu7Wpjjg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] MAINTAINERS: Add entry for RISC-V ACLINT drivers
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

On Sun, Jun 13, 2021 at 12:08 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> Add myself as maintainer for RISC-V ACLINT drivers.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
