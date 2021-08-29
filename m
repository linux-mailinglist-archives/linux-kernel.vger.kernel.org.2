Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836FF3FAC5B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhH2PAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:00:49 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45835 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhH2PAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:00:47 -0400
Received: by mail-ot1-f41.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso14915278otv.12;
        Sun, 29 Aug 2021 07:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1fbltw3MLBuOoS98NmW+6rPgiO3mlgpEY5SYN5XgMR8=;
        b=BJ8KA/47pG4cauHuKWjR2A88/eGwM4mGpROdx4OJbVzzANqADiE0N2B9idYT4kdAde
         fNeNPlXG/xygBINHqeu/BIjZ5PcFfSX3b/tsQ2egCXxNUiBSGqUeMkxWPKeHmFYXHLhA
         n5L2kZhCORX/vOCoYzQknYEbNp/k4KjEuER2XlR7Xbl3gavKkqxFKQLiHJRjFv+kSrgf
         245ZwGiNWezlFGKDi12vli0pX783ZYQa9c3oJcMMhRxr+Fq1L/7n35FU4+tiUTFs5y4b
         Mwx+JGaADZRkQ8K35gtZkfceXf3L9fM5xbEiD/9sWT+dtvsWTxM9iC5wUSfRy6t2GTxL
         e+yQ==
X-Gm-Message-State: AOAM530yPvPp/vA2Oo+bpVU5mOEOONrFqWd1L8toJmPfqhOrmTzWbJC9
        nyJPf+0USl664ZMxQsucww==
X-Google-Smtp-Source: ABdhPJxgcPYAiARJ2IljUopanOwJB3/pN9yqy+Hw6MMqIPWV6xS/IL+dLOJvOskwmzg8jAA0ePJMhA==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr16609743otn.350.1630249195481;
        Sun, 29 Aug 2021 07:59:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j125sm2402835oif.53.2021.08.29.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 07:59:53 -0700 (PDT)
Received: (nullmailer pid 3944982 invoked by uid 1000);
        Sun, 29 Aug 2021 14:59:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, list@opendingux.net,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210828112640.7248-1-paul@crapouillou.net>
References: <20210828112640.7248-1-paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add AUO A030JTN01
Date:   Sun, 29 Aug 2021 09:59:52 -0500
Message-Id: <1630249192.491326.3944981.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 12:26:39 +0100, Paul Cercueil wrote:
> Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
> 24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
> interface.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/display/panel/auo,a030jtn01.yaml | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dts:23.11-21: Warning (reg_format): /example-0/panel@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dt.yaml: example-0: panel@0:reg:0: [0] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1521878

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

