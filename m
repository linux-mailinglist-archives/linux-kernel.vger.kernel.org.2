Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F533352FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhDBToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhDBToM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:44:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD4C0613E6;
        Fri,  2 Apr 2021 12:44:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so8676377ejc.10;
        Fri, 02 Apr 2021 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+lt+S/ZLdqVD9wm9kBVmCXCWXUAoepldUN0PhoFI5s=;
        b=kmNBfUDpBOi0DJY/xU75oKqd4D6q6p2aOAMhwn9z5io3OSIN9Hh1YGqvg3eRbUmUBI
         4ITjKlMojgLTITKAlqGVBRqdqC2rm+RrUozePcwxJUJERvJzqWXptjos+NT2BhfKnTKm
         /2GTWvZr+g7d3SXKE0kOkC8PsRgixcmwtmf3oX5Aqx5HtPJVbuNEBcxf0CUz9okF9HbL
         GiaE3IhpIk8ySwKEAfd1TT0Pci1p+/V6oOYmhmlwtPJN+ZGDlg34sZfKstJoAefCW/wy
         N+DBogQ6b/Np7CiVj49iIT9o20EACmMer+nhos1trVsUDocJtdTxc38BPL7LuVrWU4eV
         5lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+lt+S/ZLdqVD9wm9kBVmCXCWXUAoepldUN0PhoFI5s=;
        b=nqqit4LQA/wFyUMKianjfHuubkfgNYRVY0QPtENNqgG5QpWxOoOCaFo/Ql7uOfuwXf
         pIzJRSWgsnvjGI1YY/UlmJp30h5qAFWCCXIhGB9v0pRatiPJjk9sBh83UqVXrp2u441T
         5pFwiFLU/NscHah3/EjI7gUtLux+Ld83P42p+/Ue4ajOaJDcJ37NQsnttOLYOVp4wJj3
         BIJGHzi/+66po4v0GLi8PJ1zgUqDnOn76uJl0N8usQGoJUP7Tu0cNz9pkXyz/55+4qvk
         TOk8DBBZGtombFAMxkSXx2tI9vi3ECvtW/qJQ649T9RUx0DvBJQVFIaS1yr5meCiw0ik
         iteQ==
X-Gm-Message-State: AOAM530PogcvtfktNqs1J3IEyFJwqKUVQBu+eZxgZP9wBzDpaoAsmZrJ
        gTGTSRBs+KCKwwfqIMW41oc=
X-Google-Smtp-Source: ABdhPJyXQleTxE64fhz3EFU3mvIEn1Xv+4xInm34tWvg/gZVapJRE64ZkPWoYgoA82ILVRgVQ1I0Lg==
X-Received: by 2002:a17:906:ae8d:: with SMTP id md13mr15728393ejb.275.1617392647140;
        Fri, 02 Apr 2021 12:44:07 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id r13sm5981070edy.3.2021.04.02.12.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 12:44:06 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:44:04 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reserved-memory: Add Owl SoC serial
 number binding
Message-ID: <20210402194404.GC2052516@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <fb74862bec15f1e9e0c4d8b70ebd6c07c6eb1a40.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401170704.GA610119@robh.at.kernel.org>
 <20210401174001.GA2016477@BV030612LT>
 <20210402180607.GB31906@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402180607.GB31906@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:36:07PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 01, 2021 at 08:40:01PM +0300, Cristian Ciocaltea wrote:
> > On Thu, Apr 01, 2021 at 12:07:04PM -0500, Rob Herring wrote:
> > > On Tue, Mar 30, 2021 at 04:48:16PM +0300, Cristian Ciocaltea wrote:
> > > > Add devicetree binding for the Actions Semi Owl SoC serial number
> > > > reserved-memory range.
> > > > 
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > ---
> > > >  .../actions,owl-soc-serial.yaml               | 53 +++++++++++++++++++
> > > >  1 file changed, 53 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > > > new file mode 100644
> > > > index 000000000000..41b71f47ee6c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > > > @@ -0,0 +1,53 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/reserved-memory/actions,owl-soc-serial.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Actions Semi Owl reserved-memory for SoC serial number
> > > > +
> > > > +maintainers:
> > > > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > +
> > > > +description: |
> > > > +  Provide access to the memory region where the two parts of the Actions
> > > > +  Semi Owl SoC serial number (low & high) can be read from. This information
> > > > +  is provided by the bootloader, hence expose it under /reserved-memory node.
> > > > +
> > > > +  Please refer to reserved-memory.txt in this directory for common binding
> > > > +  part and usage.
> > > > +
> > > > +  This is currently supported only on the S500 SoC variant.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - const: actions,owl-soc-serial
> > > > +      - items:
> > > > +          - enum:
> > > > +              - actions,s500-soc-serial
> > > > +          - const: actions,owl-soc-serial
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: true
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    reserved-memory {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <1>;
> > > > +        ranges;
> > > > +
> > > > +        soc_serial: soc-serial@800 {
> > > > +            compatible = "actions,s500-soc-serial", "actions,owl-soc-serial";
> > > > +            reg = <0x800 0x8>;
> > > 
> > > You end up wasting a whole page of memory for 8 bytes. It may be better 
> > > to copy this to a DT property ('serial-number' is already a defined root 
> > > property).
> > 
> > Actually there is more information provided by the vendor bootloader
> 
> Then you should call it as socinfo or something not soc_serial.

Agree, maybe 'bootinfo' or 'fwinfo', to suggest it is coming from
firmware / bootloader.

Thanks for reviewing,
Cristi

> Thanks,
> Mani
> 
> > in this memory page, so we might use it once we are able to decode it.
> > For the moment I could only identify the serial number.
> > 
> > Thanks,
> > Cristi
> > 
> > > Rob
