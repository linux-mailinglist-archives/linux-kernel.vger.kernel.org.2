Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD423DAE30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 23:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhG2VXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 17:23:24 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:45746 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2VXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 17:23:20 -0400
Received: by mail-il1-f169.google.com with SMTP id z3so7294063ile.12;
        Thu, 29 Jul 2021 14:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FZW94h1H39rcv+FtZXS3JtZAWRYyq7KjWtyIy+ADEfY=;
        b=QGlwPzLlNuRP9/8vzoIipr5O40nWmIFtVRN0/aOuClTX6YpYyN3NPBIzAyYGe9yAOe
         pvrh74v6fOMTEZasgLcGM64SnPI4BGk4TcoVjPrLjXSu3aHH2WyVc8w99OkR2WN0D4Vy
         rKKtUGg1cc0unJvrZpi+O67Db/gYiBavwuY+vHrO72fTY4sQLEyHV7qNnGa50pS61ni1
         ti3K7POFUYC9o6TbYsJZ8SEbK9+tA/qkRut82ISQpp5HJDI0tHHdlo3KB1kqIcFTD3DS
         P495hwjoGZKcKSjUeWR1IecpGN6vLPk71jur3urFTsxR2x9g1MHe409zgNziFiye28kc
         QdKg==
X-Gm-Message-State: AOAM533+26uxUdrNP8fww7N1W4jHAD21c6CvQS9Kb+ZM3TfaIIK90RwV
        aIWXh0W1oF37o0BGam94WSqtElEvhQ==
X-Google-Smtp-Source: ABdhPJzTFWVM255v25a+cNpfULd0/j7AfVEKs73rjAXZXFUxBZdValTxXcgb5paDoIp7XKFCHT1zDw==
X-Received: by 2002:a92:db4c:: with SMTP id w12mr5410487ilq.306.1627593795671;
        Thu, 29 Jul 2021 14:23:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r1sm2406728ilt.37.2021.07.29.14.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:23:15 -0700 (PDT)
Received: (nullmailer pid 915595 invoked by uid 1000);
        Thu, 29 Jul 2021 21:23:13 -0000
Date:   Thu, 29 Jul 2021 15:23:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, lokeshvutla@ti.com,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: Convert AM654 SERDES bindings to YAML
Message-ID: <YQMcQRy+vlI/L2G+@robh.at.kernel.org>
References: <20210723135605.23572-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723135605.23572-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 19:26:05 +0530, Kishon Vijay Abraham I wrote:
> Convert SERDES dt-bindings for TI's AM654 SoC to YAML binding.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/ti,phy-am654-serdes.txt      |  82 --------------
>  .../bindings/phy/ti,phy-am654-serdes.yaml     | 103 ++++++++++++++++++
>  2 files changed, 103 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
