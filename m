Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A9244AE56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbhKINGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:06:33 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38497 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhKING2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:06:28 -0500
Received: by mail-oi1-f171.google.com with SMTP id r26so12255351oiw.5;
        Tue, 09 Nov 2021 05:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Ko2dk4khs6TuCfZWpKr+X/YpD/2ivl7IRDSFpijQnZQ=;
        b=naWTuXP3gVpPpb+9aDqD4ta5aC9LneIsfbtjuG/HcdUjgQrS0Yh+aR/GPm2azccD0n
         Sw1+d6AYex5DM50b2r7C/5hE3XyFhzPufTkEGMqfSuwTT+sdjjhGtCwUh6KBZPraKUQ/
         CZeLgwyuHZbn0z747MHZn9Zq8uCkbBkvM4atM90U+4rpNWS+/DCM4siCAvGHmwJdBzJ6
         g3lGfPDq8G24OGfEK/D41kJEZ/FYCac2X6WxjfkTREOecVSYCgigZrIm0WTF7Dk1aEUV
         iXlZ0/ClxjaioQvNcBeDHywlDJ1B0VI5GRwFpn9+cwMWvl02I/XnxrjgyU8OjUAYrD9C
         sOhw==
X-Gm-Message-State: AOAM531B+ppqP7KAFjnxXL0vvel99+m/cQYSwYPDvTrENcqUg0Xi5vZR
        DLYanFTZC+0IXh23NY+MOw==
X-Google-Smtp-Source: ABdhPJxmdR8zOIBybiLQ024IstvrijeHVsUHBInHYbbRC9DtlS4ssG0CMH25NvJfKGD8AYaliw43tA==
X-Received: by 2002:a05:6808:14d6:: with SMTP id f22mr5390171oiw.101.1636463022146;
        Tue, 09 Nov 2021 05:03:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l21sm4102513otb.65.2021.11.09.05.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 05:03:41 -0800 (PST)
Received: (nullmailer pid 1726441 invoked by uid 1000);
        Tue, 09 Nov 2021 13:03:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211109053334.1840273-7-hsinyi@chromium.org>
References: <20211109053334.1840273-1-hsinyi@chromium.org> <20211109053334.1840273-7-hsinyi@chromium.org>
Subject: Re: [PATCH v2 7/7] dt-bindings: arm64: dts: mediatek: Add sku22 for mt8183 kakadu board
Date:   Tue, 09 Nov 2021 07:03:40 -0600
Message-Id: <1636463020.563453.1726440.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 13:33:34 +0800, Hsin-Yi Wang wrote:
> Add sku22 which uses different audio codec than previous kakadu board.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2: fix compatible items matching
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek.yaml: properties:compatible:oneOf:27:items: 'oneOf' conditional failed, one must be fixed:
	[{'oneOf': [{'items': [{'const': 'google,kakadu-rev3-sku22'}, {'const': 'google,kakadu-rev2-sku22'}]}, {'items': [{'const': 'google,kakadu-rev3'}, {'const': 'google,kakadu-rev2'}]}]}, {'const': 'google,kakadu'}, {'const': 'mediatek,mt8183'}] is not of type 'object'
	Additional properties are not allowed ('oneOf' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek.yaml: ignoring, error in schema: properties: compatible: oneOf: 27: items
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/mediatek.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1552630

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

