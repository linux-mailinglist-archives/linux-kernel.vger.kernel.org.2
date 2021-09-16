Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C012040D9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhIPMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:23:27 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:35573 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbhIPMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:23:26 -0400
Received: by mail-io1-f44.google.com with SMTP id a15so7630397iot.2;
        Thu, 16 Sep 2021 05:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eBjsALulZMPTSCf3SKKox/6zb556B2h+vF/yLzDTuL0=;
        b=KKqXQsJG5zzUdX9Yh0Utma8D2xu6DDRaZ4+mkz9EGlrwChyAOTLN+2n6vwWrhs/mET
         D7g1rYB9Y6mdvglGbivLgx/XQROn4NJfvBXYfKtyjUVi36/f12Tb3Lt4ZmJ+QUrdfio+
         s9SrWARAxKlWrfoTUN5+1qsaeHufLOaWeES8utwBq5Cgz/pr5kFV4fpvyRK5yr+JOsmq
         GbZa/gWz2+X1jRPQBI2qke04GaL6KAIirLKsQaQAgonZ+5b6H6DwjFA8JHkZ2Hr32HAg
         EhpYyohvbxxyKiS5JcBmrpKB/eR1+0fcH7piLUaD3MIMpNvYCdBeePBJZnqYO4eavrvY
         fRVA==
X-Gm-Message-State: AOAM533oQEojpm3qfc+N/WDi3NQWO9nugq4uKX65aUE5sMpU/ClYtTSn
        fQTv2A2VHTIyMkn4R/iXwQ==
X-Google-Smtp-Source: ABdhPJybW8Pfcs+9FTVdwooVbW86PI0JLe53MZTM9I99F070ENPtsjWaVlV5cuzQy4jxtSJmwL8xCA==
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr4215684iov.62.1631794925414;
        Thu, 16 Sep 2021 05:22:05 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id d12sm1564858iow.16.2021.09.16.05.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:22:03 -0700 (PDT)
Received: (nullmailer pid 1119424 invoked by uid 1000);
        Thu, 16 Sep 2021 12:21:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     linux-arm-kernel@lists.infradead.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-aspeed@lists.ozlabs.org,
        yulei.sh@bytedance.com, joel@jms.id.au, osk@google.com,
        devicetree@vger.kernel.org
In-Reply-To: <20210916092515.10553-2-chiawei_wang@aspeedtech.com>
References: <20210916092515.10553-1-chiawei_wang@aspeedtech.com> <20210916092515.10553-2-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML schema
Date:   Thu, 16 Sep 2021 07:21:53 -0500
Message-Id: <1631794913.526068.1119423.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 17:25:12 +0800, Chia-Wei Wang wrote:
> Convert the bindings of Aspeed LPC from text file into YAML schema.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 187 ++++++++++++++++++
>  2 files changed, 187 insertions(+), 157 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0: /example-0/lpc@1e789000/lpc-snoop@90: failed to match any schema with compatible: ['aspeed,ast2600-lpc-snoop']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1528736

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

