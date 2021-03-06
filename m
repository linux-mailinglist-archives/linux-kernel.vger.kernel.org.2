Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD39732FD7E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 22:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCFV0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 16:26:10 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:38149 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFVZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 16:25:38 -0500
Received: by mail-qv1-f54.google.com with SMTP id bh3so2809917qvb.5;
        Sat, 06 Mar 2021 13:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fAXOswsEkCwCYLA42rqdjJRv0N0k2d/7dOqRSOJ+rZY=;
        b=nwNWB62HTBV2AOLk5k5Gt6/Vz6zjyzIPAhz3FRGi+l1UISs5xORUUk4qS/bv06X6ib
         mOYPs1b4AsYhmNZ00BnIhITqDwxvFO1c4LQlx5HBMyM9YqE0JKi5x7fKGnbaoQkOEHlY
         PqPEGUo0Qw2c3TkBvEc9jTwjPb+8aSU4LIF7dpQ8+PK7L9plzI4D7VEAeMe1+gUB6Tpu
         ZT39E8otO1ayxNrSzr6GgDFlY4mh8XDXUHWBJKvniQ/z62KzMl6c9ctDCUjF7n2fou4T
         nVXVk45O4ankn2bxdsSwZrLyh+SO3AFQTvxu1xAfq23zN1bYgoXGJRzisESKwX2gNy/w
         xGYw==
X-Gm-Message-State: AOAM531AZ2MMyj5ZwzQiWp3xmT9FF8eKe7WAp5p64a8xjKuURNLt6vW9
        Yg3NHzUTHN/AEdCm6SzkNg==
X-Google-Smtp-Source: ABdhPJxSjrmvdxUpEYQNr1si+PAGIJYtuOeH9qs3P2Tuf7j/rQMTKTU/Ld0F9xJcxI74vf2tIwv3+A==
X-Received: by 2002:a0c:b929:: with SMTP id u41mr14981209qvf.30.1615065938231;
        Sat, 06 Mar 2021 13:25:38 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id s126sm4485763qkf.62.2021.03.06.13.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 13:25:37 -0800 (PST)
Received: (nullmailer pid 1238784 invoked by uid 1000);
        Sat, 06 Mar 2021 21:25:32 -0000
Date:   Sat, 6 Mar 2021 14:25:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Vivek Unune <npcomplete13@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: phy: convert Broadcom NS USB 2.0 to the
 json-schema
Message-ID: <20210306212532.GA1238704@robh.at.kernel.org>
References: <20210226114501.31086-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226114501.31086-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 12:44:59 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Minor example fixes:
> 1. Include bcm-nsp.h
> 2. Add address to the node name
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This has been verified using dt_binding_check
> ---
>  .../bindings/phy/bcm-ns-usb2-phy.txt          | 21 -------
>  .../bindings/phy/brcm,ns-usb2-phy.yaml        | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
