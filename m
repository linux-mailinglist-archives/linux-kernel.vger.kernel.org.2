Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77961402805
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbhIGLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:50:19 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40463 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIGLuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:50:14 -0400
Received: by mail-ot1-f54.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso12380987oth.7;
        Tue, 07 Sep 2021 04:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8749oNI+t3oxaJjdYlorDSNDCitAkoaehr9gkop6Gdo=;
        b=LOWLp5uZLtK+WkmzBsQNnHXU7ZJcJG62SWO9q9B/9YcLgIgwA2fcOn88mzSBCeNzRy
         3jxGMsQ42AlVWBVpA9A9VFLMO70QnQ7QLKDDTE6PZJVz0qg5cdr/FfmPYuC0mF+F/0Vq
         LaPXri8lTT+/fKGeeygPobp7swCFNXlBtjttJ51/ztSknrkV0JBtgevSECC5BIHPhD1q
         B6NBExkfScO+WEF8GygH6YGs7KotGKs7F4eqyzySLJ0qYP5PA/5vxzvbTfVqIbxM5WwK
         4rTlw+0fnjZK+J92TQDPEkqpO+TMWOp8MRmFUqWD6sr0IwaK4NijBcnSp37TYEhR+J7i
         JYqg==
X-Gm-Message-State: AOAM533HrbhtIg7OOY15+ALxEYfb/rpIX24JKnjZ5vQUp8aiRxJvwAA6
        W6AwPeFrlD5H1fPhW4RRLSnKlgnJ0Q==
X-Google-Smtp-Source: ABdhPJzI8KS5tP7xX2DU403V2jHx15L00fx4MQQfgtR6q6C3De4596nsagKTEyYFbp1EFLg/nWAeSw==
X-Received: by 2002:a9d:5787:: with SMTP id q7mr14178594oth.353.1631015347598;
        Tue, 07 Sep 2021 04:49:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l21sm2192416oop.22.2021.09.07.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:49:06 -0700 (PDT)
Received: (nullmailer pid 3599960 invoked by uid 1000);
        Tue, 07 Sep 2021 11:49:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     shruthi.sanil@intel.com
Cc:     tglx@linutronix.de, andriy.shevchenko@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, srikanth.thokala@intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210906183621.21075-2-shruthi.sanil@intel.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com> <20210906183621.21075-2-shruthi.sanil@intel.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
Date:   Tue, 07 Sep 2021 06:49:05 -0500
Message-Id: <1631015345.791897.3599959.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2021 00:06:20 +0530, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which can be used as
> clocksource and clockevent device in the Intel Keem Bay SoC.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> ---
>  .../bindings/timer/intel,keembay-timer.yaml   | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/timer/intel,keembay-timer.example.dt.yaml:0:0: /example-0/soc/gpt@20331000: failed to match any schema with compatible: ['intel,keembay-gpt-creg', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1525030

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

