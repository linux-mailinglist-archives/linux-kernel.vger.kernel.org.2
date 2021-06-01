Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE30397455
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhFANed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:34:33 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44564 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhFANeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:34:10 -0400
Received: by mail-oi1-f170.google.com with SMTP id d21so15453378oic.11;
        Tue, 01 Jun 2021 06:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QbAYTIfaJrRwRGehKFdwrYMDuX76Y6YqwRn38v62cLU=;
        b=ngfZ5MCdYZlX8E9bUPZwWl5i/p0zRtvCm4IXLeWB6I+nQCOAnBEuC0ZQuzDchGi3zJ
         6ko5QEbJdftXZwNnrTPwFcouVPHsSZgN9sIDO8ZZR/tfZYztM5mzTpOIf38IYRBoR2wf
         zJxca6ciPZq0PXMIWVOQB2JQicSjgRtt5ukh3z29jXrMgNI4bsciI08s+U5bo0oZrLAx
         MQZfUpaWTC02OTjaxiC1NZ4Ik3U/I6Jo711U3yXnfmi/WDr4mulUMd/l/FaGqhOTOQcQ
         KYgufCu6QrUIRZzenv5wjzaUA0hLu/QfHGhNrz1xeMi7uelTnARdcS7RwMMv16f+jN2S
         EqEA==
X-Gm-Message-State: AOAM530zsrcmHnoaJIpMMtLkOC8IubPKgGUtDaVJORMNbSw2wngP3RkN
        YQb1iZsTGMMLdhQIwEzq7A==
X-Google-Smtp-Source: ABdhPJwPlU8tzCjo7uqUiStY1EgY0vdRyYQw7XSuzB+8lwNQUBS33GjtrZhyfgvuj4UZW3UZWTtaoQ==
X-Received: by 2002:aca:f482:: with SMTP id s124mr1829703oih.167.1622554347934;
        Tue, 01 Jun 2021 06:32:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a18sm3829863otp.48.2021.06.01.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:32:24 -0700 (PDT)
Received: (nullmailer pid 242367 invoked by uid 1000);
        Tue, 01 Jun 2021 13:32:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20210531115857.718985-1-iwamatsu@nigauri.org>
References: <20210531115857.718985-1-iwamatsu@nigauri.org>
Subject: Re: [PATCH] dt-bindings: clk: zynqmp: convert bindings to YAML
Date:   Tue, 01 Jun 2021 08:32:10 -0500
Message-Id: <1622554330.051024.242366.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 20:58:57 +0900, Nobuhiro Iwamatsu wrote:
> Convert common clock for Xilinx Zynq MPSoC SoC bindings documentation
> to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../bindings/clock/xlnx,zynqmp-clk.txt        | 63 ------------------
>  .../bindings/clock/xlnx,zynqmp-clk.yaml       | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.example.dt.yaml:0:0: /example-0/firmware/zynqmp-firmware: failed to match any schema with compatible: ['xlnx,zynqmp-firmware']

See https://patchwork.ozlabs.org/patch/1485640

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

