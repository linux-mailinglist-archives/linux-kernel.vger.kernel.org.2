Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21936337281
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhCKMZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhCKMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:24:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F0C061574;
        Thu, 11 Mar 2021 04:24:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p7so34456632eju.6;
        Thu, 11 Mar 2021 04:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Bj1PrbXn3gHkHJv+RDFaf6IcgjKHh54NejPnGnfyo4k=;
        b=RvXOZn/rNiB27hC5Yi/2SxelMvtpDEApoDTQBbT+pglGgTi+JbxSpw8Pb/v4tDwKFh
         eFOenLKzhtM6DkkKvARdcWjqVLsPidqDmzpNUVvhYHcG14yPWQlr4/teEVU2Vp3MpuzF
         mDkhsiYs6XR+5eXyQI0t4YhAk4aQzXjLfFIIxVjlFaHnceLjyqMaylNXdZudxE0WfIK+
         aUMi8SQTo87wRk/4OS8uwbKm753wCngLvHyyAdYf/biGRUueVAr4VbofxzIWB4mo+8YG
         5juCLucR6ow+cKJuWhaneZOuFHsjQMtaYgHXNkDn9yGyDQhcexRJJ93fAocOchi8ff3h
         JKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Bj1PrbXn3gHkHJv+RDFaf6IcgjKHh54NejPnGnfyo4k=;
        b=sFCT7CHWYBzYj7/4S1m6u+TVC57hjuefOzJf6eHq7geO6kPemZ67fJHaFJk6+tarvy
         BUnownSbHFLQsWgjPlbtCbBldtlMe46ZQ5ytJdaPNkkDhrG/fR+j/v5i1Uxg/vmSOYdv
         bDSpfHYOZLaBxZfAlLhgXd2e2tsIOI8MSvHa/0F5bLLA+QWJU6pbjkf+q9BZFs08l6IA
         HooSI/XJa5jVhqxqEEYR9St2jeQlzVbe5iH0iTq0vatBQdvJn7GmW6O5HsyWQMlAXwXI
         PWY/AhjrPp0G6pSaiabbAKMQtFMTGSBFtET2nttfyMWquX71bPTwLFNQraLkIWo2RSF5
         uxXw==
X-Gm-Message-State: AOAM530IpaHL/grq7rAa1bumfueYKeXPcl6J/MBvGnHEPYnA0rcz8+K2
        /XOCLBOqsUH3jjWceWyxvIg=
X-Google-Smtp-Source: ABdhPJxP/IiRrbAzwnECNCOgeXFdx6CfLzqL0rTIPUYKwIxQj73jl2cwZsPjGKEHkZVIPbEDcjeBiA==
X-Received: by 2002:a17:906:8583:: with SMTP id v3mr2867228ejx.361.1615465497291;
        Thu, 11 Mar 2021 04:24:57 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id t16sm1238428edi.60.2021.03.11.04.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:24:56 -0800 (PST)
Date:   Thu, 11 Mar 2021 06:18:34 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
Message-ID: <YEmoKuL9IyIrUW0N@Ansuel-xps.localdomain>
References: <20210310210812.8880-1-ansuelsmth@gmail.com>
 <20210310210812.8880-2-ansuelsmth@gmail.com>
 <5d798266-3a18-d50d-9c3e-f91bc2460fe5@gmail.com>
 <YElMjg/AspNSRe0A@Ansuel-xps.localdomain>
 <1d2ad735-ad15-be6a-ad90-9c33f5845a15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d2ad735-ad15-be6a-ad90-9c33f5845a15@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 07:37:13AM +0100, Rafał Miłecki wrote:
> On 10.03.2021 23:47, Ansuel Smith wrote:
> > On Wed, Mar 10, 2021 at 11:41:24PM +0100, Rafał Miłecki wrote:
> > > See inline
> > > 
> > > On 10.03.2021 22:08, Ansuel Smith wrote:
> > > > Document nvmem-cells compatible used to treat mtd partitions as a
> > > > nvmem provider.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >    .../bindings/mtd/partitions/nvmem-cells.yaml  | 96 +++++++++++++++++++
> > > >    1 file changed, 96 insertions(+)
> > > >    create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > > > new file mode 100644
> > > > index 000000000000..f70d7597a6b0
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > > > @@ -0,0 +1,96 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Nvmem cells
> > > > +
> > > > +description: |
> > > > +  Any partition containing the compatible "nvmem-cells" will register as a
> > > > +  nvmem provider.
> > > > +  Each direct subnodes represents a nvmem cell following the nvmem binding.
> > > > +  Nvmem binding to declare nvmem-cells can be found in:
> > > > +  Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > > > +
> > > > +maintainers:
> > > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > 
> > > I think that when Rob wrote:
> > > 
> > > On 10.03.2021 03:58, Rob Herring wrote:
> > > > I think this should reference nvmem.yaml.
> > > 
> > > he meant you using:
> > > 
> > > allOf:
> > >    - $ref: "nvmem.yaml#"
> > > 
> > > (you'll need to adjust binding path).
> > > 
> > > Please check how it's done in Documentation/devicetree/bindings/nvmem/*.yaml files
> > > 
> > > 
> > 
> > Aside from that, should I readd the old properties or I can keep the
> > compatible as the only one required?
> 
> What old properties do you mean?
> 
> You shouldn't need to add anything to the list of "required" I think.
> 
> Some NVMEM providers add "#address-cells" and "#size-cells". That makes
> sense if NVMEM provider must provide at least 1 cell. I'm not sure if we
> need that for MTD.
> 
> Even "compatible" is actually redundant but most YAML files list it for
> convenience. Source:
>

Thanks for the clarification, I sent the new version hoping the yaml
documentation is now correct.

> On 10.12.2020 03:48, Rob Herring wrote:
> > And drop 'compatible' as required. It's redundant anyways because the
> > schema will only be applied if compatible matches.
> 
> http://lists.infradead.org/pipermail/linux-mtd/2020-December/084574.html
> https://patchwork.ozlabs.org/comment/2597326/
