Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076DB43F25A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJ1WKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJ1WKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:10:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492F2C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:08:25 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x8so6112698oix.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/Pr4+moq6uxxSNErzs5t8Ot9an4fXCfokoXqjuAIaPM=;
        b=ebzHjuz36pjePUwf6bx+AtX5Vlyr9kmsxahF9QG/CPujIICXfNLXBrhctdsiDigC1r
         oC7gWnW3ZT1+gitykWhbRQnv2Gst/kC9DCuQ/JAe75+aAQQ4EKrMFiBd2823/zZCIbL0
         mwG/AgqpbsrScim2HxTEhOieAPh1KtKBEnhbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/Pr4+moq6uxxSNErzs5t8Ot9an4fXCfokoXqjuAIaPM=;
        b=jukUAJqk6/CFS4XemORrfvUuCFPjlWKRxy2wVJMvd11GwqVBJPCkE8lWNafd7sfeUY
         Mt3wZCcJfu05eq0v6LG2o1/2G1Zz5GC/RctvRIdYNDGvUwo5guksgSlcOP46FUWJyD19
         d+Nc7H9gTId1l/+GLWG7IOlUW4fCIcui03fLbjy+HBFu0H7V0RMyDmv6OykwTCbpTxiL
         LYDT2Say/5uUcbdLx/7+CqgofCaoHjjkETBKU9SicWBdK0XoZkZokKQK03avohhDT0dT
         A+9r/gNQSvXVw7fr536Y+PGegq7UepnMwLCgG7HpbLiZqu7SLLfrnpkL1KZnP5P0jVyE
         gq9g==
X-Gm-Message-State: AOAM532ccR/E1mAundV44LRi9yKAG4sj84rZdVh/ea7INCHsYicO3Tkp
        EQhTXw2fGJxIteQHc/lZp1yWC+pDNQNwDRdn9nVb1g==
X-Google-Smtp-Source: ABdhPJyTHzX6uF5OsBpL7VXXllfq+d9ZMUgRaSJsFQgxo4OpDV3YsTM9R8u9y+LDZWpQqgNTTdKDKdEBLc9IG7kuVko=
X-Received: by 2002:a05:6808:2124:: with SMTP id r36mr5299547oiw.64.1635458904676;
 Thu, 28 Oct 2021 15:08:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 15:08:24 -0700
MIME-Version: 1.0
In-Reply-To: <1635408817-14426-3-git-send-email-pillair@codeaurora.org>
References: <1635408817-14426-1-git-send-email-pillair@codeaurora.org> <1635408817-14426-3-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 15:08:24 -0700
Message-ID: <CAE-0n50z=h-avn+K-weZnZFVN7nsR=fLAtge7jFZ0JLx2JvP2w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibis@codeaurora.org, mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-10-28 01:13:36)
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> new file mode 100644
> index 0000000..96d11a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> @@ -0,0 +1,194 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-wpss-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC7280 WPSS Peripheral Image Loader
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  This document defines the binding for a component that loads and boots firmware
> +  on the Qualcomm Technology Inc. WPSS.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc7280-wpss-pil
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      The base address and size of the qdsp6ss register
> +
> +  interrupts:
> +    items:
> +      - description: Watchdog interrupt
> +      - description: Fatal interrupt
> +      - description: Ready interrupt
> +      - description: Handover interrupt
> +      - description: Stop acknowledge interrupt
> +      - description: Shutdown acknowledge interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdog
> +      - const: fatal
> +      - const: ready
> +      - const: handover
> +      - const: stop-ack
> +      - const: shutdown-ack
> +
> +  clocks:
> +    items:
> +      - description: GCC WPSS AHB BDG Master clock
> +      - description: GCC WPSS AHB clock
> +      - description: GCC WPSS RSCP clock
> +      - description: XO clock
> +
> +  clock-names:
> +    items:
> +      - const: ahb_bdg
> +      - const: ahb
> +      - const: rscp
> +      - const: xo
> +
> +  power-domains:
> +    items:
> +      - description: CX power domain
> +      - description: MX power domain
> +
> +  power-domain-names:
> +    items:
> +      - const: cx
> +      - const: mx
> +
> +  resets:
> +    items:
> +      - description: AOSS restart
> +      - description: PDC SYNC
> +
> +  reset-names:
> +    items:
> +      - const: restart
> +      - const: pdc_sync
> +
> +  memory-region:

Does it need

    $ref: /schemas/types.yaml#/definitions/phandle

because it's a phandle?

> +    maxItems: 1
> +    description: Reference to the reserved-memory for the Hexagon core
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      The name of the firmware which should be loaded for this remote
> +      processor.
> +
> +  qcom,halt-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle reference to a syscon representing TCSR followed by the
> +      three offsets within syscon for q6, modem and nc halt registers.
> +
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM.
> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the Hexagon core
> +    items:
> +      - description: Stop the modem
> +
> +  qcom,smem-state-names:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The names of the state bits used for SMP2P output
> +    items:
> +      - const: stop
> +
> +  glink-edge:
> +    type: object
> +    description:
> +      Qualcomm G-Link subnode which represents communication edge, channels
> +      and devices related to the ADSP.

Any properties of glink-edge that are required?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended

interrupts

> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - power-domain-names
> +  - reset
> +  - reset-names
> +  - qcom,halt-regs
> +  - memory-region
> +  - qcom,qmp
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +  - glink-edge
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
> +    remoteproc@8a00000 {
> +        compatible = "qcom,sc7280-wpss-pil";
> +        reg = <0x08a00000 0x10000>;
> +
> +        interrupts-extended = <&intc GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
> +                              <&wpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                              <&wpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                              <&wpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                              <&wpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +                              <&wpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog", "fatal", "ready", "handover",
> +                          "stop-ack", "shutdown-ack";
> +
> +        clocks = <&gcc GCC_WPSS_AHB_BDG_MST_CLK>,
> +                 <&gcc GCC_WPSS_AHB_CLK>,
> +                 <&gcc GCC_WPSS_RSCP_CLK>,
> +                 <&rpmhcc RPMH_CXO_CLK>;
> +        clock-names = "ahb_bdg", "ahb",
> +                      "rscp", "xo";
> +
> +        power-domains = <&rpmhpd SC7280_CX>,
> +                        <&rpmhpd SC7280_MX>;
> +        power-domain-names = "cx", "mx";
> +
> +        memory-region = <&wpss_mem>;
> +
> +        qcom,qmp = <&aoss_qmp>;
> +
> +        qcom,smem-states = <&wpss_smp2p_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +        resets = <&aoss_reset AOSS_CC_WCSS_RESTART>,
> +                 <&pdc_reset PDC_WPSS_SYNC_RESET>;
> +        reset-names = "restart", "pdc_sync";
> +
> +        qcom,halt-regs = <&tcsr_mutex 0x37000>;
> +
> +        status = "disabled";

status can be left out of examples.

> +
> +        glink-edge {
> +            interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
> +                                         IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                         IRQ_TYPE_EDGE_RISING>;
> +            mboxes = <&ipcc IPCC_CLIENT_WPSS
> +                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +            label = "wpss";
> +            qcom,remote-pid = <13>;

There are a few properties here that don't seem to be required. Is that
intentional?
