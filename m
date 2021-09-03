Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466A7400446
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349572AbhICRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:46:40 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42998 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhICRqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:46:38 -0400
Received: by mail-ot1-f44.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so7386563otk.9;
        Fri, 03 Sep 2021 10:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9w3q69G1Vy9V32oJP3rKAD+3FAp+dB9LDW5+LFzDt3k=;
        b=LfUm90IdAg4H+L5/hjwMMNaFBJYiTmMuAds2b9JFBf7GHzf2RmdhGhkc8l4tdQlKaB
         zJzlN5l8wICJ65xS01Fi+2oi2w2vTurHJZ1eNyAAZMkWnJxQozokD14UTTjCHAikZxmz
         YCZUtAVxOUxzNGJuFQOZW1Iw1sTkOAHZxry2/JUiIwpQnZqbUSpXvJD8ZuKgDCAIpxeg
         LU0EDHZqGZkIlFHbxY98/RBq7l6GXgMKzP1K4zFNQFQnfOX7UhFqstAYbyQsvjb97ggn
         vb3fveZTsh6JvJxRPGEmk25IZlLEbq1aB+ztA888LtuTHFtdPb0lnGqDZLITPqfRWm3y
         vg7g==
X-Gm-Message-State: AOAM531Cd8n7/WfPXt57q+pK5KqKk2MDWgaCqi4XS7qJkS0Vd6Kw58Gl
        s/SVWtRr6rrXtGoj9stZqJN4gglNAQ==
X-Google-Smtp-Source: ABdhPJyxKMiNv1GaaGO+swMY3OUKvOq/R6tpGq1nY9GWp4sitfmq8bXq2UPaZZoSPazdN9CALaxLjg==
X-Received: by 2002:a9d:5a8e:: with SMTP id w14mr184879oth.65.1630691138465;
        Fri, 03 Sep 2021 10:45:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l3sm1084209otd.79.2021.09.03.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:45:38 -0700 (PDT)
Received: (nullmailer pid 3156938 invoked by uid 1000);
        Fri, 03 Sep 2021 17:45:37 -0000
Date:   Fri, 3 Sep 2021 12:45:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     York Sun <york.sun@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: memory: fsl: convert DDR controller to
 dtschema
Message-ID: <YTJfQaOZUdz6LFpe@robh.at.kernel.org>
References: <20210826113049.92962-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826113049.92962-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 13:30:47 +0200, Krzysztof Kozlowski wrote:
> Convert Freescale/NXP DDR memory controller bindings to DT schema format
> using json-schema.
> 
> Previous bindings were not listing all compatibles, so scan through
> devicetree sources and drivers to get these.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/memory-controllers/fsl/ddr.txt   | 29 -------
>  .../memory-controllers/fsl/fsl,ddr.yaml       | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ddr.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
> 

Applied, thanks!
