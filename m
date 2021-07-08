Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D73C1471
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhGHNmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhGHNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:42:10 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA451C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:39:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i18so8946870yba.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOjj479tAYR8htOT6wsMXzX39R4Q2+skOoeED/e4V8E=;
        b=f9FeASktmqEXsl27jvJ/icNdiB5gBFDRI6giCnBn3E46WmIwA6qyfcA9rhmGtjocs5
         IW8VrM9fGHG6ut5Y7xdyZUe10Dn6iWRTxS0cctcDbdLuoQqTx9ap0jwgAYsRTnnFdx6E
         Ev0G/N7M+ARnmzWpH9PsUnxUfTpa9O0t1vLL4F7yZePreti0Rqx1PcCLZeFr3FXsMqGX
         Px1Vi6hfE5lEJnvpY7VEY0RZAGk6hfZ2Q68Ia9Go1+xmlbGC1ZgcuK//AclHAUzyhT0E
         SMCURuNz/gKtADQ+paxOmpjb6K10Z2w6cHz0bBtIo0Q9pCblUeoUCwzdny1SHgtT+AUm
         cHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOjj479tAYR8htOT6wsMXzX39R4Q2+skOoeED/e4V8E=;
        b=WqiSvqqOeYlyY+CnzgNlOZcqPnuKBZ4VfjGvv5MDrFvG6XzLSfTht0HmgYVcjCyrZd
         igcvOPMqNw1hcGP6z/AJUT+qwiYy4w4e2xHCojKVGfwZ5ytHASDNkIXX0d+CubPFIi4b
         7Q4EG74ubHNdItRHe1nMWwaIdo58m2ydM0QS3KUdHJTNR3SqV9dwqb8CyPGWGx28AzJA
         U+uGMhUxkqAr9nHB8v63q4uk5W9XYIBq6LK+wg+vQfM6fZQkNBpaeN+9/q7itbx7OSvh
         48Xd7x2i0ZQHRiQD8u3VkAUuOxfdzYIoeJhFpMTJLQyiwyQFtEkrfdQijMg9Rl7Sz0w/
         mMoA==
X-Gm-Message-State: AOAM533u+Yy0HBEnaIiLU73dt2SsUYfMJdhLwGacqix456rTLTTAfXxk
        j6B9brFtCAbAcOL2xwLQyCyJrgzmuZuRIlAv1+k=
X-Google-Smtp-Source: ABdhPJxmyb5IyWJwnoebDxK7rCDnXHMCtTgKVmOTLA/UwSVVH7FDS6Qdg4j6epHs/5AZwAzfDniEIzUVNRyz3tF0cZs=
X-Received: by 2002:a25:b701:: with SMTP id t1mr36852054ybj.517.1625751567354;
 Thu, 08 Jul 2021 06:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210616060251.398444-1-bmeng.cn@gmail.com>
In-Reply-To: <20210616060251.398444-1-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 8 Jul 2021 21:39:16 +0800
Message-ID: <CAEUhbmXQt0pnqvzCGwGU38_U0qRZRmgGA4qgaFT_HevbSZRDBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: dts: microchip: Drop "clock-frequency"
 property of cpu nodes
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:02 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> The "clock-frequency" property of cpu nodes isn't required. Drop it.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 5 -----
>  1 file changed, 5 deletions(-)
>

Ping?
