Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC4352EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhDBSGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234628AbhDBSGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:06:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5798E610A5;
        Fri,  2 Apr 2021 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617386774;
        bh=g6R99wNEiaWYjUZA/Zr//MAlmyK7L1YWL5mD/61jbv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGaw/CfI/k5x+byWWJbrGybqVaGb31AIwkEo5rGJ1eH835kv0HMdK73qwOtsRY6Nu
         RQ8AO0DR6v/KMLAnvA+IvKSgfp/Kw8+TLNOmSAE6RaUN10rLyeLjyhI2xu24+DcpC+
         CH1kCSTuoDB3lW/nuboMLmkgZRyBQZnZTD269RhTjbkqfXP9PEBf4P+z1gtzNpaIUy
         5i4GQ61FF1alW0z5K/fQX8HzYDusa74cH97ptCilGabfCE0pEzRu09C8ffzOaPD3iW
         RCXpfM6DHSk+3CQfGpSUrJA128uEmtUXVi/5V8Lt675cUgb6HsVmLpu2ecbbnGH4op
         oTml45c4736AQ==
Date:   Fri, 2 Apr 2021 23:36:07 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reserved-memory: Add Owl SoC serial
 number binding
Message-ID: <20210402180607.GB31906@thinkpad>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <fb74862bec15f1e9e0c4d8b70ebd6c07c6eb1a40.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401170704.GA610119@robh.at.kernel.org>
 <20210401174001.GA2016477@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401174001.GA2016477@BV030612LT>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 08:40:01PM +0300, Cristian Ciocaltea wrote:
> On Thu, Apr 01, 2021 at 12:07:04PM -0500, Rob Herring wrote:
> > On Tue, Mar 30, 2021 at 04:48:16PM +0300, Cristian Ciocaltea wrote:
> > > Add devicetree binding for the Actions Semi Owl SoC serial number
> > > reserved-memory range.
> > > 
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > >  .../actions,owl-soc-serial.yaml               | 53 +++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > > new file mode 100644
> > > index 000000000000..41b71f47ee6c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reserved-memory/actions,owl-soc-serial.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Actions Semi Owl reserved-memory for SoC serial number
> > > +
> > > +maintainers:
> > > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > +
> > > +description: |
> > > +  Provide access to the memory region where the two parts of the Actions
> > > +  Semi Owl SoC serial number (low & high) can be read from. This information
> > > +  is provided by the bootloader, hence expose it under /reserved-memory node.
> > > +
> > > +  Please refer to reserved-memory.txt in this directory for common binding
> > > +  part and usage.
> > > +
> > > +  This is currently supported only on the S500 SoC variant.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: actions,owl-soc-serial
> > > +      - items:
> > > +          - enum:
> > > +              - actions,s500-soc-serial
> > > +          - const: actions,owl-soc-serial
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    reserved-memory {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +        ranges;
> > > +
> > > +        soc_serial: soc-serial@800 {
> > > +            compatible = "actions,s500-soc-serial", "actions,owl-soc-serial";
> > > +            reg = <0x800 0x8>;
> > 
> > You end up wasting a whole page of memory for 8 bytes. It may be better 
> > to copy this to a DT property ('serial-number' is already a defined root 
> > property).
> 
> Actually there is more information provided by the vendor bootloader

Then you should call it as socinfo or something not soc_serial.

Thanks,
Mani

> in this memory page, so we might use it once we are able to decode it.
> For the moment I could only identify the serial number.
> 
> Thanks,
> Cristi
> 
> > Rob
