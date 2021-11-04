Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C54456F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhKDQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:15:36 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41896 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKDQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:15:34 -0400
Received: by mail-oi1-f171.google.com with SMTP id l15so10012294oie.8;
        Thu, 04 Nov 2021 09:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=F8S7posVfJa10aMcTqnPvT5yLO9Zkvy1OBcQITEzqpY=;
        b=Ae+jxVRaqGcoTydkKokAlHiCu4FmwPf+wiNZxhn0X+mlmBicTxTXs3Wcha8Au/7vqo
         GavonZXqGlF39QP91rDVS4ITzegkQ9ACrA+YARafYMDOc+OfYNTl1Kjkt24bbAcuDacz
         WELkxjtiFucvvMB+xbnyQMRiklzj82Yq4zfymut5HNq6FmfFvLptB9xxFNxiRA7wSoqn
         pPjAUil+0Y+w/RoSmEOz2vFlGNgm5RjS/218NTx1IJJyL5zYY5HBsvxQeT4Qdl73hs4f
         YHHKWRKBaRcXmhMMRDh8t6Aq2P/Q3iMNfzc3zm92gQsbEWu1EDM4quogidt3VGFlyV5G
         tSVQ==
X-Gm-Message-State: AOAM533NT9eWRd6D4fot84YNhC9eSMr4gV9SkxGzGB9O97v4vLq7WN84
        9ZPSkU/Vki10kGmR8AxKB83G0Xg4yw==
X-Google-Smtp-Source: ABdhPJwqUVX+YeETjwLQl3NQ7K+px0unN5KE5rEKkmpNng5TJE6UFg/nAQ1maNMUHdZGGJPLMsa8Bg==
X-Received: by 2002:aca:210d:: with SMTP id 13mr1112566oiz.32.1636042375635;
        Thu, 04 Nov 2021 09:12:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c18sm1730840ots.64.2021.11.04.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:12:54 -0700 (PDT)
Received: (nullmailer pid 3458347 invoked by uid 1000);
        Thu, 04 Nov 2021 16:12:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Akash Gajjar <gajjar04akash@gmail.com>
Cc:     Liang Chen <cl@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, Levin Du <djw@t-chip.com.cn>,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Alex Bee <knaerzche@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20211104075234.8020-1-gajjar04akash@gmail.com>
References: <20211104075234.8020-1-gajjar04akash@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add rock pi s dts support
Date:   Thu, 04 Nov 2021 11:12:52 -0500
Message-Id: <1636042372.246110.3458346.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021 13:22:24 +0530, Akash Gajjar wrote:
> Rock pi s is RK3308 SBC from radxa. Rock pi s has a,
> - 256MB/512MB DDR3 RAM
> - micro sd, sd nand flash (optional on board 1/2/4/8Gb)
> - 100MB ethernet, PoE (optional)
> - onboard RTL8723DS 802.11 b/g/n wifi + Bluetooth 4.0 Module
> - 26-pin expansion header
> - USB2.0 Type-A HOST x1
> - USB Type-C DC 5V Power Supply
> - 2 LEDS, 2 Keys
> 
> This patch enables
> - console on UART-2
> - nand flash
> - sd card
> - 100Mbps ethernet
> - USB2.0
> 
> Signed-off-by: Akash Gajjar <gajjar04akash@gmail.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 208 ++++++++++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/rockchip.yaml:473:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/rockchip.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 850, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 731, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a plain scalar
  in "<unicode string>", line 472, column 22
found a tab character that violates indentation
  in "<unicode string>", line 473, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/arm/rockchip.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/rockchip.yaml:  while scanning a plain scalar
  in "<unicode string>", line 472, column 22
found a tab character that violates indentation
  in "<unicode string>", line 473, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/rockchip.yaml
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1550787

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

