Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C941C36430B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbhDSNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:13:52 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34731 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbhDSNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:11:36 -0400
Received: by mail-ot1-f47.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so32487293otn.1;
        Mon, 19 Apr 2021 06:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bUOnAN9m9JsNWQhRgesz+7tvMCC84BONiT/82qQ3gaw=;
        b=af8qF+ug8A0Mmr4Z8kQDauTmskpAja/c0xfOpZWkc1mbN6VjI+4kzxFsgnJyi7mbgN
         2q58lS8JdSc+rfsG1264ihRvtS84IM+H/dag/RPZrdajbrzsqSHWGGE41ZYVEZINpx5W
         PypnfSVLeit9yjU/G5XbhFiCHClaaKpcuG0YD+Jpe4q3IrDyAviUjrEJ1dLnEXxscxac
         hc+4u1vNnRN6FgqZVwMISbhnBw1Dh49d1zekIkIyoDAV4mQsY65zF+mbz+XT0ku+/7aP
         S3LQCKH3AieYk5p3bSffsXzt8uriampx3VNvuXniXjb80VMeqnbUFEvPgSS+FHVH23hq
         KLNQ==
X-Gm-Message-State: AOAM530sIz8hqcgmyuej6xYhS5mzTPtA7s5vgDrleJPpC4k1/7XLW98T
        qrry6yRSfQJTCrgOzFfzQQ==
X-Google-Smtp-Source: ABdhPJyapjCa0fKnnqCAnOdhUBGTP9VwWD+Dv/EJDnnLHQJ3NH0YdFo0HuJK4aAn0PgiE2ymjj5IXQ==
X-Received: by 2002:a9d:6056:: with SMTP id v22mr8249688otj.231.1618837866868;
        Mon, 19 Apr 2021 06:11:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u126sm3165595oig.4.2021.04.19.06.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 06:11:05 -0700 (PDT)
Received: (nullmailer pid 1055971 invoked by uid 1000);
        Mon, 19 Apr 2021 13:11:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     kernel@pengutronix.de, robh+dt@kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        alistair23@gmail.com
In-Reply-To: <20210418210222.2945-1-alistair@alistair23.me>
References: <20210418210222.2945-1-alistair@alistair23.me>
Subject: Re: [PATCH v5 1/5] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Mon, 19 Apr 2021 08:11:03 -0500
Message-Id: <1618837863.719734.1055970.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 07:02:18 +1000, Alistair Francis wrote:
> Initial support for the Silergy SY7636A Power Management chip
> and regulator.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
> v5:
>  - Improve the documentation
> 
>  .../bindings/mfd/silergy,sy7636a.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml: properties:regulators:properties:$ref: '/schemas/regulator/regulator.yaml#' is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml: properties:regulators:properties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for '$ref'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml: properties:regulators:properties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for 'additionalProperties'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml: ignoring, error in schema: properties: regulators: properties: $ref
warning: no schema found in file: ./Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
Documentation/devicetree/bindings/mfd/silergy,sy7636a.example.dt.yaml:0:0: /example-0/i2c/pmic@62: failed to match any schema with compatible: ['silergy,sy7636a']
Documentation/devicetree/bindings/mfd/silergy,sy7636a.example.dt.yaml:0:0: /example-0/i2c/pmic@62/regulators: failed to match any schema with compatible: ['silergy,sy7636a-regulator']

See https://patchwork.ozlabs.org/patch/1467830

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

