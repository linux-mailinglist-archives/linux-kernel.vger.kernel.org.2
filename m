Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6B457B07
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhKTEJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbhKTEJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:09:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:06:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a9so21487568wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zj9LfTNeTtv2Et/1mlpKwDYIeE5/dUFTD8JTvEnxqpY=;
        b=gL+1wye+8tSijwPvsxt81oz9tLdroFm9IWJipQoqjbCaI/uFM2dzeJ6FbVmkodDl6I
         QgCy4zb7gq03bonQqBoK7XBmkUz9Q4NzFkwzc0w7b3/zSsGl1VPdCMilTLhR56AdSRQV
         VvjHVZfCct72kAGTP92CrBnRrwykiVaoCUWJgoCxNaAbvWn3qd8xpnoiclBRhr1zivzZ
         h/FHintKsinuNMDYQZPAZf0oQPS/iN0sNfyCh16Qf5zkckQTknq2bpBsTnJO6/BM2nzW
         EkX2BcqvcEJ1uintBz20F+AaqIp6ueX6RdhKSeuKrUkC8VhTxrnDXEFy2RRLDxY9p6Za
         rbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zj9LfTNeTtv2Et/1mlpKwDYIeE5/dUFTD8JTvEnxqpY=;
        b=VS09OExv4KCwwsYQWl1r9zJMSZBgWnHFDrS3e/mMSdzTWqw0n5dXJANrpGc5c8yVXj
         r61WQpcKsQvBiV3kGrsrs+C768PAAqxDXcay9UlCkMW8dGAPKMcfvIVMAJcdGkwO+3sH
         RyNf1jxZxceNbf4JN0HXT5mTXvqUqKDK2XiCqHs/jyk8Osc68mOE9YCUwruYuRWVdI5r
         XSbJmykB0nHh4q6OmqAEFWYjdg83HQJ63utcWJFVh0ImWzOa+fqb+jz2JIek4bRnniuB
         2A5SAZqFy0N6Kvm9gt7iIQir7jir/SwNOT3RsHr7bAioWmCvMT/Mshq/h/WOmEs6RAye
         EYJg==
X-Gm-Message-State: AOAM531l79dyM8wgX/S/K9qwPPtgxqZws0pXhs+pLbPk9e28Jq1jMpYu
        ysOAMk9L9lhy8Dgxv3U+5vSyYW80pXZ2shVpdDi5gw==
X-Google-Smtp-Source: ABdhPJyrydUzo3fszfZv36X6eCZ62sCl5xd+acY4/EMveMQCEW6TSBW6pj9/RihmIVL7rsGQjCnlatx6PNsal6/p7kA=
X-Received: by 2002:a5d:628f:: with SMTP id k15mr14422173wru.363.1637381158507;
 Fri, 19 Nov 2021 20:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-12-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-12-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:35:47 +0530
Message-ID: <CAAhSdy2PadUtRDxUy3Y16RBSEubDqUE_sE2Br22OZA+-HBGnrQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] RISC-V: defconfigs: Remove redundant CONFIG_EFI=y
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>, axboe@kernel.dk,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:15 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> We've always had CONFIG_EFI as "def_bool y" so this has always been
> redundant.  It's removed by savedefconfig, so drop it to keep things
> clean.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index a72dbd74b93d..f120fcc43d0a 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -143,4 +143,3 @@ CONFIG_RCU_EQS_DEBUG=y
>  # CONFIG_FTRACE is not set
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
> -CONFIG_EFI=y
> --
> 2.32.0
>
