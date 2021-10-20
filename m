Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E587F435084
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhJTQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJTQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:47:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33406C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:45:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so409638edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54ox45iamAqJI/ZSpvjT5ytrb9y5qaD60KiIyvWufQE=;
        b=JEupWRdH/ZFgHpE7i0xYU+gheIJ1mWk/Jz6nhN8ZHLR8hos3roX9F3YPG+T0GhLy54
         V9z2FFrRspZ+M/UVhD6C9+ntvoNq9NQmwqdkmy7P0biv9p3fxbC9TCX8vsuozogk6IfP
         w45AvME8aouQje4BLDMWoy/UeUIa3cY3oIShCUMWl2fraXHU65RnBPw0Q7K5NckNkGZ5
         3Mi4zHehqsT/5ei+v6usNQ0sxxTXbE33FsfjqIqkE+/LJjLlJW5nxnkxPYN68u53iKa2
         GllZVbX1htMdYfc5hAkSQvrYUboiqh/Ce/oSKMuKV37t6r5fdRqkHkdcTELd4iTU5aS9
         YEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54ox45iamAqJI/ZSpvjT5ytrb9y5qaD60KiIyvWufQE=;
        b=kkoT2A0YcG3g4wNvGBRr94UPDigZm0sBe8NdftJeBdwYiALpVmc30wCO3QlBgqb/6B
         iSgfNr/Ur+rk7u01Zpmm8W8Tr7fEi65PHIT1ZzCbchYaxcHxIDLVGC3YfYRUbxpAyCC7
         aHqKQWgXAEefC0EZX8dedez8EaQ2vaamCVNwNNvwFOetW7ZPFhxnJ54f0OtyNjT1a7Y/
         hfSGDQEOpzHN8GxURW4jnYMeKR+vLoFTuGd55FuzGenapTQPRtbWAuHkMKmdiQeDwVMm
         i54iPx/ld24Nj43LtvRERKSIroffsZFXyZNLWK5mYf5k/4ps+jxnW4sRKgPUzMOFmPsy
         XxyA==
X-Gm-Message-State: AOAM530i2JnFMm2p1i7EWIHc9zp3y1Dj290eDnfYbwdfhXM9P7iLvP/y
        fypYF2FKaMzz2HN/BVDeumptD3ONPLnHhv6AFl68bA==
X-Google-Smtp-Source: ABdhPJwESR4BaiSZNwncK3k5JFkYwYy3lXgr3LuPP4BgzRv4dmOeosqMpCxNFStPOzgnfaTqzpxnUP59bHg64aVX7uU=
X-Received: by 2002:a50:ec0f:: with SMTP id g15mr61186edr.47.1634748322553;
 Wed, 20 Oct 2021 09:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211018114046.25571-1-etienne.carriere@linaro.org>
 <1634578358.516648.2612839.nullmailer@robh.at.kernel.org> <CAN5uoS_B6PrkWtaX5V4xdNnvRjzTJwsB=txVK0YB8bGjWsKdNA@mail.gmail.com>
In-Reply-To: <CAN5uoS_B6PrkWtaX5V4xdNnvRjzTJwsB=txVK0YB8bGjWsKdNA@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 20 Oct 2021 18:45:11 +0200
Message-ID: <CAN5uoS8V7ygo04iOjb=AF8HLf58cpZkL8QzkaG8kouKtUYS-aw@mail.gmail.com>
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

Hi again,

On Wed, 20 Oct 2021 at 17:52, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello Rob,
>
>
> On Mon, 18 Oct 2021 at 19:32, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, 18 Oct 2021 13:40:45 +0200, Etienne Carriere wrote:
> > > Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> > > based on an OP-TEE service invocation. The compatible mandates a
> > > channel ID defined with property "linaro,optee-channel-id".
> > >
> > > Cc: devicetree@vger.kernel.org
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > > Changes since v2:
> > >  - Define mandatory property linaro,optee-channel-id
> > >  - Rebased on yaml description file
> > >
> > > Changes since v1:
> > >  - Removed modification regarding mboxes property description.
> > > ---
> > >  .../bindings/firmware/arm,scmi.yaml           | 44 +++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'description' is a required property
> >         hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> >         from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
> >         'type' is a required property
> >                 hint: A vendor boolean property can use "type: boolean"
> >         Additional properties are not allowed ('maxItems' was unexpected)
> >                 hint: A vendor boolean property can use "type: boolean"
> >         /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
> >                 'enum' is a required property
> >                 'const' is a required property
> >                 hint: A vendor string property with exact values has an implicit type
> >                 from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> >         /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
> >                 '$ref' is a required property
> >                 'allOf' is a required property
> >                 hint: A vendor property needs a $ref to types.yaml
> >                 from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> >         hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> >         from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: ignoring, error in schema: patternProperties: ^protocol@[0-9a-f]+$: properties: linaro,optee-channel-id
> > warning: no schema found in file: ./Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml:0:0: /example-1/firmware/scmi: failed to match any schema with compatible: ['arm,scmi']
> > Documentation/devicetree/bindings/firmware/arm,scmi.example.dts:175.39-178.19: ERROR (duplicate_label): /example-2/firmware/scmi/protocol@14: Duplicate label 'scmi_clk' on /example-2/firmware/scmi/protocol@14 and /example-0/firmware/scmi/protocol@14
> > Documentation/devicetree/bindings/firmware/arm,scmi.example.dts:180.40-186.19: ERROR (duplicate_label): /example-2/firmware/scmi/protocol@13: Duplicate label 'scmi_dvfs' on /example-2/firmware/scmi/protocol@13 and /example-0/firmware/scmi/protocol@13
> > ERROR: Input tree has errors, aborting (use -f to force output)
> > make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/firmware/arm,scmi.example.dt.yaml] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1441: dt_binding_check] Error 2
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/patch/1542547
> >
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit.
> >
>
> Thanks for the feedback and guidelines. I've played a bit with dt
> checker and saw that description/type/etc.. are not needed when the
> property name does not include a coma ','.
>
> I think i'll use "optee-channel-id" instead of
> "linaro,optee-channel-id" as property name.
> With that name, 'make dt_binding_check' passes without complains on
> arm,scmi.yaml.
> I have no strong preference and here and can go either ways.

Discard my comment. I'll preserve the linaro, vendor prefix.
This property is all but generic.
I"ll add a clean description where needed and run dt_checker against.

Sorry for the noise.
Regards,
Etienne


>
> I though the "linaro," was expected.
> Please tell me if there's any reason I need to preserve this "linaro,"
> prefix on that property.
>
> Regards,
> Etienne
