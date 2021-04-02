Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0EB352FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhDBT0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:26:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB85C0613E6;
        Fri,  2 Apr 2021 12:25:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so6367031eds.4;
        Fri, 02 Apr 2021 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eBa1l0nkkvfTf4uuzpNC8DhkE5lg+13JVTfQ5ud3GcE=;
        b=A5owe0ywEifla9cqAwxdKeZzym4fxNR9UBjsxw86RxuLyevdtD34PPVnFCPX1XZDD8
         97B1ynxpvQGkMusOuC2GvfxNZD666mpEf3EzauHUDxcBllWka/mZTCubSaZmPFi1YdQH
         CS1GACuYXaOB4JHh1Titvx/SO6KfNDx3u80Hc8KRe7AP4Kngxul9MFdjW/ZyGu4in5mW
         LGYQKbFegQEmaes5kRgHgCX3c/0eZ4KCXlkXadCj/rNDVvRb3SDI1hs31wiOmygCw+hr
         r4c1XiCH6vVkxsoYbVyYFomUTjgQZeOc0vC5cX2ms5AA9DrjQ9vcEZaPOAf0bkSTA0V2
         rd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBa1l0nkkvfTf4uuzpNC8DhkE5lg+13JVTfQ5ud3GcE=;
        b=dhSEVyhKJ5CgyHgVbQzHrOrgVd+Ptvcp4WW+/xDXPb1f7P36zJFQ44VGB9dn/U+Mne
         5K/KQQBr22ts1sPV0YrmPAWTcG5BxsQLNs3ghP/9NAXzniiJJ0a9eEfQ0OO5BhJ5Yhrz
         bUf1xndllDmQLOGBTx7pJtw+2PXu306GHzkaZKzQGl5y8fJvvocZgolrYG9bk1kSQrYu
         Z7OfGUt2x8uQEVTali9PrxnaBWZfO7dQF8s/Y1HCtdCP9TF0Zgkp8D1NKCpAnyHjX+OG
         FlrCcYHpteWsw9HVHrInuBi5JK0Wukm2TzyfUF2u+D7J2rp+oi3CL+cMrKmUsGzKreVm
         bbXA==
X-Gm-Message-State: AOAM533hbrOLQJGyvFj7dV/L0KdoS/cHSPvONNHbKZA+QcjxrtKEW3pi
        wNtKf9yUMd48Ij5MFnNGGDfxWImXhJg=
X-Google-Smtp-Source: ABdhPJyavIkdyCjowSW48m9XSi0klJz2e7GZPVIBZdf7s99BueQwLG4v7nsfEpVUkPZMMnS81OZ3+g==
X-Received: by 2002:a05:6402:2787:: with SMTP id b7mr1875410ede.225.1617391558402;
        Fri, 02 Apr 2021 12:25:58 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id x24sm754352edr.36.2021.04.02.12.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 12:25:57 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:25:55 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: soc: actions: Add Actions Semi Owl
 socinfo binding
Message-ID: <20210402192555.GA2052516@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <15da0257b10aa62bfb7046437915d05a614c01ee.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210402180407.GA31906@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402180407.GA31906@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:34:07PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 30, 2021 at 04:48:17PM +0300, Cristian Ciocaltea wrote:
> > Add devicetree binding for the Actions Semi Owl socinfo driver.
> > 
> 
> Devicetree binding shouldn't be added for a driver instead for an IP or hw.
> 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  .../bindings/soc/actions/owl-socinfo.yaml     | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> > new file mode 100644
> > index 000000000000..01e4a8b4f5ac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/actions/owl-socinfo.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Actions Semi Owl SoC info module
> > +
> > +maintainers:
> > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > +
> > +description: |
> > +  Actions Semi Owl SoC info module provides access to various information
> > +  about the S500, S700 and S900 SoC variants, such as serial number or id.
> > +
> 
> S700/S900 are not yet confirmed, so please avoid them.
> 
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - actions,s500-soc
> > +          - actions,s700-soc
> > +          - actions,s900-soc
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - actions,s500-soc
> > +          - actions,s700-soc
> > +          - actions,s900-soc
> > +      - const: simple-bus
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    / {
> > +        compatible = "roseapplepi,roseapplepi", "actions,s500";
> > +        model = "Roseapple Pi";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        soc {
> > +            compatible = "actions,s500-soc", "simple-bus";
> 
> No. This shouldn't fall under /soc. I think you should added a separate
> compatible for the reserved memory itself and add a corresponding socinfo
> driver under drivers/soc.
> 
> This way it is obvious that the information is contained in a memory region and
> a driver is used for parsing that.

I avoided on purpose to bind the driver on the reserved memory node
in order to be able to handle also the S700 and S900 SoCs, for which
we currently provide (only) the following information: machine, family,
soc_id.

I assumed the serial_number is not mandatory and we can use the driver
as it is for all SoC variants. I don't know how the serial number for
S700 and S900 could be read, but I think it is very likely they require
a different access method.

Hence my intention was to keep the driver generic, not coupled strictly
with the serial number information.

Regards,
Cristi

> Thanks,
> Mani
> 
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            ranges;
> > +        };
> > +    };
> > +
> > +...
> > -- 
> > 2.31.1
> > 
