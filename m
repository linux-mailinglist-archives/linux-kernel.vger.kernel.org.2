Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45793EF2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhHQT6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:58:37 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36467 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:58:36 -0400
Received: by mail-oi1-f182.google.com with SMTP id bd1so869216oib.3;
        Tue, 17 Aug 2021 12:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XswSKX2YNfn4fxq6lztzp7gFskvRH1mEGY9i4/UDIcE=;
        b=XLud5UxglgSHWYr9oUt+DbGEL8WshlkWsmhBot8Ier2yXoJwe2z8cZB+0B9W5zgzDY
         RZJS4GVMM76fNJnVYcdKf2C/E9gdsBCwLFjmyoMIciqXdOuKWZDCX+z3sDuzhioRnno0
         7I9bUFOmbyD4/rxQf+1uNnP/XLbNaNSfspgeMGbX5YfmAriWSt+l+RIwHBOh+09LW9ix
         sk5Q0aQn3e6RoMnQC314ameJSiZNXkGF98b1C/FeY1elxO1iyu8gVfuRdCbBGhl3yLiX
         hEqdja8875t5KlfHf/Z2IoRY5aXqr2pI/JETLOYhhLTOWvdN+CAK5XPFxuBospV+8NRN
         691g==
X-Gm-Message-State: AOAM532wrXxSTDx/eYgEzUnPpfJq70BMLtWq24jjdXH6TrtZsVFPZEtt
        wpSoCOc0VioQEtgJM9v/lQ==
X-Google-Smtp-Source: ABdhPJw2YJdPmm6vI/tJq6qFR0OSaSyTEaX+Og+DxLv0oF+LjxctmQIYipB7L03BC/A+QDfMHjuSJg==
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr3997896oic.49.1629230282576;
        Tue, 17 Aug 2021 12:58:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s63sm697959oia.52.2021.08.17.12.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:58:01 -0700 (PDT)
Received: (nullmailer pid 744134 invoked by uid 1000);
        Tue, 17 Aug 2021 19:58:00 -0000
Date:   Tue, 17 Aug 2021 14:58:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, shawnguo@kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
Message-ID: <YRwUyLsvoSpFI9X8@robh.at.kernel.org>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-2-qiangqing.zhang@nxp.com>
 <6e3f6881-929d-1663-58f1-39bf35069175@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e3f6881-929d-1663-58f1-39bf35069175@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 11:16:49AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 10/08/2021 08:35, Joakim Zhang wrote:
> > Introduce "reverse-data" property for nvmem provider to reverse buffer.
> > 
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > ---
> >   Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > index b8dc3d2b6e92..bc745083fc64 100644
> > --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > @@ -61,6 +61,11 @@ patternProperties:
> >                 description:
> >                   Size in bit within the address range specified by reg.
> > +      reverse-data:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Reverse the data that read from the storage device.
> > +
> 
> This new property is only going to solve one of the reverse order issue
> here.
> If I remember correctly we have mac-address stored in various formats ex:
> from old thread I can see
> 
> Type 1: Octets in ASCII without delimiters. (Swapped/non-Swapped)
> Type 2: Octets in ASCII with delimiters like (":", ",", ".", "-"... so on)
> (Swapped/non-Swapped)
> Type 3: Is the one which stores mac address in Type1/2 but this has to be
> incremented to be used on other instances of eth.
> Type 4: Octets as bytes/u8, swapped/non-swapped
> 
> I think its right time to consider adding compatibles to nvmem-cells to be
> able to specify encoding information and handle post processing.

Yes. Trying to handle this with never ending new properties will end up 
with a mess. At some point, you just need code to parse the data.

Rob
