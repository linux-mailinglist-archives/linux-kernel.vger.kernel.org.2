Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6F3C147A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhGHNn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhGHNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:43:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F980C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:40:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i4so9026313ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhbJLZfgKwOET9rHWiznBr4jI2d+iOS8kqNDZ68pA/k=;
        b=IHUhf7vNXrqyxlz7frFamh0/KtgVgGVk6JLPTgXUjKdbJ+3kvLyu2XKuJonLPRi26S
         XbYPe7ClKlQHHkvzrNzmamLTdcOveHUsh9SyC8YY0WGLEwrIA2ADdSruXws1aYKcQlXG
         Num9DMBxupBXMRkkryAQb7J2vEE85nfRT/Ae690TBR+fEmvUgUxonImjpjWM5FT4IYrP
         k79M7a3BSXP1c4ceScDY/GNqKoWzkJLDssrUBSQdDJoS1IMRn5GkCuc417TNIKFwdsIe
         nP3rZ/nyzNfuqu14enRNM1s23jZHHp2kqZWw0Ylm0yTGcBYBpoo7EAxM+pzxNZmKf9WR
         Lfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhbJLZfgKwOET9rHWiznBr4jI2d+iOS8kqNDZ68pA/k=;
        b=rj5EGEW8rUc6H7rwwqlqQUrW3JpcFL/cnGO/Q1WPGe+tjoAzCfy2MZQGxaYVppNUUu
         JA3RFTCDtGOy698Rv/wFsNBnv4zgVKLjziahSVkzMHUG8tT2VfDxRfiVOG6xZzkk9BQi
         AyuncqEkuZ1TpcTmXISBhSnxKIDQcPiNq/JZYr7F6vSX0t4BkpLvxRn/HLHvQJ0Mv/Yf
         ZrHpBqfhhS0VXdCVdRfi9I4S9MdEuZHbRyCvDvmZhUBbqB3eU41eoyKXFxnQ7rF3IPIT
         XvMSkgI28M1F9PPJLxaupWuR/SejnexL5h19aE5f+8CWCRbY7QXgKUXUBcK8oNfFhRni
         U4ug==
X-Gm-Message-State: AOAM533GG5Tgm+R8dCIrpnnU7XPowEbB1P1vEZ0sWmpxD13glSH7uxsd
        b0AG808XRV3vaawjTL5YKw3S+WuilvJSOPIlcITjbHka
X-Google-Smtp-Source: ABdhPJzT7N5eVaaIUx2T5VzlnlE3hXtBWO7bZWZ1fPFhOUgcfv2PA/+AwsRJz5IrOPVqfVvxzcBEXSnNtCpYx2zNt50=
X-Received: by 2002:a25:b701:: with SMTP id t1mr36858908ybj.517.1625751644825;
 Thu, 08 Jul 2021 06:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210702014319.1265766-1-bmeng.cn@gmail.com>
In-Reply-To: <20210702014319.1265766-1-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 8 Jul 2021 21:40:33 +0800
Message-ID: <CAEUhbmW2p22t=bFHJeNee2WpHEA6-smUzg6ffgqrfWcXx=iqfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: dts: microchip: Use 'local-mac-address' for emac1
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 9:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Per the DT spec, 'local-mac-address' is used to specify MAC address
> that was assigned to the network device, while 'mac-address' is used
> to specify the MAC address that was last used by the boot program,
> and shall be used only if the value differs from 'local-mac-address'
> property value.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Ping?
