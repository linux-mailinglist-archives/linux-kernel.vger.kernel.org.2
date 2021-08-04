Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4C3E0308
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhHDOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:24:36 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:40861 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbhHDOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:24:28 -0400
Received: by mail-il1-f175.google.com with SMTP id d10so1823587ils.7;
        Wed, 04 Aug 2021 07:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NE14rxs7Nx1Lsqlrn/QWnMRazks8S/eA0DgP+s+Spxs=;
        b=kpw5gDpy0+df5JVJE96ikqrMDCX4R6UiWs7t30l/vGJhyq2MtWj/x+82TLJtVNrYvl
         EsAH9sucZ4k8BvdegazOIrcpG1YZ4biYRy9NoycrIK7d3q8ZTEuvabTIN3HBZoVctEiq
         8sc7TUapk1klaveWSyJLL5Ky0pLHkOwSA8V9XVbv/rJ4O2zXTmWHXR6dnyWwC4BYcGgo
         pqORyVz6gQpks1BduXwUnsFEqpKkklSR1XyiwQxthEyelwLuptkyxgn8X+Ym0bLIngGL
         8YMegX9IZnd6TrFu86nX45lJm3rzcY67TtcL2PfGPRpFL3B8k4MIw9R7dPc0R9QW6em7
         X4CA==
X-Gm-Message-State: AOAM531A6P3BhDtuxWjuulG9oAP/c55Oq1PH+vRXbbm2upnMMGD9OiHr
        EvOQtEwGsilw4HOmgdfKrQ==
X-Google-Smtp-Source: ABdhPJw4PnKBCsysHRUT4YwQyRmJ8CKJdCtUX7GtioXxbF/243SRujd9UByGy0dd1Hm6Gltot23Iwg==
X-Received: by 2002:a92:c54d:: with SMTP id a13mr209ilj.74.1628087054317;
        Wed, 04 Aug 2021 07:24:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w13sm1208894ilo.10.2021.08.04.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:24:13 -0700 (PDT)
Received: (nullmailer pid 1150193 invoked by uid 1000);
        Wed, 04 Aug 2021 14:24:12 -0000
Date:   Wed, 4 Aug 2021 08:24:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, mauro.chehab@huawei.com
Subject: Re: [PATCH v4 4/4] dt-bindings: phy: Add bindings for HiKey 970 PCIe
 PHY
Message-ID: <YQqjDICecHumVay2@robh.at.kernel.org>
References: <cover.1628061310.git.mchehab+huawei@kernel.org>
 <461495431dd28ad2779658659f137db4bd747aa8.1628061310.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461495431dd28ad2779658659f137db4bd747aa8.1628061310.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 09:18:57 +0200, Mauro Carvalho Chehab wrote:
> Document the bindings for HiKey 970 (hi3670) PCIe PHY
> interface, supported via the pcie-kirin driver.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> 

Applied, thanks!
