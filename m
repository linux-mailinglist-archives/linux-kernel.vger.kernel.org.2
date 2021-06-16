Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE43A8F43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFPDSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:18:18 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC51CC061574;
        Tue, 15 Jun 2021 20:16:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i4so933467ybe.2;
        Tue, 15 Jun 2021 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9xlk2ZBsShaAsqV3orNyPJJYg7Vzz29UtFHXqBDhAU=;
        b=opAbog307i2ZykhXFdHafYS+f6jxVLUCd+pHtDaC4XBZS3dHF4cK8XN7eCsK02Ouel
         4H58j/iKjyoXplkV4RqPpedtDy8f+wKm9BNi+KV6vpKY3NUeSGL2vjoqT/aedzXEk2ib
         Q23yU85p/blkIX1JwpFIuitJIsZA+G0IqLuITuOTy5YPAzc+cEPfuDa1eXXylM/gPEhm
         R9wOCDuEXt+wQVMnf55ueYKrfu4cGJqF7K9EUdil9mJvw04DIVKFTjwUl99pdxcYxaHy
         Wi+g8uDDEFu8zw9mlEeSV3UWo9jopBqVFmSUGrN1YZFXk9+pC+kiy6sVKp5wjcrMBkxi
         Xjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9xlk2ZBsShaAsqV3orNyPJJYg7Vzz29UtFHXqBDhAU=;
        b=UfyEiBcVkIHsvyuLR+zc9VW8roVyeAzRfzc3PXkFCBhyT2oVIH1ncMJhG/VZQrDbI7
         X3KDYi3wG5rOk75eIJwttX+vu7kQChR85vc3qkKJkqU8NpIsN5Xa3Dnus250pDcFF7kH
         ykx96kQlj+fk9q49AS6fEmRdanWFH4eNyuY+QX5ENQU1ubkq6bpQ+OJTe86LBp4QlC6c
         mIRhSP5NXPnsZL8A/uEsn5usmsrVGy8hYPrGLs0aqpGr+p3wo7VneEAiiZ2Wl2A0bzAm
         M8mdSIGg9vJiaBebIMVx06D5Vgv7RmcDjfnyGswWl2zBb0Yyi2ymZtSyWyZwFBMudoPj
         dwOg==
X-Gm-Message-State: AOAM533nbOtOmYf4yEw3/YcLHqUm/dGPVf5Oy1pRCg2q0e5OWMgHTM8j
        v8DlqvZQACuYtCHHV8x/wdCjFYCRapGjzCZbK20=
X-Google-Smtp-Source: ABdhPJz8un0SBnoHgopqh1bk66DKwxdavj3eROY61VihfQjpDSbrsP0wUC4Y7WeIRKmBuXe6ud85NftBDyOGg1F5/ns=
X-Received: by 2002:a25:2e43:: with SMTP id b3mr3233353ybn.152.1623813371213;
 Tue, 15 Jun 2021 20:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com> <1592308864-30205-3-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1592308864-30205-3-git-send-email-yash.shah@sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 16 Jun 2021 11:16:00 +0800
Message-ID: <CAEUhbmXKdukBwd0OL2ApOD67aQ9ytSPns3z=COtXTSP_mm3wvQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: fu540-c000: define hart clocks
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, sachin.ghadi@sifive.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Green Wan <green.wan@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        lollivier@baylibre.com, deepa.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 8:01 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> Declare that each hart defined in the FU540 DT data is clocked by the
> COREPLL. This is in preparation for enabling CPUFreq for the
> FU540-C000 SoC on the HiFive Unleashed board.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>

Any idea of why this patch was not applied?

Regards,
Bin
