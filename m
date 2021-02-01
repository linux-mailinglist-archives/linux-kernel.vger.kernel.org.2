Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85BC30A97D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhBAORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:17:39 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41493 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhBAORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:17:32 -0500
Received: by mail-ot1-f46.google.com with SMTP id k8so16362089otr.8;
        Mon, 01 Feb 2021 06:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=j5AzmbtQLD6qvkbcKGfw8vqLisCSy+bTOHK7NQK+zqs=;
        b=JY3H64HIa6Ea9PhncWfaNmfxtKbPyeGnuXkZPkFcu9ZOZvfNVtgCuZpG7O8RrNEvwy
         wzDALpWH40yZ3Yl9aBcTyELnos/qoWdG0RSzMBP8g9A0UMzS1Ys4rwjIOZ5c8EYNpMTz
         +gKuOdcymZ6SDlV7aWbpYXTftxVaaL62/pmaK9mrgdi/4D5j157Y17YBhVxKzt3D5O5/
         gKFrquZdsHK8T60GeylaTawhpXpJTUUG2JUR9bEd1pXro0opYsZIBCQ6THc8KoJHpy57
         lCcWAfo12V1StLT7vlmlLBdE9qlsky6j+uphsE6CzluKaO9ANK4icqXC1EHNMQNWsRgp
         IvNQ==
X-Gm-Message-State: AOAM533A5McWRnUr0eHI7YXLky4klnktM6F5ItmFHrBl4B6Uvhdncvj9
        Y4fEPFrBlKmILyGwIpx1gQ==
X-Google-Smtp-Source: ABdhPJzh31Z9pmkLhq6hmLPPwSnMKUcOAuOdroAZX6HoZJrMnw++Uk+pF8jLAepwKUo1G9Ca2sSgmg==
X-Received: by 2002:a05:6830:24a2:: with SMTP id v2mr11469559ots.298.1612189010707;
        Mon, 01 Feb 2021 06:16:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 69sm3922712otc.76.2021.02.01.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:16:49 -0800 (PST)
Received: (nullmailer pid 1041707 invoked by uid 1000);
        Mon, 01 Feb 2021 14:16:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>
In-Reply-To: <20210201103712.1619585-1-iskren.chernev@gmail.com>
References: <20210201103712.1619585-1-iskren.chernev@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
Date:   Mon, 01 Feb 2021 08:16:48 -0600
Message-Id: <1612189008.116859.1041706.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 12:37:10 +0200, Iskren Chernev wrote:
> The Samsung S6E3FA2 AMOLED cmd LCD panel is used on the Samsung Galaxy
> S5 (klte).
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
> OK, miraculously the panel turns on and off now, so the simple-panel can
> graduate into its own driver.
> 
> v1: https://lkml.org/lkml/2020/12/30/293
> 
> Changes in v2:
> - move bindings to separate file, add 2 regulators
> - add standalone panel driver
> 
>  .../display/panel/samsung,s6e3fa2.yaml        | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.example.dts:28.50-51 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1434112

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

