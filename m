Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2AB3C1472
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhGHNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhGHNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:42:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020B4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:39:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k184so8947861ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUfpTJEM5/D8ctmlDv+SG01e+UeWNEeVLdWzBRW2AAg=;
        b=cV6KerYNHeTtem3QqcymyHW3Xuz7IFbIAc//FO8ZB+ufC9KgIxfG+xQeEGGx7eMV1w
         m22czX63olHy78ITqFqWHJbvX+ISKtSArYHFeyCZTyZ1wiQGbIC1YeEiv4YZ74Ogyuq+
         Tv5EXGAsTTEAyJe0ESkxIq3hxpug6gi4s9X4xOOrSPbdf5m7PRhZQsB2WoOACCjh8UtQ
         V5O0sW2Cj92Lk8Rkak5LzF5JoHEz0hRLzSZ6407bOncttNjXwueRnB4sDtxFVYHjvLGM
         Ic4UHr0o2e6E9o6f56XSGA3NFYjpPlaF+hGgGkHhE2v8XSjz9sW0SWQfDx8sZWqRzkHd
         keDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUfpTJEM5/D8ctmlDv+SG01e+UeWNEeVLdWzBRW2AAg=;
        b=ANEFpQQ5XJ272darrGFzgpGW6T+3eAmZSvmXdZ23HQ/nUmGu8C9PIG2vrlPMI27b8h
         Egozv3lbtyc3dCcZULeZPWgDjYydE6gYbrzh2V4kjba+FJKeA2ncHrAW6yM9pqLK2Q27
         MR17qKUg9NfFa/f89YKjL0AK0KZ+oNfhgct62IJ2ewk6jPK1xD8ULUIjWAL9dyMZLK5i
         JPoCTvg054SD4dXU6TGMOLxMA8lH822dT6qWF0XaafD+SpZPMOHfbKbS453bE0jxhYBI
         VMEz4/YVdXfC7QCv/ftMN2Da2tfyZIoU4FHU3HC6FmGHZIgAHGwzNnOmUEBR0xc5QisG
         TZoA==
X-Gm-Message-State: AOAM532qd9yXsGYB0PeTFaFfvyWzZ1mGZ9jCtQ/UBG/3rn3uP8v6pi1A
        6AFZvoKw4jqx4+G5M+8d06nj9y3xtAKpNNt/shY=
X-Google-Smtp-Source: ABdhPJw3HWI7ivTZ45Cg5T487tJ+w2MNpY+Xj0x97C9Eih+AkDvJ+FVMwWgSTrSsFYacg1mP90eYdNcC+lCBoRlP1vc=
X-Received: by 2002:a25:df11:: with SMTP id w17mr38849657ybg.314.1625751591298;
 Thu, 08 Jul 2021 06:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210616062739.398790-1-bmeng.cn@gmail.com>
In-Reply-To: <20210616062739.398790-1-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 8 Jul 2021 21:39:40 +0800
Message-ID: <CAEUhbmWXO+kHTmQEggjcyyqpQaLwVFeu2ueos+a4WN=P34Vwrg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: microchip: Define hart clocks
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

On Wed, Jun 16, 2021 at 2:27 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Declare that each hart in the DT is clocked by <&clkcfg 0>.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---
> Similar to https://patchwork.kernel.org/project/linux-riscv/patch/1592308864-30205-3-git-send-email-yash.shah@sifive.com/,
> this adds the same <clock> property to PolarFire SoC CPU nodes so that we can
> calculate the running frequency of the hart.
>
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>

Ping?
