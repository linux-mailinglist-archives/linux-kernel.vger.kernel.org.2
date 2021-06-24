Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80E3B36FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhFXT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:28:49 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:36411 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFXT2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:28:47 -0400
Received: by mail-il1-f180.google.com with SMTP id q9so7470552ilj.3;
        Thu, 24 Jun 2021 12:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6h1Sx3JbYU2baky6rD9hMRn1kfJYQMiqvIqi3obyV8I=;
        b=OQVKC33Z/2afMC9cWaXlJf3qAGvFB83CCMff6gvPe9QTt6et3rEyjCN5Vjc0vo5kqz
         CmbzLdFJgj2XGzxYlK04QiaOpvN5XU28DoLx2e/and/6HCIhCPhMezsO73c7P0GPslgE
         l+Qs2NG28XiDv7naBBkA0DPp1ygfjJDDz/S88931KUcQ1tfVvhthpUZgSwowN0ohwWLT
         lCQ2oxcX6cYOXM5hZHBD+1F9h1yjQ9i7jUKW0dn1yRd4VIu2/16+sMXuiAonUYSPIjSl
         AOS5G6XaUBqQAYQMW1bnE8gsogxV/oqxiqwiruhACBbYE9J1/lcYVlKPQaB1qJ0KpwE9
         +aJA==
X-Gm-Message-State: AOAM530rq4h2/s/Sd/6AWCNfZf3ka+rT/96QyU69fPuoVZ+coEXsn7iZ
        KXPQ2zQ7Edr4JQV8wchollOeQDCKBg==
X-Google-Smtp-Source: ABdhPJz0Vgwv3Iq8nazL1YEj6niGuV9FnumXPQVtk8MmnklrGEOvQn76JOi0eS/UbHwhIZJMgNMjvQ==
X-Received: by 2002:a92:3610:: with SMTP id d16mr4554156ila.16.1624562786757;
        Thu, 24 Jun 2021 12:26:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r6sm1711534ioh.27.2021.06.24.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:26:25 -0700 (PDT)
Received: (nullmailer pid 1846846 invoked by uid 1000);
        Thu, 24 Jun 2021 19:26:22 -0000
Date:   Thu, 24 Jun 2021 13:26:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
        jamipkettunen@somainline.org, Robin Murphy <robin.murphy@arm.com>,
        angelogioacchino.delregno@somainline.org,
        Joerg Roedel <joro@8bytes.org>, konrad.dybcio@somainline.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: iommu: arm-smmu: Add binding for
 sm6125
Message-ID: <20210624192622.GA1846816@robh.at.kernel.org>
References: <20210612094606.89576-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612094606.89576-1-martin.botka@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 11:46:04 +0200, Martin Botka wrote:
> This patch adds binding for sm6125 SoC
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in V2:
> Add commit description
> Changes in V3:
> None
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
