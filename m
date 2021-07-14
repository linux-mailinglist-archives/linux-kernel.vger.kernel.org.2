Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604A23C8B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbhGNTSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:18:40 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46705 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhGNTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:18:39 -0400
Received: by mail-io1-f54.google.com with SMTP id p186so3467372iod.13;
        Wed, 14 Jul 2021 12:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qokcf0qnNXxANCouZM+vm8WlzhoKngxqS47WEOvpyiw=;
        b=p7fjoFLF1KB4Wh0obSrbhiaM49obw3nbNJUj5AFm9ftrDpB3yvnaaGp4mtNRWC3vmV
         7cg2Hiv9cAY+/0BC0/84DAm9lMRJw/xrGBxV2VFOP7f0zd+pSHYJRjjj1kjBu3lb5b3y
         eAhDcYh/U7OjUaYy+nNLzOjuuR3P6M99bgi8VyF+PNECDrPn17JQx0mwAQvHYswoE/13
         XLNVi2u8E2ZJRSP3IO97QL2yNnW5KXzA62qmUWSwSlsGP24CTXbR0NHxuPIusHywkz9b
         Bg1B9+e0Ntqaqk0PJJsFniwzjq4u9fDt10jTbrsHypJ/D72ldreNIwLab85PlQDKz+Oe
         K8eQ==
X-Gm-Message-State: AOAM532SojDw2hU6J55P61McJpVflRy0Mbnhm0gBBEyi3p3cEONXLhco
        7oRXb40Qh2iDoFecMyQnhg==
X-Google-Smtp-Source: ABdhPJwoiD++aWTbqrkSBGFWU2brt5M3O0OT1auNjVG6kLBspkdzqmsrhIzvTwWXPxlvSZwXIIV7nw==
X-Received: by 2002:a05:6602:1c4:: with SMTP id w4mr8013951iot.44.1626290147179;
        Wed, 14 Jul 2021 12:15:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t11sm1665314ilj.63.2021.07.14.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:15:46 -0700 (PDT)
Received: (nullmailer pid 2991097 invoked by uid 1000);
        Wed, 14 Jul 2021 19:15:43 -0000
Date:   Wed, 14 Jul 2021 13:15:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: Convert UniPhier glue reset to
 json-schema
Message-ID: <20210714191543.GA2991022@robh.at.kernel.org>
References: <1624413208-17562-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624413208-17562-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 10:53:28 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier peripheral glue reset binding to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../reset/socionext,uniphier-glue-reset.yaml       | 88 ++++++++++++++++++++++
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 61 ---------------
>  2 files changed, 88 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reset/uniphier-reset.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
