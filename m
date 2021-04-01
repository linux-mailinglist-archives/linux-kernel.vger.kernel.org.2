Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B656E351F58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhDATIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbhDATGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:06:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C598CC03D225;
        Thu,  1 Apr 2021 10:57:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b7so4171277ejv.1;
        Thu, 01 Apr 2021 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SU4RbOPNHP2ZwBcuTmWq/GTcYcUsYxKHBsEME1pvvGQ=;
        b=Pk+H3SeIsgoAjYphDeLPalvCm6EsJbsA7KyLIPux7/WfS3x7EsLRgUNfTPL4QwprU3
         sHWuE5J2TsFm5rYykvq+Vn4uw2nmvPDVjeEnQQ9hDzxbn3U3a3+3WlCHUhEXFpCW13N+
         /vSnIMRA6aHL9eRRmias0UlyXR/0nbCS8ba+mBEVsLz40sOSo5NAq3LhSN6JvTD3ml7w
         jBSXTrdIcjUwtNlUTLYVhXfob8OnG3eH7o5AsljAUNBylL1TTiQNWdx5zLunp4cptHFX
         t2JIJe9XIsyu5Ul9/4lN3UokJtOwhYeQDo9BjnbedAGxHj37dVRX3RBJ4EY79+PMLPe9
         +Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SU4RbOPNHP2ZwBcuTmWq/GTcYcUsYxKHBsEME1pvvGQ=;
        b=sC7GFsv2emXQ62sK3W6+ZPincUPI+sZWOXmFHc8p+liV7ONS2fFGSeTEVW/0EvUH+o
         Po0bc8wQTMRqFx28VYiMCQqob221BDg8peP9Ycp7ZfwkbBAzsyYGQdF6lAmhWtJUuSZn
         +iGbjg8hMkko2OOilXcgjqvQYKTRl8zABYErgyFBoQR7WANZV3jqh7T/2xooe7NTzlJS
         hLnulYnCciNzqzpvBZlBx4TwDTLPFCjivo7seh/qRn7Wt7euwJHpRXltsntxNRV7CrTo
         xNRbVsH5l1mIPSR54lKIi4bRTwLw4oxJ+tsCoTzsm2dy87XHGyO9d1i9hfVObo5x/ha7
         hqXQ==
X-Gm-Message-State: AOAM530CjWhTB2m2MwT9yMwvmpe1Pe+3mLLKg7IQAikBZXDIGw9MDOkj
        ODcqkUT07rTDs4wC4T+Y0zo=
X-Google-Smtp-Source: ABdhPJzdA/tAYmJiie7zrEmMoslDQAs4DVN4ChKNsQPEoQCee4kryfkGjoQcSj/rqZOo4zGkwdVSvQ==
X-Received: by 2002:a17:907:110c:: with SMTP id qu12mr10556442ejb.442.1617299825578;
        Thu, 01 Apr 2021 10:57:05 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id yk8sm3167870ejb.123.2021.04.01.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:57:05 -0700 (PDT)
Date:   Thu, 1 Apr 2021 20:57:02 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: soc: actions: Add Actions Semi Owl
 socinfo binding
Message-ID: <20210401175702.GB2016477@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <15da0257b10aa62bfb7046437915d05a614c01ee.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401170818.GB610119@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401170818.GB610119@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:08:18PM -0500, Rob Herring wrote:
> On Tue, Mar 30, 2021 at 04:48:17PM +0300, Cristian Ciocaltea wrote:
> > Add devicetree binding for the Actions Semi Owl socinfo driver.
> > 
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
> What's the actual h/w for this bus? Still looks like abuse of DT to 
> create your virtual soc_info driver.

Right, there is no bus involved in accessing soc info, but I assumed
the already existing soc node in common DTS is a good candidate for
binding the driver. (e.g. arch/arm/boot/dts/owl-s500.dtsi)

Should I, instead, create a dedicated sub-node?

Thanks,
Cristi

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
