Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D045E9E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347287AbhKZJJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:09:06 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:33660 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359748AbhKZJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:07:05 -0500
Received: by mail-ua1-f43.google.com with SMTP id a14so17365642uak.0;
        Fri, 26 Nov 2021 01:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtczldvNbGmrR5ykoDUfpIb1hDrMTteo+qnCjEU6gxM=;
        b=BzvIgCA55HFrGJdHz3K8j4yBECJFrGuA8cqUPURhb6gESAdA1xSHkKNCY2FQ3CT+J3
         XIXCrXJKguo1bjvPFiliJ60PcISgAhvmqCBerxOv9VTUlBDjvO0SCT8cKRB5LStvnT/c
         Wfh8IrdhjCyPgcvRcJgMotLQXKlV8IlP4b2S4vPKDfLkyvJsxligV5pybxvh/+oCCaBg
         SnWdbNtIl3ZqeeCQsU++tn7BNAFxhHULJekVg4WDFwAcu6PJkcmS6gdMxfwAawu3bXoK
         MctzPZWtM/yuTzTbnI7L8h+SxRKxnzegf7bLdxvEgKCrlqBALWkn4J5PFzcKYVqi7F3l
         6/3Q==
X-Gm-Message-State: AOAM533S3dmW66KECScuplIC+9BUn8NkyjHNyLA9DfncTDe1ZOmkakuj
        WxhMEOkm3Ol0weIZrrHSHCWT0JkYmtiYAw==
X-Google-Smtp-Source: ABdhPJwwFkscLGWyMPhLRJWZjIo2o4YeORft1JuaDT8pCf0ChSKSx61WWd9vwyUDUn1auvdcqklDYw==
X-Received: by 2002:a67:fa59:: with SMTP id j25mr16126005vsq.30.1637917431922;
        Fri, 26 Nov 2021 01:03:51 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id p3sm3345680vsr.3.2021.11.26.01.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 01:03:51 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id u68so5501899vke.11;
        Fri, 26 Nov 2021 01:03:51 -0800 (PST)
X-Received: by 2002:a05:6122:104f:: with SMTP id z15mr13511423vkn.39.1637917430800;
 Fri, 26 Nov 2021 01:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20211125152317.162958-1-geert@linux-m68k.org>
In-Reply-To: <20211125152317.162958-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Nov 2021 10:03:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVg-r3P_SPqDK7K4rYLzLP+=Wy9KatiNrpK7ebKJSx-Tg@mail.gmail.com>
Message-ID: <CAMuHMdVg-r3P_SPqDK7K4rYLzLP+=Wy9KatiNrpK7ebKJSx-Tg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: sifive,clint: Fix number of interrupts
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 4:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> To improve human readability and enable automatic validation, the tuples
> in "interrupts-extended" properties should be grouped using angle
> brackets.  As the DT bindings lack an upper bound on the number of
> interrupts, thus assuming one, proper grouping is currently flagged as
> an error.
>
> Fix this by adding the missing "maxItems", limiting it to 10 interrupts
> (two interrupts for a system management core, and two interrupts per
> core for other cores), which should be sufficient for now.
>
> Group the tuples in the example.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a35952f487426988..55bec2d059807c48 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -43,6 +43,7 @@ properties:
>
>    interrupts-extended:
>      minItems: 1
> +    maxItems: 10

Cfr. Jessica's comment on my PLIC patch:

The maximum supported by the CLINT memory map is 8192.
Device-specific limits would be 4 for k210 and jh7100, and 10 for
fu540.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
