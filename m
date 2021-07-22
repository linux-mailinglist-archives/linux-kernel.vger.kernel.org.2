Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F723D1C00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGVCF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:05:26 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:41728 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhGVCFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:05:25 -0400
Received: by mail-il1-f181.google.com with SMTP id p3so4091421ilg.8;
        Wed, 21 Jul 2021 19:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ixKGpO941ZDKCFs+4cX6wK1iiC57fsrwJDPh4qCXl8=;
        b=p6LQT0kW42ZVKkfRH+9xLU3XOW+RUujV3Wrs70SKoMjQMrnOdKNuHqqE2ylz5r/WHo
         sqJmQHx+2HTsXjeety/eArpQGLpr+4F7tcY2NSp71tk7Kp9Ue9Moq2m+gzKz7GRsGgeU
         4SnLJzYdtb/laFIl4HAKsluZod5gPy2l3ILCkMEv0tQWwQWaFEOEP9AVyuedoQWRtKa/
         5+NUxYvqcOjeUFiQTu2pod8bcYyRGgxtduXZ4+P24Sn54rR4lGV6exjYaUcoqH0F6bU1
         qnZGIGC0a+8XguHj2IaYrJRZv88uj0uLf2vRVaqpVWcCiS1wslr94W/2eGofMDZF/BVG
         EEMg==
X-Gm-Message-State: AOAM532OTKqRGstuTjyBLnqZPw+3VsvZhAkMSP9qpUyzL2LdkUGLDCRo
        9Gzj6Fup2QZMOEbsxIS16Q==
X-Google-Smtp-Source: ABdhPJzPziBeK/sDz4zL0wrDsgghuGYSXq02K/iHmXhW1iZs16Y2sUUdWpbimdZFJB8XBQAaFKul4A==
X-Received: by 2002:a92:d5cb:: with SMTP id d11mr25239213ilq.133.1626921959811;
        Wed, 21 Jul 2021 19:45:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z12sm15480548iom.6.2021.07.21.19.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:45:59 -0700 (PDT)
Received: (nullmailer pid 3196078 invoked by uid 1000);
        Thu, 22 Jul 2021 02:45:56 -0000
Date:   Wed, 21 Jul 2021 20:45:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Fabio Estevam <festevam@denx.de>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, kernel@dh-electronics.com,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH V3] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Message-ID: <20210722024556.GA3196044@robh.at.kernel.org>
References: <20210714202252.5898-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714202252.5898-1-cniedermaier@dh-electronics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 22:22:52 +0200, Christoph Niedermaier wrote:
> Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards. The DHCOM DRC02
> device can only house a SOM with iMX6S and not with iMX6DL, due to some
> thermal design consideration. But for compatible fsl,imx6dl is chosen,
> because fsl,imx6s isn't available, the iMX6S is basically a iMX6DL with
> one CPU core disabled and therefore the kernel discerns the iMX6S/iMX6DL
> automatically.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: robh+dt@kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: kernel@dh-electronics.com
> Cc: Fabio Estevam <festevam@denx.de>
> To: devicetree@vger.kernel.org
> ---
> V2: - Remove line with fsl,imx6s on the DRC02 Board
> V3: - Rework of the commit message
>     - Add Fabio Estevam to the CC list
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
