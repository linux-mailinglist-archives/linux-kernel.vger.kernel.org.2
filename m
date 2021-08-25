Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2663F79D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhHYQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:06:34 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43955 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhHYQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:06:29 -0400
Received: by mail-oi1-f182.google.com with SMTP id w19so1468364oik.10;
        Wed, 25 Aug 2021 09:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bzeq1vxevafZNcmCfWSubGwbo3+FVzEro3mTelbJdwo=;
        b=gNae1d9ARJ6aHQYrmuRZeJoKneFtvXQP8sWIMRM+VUgAq3NDI9ib8wc+isSwzD2h3t
         lPJ4yfdzbN6Hd/lIfXQG+GtTDtassYLC8whC8Bp/cfUZZJ71iML6qM4AST0MNnG9dFnt
         RZGxrKZA24yVcEdbZGUrCuucoarLm7mZP5dd3m9KdV1RXajvBwcvzVvI6ZR/i/7RrTqM
         26XLHKvxB1tQIZS8m7M6gmBt+NBn+cxYn8iVmFqbcnagF6KMJj4/3EyyQ310g7mkXOb4
         opM3HMPFvhWuW5FXkAj8g1Cv+wfzV6F/JQ08X1B2VeVcYIobY9jy1P+O3LsWo6o9juL3
         d0Xg==
X-Gm-Message-State: AOAM530dR24oxIWOR/FOpuOQqKBNx3M7FdoK8i0dWeiEiFbz1kLrVmRS
        DE1mjfCOMxYya4AODDeP4Q==
X-Google-Smtp-Source: ABdhPJzbhyfpOlDR/PZPQELidDiQ70AzLoDo5sxkqNbth7DfwIfYr61MfrDR1En9VR9U9z+ZntiA7w==
X-Received: by 2002:a05:6808:1294:: with SMTP id a20mr7532780oiw.4.1629907543513;
        Wed, 25 Aug 2021 09:05:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s63sm41636oia.52.2021.08.25.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:05:42 -0700 (PDT)
Received: (nullmailer pid 2871688 invoked by uid 1000);
        Wed, 25 Aug 2021 16:05:41 -0000
Date:   Wed, 25 Aug 2021 11:05:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Hao Fang <fanghao11@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, monstr@monstr.eu,
        Daniel Palmer <daniel@0x0f.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Max Merchel <Max.Merchel@tq-group.com>, git@xilinx.com,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for Topic Embedded Systems
Message-ID: <YSZqVWx9le8Kn7Z8@robh.at.kernel.org>
References: <b6e42012977876c421672a84bdb7636be819d664.1629877585.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e42012977876c421672a84bdb7636be819d664.1629877585.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 09:46:28 +0200, Michal Simek wrote:
> Add vendor prefix for Topic Embedded Systems (http://topic.nl).
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
