Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7B36CE11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhD0V6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239157AbhD0V6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:58:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 209FF613FE;
        Tue, 27 Apr 2021 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619560675;
        bh=FG7TiI/n5pBkv13LuX8sBw0aAzWZoQroBWucMt/TDxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oSFNW1cD9UE38wIJeeE1yhgIomctgwv766DKbvDQjLLl9jcS7BtFJ984s40ZWBIp6
         zgtM2djeGagU+2jqRNasuXkrS6IeMZc/VTGxoa1EAM1hObbrWBmT0dQx0svcBBbjEB
         FzCg1WwuP/QiUa+4eeCvHXkgTWwOiwB0bpqQW/l6RMXfuTG0aZw7wAHNpHiB5KeZcc
         tmKfyL7HeUy0PdrnxxKYrq2zagqSgCCsYs/Juuyx0kK/SPL9PpzieimzM/lLjv97Z2
         05wQQmc1LsdL0tKriAkf8xa2GPr/LUvUGm0unRt+KyvckKZOnXXSboZEVQDBb82vHF
         GmFbpDeaLEnhw==
Received: by mail-qv1-f49.google.com with SMTP id j3so29811221qvs.1;
        Tue, 27 Apr 2021 14:57:55 -0700 (PDT)
X-Gm-Message-State: AOAM530Qx5GON+J6uI3uMgEak8O9tvmpGn0JmWeWozX8Y6ZDpbMStvmk
        nBbeGPF/jEAbak1NpbqlV+vIPTH1512+f8e4uA==
X-Google-Smtp-Source: ABdhPJzma2yQocrUD883SqCQ10PPf3W8kZ+vt8AJhczYrRR5HoYFC+DWBAkMElf83d9UQkpuuCfZEcbKzEeQNp4bxwg=
X-Received: by 2002:ad4:5742:: with SMTP id q2mr26444798qvx.11.1619560674320;
 Tue, 27 Apr 2021 14:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210422145330.73452-1-tsbogend@alpha.franken.de>
 <20210422145330.73452-2-tsbogend@alpha.franken.de> <1619115798.231872.3355876.nullmailer@robh.at.kernel.org>
In-Reply-To: <1619115798.231872.3355876.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Apr 2021 16:57:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnAvc_rewNRDipEpJbp=Aj1yrTvgkJQMSH4E-pK4XBYg@mail.gmail.com>
Message-ID: <CAL_JsqKnAvc_rewNRDipEpJbp=Aj1yrTvgkJQMSH4E-pK4XBYg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: interrupt-controller: Add IDT
 79RC3243x Interrupt Controller
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 1:23 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 22 Apr 2021 16:53:29 +0200, Thomas Bogendoerfer wrote:
> > Document DT bindings for IDT 79RC3243x Interrupt Controller.
> >
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > ---
> > Changes in v4:
> >   - renamed to idt,32434-pic
> >
> > Changes in v3:
> >   - fixed compatible string in example
> >
> > Changes in v2:
> >   - added dt binding doc
> >
> >  .../interrupt-controller/idt,32434-pic.yaml   | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.example.dt.yaml: interrupt-controller@3800c: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml

Now this is an error in Linus' tree. Please send a fix.

Rob
