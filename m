Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031F432CD6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbhCDHNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbhCDHNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:13:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49447C061574;
        Wed,  3 Mar 2021 23:12:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m7so232445wmq.0;
        Wed, 03 Mar 2021 23:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4pM5UzwJCaSA1xipkCauFzjQ9OrQvbh3Krxwlg6A34=;
        b=Td5CtP2JXZs3/z+onUhusDaS/j80xOxhLLTBHnmC2rlv7gQbVZaoasHlCAihJpjy3f
         1pn43gUjayYEoX2t50IEoWfDWvSM8yNa1lJKXDRVn3A9XIKqwS21w2G9f/XVkvcBfvB1
         sgcrIpMNzLP+UKxP4w3TkoUg5MrBmbdI03BIqawDkqvjhyTYLihP9ZOIH9sYUX38PwqG
         7YucHosRHqBc+uLsycdLK9PkJSoHCErCYTvEzxvfZR/uBEApK+X5iqsI44QqHz6fm0nF
         d/UsWBaKW8wkdfERPQCu0ifMUC8uvblyosKkaNHT4o4Ul3YSuBGxDQYuQtLPIZzXY7Gc
         8K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4pM5UzwJCaSA1xipkCauFzjQ9OrQvbh3Krxwlg6A34=;
        b=VCRMfJ7F9cb1ELV/DvqZ/3OGMwJ/P7qJoDSCmUlrmTOq7F3yvaFRRRyFwdbMWFxQuX
         92N4stavyel2hoDkgT0SlS60mueB1rp45BYg6Bq3ltgtXTEyfga8TqJSXrdH8675udlr
         DObcNQqgi+7iC8i04TE61jb7b2bsadFoVuud65uLFwUcwoVo/tBR8NX2EWnjqjBgLfYp
         JXWuxBxJ2MgFDbat7F6PJoUf/97LaJjhYieSCkkuKfSHYWn5QAQjVY3XSCNzkFggNHZj
         o3OwYracqtDG+qDn0TYz1FTv5CRC0tL7jB5lZPkHr7KYGQ2X6wrrkXroRBp8uRVprioE
         zZPQ==
X-Gm-Message-State: AOAM533oJzxL8AkPPbRziFGeOGhvtQ66QCH6xli3jGaDvvY7h/mpYeg3
        IZpZIN/0stTNBWkfbjfvGondZXPzhxFIJGzqCk0c86Mf
X-Google-Smtp-Source: ABdhPJwYVUlui2AC7T6vQ81NWLGM2vgiDSy9t8fSLesvFTqaLJWz7p/s8gl+y3QYqTdSrvhjt4vWn78UHbdhRAPCeqE=
X-Received: by 2002:a1c:7402:: with SMTP id p2mr2286514wmc.43.1614841948026;
 Wed, 03 Mar 2021 23:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com> <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org> <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
 <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com> <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
In-Reply-To: <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 4 Mar 2021 15:11:51 +0800
Message-ID: <CAAfSe-t1+v6549K0==EcFgU3ghC=yEZ73e70QoJz_J3MXxWBxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, 16 Feb 2021 at 23:10, Robin Murphy <robin.murphy@arm.com> wrote:
>
> >>>
> >>> On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> >>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>>
> >>>> This iommu module can be used by Unisoc's multimedia devices, such as
> >>>> display, Image codec(jpeg) and a few signal processors, including
> >>>> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> >>>>
> >>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>> ---
> >>>>   .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
> >>>>   1 file changed, 72 insertions(+)
> >>>>   create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..4fc99e81fa66
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>> @@ -0,0 +1,72 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +# Copyright 2020 Unisoc Inc.
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Unisoc IOMMU and Multi-media MMU
> >>>> +
> >>>> +maintainers:
> >>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    enum:
> >>>> +      - sprd,iommu-v1
> >>>> +
> >>>> +  "#iommu-cells":
> >>>> +    const: 0
> >>>> +    description:
> >>>> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> >>>> +      additional information needs to associate with its master device.
> >>>> +      Please refer to the generic bindings document for more details,
> >>>> +      Documentation/devicetree/bindings/iommu/iommu.txt
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +    description:
> >>>> +      Not required if 'sprd,iommu-regs' is defined.
> >>>> +
> >>>> +  clocks:
> >>>> +    description:
> >>>> +      Reference to a gate clock phandle, since access to some of IOMMUs are
> >>>> +      controlled by gate clock, but this is not required.
> >>>> +
> >>>> +  sprd,iommu-regs:
> >>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>> +    description:
> >>>> +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> >>>> +      register range used by the iommu and the media device, the cell
> >>>> +      defines the offset for iommu registers. Since iommu module shares
> >>>> +      the same register range with the media device which uses it.
> >>>> +
> >>>> +required:
> >>>> +  - compatible
> >>>> +  - "#iommu-cells"
>
> OK, so apparently the hardware is not quite as trivial as my initial
> impression, and you should have interrupts as well.

I've checked with my colleagues for this issue. And like I explained
before, one sprd IOMMU serves one master device only, so interrupts
are handled by master devices rather than IOMMUs.

Chunyan
