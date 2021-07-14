Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6E3C7BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhGNC0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237422AbhGNC0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:26:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03AB261279;
        Wed, 14 Jul 2021 02:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626229441;
        bh=gOi7KaVgFlagOhuLpVTxxtzuSTGWggZ4MGJ4k0/eUo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bo3o+hrwV9LLnk3uDznIW6nL/vu31KPyck1XxrpYKAilnLwIFk8y16XLLfLD6ivoN
         AZQ3UUvuWJvrs4T/6zTKZ9R4rNV9Ww9Tl4Kc+eZ+B+3TCoJC4XmR9ynRGO7KRpwdBO
         HBMpa0F7VAfwp6V+hbs+9o84HmK0bfQfjTeWqGplY358I59v/Q3DePQjFXOBUBsPPL
         6/rfxNtT/mbWYbCZUrtzOdMTPx/Z/ZdmEMF4b82bCTU5H5heTgMPz8JOTu8CeGMlyo
         wxEjIPvTRvOXv7g3xBLlipJ0J1d2NNzqrDcuBYpiRRtGgOmhIMB3tNv2JOzA5oxIL2
         U7G64AFABTlhQ==
Date:   Wed, 14 Jul 2021 10:23:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "Marek MV. Vasut" <marex@denx.de>
Subject: Re: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Message-ID: <20210714022354.GA31370@dragon>
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
 <20210602195009.GA3870858@robh.at.kernel.org>
 <b765351a7c3542d2a66ab1168f1ff222@dh-electronics.com>
 <bfbd70ca-b5a6-f7a7-4c7d-72ac86874227@denx.de>
 <76d6cc846f4f473083e597303956ff11@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d6cc846f4f473083e597303956ff11@dh-electronics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 07:38:44AM +0000, Christoph Niedermaier wrote:
> From: Marek Vasut [mailto:marex@denx.de]
> Sent: Wednesday, June 16, 2021 1:33 PM
> 
> 
> > On 6/16/21 1:19 PM, Christoph Niedermaier wrote:
> >> Send reply also to Rob Herrings +dt email address:
> >>
> >> From: Rob Herring <robh@kernel.org>
> >> Sent: Wednesday, June 2, 2021 9:50 PM
> >>
> >>> On Tue, May 25, 2021 at 04:30:01PM +0200, Christoph Niedermaier wrote:
> >>>> Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards.
> >>>>
> >>>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> >>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Cc: robh+dt@kernel.org
> >>>> Cc: Shawn Guo <shawnguo@kernel.org>
> >>>> Cc: kernel@dh-electronics.com
> >>>> To: devicetree@vger.kernel.org
> >>>> ---
> >>>> V2: Remove line with fsl,imx6s on the DRC02 Board
> >>>> ---
> >>>>   Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
> >>>>   1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>>> index fce2a8670b49..3c4ff79a3be7 100644
> >>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> >>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>>> @@ -407,6 +407,12 @@ properties:
> >>>>             - const: dfi,fs700e-m60
> >>>>             - const: fsl,imx6dl
> >>>>
> >>>> +      - description: i.MX6DL DHCOM PicoITX Board
> >>>> +        items:
> >>>> +          - const: dh,imx6dl-dhcom-picoitx
> >>>> +          - const: dh,imx6dl-dhcom-som
> >>>> +          - const: fsl,imx6dl
> >>>> +
> >>>>         - description: i.MX6DL Gateworks Ventana Boards
> >>>>           items:
> >>>>             - enum:
> >>>> @@ -458,6 +464,12 @@ properties:
> >>>>             - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
> >>>>             - const: fsl,imx6dl
> >>>>
> >>>> +      - description: i.MX6S DHCOM DRC02 Board
> >>>> +        items:
> >>>> +          - const: dh,imx6s-dhcom-drc02
> >>>> +          - const: dh,imx6s-dhcom-som
> >>>> +          - const: fsl,imx6dl
> >>>
> >>> fsl,imx6s?
> >>
> >> In the first version I had here an additional line with "fsl,imx6s",
> >> but currently the kernel isn't supporting that compatible. The i.MX6
> >> Solo is currently supported by "fsl,imx6dl". So my idea was to add
> >> both "fsl,imx6dl" and "fsl,imx6s" to match it maybe on a later kernel
> >> version. If there is no match with the Solo now, it will fall back to
> >> the i.MX6 DualLite. That is why I had both fsl,imx6s and fsl,imx6dl
> >> in that order. On Fabio's advice, I removed the line with "fsl,imx6s"
> >> in version 2.
> >> Is this what you meant by your comment?
> > 
> > I didn't notice that at first myself, but I think what Rob means is
> > 
> > - const: dh,imx6s-dhcom-drc02
> > - const: dh,imx6s-dhcom-som
> > - const: fsl,imx6dl <------ this should be consistent with the two above
> > 
> > that is
> > 
> >   - const: dh,imx6s-dhcom-drc02
> >   - const: dh,imx6s-dhcom-som
> > -- const: fsl,imx6dl
> > +- const: fsl,imx6s
> >                ^^^^^
> > 
> > But that is a bit odd here:
> > - The MX6S is MX6DL with one CPU core disabled.
> > - The DRC02 device can only house a SOM with MX6S and NOT with MX6DL
> > (due to some thermal design consideration or something).
> > - The kernel discerns the MX6S/MX6DL automatically based on the number
> > of cores it reads from some register, therefore it only has the
> > fsl,mx6dl compatible to cover both MX6S and MX6DL.
> > So, the closest fallback compatible for this device really is the MX6DL,
> > i.e. fsl,imx6dl.
> > 
> > So I think this patch is correct as-is, no ?
> 
> Is this Patch OK?

Can we explain that fsl,imx6s thing a bit with some comments or commit
log?

Shawn
