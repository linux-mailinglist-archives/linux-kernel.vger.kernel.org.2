Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA26331508
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCHRkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:40:09 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:43893 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCHRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:39:42 -0500
Received: by mail-il1-f170.google.com with SMTP id b5so9562824ilq.10;
        Mon, 08 Mar 2021 09:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXeAbHF8pPCPQWCntGIxTCg+74rzVYJuqIJTeDRa+MI=;
        b=ngn9nruYksLMa23SlZjGKsJqJB2krnnBjUiC8F73krqb/7IVfDdL2uGVRFniLsEvXt
         bHb63mc4Ea1UZLGloaOM2A3Zt0UIA9YwnFTBVLauf5Fo9ozlvy8MqCLV5w3IKfs4G52/
         9V+6slEM8ggD06fVqXQD19XS0nsx8DSlfSpSpilsbUjXggJUXYxRskfL+FxrsxgbGGly
         U0DWS9ex5vITf2Cwa6hoBBM5wEKurtAP3NFeJSM88DPU7G72WqVSmvzAWMcIF8STKhFu
         T/XqM+Cd86qHjaw00CQXfjRB41owWo+21ie/hCIEB6cvW173OOOgerPpnR+YK6p/uKAw
         kw1w==
X-Gm-Message-State: AOAM533EuAEE/TSGxatijhHpK6W76Ri6DsomRTykuH+erXHEoG4yAf6I
        Cil5+I4432o9UiklN5n59Q==
X-Google-Smtp-Source: ABdhPJyONBbB2UWDo9YvwIJ8BiC6HqYRGxn2J7vNITtIOWfsn6OuxyjakNVexLI5oJvWTIR5PuNsgg==
X-Received: by 2002:a92:c24b:: with SMTP id k11mr20967126ilo.276.1615225181488;
        Mon, 08 Mar 2021 09:39:41 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l1sm3675201ioj.52.2021.03.08.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:39:40 -0800 (PST)
Received: (nullmailer pid 2679767 invoked by uid 1000);
        Mon, 08 Mar 2021 17:39:38 -0000
Date:   Mon, 8 Mar 2021 10:39:38 -0700
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 05/15] dt_bindings: mfd: Add ROHM BD71815 PMIC
Message-ID: <20210308173938.GA2679675@robh.at.kernel.org>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
 <790da5fe60eb3bcd190830770866147bbb5f8143.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790da5fe60eb3bcd190830770866147bbb5f8143.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021 12:40:50 +0200, Matti Vaittinen wrote:
> Document DT bindings for ROHM BD71815.
> 
> BD71815 is a single-chip power management IC mainly for battery-powered
> portable devices. The IC integrates 5 bucks, 7 LDOs, a boost driver for
> LED, a battery charger with a Coulomb counter, a real-time clock, a 32kHz
> clock and two general-purpose outputs although only one is documented by
> the data-sheet.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/rohm,bd71815-pmic.yaml       | 201 ++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/regulator/rohm,bd71815-regulator.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/regulator/rohm,bd71815-regulator.yaml'
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.example.dt.yaml] Error 255
make[1]: *** Deleting file 'Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.example.dt.yaml'
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1448970

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
