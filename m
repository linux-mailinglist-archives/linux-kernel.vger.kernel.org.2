Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742253EF522
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 23:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhHQVpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 17:45:30 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:36527 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHQVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:45:28 -0400
Received: by mail-oo1-f48.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso86496ooi.3;
        Tue, 17 Aug 2021 14:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJbXJaO1S8CDBHolXnG0pNdqRsTOC5L9HS9uoBlFyko=;
        b=k4SWAI+kjtMnXyp7vowkA0BhesRPDL2TRMJgIjC7GfUWAGbT3cHoPZPX9sX+Sgr8R4
         Ijxpf0uliEUw2FTdfW06jCXbnWcA3U6BUzApCrE8aoCuZxoUew4heJrRh156dZICCpIa
         zxG1SHIMh91RAxu76/DqZGwZz1oZegir45JZVTND69AZkRtn1yZLag8AJ+8nwa1IYj31
         ThaCToHk+8vhH+HS00iABQOqyee4VIqlrVFkcwlkqnLUAsbUkASa8wNsBq8N8/hZ1iO9
         BYH89I6QLNO6vERCxZaFl7bxsEzvcgFR2czEN6ZgqgTK5gD6chG3oYIqRooBj1BsZFuo
         PEzA==
X-Gm-Message-State: AOAM531PVtPia8MjNkIUxYS757YdbcIj+n/6uXbv7ZnAhanDbQ4xJF1l
        jRyo8JSZ9VNNnbTHuJZ/dA==
X-Google-Smtp-Source: ABdhPJwR5dd5wQ/YDvk31PYwnhKCj+LV9fYj+okbAgVw5jhjaeHzx9gGBJxGwPQRMUTxP3PjUVi0XQ==
X-Received: by 2002:a05:6820:61b:: with SMTP id e27mr4117053oow.68.1629236695061;
        Tue, 17 Aug 2021 14:44:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k16sm668797oor.16.2021.08.17.14.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:44:54 -0700 (PDT)
Received: (nullmailer pid 894487 invoked by uid 1000);
        Tue, 17 Aug 2021 21:44:53 -0000
Date:   Tue, 17 Aug 2021 16:44:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     anan.sun@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, chao.hao@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        youlin.pei@mediatek.com, srv_heupstream@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-mediatek@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH v2 02/29] dt-bindings: mediatek: mt8195: Add binding for
 infra IOMMU
Message-ID: <YRwt1f6UBL0zoxF4@robh.at.kernel.org>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813065324.29220-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 14:52:57 +0800, Yong Wu wrote:
> In mt8195, we have a new IOMMU that is for INFRA IOMMU. its masters
> mainly are PCIe and USB. Different with MM IOMMU, all these masters
> connect with IOMMU directly, there is no mediatek,larbs property for
> infra IOMMU.
> 
> Another thing is about PCIe ports. currently the function
> "of_iommu_configure_dev_id" only support the id number is 1, But our
> PCIe have two ports, one is for reading and the other is for writing.
> see more about the PCIe patch in this patchset. Thus, I only list
> the reading id here and add the other id in our driver.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> Change note: use "contains" commented from Rob.
> ---
>  .../bindings/iommu/mediatek,iommu.yaml         | 13 ++++++++++++-
>  .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
>  include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
