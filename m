Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4D34E880
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhC3NJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:09:03 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45867 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhC3NIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:08:52 -0400
Received: by mail-ot1-f44.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so15477042oty.12;
        Tue, 30 Mar 2021 06:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=OHtm7+pyHj4oSPzbkg2pVPKvuBPEByRYF/PMRPFvQcY=;
        b=p0iUXdBjx5CWWBF0ivRmeuVsoGRHEJKUwilJyF/wF+RBw/SVZ+yLfXueUFvK/cjKG5
         /54zKhsb1gGPh/mD94ZSn1Ja0egyYNl+8jOucP3Rg6kMFgkg4PmnsO0Nie/4kYqBpZ0t
         q0MJlvxpWrMK0FaKlXwQ5vG62jlQ7dTe0ugI7izMIFIAk3aaoVXFhfD6N/aDDm9skDjw
         IBodqywKLxoEzi3pS978uC5FZ7eL3HCYuDKkQpCa+BLGuWbScwgHH0nPVOtTRiD5q3Vy
         ILlWtH3HdKmEvJh6ra0Rayr+t2nckDYftabopGCUb3eCUmM7jdH+dYqTh4+AH5CUinnw
         CizQ==
X-Gm-Message-State: AOAM532+fJS79qJ46e55rtb9l6Xhd1OTLXCssRKuSQMMdULV/jVhwA1x
        zRnmWgThwb2TAgoKCcfyIA==
X-Google-Smtp-Source: ABdhPJyqrRcbqlskI2V3Xoi3zuER0rxOBkXIZwyBVfvjsdaD5kz6eFMj05kXN75bGJwSLt7W6ZNRGw==
X-Received: by 2002:a05:6830:1c26:: with SMTP id f6mr27152881ote.53.1617109732172;
        Tue, 30 Mar 2021 06:08:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u23sm4333697oof.17.2021.03.30.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:08:51 -0700 (PDT)
Received: (nullmailer pid 173735 invoked by uid 1000);
        Tue, 30 Mar 2021 13:08:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     cristian.birsan@microchip.com
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20210329213357.431083-2-cristian.birsan@microchip.com>
References: <20210329213357.431083-1-cristian.birsan@microchip.com> <20210329213357.431083-2-cristian.birsan@microchip.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: usb: Add DT bindings for Microchip sama7g5 tcpc
Date:   Tue, 30 Mar 2021 08:08:43 -0500
Message-Id: <1617109723.715948.173734.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 00:33:56 +0300, cristian.birsan@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch adds DT bindings for the new Microchip USB Type-C Port
> Controller (TCPC) embedded in sama7g5 SoC.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  .../bindings/usb/microchip,sama7g5-tcpc.yaml  | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.example.dt.yaml:0:0: /example-0/tcpcb@e0844000: failed to match any schema with compatible: ['microchip,sama7g5-typec']

See https://patchwork.ozlabs.org/patch/1459823

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

