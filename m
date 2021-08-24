Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12EC3F62E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhHXQnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:43:13 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44855 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhHXQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:43:12 -0400
Received: by mail-ot1-f42.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so39224450otg.11;
        Tue, 24 Aug 2021 09:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xS+QtzQiuoAe6e5m4kKcB1AtgOWvkfG4yNkCC1KF3aw=;
        b=HsW2DMWxrwwILGmeLoZpAGXqhHgT7dfl/mPY6AvvO3SJ5a023G2dH9e10RRoaWR1DW
         c2dHSerzYa/meQxRyBO0hwchId7pNEeV45tgx4M6C2XVvSNFK+YbZL/atHmr6FBU66I/
         Nuw/GWZWVCKVG6/A+fKpINCdRQ5jbTc/m6F+5ioSrEhr824hSWR72V8xRu2WDTM5NKDx
         rdKlql0uhcXrQW591KApwCbFoBd9GvNvqmrJmciy1l769RMkLZC4zuwkFwSIwEVxYY6i
         u07I0kcDmDKUXMLPaXdsWX7/VGXbsyuRNaX40jM6bn+Wolr3naO+YsQyzL5CdLQSPSr6
         VLvg==
X-Gm-Message-State: AOAM5327emRRzCSxaofceGxkFc9Nnrt4wuJWvRxGDp29aWdk+ng3Uqff
        qIC7FW0MI1XOGzExLxpZxA==
X-Google-Smtp-Source: ABdhPJzHioaZD2owbUBwVjdP9XBsuI/CgwMh0zF/+mLlYSdJS+bvBe2j/4nYeICM4bxxPP4xM2bsuA==
X-Received: by 2002:a9d:4e98:: with SMTP id v24mr20477465otk.228.1629823347901;
        Tue, 24 Aug 2021 09:42:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o15sm3592677oos.1.2021.08.24.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:42:27 -0700 (PDT)
Received: (nullmailer pid 599220 invoked by uid 1000);
        Tue, 24 Aug 2021 16:42:25 -0000
Date:   Tue, 24 Aug 2021 11:42:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>, jamipkettunen@somainline.org,
        martin.botka@somainline.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for SM6350 SoC
Message-ID: <YSUhcfEIY/wOiOIt@robh.at.kernel.org>
References: <20210820202906.229292-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820202906.229292-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 22:29:04 +0200, Konrad Dybcio wrote:
> Add the SoC specific compatible for SM6350 implementing
> arm,mmu-500.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
