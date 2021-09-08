Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E6403905
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351543AbhIHLmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:42:22 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:35607 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhIHLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:42:21 -0400
Received: by mail-oo1-f45.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so671168oon.2;
        Wed, 08 Sep 2021 04:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=erJIH1VnYLWtGRKdJRpE5M1/fXJwDp9ceva/bebj1Fk=;
        b=BCJwqAEVmARfay/VCcFCxqo5xXkwnsyYBhAvH+4yXkHtUkkL6qphzZt+INFn9W8rp6
         wiK5FzBvgUExH1Rgn3F+5p497QfNtuGaW1QyQ4as74pNQmO7oJBZd7veoaDHuxvoURaj
         +8hQsQ0TZ98mpUNVIMwF9YoW2yC6wmvRwcsbqmfYpqQiHXdm2n9Y3Ti3S3/IozujUiG3
         95fvW+IVu0LLr+hX+120AtI4sL4AXnuNc6flTGi1vEXx0k5V0p+bfswBrahas6qbCD9u
         X8hS2iUNLSU0Ux0Xs6SGhPH+WhnKwe8skhTgB5OIrTek+c2IV8+DMYGjvgrpOnfQMmZB
         k5lw==
X-Gm-Message-State: AOAM530v3fsGZznWO0TBsJEolpSmztMLhZM3YhNLqtCsAdIInTSswJdn
        Yhu6Hvw0myYSDWN+iUNkOg==
X-Google-Smtp-Source: ABdhPJw5bqv0LPB2yVc0Z6BhoWJRI+LpAkn9SRXecjKrBUTGRFpyYhtgTssW7F1kA4Wzn9mrvApYZA==
X-Received: by 2002:a4a:ca83:: with SMTP id x3mr2432630ooq.2.1631101273136;
        Wed, 08 Sep 2021 04:41:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m20sm397019oiw.46.2021.09.08.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:41:12 -0700 (PDT)
Received: (nullmailer pid 1816057 invoked by uid 1000);
        Wed, 08 Sep 2021 11:41:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908082350.106948-2-claudiu.beznea@microchip.com>
References: <20210908082350.106948-1-claudiu.beznea@microchip.com> <20210908082350.106948-2-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: microchip,eic: add bindings
Date:   Wed, 08 Sep 2021 06:41:11 -0500
Message-Id: <1631101271.425453.1816056.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 11:23:49 +0300, Claudiu Beznea wrote:
> Add DT bindings for Microchip External Interrupt Controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../interrupt-controller/microchip,eic.yaml   | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.example.dt.yaml: interrupt-controller@e1628000: #interrupt-cells:0:0: 2 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1525680

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

