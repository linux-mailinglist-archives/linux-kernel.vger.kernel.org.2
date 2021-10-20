Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B0434F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJTPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhJTPz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:55:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:53:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so27717036edc.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvpaCofbfPMgdFg6goKpvTUInlV4+5BCgWFCKXUm3As=;
        b=KUODyXHTdsMRZjAn9iIjtT5u3oa1rlWzzqBTKRCRJZsYsG+3DHhGrLMcowDWA3VtCD
         qSZ27EkbM6Bmc+U0VoeWgBYWAfdQYM+rYn/a0xchpWt2EDW3PG8s8PU/MuEpNvUSII8J
         Bcvjj0k2SlKHPx+Q8fA8xinl8+hlpCzj9jEqCfDdPpn1SN4vl6/GxR+hFvxWO2ATKUus
         PfcloE2D+R9yeol93G4T2L8hv3lx7qM+5PRwJvkUNj8kcstRU5OJS9cqeJaackJd3gKH
         UmBCLPbnMVoJu5szmseu69oWJzJWnlrBj16Tnr2iHqdosrFPmbEw5l2CBtKw8tHeRrVO
         H1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvpaCofbfPMgdFg6goKpvTUInlV4+5BCgWFCKXUm3As=;
        b=kQYBsp8c59Ducs5MSVoTaHguLjFvu1Cm9ooVQwgHSLDs9aM2ag7Bv8oqtagtCof4BN
         q2WIv6Yxf9Nt3/rqGwzB3FhqBTnOfHQv6Cbk+ArTT2J65/HxLMgLiJ24AFCKf7ufOWtE
         ulmn7e5ecgfZmAWLvlFFW8Aa52lDsVtwbXp5dqMRtp1mBQ1QWH9Jj+iqlf+H4YQaTPu5
         2HjuG2oEhDqeR8XG9Ub4HOT9KAnfpclXsT8bB/3+Lu7djqFzj6CjcVPdZYSXP/+aFvt0
         CnLe2Ht3NbYN66PYjgb0PeCb+AyDLJ5dvW8HAHqc0dOsukDplKxxfakKdM6LGfHN8MiT
         /ixQ==
X-Gm-Message-State: AOAM5338HOWSC2dFAAY/x7uoVStLmnEUD5jHkVy75AS6XZa5CUA29dMm
        sHMEuvNUZsa139jYPprIN4ed9O2efVB5fFSeCg06WA==
X-Google-Smtp-Source: ABdhPJyqXEOVX/X4gZqc9wVobupCAGTN772DwkRBf5KZ1VOLcwhg0EB6QlcXlh1zQaTCMcKXfpE+Z5MKDgfYXwVB5b0=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr111901ejx.363.1634745164492;
 Wed, 20 Oct 2021 08:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211018114046.25571-1-etienne.carriere@linaro.org> <1634578358.516648.2612839.nullmailer@robh.at.kernel.org>
In-Reply-To: <1634578358.516648.2612839.nullmailer@robh.at.kernel.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 20 Oct 2021 17:52:33 +0200
Message-ID: <CAN5uoS_B6PrkWtaX5V4xdNnvRjzTJwsB=txVK0YB8bGjWsKdNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,


On Mon, 18 Oct 2021 at 19:32, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 18 Oct 2021 13:40:45 +0200, Etienne Carriere wrote:
> > Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> > based on an OP-TEE service invocation. The compatible mandates a
> > channel ID defined with property "linaro,optee-channel-id".
> >
> > Cc: devicetree@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v2:
> >  - Define mandatory property linaro,optee-channel-id
> >  - Rebased on yaml description file
> >
> > Changes since v1:
> >  - Removed modification regarding mboxes property description.
> > ---
> >  .../bindings/firmware/arm,scmi.yaml           | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'description' is a required property
>         hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>         from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
>         'type' is a required property
>                 hint: A vendor boolean property can use "type: boolean"
>         Additional properties are not allowed ('maxItems' was unexpected)
>                 hint: A vendor boolean property can use "type: boolean"
>         /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
>                 'enum' is a required property
>                 'const' is a required property
>                 hint: A vendor string property with exact values has an implicit type
>                 from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>         /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
>                 '$ref' is a required property
>                 'allOf' is a required property
>                 hint: A vendor property needs a $ref to types.yaml
>                 from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>         hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>         from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: ignoring, error in schema: patternProperties: ^protocol@[0-9a-f]+$: properties: linaro,optee-channel-id
> warning: no schema found in file: ./Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml:0:0: /example-1/firmware/scmi: failed to match any schema with compatible: ['arm,scmi']
> Documentation/devicetree/bindings/firmware/arm,scmi.example.dts:175.39-178.19: ERROR (duplicate_label): /example-2/firmware/scmi/protocol@14: Duplicate label 'scmi_clk' on /example-2/firmware/scmi/protocol@14 and /example-0/firmware/scmi/protocol@14
> Documentation/devicetree/bindings/firmware/arm,scmi.example.dts:180.40-186.19: ERROR (duplicate_label): /example-2/firmware/scmi/protocol@13: Duplicate label 'scmi_dvfs' on /example-2/firmware/scmi/protocol@13 and /example-0/firmware/scmi/protocol@13
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/firmware/arm,scmi.example.dt.yaml] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1441: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1542547
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

Thanks for the feedback and guidelines. I've played a bit with dt
checker and saw that description/type/etc.. are not needed when the
property name does not include a coma ','.

I think i'll use "optee-channel-id" instead of
"linaro,optee-channel-id" as property name.
With that name, 'make dt_binding_check' passes without complains on
arm,scmi.yaml.
I have no strong preference and here and can go either ways.

I though the "linaro," was expected.
Please tell me if there's any reason I need to preserve this "linaro,"
prefix on that property.

Regards,
Etienne
