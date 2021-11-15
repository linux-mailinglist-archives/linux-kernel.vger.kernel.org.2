Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B201A452847
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349744AbhKPDNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbhKPDMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:12:49 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863FCC079789
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:41:38 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so30305088otj.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=i2SNPRq3pLKtwSNGCAzk+IUcH/Vb3+yYVDf0j3H0K+0=;
        b=mtZZGO4oP1PYAw3s3wv6aw5HRKl8k3hgNW+PQgfljpI1uZ7pU5leGxruNQnn2yiOWK
         Wd83MZ7tXvR2UcrJ9HgImIS4uy7wwJO8TpEGagjQXZruPiVfcnIwvjxApg9eb5GZRx4A
         QsWVwNKNtrG9ZEWrsBPGOiUi/xkmuGjOKbQ40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=i2SNPRq3pLKtwSNGCAzk+IUcH/Vb3+yYVDf0j3H0K+0=;
        b=byvXPKNF1jNxFb2bnY2gPjbBBF6/uNepkTY+ahUW0HgOOM+G7hwc94eyJ+iIdC1GTs
         puQsAbmYP4+TN4N2NiEbd+6+fOrR7JP5ZkGBU8yUeTmMfGuUMxwWMIkZLi2I7PZTZvby
         xrnXcLokm0pDOtQqvnX2XnVGK9NXi+sSLoxzmAWVfdrrtrrIICLUkH+4A66BLRB2sTfg
         JkMlsMn3t1vnXVrKmnd/EcSlmGYsXzt7a6gSkJw0qK7alBtRChu1y9+kQFRpc3e0M3Z9
         wXlGY1yGCXKLPuQf5shXGpFlifXlYdCA1pcdXlhouZxZMfhcOT305xfu1xdHOSUdZF+Q
         5qyg==
X-Gm-Message-State: AOAM531REaDphTSiGBi6ntCTGhpUMwsJDG0yl9g4PePq2V29E5GR4t95
        zABI7KR09vZ0jA9icOfZGF8Yl+o87oPB7FuY1C5Nwg==
X-Google-Smtp-Source: ABdhPJyAK5DnGIrjLnccwyQNRehg9V4oQSI/ME20O57PnslENVbYODuBGkNt8nPUL1v6F64p1gdekCaV5kIZ173HdZ4=
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr2393306otj.77.1637019697920;
 Mon, 15 Nov 2021 15:41:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Nov 2021 15:41:37 -0800
MIME-Version: 1.0
In-Reply-To: <1635860673-12146-3-git-send-email-pillair@codeaurora.org>
References: <1635860673-12146-1-git-send-email-pillair@codeaurora.org> <1635860673-12146-3-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 15 Nov 2021 15:41:37 -0800
Message-ID: <CAE-0n51uTT0KdCdsefTC-z-0bSSST53WKOz98q-YMZyt-6p1og@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
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

Quoting Rakesh Pillai (2021-11-02 06:44:32)
> Add WPSS PIL loading support for SC7280 SoCs.
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---

One question

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>  .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  | 217 +++++++++++++++++++++
>  1 file changed, 217 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> new file mode 100644
> index 0000000..eaf7dd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> @@ -0,0 +1,217 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-wpss-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC7280 WPSS Peripheral Image Loader
> +
> +maintainers:
[...]
> +
> +  glink-edge:
> +    type: object
> +    description: |
> +      Qualcomm G-Link subnode which represents communication edge, channels
> +      and devices related to the ADSP.
> +
> +    properties:
> +      interrupts:
> +        items:
> +          - description: IRQ from WPSS to GLINK
> +
> +      mboxes:
> +        items:
> +          - description: Mailbox for communication between APPS and WPSS
> +
> +      label:
> +        description: The names of the state bits used for SMP2P output
> +        items:
> +          - const: wpss
> +
> +      qcom,remote-pid:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: ID of the shared memory used by GLINK for communication with WPSS
> +        maxItems: 1
> +
> +    required:
> +      - interrupts
> +      - mboxes
> +      - label
> +      - qcom,remote-pid

Add additionalProperties: false here too?
