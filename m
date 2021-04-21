Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD1366B31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbhDUMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:52:26 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35351 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbhDUMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:52:23 -0400
Received: by mail-oi1-f178.google.com with SMTP id e25so12331207oii.2;
        Wed, 21 Apr 2021 05:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ag4B4zjVl55Bp2oWHpl6SRH9Ogx3VqB54DQ1BYQw7U8=;
        b=oRfkMpvvsWioKbRHVUOH0ElNU+0r4YmBr0SkvHAkAhwLIgvCZyRy2GRglF55phcPgH
         RYFghjBAVsGE/oFdcwi5wEHhLZaJQ+TAs0v/KdK2LGM/avhDrkDBUyJYNHVEZzKmuq2X
         SHSfcxB816hXQaccIes/DALldbOp3KSX/1EAStOdWulQ0R22a44NMBbl0rKQGjqPl5Y0
         fp3coiJQFkVpslxMhLDiEflURvBv33kOH/Iemtp82Zkjzih6kXoZIhERkIqcaG3pdVlU
         hXV5PK5jUGoEGmP1FfLJ/42FkAfa0fup/FF3X4nBUq2lYNRivea8K0lx1Uw0wF0/wEgH
         NRmw==
X-Gm-Message-State: AOAM531xJRi5EWrphLMay3Twr5PnNtjmHWWsuCsh/oP9ae87/RgZ+ONz
        g2aMgh98EWqQI3092b2NqQ==
X-Google-Smtp-Source: ABdhPJw49gdT1XI/cHuyibFgw9jlduPBc8kGP7hxhLIWFxVzQb4dtAdrnVlLssn+0y2FV4rDZFulVw==
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr6811121oic.88.1619009510429;
        Wed, 21 Apr 2021 05:51:50 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p11sm475169oti.53.2021.04.21.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:51:49 -0700 (PDT)
Received: (nullmailer pid 967205 invoked by uid 1000);
        Wed, 21 Apr 2021 12:51:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210420204821.39396-2-tsbogend@alpha.franken.de>
References: <20210420204821.39396-1-tsbogend@alpha.franken.de> <20210420204821.39396-2-tsbogend@alpha.franken.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: interrupt-controller: Add IDT 79RC3243x Interrupt Controller
Date:   Wed, 21 Apr 2021 07:51:48 -0500
Message-Id: <1619009508.490301.967204.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 22:48:20 +0200, Thomas Bogendoerfer wrote:
> Document DT bindings for IDT 79RC3243x Interrupt Controller.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  .../interrupt-controller/idt,3243x-pic.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.example.dt.yaml:0:0: /example-0/interrupt-controller@3800c: failed to match any schema with compatible: ['idt,rc3243x-pic']

See https://patchwork.ozlabs.org/patch/1468492

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

