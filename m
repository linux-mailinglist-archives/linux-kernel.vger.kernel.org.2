Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4A32363C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 04:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhBXDtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 22:49:55 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40994 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhBXDtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 22:49:46 -0500
Received: by mail-ot1-f44.google.com with SMTP id s107so892979otb.8;
        Tue, 23 Feb 2021 19:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Vj+GaDBHsdtJo8wsFzM49IM004p3o3LltrI7rg33ymk=;
        b=h2OmakugkkKJidwiMrQpASCRIk/3et2jQYmLhfcXDbi1Vm4P+0V/rglZ9x1XuhQ0pL
         wV4s/n4C6ixdzDSbDsJ0uS3ng2E8D61h2uEOUfjrjCDIloYOSyEPSMqU11ckZ6HYa/hj
         YnZ88tjptGgm0TvveTAB7HaWtssHz+XDmEpqInQl2pbZLpDxegK/uIt0JVgVWZ919ksu
         HqPegzAWrxuhFXT4U+tQ2XmEjawmRDB01SYttu4zvG1JCmNjf1XWErYUSQ+UU11bd6l9
         Z0c3HtBP5oJ7w3Xk3vJMLLozvWm53yJe5RNrwBEZrKcvvI03R+CwAnDzDfGUg97WPQzQ
         cGBw==
X-Gm-Message-State: AOAM533WdOgcI/zCUpYx627BKwDyqpcbRBaaqNEO4w4zAlcLk8CBeb6A
        lEW1pyjr0gcflscoNxDqgA==
X-Google-Smtp-Source: ABdhPJzRQi+Pm9K3uybCnSzlInlPtQVeNYzmm8dCH+tCrWr5x3gTbhHM86QGMzaTXuCQjW5ugJlYSg==
X-Received: by 2002:a05:6830:3152:: with SMTP id c18mr22963284ots.191.1614138545586;
        Tue, 23 Feb 2021 19:49:05 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f19sm170665oiw.38.2021.02.23.19.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 19:49:04 -0800 (PST)
Received: (nullmailer pid 735526 invoked by uid 1000);
        Wed, 24 Feb 2021 03:49:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org
In-Reply-To: <20210224023116.571718-4-liambeguin@gmail.com>
References: <20210224023116.571718-1-liambeguin@gmail.com> <20210224023116.571718-4-liambeguin@gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: clock: add ti,lmk04832 bindings
Date:   Tue, 23 Feb 2021 21:49:02 -0600
Message-Id: <1614138542.304286.735525.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 21:31:16 -0500, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Document devicetree bindings for Texas Instruments' LMK04832.
> The LMK04208 is a high performance clock conditioner with superior clock
> jitter cleaning, generation, and distribution with JEDEC JESD204B
> support.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/clock/ti,lmk04832.yaml           | 198 ++++++++++++++++++
>  1 file changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ti,lmk04832.example.dt.yaml: clock-controller@0: '#address-cells', '#size-cells', 'spi-max-frequency' do not match any of the regexes: '@[0-9a-d]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml

See https://patchwork.ozlabs.org/patch/1443682

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

