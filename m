Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED15414012
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 05:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhIVDen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 23:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhIVDem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 23:34:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44630C061574;
        Tue, 21 Sep 2021 20:33:13 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 67-20020a9d0449000000b00546e5a8062aso1548089otc.9;
        Tue, 21 Sep 2021 20:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9/VqydJPaYn+KOsQ3ofv9BvxBUh6olGmsxG6Mgl2mg=;
        b=FJWQK1VWOnsPvkZYXz2bF5UdFYSr+MIVkUU3hZtxh2JWJh5nw5GavUirzAqU/6LiPV
         87/RccVmsQSM/M3dAHmpX4zQIt2Y6vH4no3XraBLoZxKDuvANK7xz2A5zD4ZERwlCd2K
         1qZVOQGh8v7bIuMLS5VO9t0qRsfy7KXMHG1m7u6YAcP3dyNUQa8B4pxeRiSPQRnVOLHA
         krxpbra56nvjGaaaaZlbzBC0f+LThuGvR8alQF9GE9FlhvAg48IUBxiqENHl3FsAOyDj
         BTv2axcbKfoKD77Db9EmZ1HPdjJr4rKuvVElA1jSf+jLPmmPcqXPJYpLweISAeiqaqg1
         MAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9/VqydJPaYn+KOsQ3ofv9BvxBUh6olGmsxG6Mgl2mg=;
        b=ISvhMW/XkzfsVw1k4BKou7XQHQDaDZ3T5ZY908hOdpNnfRm3ShGzL/ReO6SwKMCzaO
         v6kVulMEuUzsGyjhP1lQbGjXj3gijAFnzCu7OSvzlHaIUCR7FeQfjsj1HE/TtSm4MJQD
         MOEppDnhaV0j1j9kwrVXSJokgRT+eGs5O9EP8u+NsQRf4oKIPgeMADKcmBXXcv1ZNSFZ
         x0c8YF9HN5Hp47XvntXg4N29ptSV9AmR5TedyGLprj6E7jG2tCVZZ37CdQ7SBnRHyq1y
         YG/OqYvU2ijqN7/34tVv90vGsRJQmEecrocfXnR2RJ7C4bfr3OiTdJznkc98PrwrllJs
         gAMg==
X-Gm-Message-State: AOAM532jXsYMhj7hrbCHHi51yY7EK6PPH4BrbnJqYRWJ5gHdMbwiUWmZ
        gLU4Nt0iz2kn+0lNRXeXBwRDNfOykAO57QCRDts=
X-Google-Smtp-Source: ABdhPJxMwlE4S9+wL2//e0l5NUrJwLNFSPjga5R7+6TkCsiM1UoIb2AdeOpiyF2KIbCKJJ23FzP2b7aehusQnnGmftk=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr29174385otf.152.1632281592646;
 Tue, 21 Sep 2021 20:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210916084714.311048-1-zhang.lyra@gmail.com> <20210916084714.311048-3-zhang.lyra@gmail.com>
 <YUNUyolr6ksEoZI3@robh.at.kernel.org> <CAAfSe-vYMUb8wGUJG7Fzehjkj8gAq1QOdgCdsTvcNyMuVeEW8g@mail.gmail.com>
 <CAL_JsqKmznCOk+qHFccnG1b5xuoNHY2vmqyv=WAjB9d=0AW70Q@mail.gmail.com>
In-Reply-To: <CAL_JsqKmznCOk+qHFccnG1b5xuoNHY2vmqyv=WAjB9d=0AW70Q@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 22 Sep 2021 11:32:36 +0800
Message-ID: <CAAfSe-sruhCCZopyserimaTYnxGmXv87nkd+T4v1uzbjCz1C7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sept 2021 at 20:42, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 17, 2021 at 3:41 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > On Thu, 16 Sept 2021 at 22:29, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Sep 16, 2021 at 04:47:12PM +0800, Chunyan Zhang wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > Add a new bindings to describe ums512 clock compatible strings.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
> > > >  1 file changed, 106 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > > new file mode 100644
> > > > index 000000000000..be3c37180279
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > > @@ -0,0 +1,106 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright 2019-2021 Unisoc Inc.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > +
> > > > +title: UMS512 Clock Control Unit Device Tree Bindings
> > > > +
> > > > +maintainers:
> > > > +  - Orson Zhai <orsonzhai@gmail.com>
> > > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > > +
> > > > +properties:
> > > > +  "#clock-cells":
> > > > +    const: 1
> > > > +
> > > > +  compatible:
> > > > +    enum:
> > > > +      - sprd,ums512-apahb-gate
> > > > +      - sprd,ums512-ap-clk
> > > > +      - sprd,ums512-aonapb-clk
> > > > +      - sprd,ums512-pmu-gate
> > > > +      - sprd,ums512-g0-pll
> > > > +      - sprd,ums512-g2-pll
> > > > +      - sprd,ums512-g3-pll
> > > > +      - sprd,ums512-gc-pll
> > > > +      - sprd,ums512-aon-gate
> > > > +      - sprd,ums512-audcpapb-gate
> > > > +      - sprd,ums512-audcpahb-gate
> > > > +      - sprd,ums512-gpu-clk
> > > > +      - sprd,ums512-mm-clk
> > > > +      - sprd,ums512-mm-gate-clk
> > > > +      - sprd,ums512-apapb-gate
> > > > +
> > > > +  clocks:
> > > > +    minItems: 1
> > > > +    maxItems: 4
> > > > +    description: |
> > > > +      The input parent clock(s) phandle for this clock, only list fixed
> > > > +      clocks which are declared in devicetree.
> > > > +
> > > > +  clock-names:
> > > > +    minItems: 1
> > > > +    maxItems: 4
> > > > +    items:
> > > > +      - const: ext-26m
> > > > +      - const: ext-32k
> > > > +      - const: ext-4m
> > > > +      - const: rco-100m
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - '#clock-cells'
> > > > +
> > > > +if:
> > > > +  properties:
> > > > +    compatible:
> > > > +      enum:
> > > > +        - sprd,ums512-ap-clk
> > > > +        - sprd,ums512-aonapb-clk
> > > > +        - sprd,ums512-mm-clk
> > > > +then:
> > > > +  required:
> > > > +    - reg
> > > > +
> > > > +else:
> > > > +  description: |
> > > > +    Other UMS512 clock nodes should be the child of a syscon node in
> > > > +    which compatible string should be:
> > > > +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> > > > +
> > > > +    The 'reg' property for the clock node is also required if there is a sub
> > > > +    range of registers for the clocks.
> > >
> > > In which cases is this not true?
> >
> > Seems not needed, I will remove 'reg' property for this kind of cases.
>
> Wrong direction. Please keep 'reg'. My question is why can't you
> always have it? That is the preference.

Ok. I will address. BTW, do we need 'reg' even though the driver
doesn't read this property? Does that because DT should reflect
hardware topology?

Thanks for the comments,
Chunyan

>
> Rob
