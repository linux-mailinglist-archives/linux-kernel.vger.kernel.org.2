Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDC368682
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhDVSYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:24:00 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33313 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:23:56 -0400
Received: by mail-ot1-f47.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso20560945otl.0;
        Thu, 22 Apr 2021 11:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Kfjgir2jOtQK1x6004nR19DHTf75FNTXdXjs+LH2Wow=;
        b=WQ9qFtHnGMKf1JkvV0xn2zeSD4M4zkZC1kTiaL5PahNUhmMMv2qngKZVpK5+VqOiYO
         gI+1TJB3QeXJCXtMTY3LRc5bB5H2d+vbTHKR8Zi/puaLGg4Ihv7CXnPWImtO/jJWA7Cd
         cRvo4XEiONmBSLS7InUhCHiDIyaueSs7BEGlugVRbYJ1cQmCtGYogoCa4YjwZRyHqVRR
         0IZ9o94Wz1LFOqO+p4iK+YTYGwiTpxWLLrFqbCbjPiKQeJuCmWqln8fYtb5NJazJVWn5
         2fTMpOtSzvOBdDOksfXen972pQqFT8zqVqyvNYfD7zi4rXyH6R0vegq/m8QGdivwe5xh
         kr4A==
X-Gm-Message-State: AOAM5305tGu4Oe13ZDb0Le9RwcoyP3483WF6c42JWzPmWhx85/NRf3Fg
        zSXxqkKsflxqt8HVlPDBxQ==
X-Google-Smtp-Source: ABdhPJyGCuzyghMGKjJ456DxWv1WcfQmZOMj8W9miNjN1WAOrW2zrouvyWVlcSWe/bKnLEWrZOX0Pg==
X-Received: by 2002:a05:6830:23a5:: with SMTP id m5mr3969855ots.127.1619115800607;
        Thu, 22 Apr 2021 11:23:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm681802oic.51.2021.04.22.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 11:23:19 -0700 (PDT)
Received: (nullmailer pid 3355877 invoked by uid 1000);
        Thu, 22 Apr 2021 18:23:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422145330.73452-2-tsbogend@alpha.franken.de>
References: <20210422145330.73452-1-tsbogend@alpha.franken.de> <20210422145330.73452-2-tsbogend@alpha.franken.de>
Subject: Re: [PATCH v4 2/2] dt-bindings: interrupt-controller: Add IDT 79RC3243x Interrupt Controller
Date:   Thu, 22 Apr 2021 13:23:18 -0500
Message-Id: <1619115798.231872.3355876.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 16:53:29 +0200, Thomas Bogendoerfer wrote:
> Document DT bindings for IDT 79RC3243x Interrupt Controller.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> Changes in v4:
>   - renamed to idt,32434-pic
> 
> Changes in v3:
>   - fixed compatible string in example
> 
> Changes in v2:
>   - added dt binding doc
> 
>  .../interrupt-controller/idt,32434-pic.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.example.dt.yaml: interrupt-controller@3800c: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml

See https://patchwork.ozlabs.org/patch/1469240

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

