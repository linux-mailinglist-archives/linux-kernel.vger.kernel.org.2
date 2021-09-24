Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86C3417DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbhIXWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:25:16 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:35356 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhIXWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:25:15 -0400
Received: by mail-ot1-f49.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so15181780otj.2;
        Fri, 24 Sep 2021 15:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=j2rtMidCAug7xpeRMw9/4suWLbeKlpbgZwjadAo6pJk=;
        b=C8tz7BGVHyGyyWeeeN9mBU7J5wucj6BOm3T7933wRHrgE4Q7CzduwWRCoPZgrGxFTh
         1j0FY+fmJtskz0HaxXlwjfRT4Z1wSVB9YKCTe/KIY6hma7dtTGHV6O7e1ORkK6WnSfFZ
         tQsXEnp1NsAP+5alQ2fpqzpXtFnen4HNHXfref5sdpAwp5PLcIq8EYrjk0J55fT0BjHV
         f2BoCvoIgNchNgvPLyven9C7YAbtIKOFd38wOOzoL20fYYjD4aUNIdAoOGVg+STDuXyj
         CMc9x76FR2wdVQo9zonw9LN2AeIAfIZNXO8q/1XJLJ3cgVHZVEoK3uRbqDDWrsx6kFDU
         kfsQ==
X-Gm-Message-State: AOAM533Y0IlVuBP5S9vtfH6Z+R5ZxvOutcNxtgD7a3Tmh2gC34rpzTNC
        RhVxIuVzVHUGZM1eGTpFB3rQ9wg0jw==
X-Google-Smtp-Source: ABdhPJwkjSEzQGHv/we+9CfyNCrWQWM1+g/njQk7Zpx0a5d+0eQpiqWKOwBOqQrlutSiJDbmMlbo8Q==
X-Received: by 2002:a05:6830:314d:: with SMTP id c13mr6092733ots.90.1632522221479;
        Fri, 24 Sep 2021 15:23:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v1sm2597204ots.46.2021.09.24.15.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 15:23:40 -0700 (PDT)
Received: (nullmailer pid 1942266 invoked by uid 1000);
        Fri, 24 Sep 2021 22:23:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org
In-Reply-To: <20210924163458.2135247-2-claudiu.beznea@microchip.com>
References: <20210924163458.2135247-1-claudiu.beznea@microchip.com> <20210924163458.2135247-2-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: microchip,eic: add bindings
Date:   Fri, 24 Sep 2021 17:23:39 -0500
Message-Id: <1632522220.005874.1942265.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 19:34:57 +0300, Claudiu Beznea wrote:
> Add DT bindings for Microchip External Interrupt Controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
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

See https://patchwork.ozlabs.org/patch/1532355

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

