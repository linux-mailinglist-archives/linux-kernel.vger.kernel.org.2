Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC69D425279
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhJGMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:07:33 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42643 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhJGMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:07:31 -0400
Received: by mail-oi1-f182.google.com with SMTP id g125so1955319oif.9;
        Thu, 07 Oct 2021 05:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZpeghEkpC1Pg3UdO1HwAb8FK9i7VWHQ5YdwnoplJxK8=;
        b=UV6iLt2AoWVRnetAGLSUQ1SSCGj7a00ZrSnSsLZMvuWlBaoeEljfaHTdTD+qD/wcrB
         0rFAYp9x1OZZwqFxpsb81UGTyznmMXpA82CIWZwA8iJht+x8p6KZI1GpgCMx0KmRKh70
         rmT2jHL342cDAaTmj7Q5m1fG2BrCGyd0hchxYzjNAEfAbtoWwdYzD3lGxqStY40BCph1
         fUA3TthvcABX0U+JVBaCuVqZI1JcJbAwEOers9IUmH5b6O5v93of9R2BhQmB2XhODX84
         k53fPqLOlrE3/yjSVDmNDcowO0NKRUwAcGmQTG289onvQc14WDEN/rrppsWH3BMg6DU7
         aWmg==
X-Gm-Message-State: AOAM533sjPEftPYQ6n3A3zOhGfZ1oGOXBY6ROuOp+EeMYAHKxCy89eU8
        BMhpF6oPiDtK8LezkOWweA==
X-Google-Smtp-Source: ABdhPJzhiXeQo/eXhIOrAs7OPuhGigLU49G1jNhsaB5Ipypuu/N1nhLiSKgYOzsnVO0FqhVwFnc2ZQ==
X-Received: by 2002:a05:6808:1248:: with SMTP id o8mr11034031oiv.151.1633608337744;
        Thu, 07 Oct 2021 05:05:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u26sm4655625oic.51.2021.10.07.05.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:05:37 -0700 (PDT)
Received: (nullmailer pid 121522 invoked by uid 1000);
        Thu, 07 Oct 2021 12:05:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        tomi.valkeinen@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20211006135150.504897-1-angelogioacchino.delregno@collabora.com>
References: <20211006135150.504897-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] dt-bindings: display/bridge: tc358764: Convert to YAML binding
Date:   Thu, 07 Oct 2021 07:05:36 -0500
Message-Id: <1633608336.190712.121521.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 15:51:50 +0200, AngeloGioacchino Del Regno wrote:
> Convert the Toshiba TC358764 txt documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/bridge/toshiba,tc358764.txt       | 35 -------
>  .../display/bridge/toshiba,tc358764.yaml      | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1537162


bridge@0: '#address-cells', '#size-cells', 'port@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/exynos5250-arndale.dt.yaml

bridge@0: 'ports' is a required property
	arch/arm/boot/dts/exynos5250-arndale.dt.yaml

