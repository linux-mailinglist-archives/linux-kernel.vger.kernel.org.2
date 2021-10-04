Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C008421681
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhJDScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhJDScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:32:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91AEC061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:30:17 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x124so22790420oix.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=uCLhCIedrLItIW/fIfQqIROcIoOGMNaU28b9WsBMQnI=;
        b=P6zsoL37SUGXaq+jlFKw64cq/gWi8DvYuFwDk7R/ncTC7gIPttZrqFNxbIRwzBNhr6
         +Hl2duvFMKp+P7YDAvnH6BQvwbL6mXtoVK/ouAC5FZ9ctWYaECxF+t3inL5aMlosIDL6
         EsZIbQyPHZZQNirMUwPuEQRxA5IKRGFyosR3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=uCLhCIedrLItIW/fIfQqIROcIoOGMNaU28b9WsBMQnI=;
        b=Pzh+gwj9I5+0OhmsSsGXOQAVoErc2x6pRVcrAkgJJNXNz0ESDcq1FwaNFB1KUsI/oX
         HpkV/T+xY45I3o6/JeS+BnkLFZnrN1YXbtQjw2WLEqlsm40zUtunvksrIsuMUDDdRGqV
         jmqDAVvyOoi5+Pj4i4XRMQCYS1tRlrurVEHFUQT5sEjLNF8kceWOBiJ2oQjteN04DxvD
         chUfBgEjQPiH6wEZxSLRMKl4QjJNOl29GuLgHkA1rn8joYBWtFvk+t2TDIyzCGY6ayMB
         x9bXUtDiVsdogM3H+DZhVgmaMDwQcr8rSVDgKy20S3wroyVr6baDrD6L8+R0Y4LiHKzu
         Qkfw==
X-Gm-Message-State: AOAM533fkNDu/gBlI5jshBBpFxtyPVWlx4X7MW51jnSrEDfh1HumDkKo
        CphB8re8GrlWLERpynjmuTaEHcxJHCtVu3O1yKWz6RQdPeA=
X-Google-Smtp-Source: ABdhPJwMewBiHcj4UTVv/PT20GzfqwNCqVLYizMCffyKapvUT9VTsB2dEfJCzOign0BlblGRDjGR712uoYIlg7cG0mg=
X-Received: by 2002:aca:42d7:: with SMTP id p206mr14586908oia.32.1633372217132;
 Mon, 04 Oct 2021 11:30:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Oct 2021 14:30:16 -0400
MIME-Version: 1.0
In-Reply-To: <1633330133-29617-2-git-send-email-pillair@codeaurora.org>
References: <1633330133-29617-1-git-send-email-pillair@codeaurora.org> <1633330133-29617-2-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 4 Oct 2021 14:30:16 -0400
Message-ID: <CAE-0n50_Qtz4OfZ9og8BWUZRe8DYRPnoSkOSAHgzTd3bpA32cw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: remoteproc: qcom: adsp: Convert
 binding to YAML
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org,
        mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-10-03 23:48:51)
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
> new file mode 100644
> index 0000000..b698bb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
> @@ -0,0 +1,167 @@
[...]
> +
> +  qcom,smem-state-names:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The names of the state bits used for SMP2P output
> +    items:
> +      - const: stop
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - reset
> +  - reset-names
> +  - qcom,halt-regs
> +  - memory-region
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +    #include <dt-bindings/clock/qcom,turingcc-qcs404.h>
> +    remoteproc@b00000 {
> +        compatible = "qcom,qcs404-cdsp-pas";
> +        reg = <0x00b00000 0x4040>;
> +
> +        interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
> +                              <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                              <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                              <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                              <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog", "fatal", "ready",
> +                          "handover", "stop-ack";
> +
> +        clocks = <&xo_board>,
> +                 <&gcc GCC_CDSP_CFG_AHB_CLK>,
> +                 <&gcc GCC_CDSP_TBU_CLK>,
> +                 <&gcc GCC_BIMC_CDSP_CLK>,
> +                 <&turingcc TURING_WRAPPER_AON_CLK>,
> +                 <&turingcc TURING_Q6SS_AHBS_AON_CLK>,
> +                 <&turingcc TURING_Q6SS_AHBM_AON_CLK>,
> +                 <&turingcc TURING_Q6SS_Q6_AXIM_CLK>;
> +        clock-names = "xo",
> +                      "sway",
> +                      "tbu",
> +                      "bimc",
> +                      "ahb_aon",
> +                      "q6ss_slave",
> +                      "q6ss_master",
> +                      "q6_axim";
> +
> +        resets = <&gcc GCC_CDSP_RESTART>;
> +        reset-names = "restart";
> +
> +        qcom,halt-regs = <&tcsr 0x19004>;
> +
> +        memory-region = <&cdsp_fw_mem>;
> +
> +        qcom,smem-states = <&cdsp_smp2p_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +        glink-edge {

Where is glink-edge documented as a property?

> +            interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> +
> +            qcom,remote-pid = <5>;
> +            mboxes = <&apcs_glb 12>;
> +
> +            label = "cdsp";

It would be good to have these properties defined as well and maybe
include the common schema for a glink edge that way.

> +        };
> +    };
