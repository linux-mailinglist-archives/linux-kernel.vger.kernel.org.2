Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD73379B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCKQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:41:57 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:39299 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhCKQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:41:29 -0500
Received: by mail-io1-f47.google.com with SMTP id o9so22605481iow.6;
        Thu, 11 Mar 2021 08:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=i8xfhIr1HLKCJnIosV9G52CMLBMofdfXZRG6SJhuaFY=;
        b=josqOmYTSXLSDDlAA6E2mKOdVSKII9KD6Ut3KHln+uf+c70AlwxPxXQotLn8k/TG8U
         kGEWJXjZmZGOikXno+5Ce4rRsRsy7yXHJ6WxQ5AXDhOrH0Lm0lek2ze+4hVItBQrJdj+
         zfBcjGR6Sz/GhcdTkuVzYd1zEBcc3x92uK7DgGSDF9GeOcRXMyJCzCXPq8YIOyI7MQbe
         g6OH+WeG5TmXxhC4fyASbsECwKLAIWExKzDjyxWMgTaMXt/jAEzLbPvBdc0HLXkdVgiK
         ZZ7ilmsyw4bVq9MbS1qYZOC2y6FrwipBGfHmMlggCWuHL7JBk/cqLiI1B24k8ZZdPRfG
         e87A==
X-Gm-Message-State: AOAM5323LNXzbGQ0FBNZR7Lw56l2CogzYzLPovbojmkodo1eqZ7FzI2L
        0S1A3Z5qO+sSehjiEN9W1w==
X-Google-Smtp-Source: ABdhPJyrqwtFe/6yLzfUrLFLJXu5wGkfX/qCwYmYeFMxYMOiwqsjWEhjvtr5J7/dDyzmgV5dkXd+qg==
X-Received: by 2002:a5e:980e:: with SMTP id s14mr7151701ioj.63.1615480888727;
        Thu, 11 Mar 2021 08:41:28 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x2sm1497206ilj.31.2021.03.11.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:41:27 -0800 (PST)
Received: (nullmailer pid 841931 invoked by uid 1000);
        Thu, 11 Mar 2021 16:41:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
In-Reply-To: <20210311051309.16789-2-ansuelsmth@gmail.com>
References: <20210311051309.16789-1-ansuelsmth@gmail.com> <20210311051309.16789-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: Document use of nvmem-cells compatible
Date:   Thu, 11 Mar 2021 09:41:02 -0700
Message-Id: <1615480862.520618.841930.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 06:12:48 +0100, Ansuel Smith wrote:
> Document nvmem-cells compatible used to treat mtd partitions as a
> nvmem provider.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.example.dt.yaml: art@1200000: $nodename:0: 'art@1200000' does not match '^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.example.dt.yaml: calibration@f00000: $nodename:0: 'calibration@f00000' does not match '^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

See https://patchwork.ozlabs.org/patch/1451109

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

