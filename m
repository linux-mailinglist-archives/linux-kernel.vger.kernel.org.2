Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316613701A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhD3Tzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:55:41 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37450 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhD3TzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:55:09 -0400
Received: by mail-oi1-f181.google.com with SMTP id k25so71125687oic.4;
        Fri, 30 Apr 2021 12:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lu0Nn1LoXCoWYQERWuKql1kJxVRz2RLN3KZDkSog1xY=;
        b=dPfpuJGrXAHGjQdknWqB1MITd5A5QdLcOt25m/m+5QKIaIvcvAKecJ4UqhRL+gJz7N
         VrFGzq9rpenMZzpgFUCKyJNSn4k/qXmJUGZAjjV6Jdfj8gtG7uPGHhbxa2d3qI+Yg9d5
         kj0eAIJ8fNQjVH6tpS/GyhoP7N/F7lyCCTcPXBiiHi/SA/xMS9z83pRsgYl79CuU2Ddu
         ZkLOqvrlatNIk3KwB68XG+h9uyzNa0oe3Szy1G0RwHQjvgt5kIg4qXfXeqhwy/zuQWYP
         mxI23nKTpDqvqn5cNcBwDXVxWRkyEhWl3fdNQS6NKjObtihtXOdPlItGpJ9hTgaNB75q
         FkFA==
X-Gm-Message-State: AOAM5301cbQfh7/ee+ohSQD3/DaYpal6S3D+AVdicW8JqcdSuTfUt7+R
        YZanzWMUqMMM0RYHHEcLjw==
X-Google-Smtp-Source: ABdhPJwhC2jwZc4M8NFfuCXq5QMte/ID3yD2MJbcD9Gdit6uesKDwlANCkGxmOp6l0U+wOMtOM9YCg==
X-Received: by 2002:aca:5fc2:: with SMTP id t185mr5424983oib.64.1619812460727;
        Fri, 30 Apr 2021 12:54:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l3sm767811otj.37.2021.04.30.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:54:20 -0700 (PDT)
Received: (nullmailer pid 3778724 invoked by uid 1000);
        Fri, 30 Apr 2021 19:54:18 -0000
Date:   Fri, 30 Apr 2021 14:54:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v8 1/5] dt-bindings: usb: Add binding for Realtek RTS5411
 hub controller
Message-ID: <20210430195418.GA3778671@robh.at.kernel.org>
References: <20210428184132.2184997-1-mka@chromium.org>
 <20210428114109.v8.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428114109.v8.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 11:41:28 -0700, Matthias Kaehlcke wrote:
> The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.
> 
> This initial version of the binding only describes USB related
> aspects of the RTS5411, it does not cover the option of
> connecting the controller as an i2c slave.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v8:
> - added entry for 'reg'
> - marked 'companion-hub' as required
> - changed node name of USB controller to 'usb'
> 
> Changes in v7:
> - added type ref for 'companion-hub' property
> 
> Changes in v6:
> - Realtek binding instead of generic onboard_usb_hub
> - added 'companion-hub' property
> - added reference to 'usb-device.yaml'
> - 'fixed' indentation of compatible entries to keep yamllint happy
> - added 'additionalProperties' entry
> - updated commit message
> 
> Changes in v5:
> - updated 'title'
> - only use standard USB compatible strings
> - deleted 'usb_hub' node
> - renamed 'usb_controller' node to 'usb-controller'
> - removed labels from USB nodes
> - added 'vdd-supply' to USB nodes
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - updated commit message
> - removed recursive reference to $self
> - adjusted 'compatible' definition to support multiple entries
> - changed USB controller phandle to be a node
> 
> Changes in v2:
> - removed 'wakeup-source' and 'power-off-in-suspend' properties
> - consistently use spaces for indentation in example
> 
>  .../bindings/usb/realtek,rts5411.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
