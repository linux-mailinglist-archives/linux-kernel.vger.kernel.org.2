Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82159346FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhCXCiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhCXCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:37:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2FC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:37:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so349580pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=od0BD5phhIgjjdHP+pXkuF/8ytaG+GpUJEyEIVUV7fU=;
        b=DNny0NmFMN/XKTCWHNlE2Azj31S6ov/KSxCVrZKIPputQXgq1w8Ito0UNkO9JtzRR/
         Q95hkwirbsGfIfqveuD6BXJyzRl0d4ftjHKXXEkaIduyWocI5G9rRQL4Z6KDX6NPad/F
         V9hqKIbmwV2xvngJhYKzHD/fp1uNcHvDPhqzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=od0BD5phhIgjjdHP+pXkuF/8ytaG+GpUJEyEIVUV7fU=;
        b=ugMqzBLb5fItHVzD5E/pL3vjDB5chBD5hV3oceU8fiOa0zERRIdUmDac5pozTI2vJ1
         uS4ZHIapVZOKhBhnAyBJcyPQj/qPEGGc0h+AAlUVQer97QWKyMp4PBh4vFBEuUH0u9yN
         cP9EjZAvHmATy7DiNogQY4wyq0JKUhVLdWUqcbyW243+rfLFtVpYW41ZIyAE9MKWXr8l
         uvOF/0mhpXuDKr7O8v+3//gi8LjM0ZcsFA33WMoxu2k/ewq7WUO7yLZ9D5yWsgq6iGxl
         EAPaYPPPzrSdPDZLflcufEY4d5S993Oy2Api/oG1gdN8tbG1V+OVkXntfdIW5YC43sh8
         4MJA==
X-Gm-Message-State: AOAM5338jE8st4Op5epaWzTONG2p7It4YWsWx7yuSZdjAlh8RyizW/Vz
        jIeSm96axFKpZDSGU/VRnK8ABw==
X-Google-Smtp-Source: ABdhPJyv9plpOoNB10k0a03KKxljHDIU04Ysw825aEB6SSWOjf5EJNYX70Cm0fswlh+QWFmuTfauXA==
X-Received: by 2002:a17:90a:a96:: with SMTP id 22mr1086638pjw.200.1616553477366;
        Tue, 23 Mar 2021 19:37:57 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id m7sm422290pjc.54.2021.03.23.19.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:37:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1616409015-27682-1-git-send-email-mkshah@codeaurora.org>
References: <1616409015-27682-1-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert bindings to yaml for qcom,pdc
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>,
        devicetree@vger.kernel.org
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        maz@kernel.org
Date:   Tue, 23 Mar 2021 19:37:53 -0700
Message-ID: <161655347383.3012082.3209818534281111587@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2021-03-22 03:30:15)
> -- qcom,pdc-ranges:
> -       Usage: required
> -       Value type: <u32 array>
> -       Definition: Specifies the PDC pin offset and the number of PDC po=
rts.
> -                   The tuples indicates the valid mapping of valid PDC p=
orts
> -                   and their hwirq mapping.
> -                   The first element of the tuple is the starting PDC po=
rt.
> -                   The second element is the GIC hwirq number for the PD=
C port.
> -                   The third element is the number of interrupts in sequ=
ence.
> -
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,=
pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.=
yaml
> new file mode 100644
> index 0000000..8b4151c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/qcom,pdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. PDC interrupt controller
> +
> +maintainers:
> +  - Maulik Shah <mkshah@codeaurora.org>
> +
> +description: |
> +  Qualcomm Technologies, Inc. SoCs based on the RPM Hardened architectur=
e have a
> +  Power Domain Controller (PDC) that is on always-on domain. In addition=
 to
> +  providing power control for the power domains, the hardware also has an
> +  interrupt controller that can be used to help detect edge low interrup=
ts as
> +  well detect interrupts when the GIC is non-operational.
> +
> +  GIC is parent interrupt controller at the highest level. Platform inte=
rrupt
> +  controller PDC is next in hierarchy, followed by others. Drivers requi=
ring
> +  wakeup capabilities of their device interrupts routed through the PDC,=
 must
> +  specify PDC as their interrupt controller and request the PDC port ass=
ociated
> +  with the GIC interrupt. See example below.
> +
> +properties:
> + compatible:
> +   items:
> +     - enum:
> +        # Should contain "qcom,<soc>-pdc" and "qcom,pdc"
> +         - qcom,sc7180-pdc #For SC7180
> +         - qcom,sc7280-pdc #For SC7280
> +         - qcom,sdm845-pdc #For SDM845
> +         - qcom,sm8250-pdc #For SM8250
> +         - qcom,sm8350-pdc #For SM8350
> +     - const: qcom,pdc
> +
> + reg:
> +    description: |
> +      Specifies the base physical address for PDC hardware followed by o=
ptional
> +      PDC's GIC interface registers that need to be configured for wakeu=
p capable
> +      GPIOs routed to the PDC.
> +    minItems: 1
> +    maxItems: 2

Can this be

	items:
	  - description: base registers
	  - description: wakeup configuration registers

and then we should always have both registers?

> +
> + '#interrupt-cells':
> +    # Specifies the number of cells needed to encode an interrupt.
> +    # The first element of the tuple is the PDC pin for the interrupt.
> +    # The second element is the trigger type.
> +    const: 2
> +
> + interrupt-controller: true
> +
> + qcom,pdc-ranges:
> +   description: |
> +      Specifies the PDC pin offset and the number of PDC ports.
> +      The tuples indicates the valid mapping of valid PDC ports
> +      and their hwirq mapping.
> +   $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +   items:
> +      items:
> +        - description: |
> +           "a" The first element of the tuple is the starting PDC port.
> +        - description: |
> +           "b" The second element is the GIC SPI number for the PDC port.
> +        - description: |
> +           "c" The third element is the number of interrupts in sequence.

Do we need the "a", "b", "c" prefixes? Is there any minItems or maxItems
that can be placed on this?

> +
> +required:
> +    - compatible
> +    - reg
> +    - '#interrupt-cells'
> +    - interrupt-controller
> +    - qcom,pdc-ranges
> +
> +additionalProperties: false
