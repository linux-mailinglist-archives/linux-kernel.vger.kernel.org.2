Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7F408AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhIMMUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:20:13 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33655 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhIMMUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:20:03 -0400
Received: by mail-ot1-f54.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso13029519otu.0;
        Mon, 13 Sep 2021 05:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QviKwU9E32B1NHqI9WCd3jJH00Se8iBU33oRL7KYCVI=;
        b=uD5aI70wKFIo5u3oCSNrT0ro8QIbw6yPaTbLeHsio9FOXxmsGQZsKRQ/mN0NTz/lXy
         FdJbEQRdh0qF3jzxHNQhh8EtbS/x904W5kktBUtTUL7NKoGbSG0q3skMg4AZGgGWhlux
         OjJ5OKghD50Kf1gAmW6FNsqtHIMf2IwZwxuKrabk9oLG1ifH5dJdAZnCbpp/H1tjYJew
         uEvzILNFfewpUbkzHrMdt98ruOZoW6mLvYNBlORb2vlooUOX8Vb/Ch4houls3WOsJ5s0
         1jihxcXBtb+cZX2O94PI1UiWYbyaIgLWA2CvIV0mJMRztZbC32rARufXH8hjD27f7QiA
         qsVQ==
X-Gm-Message-State: AOAM532JgVoT1mhFB1NEuW2Zin97ANrs/PHkAosTm1ccJJbIimlhMfos
        5pmC9WUQlutsHGFd/5F/zCb6DaJ8nw==
X-Google-Smtp-Source: ABdhPJzMsElTnZR96Stl0Jidt4vyTF4mY6gkVe/sRFOau/+qhl1NPc8J930JqDDSM8aDFfgq6rLrHQ==
X-Received: by 2002:a9d:7cd7:: with SMTP id r23mr9250801otn.165.1631535527526;
        Mon, 13 Sep 2021 05:18:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k8sm1791521oom.20.2021.09.13.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 05:18:46 -0700 (PDT)
Received: (nullmailer pid 444719 invoked by uid 1000);
        Mon, 13 Sep 2021 12:18:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     andrew@aj.id.au, linux-aspeed@lists.ozlabs.org, joel@jms.id.au,
        osk@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        yulei.sh@bytedance.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
In-Reply-To: <20210913060231.15619-2-chiawei_wang@aspeedtech.com>
References: <20210913060231.15619-1-chiawei_wang@aspeedtech.com> <20210913060231.15619-2-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML schema
Date:   Mon, 13 Sep 2021 07:18:43 -0500
Message-Id: <1631535523.196891.444718.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 14:02:28 +0800, Chia-Wei Wang wrote:
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
Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dts:30.35-36.15: Warning (unique_unit_address): /example-0/lpc@1e789000/lpc-ctrl@80: duplicate unit-address (also used in node /example-0/lpc@1e789000/lpc-snoop@80)
Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0: /example-0/lpc@1e789000/lpc-ctrl@80: failed to match any schema with compatible: ['aspeed,ast2600-lpc-ctrl']
Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0: /example-0/lpc@1e789000/reset-controller@98: failed to match any schema with compatible: ['aspeed,ast2600-lpc-reset']
Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0: /example-0/lpc@1e789000/lpc-snoop@80: failed to match any schema with compatible: ['aspeed,ast2600-lpc-snoop']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1527193

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

