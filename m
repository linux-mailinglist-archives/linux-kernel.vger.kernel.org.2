Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F172426437
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 07:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhJHFtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 01:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhJHFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 01:49:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C1AC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 22:47:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so26011175wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 22:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUO+bDpipbeRKMmW8/mqCgbraNQzAhGi9jrXbZZyXSo=;
        b=c6ulsXPTlsw6nXgIwQt10rczsK1NI/1HT0KEiJljF6wIuUKNaMiMH6PwZiJyg+KLhR
         eeTh+XLRXzY1gCid7f998gRTRuaiiP44ynrs0Q5gtmfoQj8ZrCGZcYF+Z+FnFbvbUHRm
         WHrLYjJvJaHpOEo56YJ1iSHpj8a63WLdIxeObYIhVs8v4MUjJJJO0KVEmVBbyL4vR3bS
         RYOZkgNqLhLpfFh3gltneN9oK30ej4VfotD/1UEkRzZm2oY8QjeML1/AWdhquNmF+3ij
         riF2c8RBnq8yLiUC/tUvgeCBWIOkz0YvGG2CUrreuURZYKL7R5Xc0wmsuCRiXcTXnIOP
         hicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUO+bDpipbeRKMmW8/mqCgbraNQzAhGi9jrXbZZyXSo=;
        b=KNJOa86hhEwoHW9Aaa1pfgwgjn9MTqhdqInWDKnWOw2VnD1SLfwEuoaRaDLRpf8bN0
         78AP6tgaPbTLFEnywPHioxFeRW02wyMJ0FPIfj1JnVI820z7mT7UDSiXDHbzIqG5aD+f
         OZLg/MzDpvLUOIhTnKwEG7dzJV06uJOkgc85nrIMc3tXOyQvDIkhYzTh/oqRUgYj7r1b
         0BVEBXqOcSllw3+//rlYX/KAOAprnFB+5FUDFSV1ok9pfQ6qB/4iAaEO79pfaEdUHqzj
         iq/ojoCIyERmy2Rml+6pCXVsiI0eiE36DHB1oVxLripkhd8LTLH75LBc1yuHIf5iJSkA
         YwMA==
X-Gm-Message-State: AOAM531DzsoR2jFDTX94yyOAQMx4Oxxh92dSmzG8UXoCgqnmNFc3b8Rs
        gpdfe0tiasd55NLHXcxgJZ8lStTXTqIXgQIMqRaD4A==
X-Google-Smtp-Source: ABdhPJxVe1g7+6FuGdJEE0Z8tFx3XyHA4eOQMHsm6VHXPE5LFkXY71ABHoAVSmqLpRgdyU7INpagtuuvpQidMoRpUBc=
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr1338090wmj.176.1633672028067;
 Thu, 07 Oct 2021 22:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211007123632.697666-1-anup.patel@wdc.com> <20211007123632.697666-6-anup.patel@wdc.com>
 <1633661172.595534.1409590.nullmailer@robh.at.kernel.org>
In-Reply-To: <1633661172.595534.1409590.nullmailer@robh.at.kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 8 Oct 2021 11:16:56 +0530
Message-ID: <CAAhSdy2fBgA5xymwp=276qodB9mkNVOg+b6FhN1mxvm_s2KbOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 05/10] dt-bindings: interrupt-controller: Add
 ACLINT MSWI and SSWI bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>, DTML <devicetree@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 8:16 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 07 Oct 2021 18:06:27 +0530, Anup Patel wrote:
> > We add DT bindings documentation for the ACLINT MSWI and SSWI
> > devices found on RISC-V SOCs.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  .../riscv,aclint-swi.yaml                     | 97 +++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml:34:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
> ./Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml:39:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
>
> dtschema/dtc warnings/errors:
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1537678
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:

Ahh, I did not have "yamllint" installed. I am able to reproduce this
warning with "yamllint". This will be fixed in v5.

Let me know if you have any other comments apart from this.

Regards,
Anup

>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
