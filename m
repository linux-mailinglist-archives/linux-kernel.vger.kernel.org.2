Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56547332D16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCIRT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:19:28 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:41867 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhCIRTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:19:19 -0500
Received: by mail-il1-f177.google.com with SMTP id c10so12856193ilo.8;
        Tue, 09 Mar 2021 09:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JsaLqg+Y+wZKqqo4vFt6KIoJc4yVnjqgApdeWlQB3eg=;
        b=X9hL/Z035Ab6q0as15S4FW9/ssLwHLff6MVDNqRAPUFqYOkvbCXyKMQFY/OZMJ+wvw
         nodiq8UoxYwJkZEddLS+lG+WmfO0AEwYeWL2K92NyUJgSZdT9c2ECZYebJJWtRfiPRG1
         //i8XLZqk8rbHxj/Iy/Xd8AB7F12WJPZ39LN89fMJH0MzvGpaz34R2oEB3jbKhqQoBCS
         mG8ngAqHwGE3bauaoho4Q3msftLsA7pb5ihhu+oM5FJWvI5NOsZbUzODXsVV7hJYuR9s
         ooPIcMZr3B/Mz06ICrfFf/sh1WMwAiArZJMzOsYElkG9HdwuG3DN2BjcKbCtNgLJ4G8K
         a2gA==
X-Gm-Message-State: AOAM533S7PfNcifsr5wdfF9/2tb43sbcus3Nyz1PJ94ZhLJDLexA2Lq8
        iqe6guuD7cc1Z5PisipqKw==
X-Google-Smtp-Source: ABdhPJwn+5EIhFQnFbb9g58ohLGO2gRFJG9Jfjgso1gkrRdgI1TduaMeMt6PrbW35OnRaWGFUaYw4A==
X-Received: by 2002:a05:6e02:12a1:: with SMTP id f1mr24653652ilr.124.1615310358499;
        Tue, 09 Mar 2021 09:19:18 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e4sm7917359ilc.47.2021.03.09.09.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:19:17 -0800 (PST)
Received: (nullmailer pid 485086 invoked by uid 1000);
        Tue, 09 Mar 2021 17:19:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     sanyog.r.kale@intel.com, vkoul@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, yung-chuan.liao@linux.intel.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        pierre-louis.bossart@linux.intel.com
In-Reply-To: <20210309141514.24744-5-srinivas.kandagatla@linaro.org>
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org> <20210309141514.24744-5-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 4/5] ASoC: dt-bindings: wsa881x: add bindings for port mapping
Date:   Tue, 09 Mar 2021 10:19:11 -0700
Message-Id: <1615310351.627443.485085.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021 14:15:13 +0000, Srinivas Kandagatla wrote:
> WSA881x SoundWire device ports are statically assigned to master ports
> at design time. So add bindings required to specify these mappings!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,wsa881x.yaml          | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wsa881x.example.dt.yaml: speaker@0,1: 'qcom-port-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wsa881x.example.dt.yaml: speaker@0,2: 'qcom-port-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml

See https://patchwork.ozlabs.org/patch/1449860

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

