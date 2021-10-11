Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2724292A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhJKOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbhJKOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21D5C061765
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:52:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so57113669wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5acyx8mtWXW7VMwQQTn2016+YkzgOn6sSwlU3dh0rXE=;
        b=FzkiXRZ5VhkrJM6F+VlDWN8+7gpi+N5jpIJyNhMNGX1Pvie6baSCXvEOq//F5INNoK
         CSCWIdPcK1UoliuPOdY+HFIy3KxSyxzB5argZRa39cHIOQsRnl+inw1vcZQE+Xtnrj4L
         pLxGC7BgTTcnXomAGvKpb8/rfE5bZ83ENw47muAxNScAmQw9cf9KZT4gyccNQTooDwH2
         24xPNp6zl0NOWVuLTKunM16xgJqkaZHdO/XUNtfHExzPP67F4eFGd2T2cmOlxGP3QV84
         MYgTemob4zvzvDW3dxItlyTAMA5QbciuxpHhSEhSIlarubIbIdUsAvB51MatL8sk2h1m
         NYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5acyx8mtWXW7VMwQQTn2016+YkzgOn6sSwlU3dh0rXE=;
        b=shgnLw2a8YQ61DkWcNsP//fWwWk/6si1yjwKNF/6PQ553ZVCExQf+lpHsYPCpmbTd8
         dXjIhIESVe8hx0nL7fiuIONAyu2/1KbJujVnVaCIQM1OxAKd9LnvtTRySdSV11ZsQvQj
         u1iSM6hIFERzkJq2PJTBgD/jjaArJbIetv/lUWZKvB2zPpA7zFtXM5fT1umogE9O+BlJ
         jtPfLEBdIHwLAuBHn6YRbBhy8tE7sLyzbNTA6QqArcsyVp7UB9wMaDXnhzD4wYF47HVX
         ZeF3cXustFchfHdJRxMy1fuBY7kktk5G+8wmmN3XYnQ+rmiQw3uKYNmkKWXDbYTf9lHJ
         kF7w==
X-Gm-Message-State: AOAM533SPp5BpGpQAB26KVCNM5ffcY1YGeXbeDBYeB0mMRpSysgNwzlF
        JPN+fXputtp+Xyfom8NEfLRYcesC1WRLCT9/k8zIRA==
X-Google-Smtp-Source: ABdhPJyny/1ehYP8OU2mHUCswZL621CNkDqilAKZiJavzBHnmKYteFSk6vwdGZcV8mKtKOx7X1JSRF0kPmdXzGd77FQ=
X-Received: by 2002:adf:e60a:: with SMTP id p10mr5880295wrm.306.1633963956181;
 Mon, 11 Oct 2021 07:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211011132431.2792797-1-guoren@kernel.org> <20211011132431.2792797-2-guoren@kernel.org>
In-Reply-To: <20211011132431.2792797-2-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Oct 2021 20:22:25 +0530
Message-ID: <CAAhSdy29awBS7cATQjGvP1nqC_aYJgKvAQBxMxvhJAOK7VPr9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: update riscv plic claim-mask-support property
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 6:54 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add claim-mask-support to control riscv,plic don't call
> unnecessary mask/unmask operations.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 08d5a57ce00f..f32c1792604c 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -71,6 +71,8 @@ properties:
>      description:
>        Specifies how many external interrupts are supported by this controller.
>
> +  claim-mask-support: true
> +

This DT property does not describe HW in any way, rather it enable/disable
a SW behaviour in the driver. IMO, this DT property should not be added.

Regards,
Anup

>  required:
>    - compatible
>    - '#address-cells'
> --
> 2.25.1
>
