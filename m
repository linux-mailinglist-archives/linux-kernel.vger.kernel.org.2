Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AC3F1148
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhHSDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhHSDLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:11:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D4EC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:10:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id a93so9548731ybi.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPimCmfapHOlzWNF2PPhKvm04+9IOZnhcwkF9fEYFus=;
        b=XFPy4x2LjgGqBSSCHaaq0795IL9VWSfPQxX12vQ9hAPjHrkLmlkZhQTj8Y9pDsN+gg
         hPmt+wkZzj/lJ49kzCsVrTlLv5eVcyyiRZjH4SpMDays56FkWoQJFoRcljDIQmOlQh28
         sbWEGBRZePrhK7Gi1jT/nQVt//246rImKbAhtLgjgyJHQvRppJm9WFKxLxwp4m5ELEQe
         /zCLJSL83Bda1dn5a1vu/qOe7jnlJOtzelEI0fwaDIXgnaGaGOY2dFqBnMh/NwhIgPHf
         Ngwcm1DJU8MsKiDqHee96sHaWdwgknD4HmI3eSXEHcaMU/kAO3PcoTs4bgxHvXjvtSfE
         VFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPimCmfapHOlzWNF2PPhKvm04+9IOZnhcwkF9fEYFus=;
        b=C2s/+5H2glkvrRlDYpb2OHm7vVYBVSmf9yDwK4+KG34sSZ1gWw3z+Eiv+jxJS+f8t7
         WGkrYqbREcCTfuCLGeT/29RBMJhrSIbLUjiGIl3Pr/+t/nxyzzMpIqOg/1GlMT0BNBz+
         QgJJS8eg9+tXPHkiHfAJ9g+G1KKMcNffAMNdUJQotVl4hh0rrivVEZVnSf6dDC3BDNVn
         szcfnzTTOrrZLDKfOr7IsTPgWqV+UFjz7rKP9eGfe7zsFTNt2xnGd6QMBtapKXFwQxq6
         Cg2Ea4ZHfx8rj1HhKAZDOdpwa4JnVZjFNaN2u7/YuuiLK3e2uqgdp2thJK43jvtA2BsH
         5bkA==
X-Gm-Message-State: AOAM5309Bx+XrTEMu6IgvY6ulnhWE/y586Q8e8KFKKfQf4SM5NKOxEtk
        8RZx5DdNQdW13ZdXFHKKYuxIRj/Ddm3Q1sF54zM=
X-Google-Smtp-Source: ABdhPJxmgzMx9Yye/aziYhTeoHw2LnJ80f4jTojPyOeB6B4p5MmonChI49jjg+NoCs2o5oD9aLZie2nLVCxBma9jIis=
X-Received: by 2002:a25:e70c:: with SMTP id e12mr15959000ybh.220.1629342642961;
 Wed, 18 Aug 2021 20:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210804123015.807929-1-bmeng.cn@gmail.com>
In-Reply-To: <20210804123015.807929-1-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 19 Aug 2021 11:10:31 +0800
Message-ID: <CAEUhbmXxGJMoS-qDncjx5uPqTz7h-aE+h=gLd==tpgLt=uy7Yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: dts: microchip: Use 'local-mac-address' for emac1
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 8:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
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
> Reviewed-by: conor dooley <conor.dooley@microchip.com>
> ---
>
> (no changes since v1)
>
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Ping?

It looks like these dts patches are still not applied...

Regards,
Bin
