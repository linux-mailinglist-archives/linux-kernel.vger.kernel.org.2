Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A603F88D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhHZN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:27:09 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43815 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbhHZN0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:26:50 -0400
Received: by mail-oi1-f172.google.com with SMTP id w19so4482378oik.10;
        Thu, 26 Aug 2021 06:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yGrmY0Wm9zImGOy/o3LCoKO0Ng/hLTcj4XnHAPE/eDs=;
        b=KhPZETYFGzQTe61EkA+RCR+EPRVfs9B/TQidWuqXLx37OYJ0CG1H/92NHDRueaQ3jI
         kZ1mhhDEcIlGUxBDlFzoahtBbjL0etth9W6ZLf+U0pROgmNdsgwEcbDZFrCRfb/omUwK
         rf6/CVncHnjUO+RWjlwhsdjCl9umS6gP9v6uRJNrS16LhMJWYKZ7z1rvkVF1vnUBeyuf
         JawvqaTHmtqxBxberOHVJzXg52rtEs+5DCufEGKPLJXv2Eolwgf9i2+ZoFbevrB/wYs3
         aQPPut0/wxLeO9bTfUU5R8K7izmVczVcAJNnh1b7ZobJnOGDZeDyNRXFpginE59IgosK
         Fsfw==
X-Gm-Message-State: AOAM530COZvRD4TjZPTlqk9yDqCl0MJOmJJXGrueZ9LFwj4nolYCpYUj
        hXqurRiwx47WqH70C7x2Ng==
X-Google-Smtp-Source: ABdhPJwolzkhSzZMufONuxtdvIMwlkvhTNBvyCc9Y5tP4vHtKhzTpiQyufCG5WCn30VqdDSpmGRVXg==
X-Received: by 2002:a05:6808:690:: with SMTP id k16mr2382166oig.152.1629984363205;
        Thu, 26 Aug 2021 06:26:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c24sm576169otf.71.2021.08.26.06.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:26:02 -0700 (PDT)
Received: (nullmailer pid 1033383 invoked by uid 1000);
        Thu, 26 Aug 2021 13:26:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org
In-Reply-To: <20210826061623.6352-2-chiawei_wang@aspeedtech.com>
References: <20210826061623.6352-1-chiawei_wang@aspeedtech.com> <20210826061623.6352-2-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: aspeed: Add eSPI controller
Date:   Thu, 26 Aug 2021 08:26:01 -0500
Message-Id: <1629984361.334223.1033382.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 14:16:20 +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed eSPI controller
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml  | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/aspeed/espi.example.dt.yaml: espi@1e6ee000: 'espi-ctrl@0', 'espi-mmbi@800' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/aspeed/espi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1520968

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

