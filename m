Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885F3313DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhBHSsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:48:37 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36102 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhBHQ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:56:11 -0500
Received: by mail-ot1-f54.google.com with SMTP id 100so8107044otg.3;
        Mon, 08 Feb 2021 08:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cQOD4UfhBCguCmT5KtaisymtJXK2KlCAy1kN/LZCqm8=;
        b=S/j0qx/SyjN7p+E+DaQRTbTex5YFa9+XXtLSvmjjJDugcDsApWs+rwKkCiKgneiWzM
         dIw/o6BQBbWb0sbqC8Ts5wPDYABIN1z7QY8n2jpPY8NV2I0ai/R45IA3KM/I6PzhwDrq
         eNcQXRsbCz8vdgFKfehSMI2k9esOhANNiQxs/eDTAGiga20dxBBb7h77V+1NgZsLkkhF
         stjOhk2+zAEzhjCbIe2koCG9RzF0dWrGiCpaIRF0ArY6jKbyvv6VhrjecfCfV6Yvq1Wf
         sVElj1Wz0bBlgd+t2uSROa87CND3g7JpQVM9jo5PmTpW9H+SgtUMK8QbscaX5UM1awdi
         CC5w==
X-Gm-Message-State: AOAM5305l3z9EIloqz08vVDprYHikBX9Z3xn6nQplGYzRzMtPmCVKV+x
        D/Co+/vmqOux1KGsddhYUg==
X-Google-Smtp-Source: ABdhPJzgHduVL0CtolKn6INiA3wtYNJLWgeS0pYCALroa6UC1v9J1pa2xhmZzMqmaHUuoepJTuyIDg==
X-Received: by 2002:a9d:6c7:: with SMTP id 65mr4466510otx.240.1612803330312;
        Mon, 08 Feb 2021 08:55:30 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q6sm3873511ota.44.2021.02.08.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 08:55:28 -0800 (PST)
Received: (nullmailer pid 1522090 invoked by uid 1000);
        Mon, 08 Feb 2021 16:55:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Orson Zhai <orson.zhai@unisoc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>, haidong.yao@unisoc.com,
        Baolin Wang <baolin.wang7@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
In-Reply-To: <1612785064-3072-3-git-send-email-orsonzhai@gmail.com>
References: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com> <1612785064-3072-3-git-send-email-orsonzhai@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: mailbox: Add interrupt-names to SPRD mailbox
Date:   Mon, 08 Feb 2021 10:55:22 -0600
Message-Id: <1612803322.554208.1522089.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Feb 2021 19:51:04 +0800, Orson Zhai wrote:
> From: Orson Zhai <orson.zhai@unisoc.com>
> 
> We add an optional supp-outbox interrupt support to driver and change to
> describe interrupts with names for easy configuration in device tree files.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml: properties:interrupt-names:items: {'enum': ['inbox', 'outbox', 'supp-outbox']} is not of type 'array'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml: ignoring, error in schema: properties: interrupt-names: items
warning: no schema found in file: ./Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml

See https://patchwork.ozlabs.org/patch/1437629

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

