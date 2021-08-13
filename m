Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6743EBD28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhHMUO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:14:26 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40715 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhHMUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:14:25 -0400
Received: by mail-ot1-f53.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so13437869oth.7;
        Fri, 13 Aug 2021 13:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgB4NgYatIsDbtRKZgX8xWlz86d7FogZ5voxSBxuiCs=;
        b=NviuOFwn6q0z2S8QE9+baaNsGDjwhv+vgxRdpvN8vplYA6wxGxYBxfH/CLWYh1xUCr
         Wnt5j9rlDg4nS4E6Lwa62xZT8v6BN9WVqyu6hsODDkMsSe73s+tQtEIRSbwAs9zvHqWH
         3N2eAqr2ZpDTKL9gg6ddWwL7UDnRo8YThvk8HjgSKpbRwhDRMmM2sBeWT2zU5MnATd5j
         l8tTbkeej1+UxKmQX89KzqX/Z2BhCLQRvKh/l2/L+AjvgUBdEw4UnVBiz6tqBbggiAP1
         Q0S9llWir3VDVLCpIsmNmZk37S+kZ9oaZgOt+sZNUwlmeDDdWl0xLcnvDinSOe6clWIu
         g3Og==
X-Gm-Message-State: AOAM531wGtjlGq6NonS/aFaS7jKJzGCjN9TzpvFQoYrrBMCsRbnDmFqa
        Fck6pVF+am9XWySt2T4nRA==
X-Google-Smtp-Source: ABdhPJwwCyqqirH/elfGbuCKrfd56vMsIKlXL9oqb/uDXXKE879RfbEZgFWOmiEJ/XgGNTQOZIGlrQ==
X-Received: by 2002:a9d:7608:: with SMTP id k8mr3436762otl.239.1628885637594;
        Fri, 13 Aug 2021 13:13:57 -0700 (PDT)
Received: from robh.at.kernel.org (2603-8080-2a06-ed00-7254-0b80-dd3c-00c6.res6.spectrum.com. [2603:8080:2a06:ed00:7254:b80:dd3c:c6])
        by smtp.gmail.com with ESMTPSA id s63sm567380oia.52.2021.08.13.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:13:56 -0700 (PDT)
Received: (nullmailer pid 3947028 invoked by uid 1000);
        Fri, 13 Aug 2021 20:13:54 -0000
Date:   Fri, 13 Aug 2021 15:13:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     git@xilinx.com, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        monstr@monstr.eu, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: timer: Remove binding for
 energymicro,efm32-timer.txt
Message-ID: <YRbSgkDRXdXzjKW3@robh.at.kernel.org>
References: <571fc4b2e6d41c61b7f4445601a79bb50aace2e7.1628245879.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571fc4b2e6d41c61b7f4445601a79bb50aace2e7.1628245879.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2021 12:31:22 +0200, Michal Simek wrote:
> The driver has been removed by commit 523d83ef0979
> ("clocksource/drivers/efm32: Drop unused timer code") that's why binding
> doc shouldn't be also valid anymore.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  .../timer/energymicro,efm32-timer.txt         | 23 -------------------
>  1 file changed, 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/energymicro,efm32-timer.txt
> 

Applied, thanks!
