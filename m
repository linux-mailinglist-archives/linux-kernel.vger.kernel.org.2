Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255A3375C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhEFUgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:36:41 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36695 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhEFUgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:36:39 -0400
Received: by mail-oi1-f178.google.com with SMTP id o16so1564333oiw.3;
        Thu, 06 May 2021 13:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XviLvGpJFaRdXjUf+47jXRg5BSAJvuUIHuWDGU5d4Yg=;
        b=eB3yh1FAGGeJNhqGf+/dXcuQT5wC6dgGY321Aiw3JJoIhlTUZ/Ovzq48M4Gn8DwZiB
         Cie0xozW7UpU2QopvZTr9EqhPFnbAfRn2dMUmNYoJAosH9Ibs8L3C1pbUFssgWPnpupt
         /Tovpoxsc6efBtC//HP0bUlw9I9cqs4LGrml5KfhiC063FPZ6eMDv2g+/BHEm8s0yjGu
         jxYsHO7jx1rzbnZmdYAINS/S/MhyGE9S+s0TLmuH5FZ4UI14VsJajQcevirKwj7OglTF
         0AZ+JLMpm9APe6NlYDfaJj3ygNJtEL4UeB+mnq6co12kW4gpS6FnKs081OkWqS+tES9C
         qtdQ==
X-Gm-Message-State: AOAM531kZwj4nAQg9y6i17qv07ZNAva+eSqGwwZfvFbvGgMYNRhUALBs
        5SZUM8VOWEhtjD6Nfu3b6skASTYm9A==
X-Google-Smtp-Source: ABdhPJxRy2L+/BAoxrnnJOdfWaZK4QI9+BE9wFOUThILsEgKO/rZw4PbKWcnlhOXEaSb+96gFpBsWQ==
X-Received: by 2002:a54:4017:: with SMTP id x23mr4483952oie.13.1620333340966;
        Thu, 06 May 2021 13:35:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w66sm716019ooa.37.2021.05.06.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:35:40 -0700 (PDT)
Received: (nullmailer pid 759479 invoked by uid 1000);
        Thu, 06 May 2021 20:35:39 -0000
Date:   Thu, 6 May 2021 15:35:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     will@kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, xxm@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        joro@8bytes.org, robh+dt@kernel.org, heiko@sntech.de
Subject: Re: [PATCH v3 2/4] dt-bindings: iommu: rockchip: Add compatible for
 v2
Message-ID: <20210506203539.GA759432@robh.at.kernel.org>
References: <20210504084124.131884-1-benjamin.gaignard@collabora.com>
 <20210504084124.131884-3-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504084124.131884-3-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 May 2021 10:41:22 +0200, Benjamin Gaignard wrote:
> Add compatible for the second version of IOMMU hardware block.
> RK356x IOMMU can also be link to a power domain.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 3:
>  - Rename compatible with SoC name
> 
> version 2:
>  - Add power-domains property
> 
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
