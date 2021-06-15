Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124433A81C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFOOHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:07:11 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:45647 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFOOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:07:03 -0400
Received: by mail-il1-f172.google.com with SMTP id b5so15349391ilc.12;
        Tue, 15 Jun 2021 07:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=P7f4PIAriLzauXRZaRCNZKSfNkQTAx55TUjfutsfWbU=;
        b=YTPx7dUuxZGZvIDNgvt0TcIYSEWqPhG6AmoSjB/w0Qedf0viSJSuiz+AFCvO7+GFpm
         U/ykckdgieaQhy7a8qqhW7mFds9Qw+8eZ3QiJ0tSdIxtrF+2HfBYBO8pfa+g8KvQ6p4A
         mi9cC3is04v31PKFrZtwBMdmwQvapQ21cK7ReR9lkuEWvkRzGM1fhgU6QmIXPlpHkFj1
         FzI4v0NxQWC1bMk0jU3W/X6OjIA9TPkAfvODVvMlCLtiX3QCBfY6S0+dN44L+Fu8un19
         Jijsrcl/D1fUoHuMmtjPM2Nv8T8xLImX/ZM2DfXxS7+wKDyytewGUa+q8R/KCXlpaVRT
         WajQ==
X-Gm-Message-State: AOAM533iC9/X1X6iCc7CwrSTNL+WEJOTElpHxRaNd7l+BReIKIkIstnt
        h1WkD8jp+LhpIHU0ZwjiDw==
X-Google-Smtp-Source: ABdhPJyfSHlrhhZrXCQVJV+wh8fp7Ii0Fv12GxhX2inTTiFj3bAb8quyDCvZ+yaqv0o9BcmPvEOz6A==
X-Received: by 2002:a92:8e04:: with SMTP id c4mr18390330ild.219.1623765897739;
        Tue, 15 Jun 2021 07:04:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u14sm4118371ilk.15.2021.06.15.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:04:57 -0700 (PDT)
Received: (nullmailer pid 487345 invoked by uid 1000);
        Tue, 15 Jun 2021 14:04:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     heiko@sntech.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        kishon@ti.com, vkoul@kernel.org, kernel@collabora.com,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        pgwipeout@gmail.com, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210614154359.805555-2-benjamin.gaignard@collabora.com>
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com> <20210614154359.805555-2-benjamin.gaignard@collabora.com>
Subject: Re: [PATCH 1/4] dt-bindings: phy: rockchip: USB2: remove useless #phy-cells property
Date:   Tue, 15 Jun 2021 08:04:53 -0600
Message-Id: <1623765893.351779.487344.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 17:43:56 +0200, Benjamin Gaignard wrote:
> '#phy-cells' property is needed in host-port and otg-port nodes but
> not in parent nodes. Remove it from the JSON schema.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml         | 2 --
>  1 file changed, 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.example.dt.yaml: usb2-phy@e450: '#phy-cells' is a required property
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/phy/phy-provider.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1491757

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

