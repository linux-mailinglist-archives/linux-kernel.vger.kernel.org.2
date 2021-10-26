Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA843BC31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhJZVTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:19:53 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33346 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhJZVTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:19:39 -0400
Received: by mail-ot1-f50.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so675596otg.0;
        Tue, 26 Oct 2021 14:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/SrXILfDig/lomeVjP9F/pME3hMbDlFyEMawRRJ9jo=;
        b=C+OM+J0Rav/+VM01YRb5BxumRAgux+FtbG33pfivCK0zhc3Fj1JZIMa1hTiOfiqal+
         bUtaHkqMIq/f9n6CtqTpwVh37i1fld/NVVnDQcflQLeKeGEJVcdYTQg7+hhS8EZaZpJ3
         Nvoo+LpqWSPk7D8rhvAfqxSDL8/D3CzaGiIBcJNWkr5GBWEw4nCjhCYYitPDkHnX59QQ
         vmqm4YvBNEHroM02/gx10Jfd6AXf8773IT4qjU8rdXDRsPBq6tc0CoVB9LrFJMh7vczj
         thCpcmGCPujwbdixJWwT7k3ah9hUKi+X6CUVq58e9aJGnrH2XGhCecNJ0V3SC9EVIHg5
         InUw==
X-Gm-Message-State: AOAM533iCbUdxtGIv9nejno8y0xjMhygY5jTnByR0Tic+OiVdYFXmxLh
        Ykj7NMgWVPbU8NMOFGXcm8wDr9o19w==
X-Google-Smtp-Source: ABdhPJyU3/GpOrfCyBeuLzT4mA91G664hqEOZhtukXvwz9aEgFHc9GajOknk/2GTZt1YJ2VZu83npA==
X-Received: by 2002:a9d:715c:: with SMTP id y28mr22144929otj.362.1635283035238;
        Tue, 26 Oct 2021 14:17:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g21sm4301009ooc.31.2021.10.26.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:17:14 -0700 (PDT)
Received: (nullmailer pid 3267937 invoked by uid 1000);
        Tue, 26 Oct 2021 21:17:13 -0000
Date:   Tue, 26 Oct 2021 16:17:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: fsl: convert ifc binding to
 yaml schema
Message-ID: <YXhwWR7fDrv9L+mY@robh.at.kernel.org>
References: <20211015005707.1996-1-leoyang.li@nxp.com>
 <20211015005707.1996-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015005707.1996-2-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 19:57:06 -0500, Li Yang wrote:
> Convert the txt binding to yaml format and add description.  Drop the
> "simple-bus" compatible string from the example and not allowed by the
> binding any more.  This will help to enforce the correct probe order
> between parent device and child devices, but will require the ifc driver
> to probe the child devices to work properly.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../memory-controllers/fsl/fsl,ifc.yaml       | 113 ++++++++++++++++++
>  .../bindings/memory-controllers/fsl/ifc.txt   |  82 -------------
>  2 files changed, 113 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
