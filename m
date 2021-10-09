Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2E427CE1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJISzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhJISzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:55:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78354C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:53:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b20so54282738lfv.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LnzLFAk3139Iv7hHI1W57hPa7Zv+3a8hcq1wSnPhYrk=;
        b=CL7I53VNh1nhDl/zUWjM+50sQLL7XCqK2njpQSIAXKUypLtXf97HmeL5Fe1IpjjItw
         Hy8xuYsieNHfb2ScocmQxAeD8ZIU+lfY21DYlVqhwt5eyOb9hOBPcJzTSGRjFQG7v8YG
         rLMrMcJVET1gbE0+rEz+q3rN3cti9k6bTvEGih/attOM5im4nTJhgy5o1JD1DMW4Ial7
         8Oz2wWl5qPV8FL5NyX5okr4aKTfXLHQjBJkqZUenIFJgUSaFluMoVNdCJ837zpFHKFfI
         D1lNNZZFt1gASWvXWLLEtDwMezXMU/v48nE5+B91l/OE4WWJWTkiJsDeROFYpYb+sOfE
         2LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LnzLFAk3139Iv7hHI1W57hPa7Zv+3a8hcq1wSnPhYrk=;
        b=A6YnPcNq+MQvYq3g7/aojg5pPytTLdtEVCO8seObL4c5e4ZBaSyJED11bwQjAXrcV7
         3aIY9IMEyug+90A7Ei1E6lsz0WN0yl6NhF5h9BWd89WWAmOulz7g3hg8ssRvVf3vQYLx
         4ElYhoSru0NfMQjWO2Q5LXUIMOe6iXwwLJtNG3rxWm+4dJhCkdlMVK3JMWmpcTXyZszM
         y5nj99joeoz6k535ED+5+QZ60qHJ8oBFKQNNCDEKv1tRji9Hu2HmyNEsbMTYXrMRsORa
         9CuIF8uDXQtUK+2cVVDOzQDEljmj299nFk8niE8Sh6looJLvljNI/7a37aIhV8oRCscZ
         bLeA==
X-Gm-Message-State: AOAM531lp2wuCl9A/ucfqQmnyVsoYpGTUqNSFfCDveck1Dj6wj09prU0
        mayK+UKpQZAQvON8gkIlki7bGxyMdh1NrUlmUOACOQ==
X-Google-Smtp-Source: ABdhPJwXTBVkZV32W0aAjwn7T0xQsjwTWXDvAAwMAuwgDOqbqrwklVmo5pC6t/5D4NNkinmPBBApEcTl4Fcc1JS9EZ0=
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr11388371lji.253.1633805615304;
 Sat, 09 Oct 2021 11:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211009185257.2230013-1-osk@google.com>
In-Reply-To: <20211009185257.2230013-1-osk@google.com>
From:   Oskar Senft <osk@google.com>
Date:   Sat, 9 Oct 2021 14:53:18 -0400
Message-ID: <CABoTLcRn6LY1td6S0y2p7bMJmAE=RE-bJTgfX9F4yzwf=jbLTQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since "PATCH v4 1/2" as requested in the review:
- Renamed "signal" to "channel"

On Sat, Oct 9, 2021 at 2:53 PM Oskar Senft <osk@google.com> wrote:
>
> This change documents the device tree bindings for the Nuvoton
> NCT7802Y driver.
>
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
>
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> new file mode 100644
> index 000000000000..ff99f40034f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT7802Y Hardware Monitoring IC
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  The NCT7802Y is a hardware monitor IC which supports one on-die and up to
> +  5 remote temperature sensors with SMBus interface.
> +
> +  Datasheets:
> +    https://www.nuvoton.com/export/resource-files/Nuvoton_NCT7802Y_Datasheet_V12.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7802
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  channel@0:
> +    type: object
> +    description: Local Temperature Sensor ("LTD")
> +    properties:
> +      reg:
> +        const: 0
> +    required:
> +      - reg
> +
> +  channel@1:
> +    type: object
> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD1")
> +    properties:
> +      reg:
> +        const: 1
> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage
> +      temperature-mode:
> +        items:
> +          - enum:
> +              - thermistor
> +              - thermal-diode
> +    required:
> +      - reg
> +      - sensor-type
> +
> +  channel@2:
> +    type: object
> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD2")
> +    properties:
> +      reg:
> +        const: 2
> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage
> +      temperature-mode:
> +        items:
> +          - enum:
> +              - thermistor
> +              - thermal-diode
> +    required:
> +      - reg
> +      - sensor-type
> +
> +  channel@3:
> +    type: object
> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD3")
> +    properties:
> +      reg:
> +        const: 3
> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage
> +    required:
> +      - reg
> +      - sensor-type
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nct7802@28 {
> +            compatible = "nuvoton,nct7802";
> +            reg = <0x28>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 { /* LTD */
> +              reg = <0>;
> +              status = "okay";
> +            };
> +
> +            channel@1 { /* RTD1 */
> +              reg = <1>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +              temperature-mode = "thermistor";
> +            };
> +
> +            channel@2 { /* RTD2 */
> +              reg = <2>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +              temperature-mode = "thermal-diode";
> +            };
> +
> +            channel@3 { /* RTD3 */
> +              reg = <3>;
> +              status = "okay";
> +              sensor-type = "voltage";
> +            };
> +        };
> +    };
> --
> 2.33.0.882.g93a45727a2-goog
>
