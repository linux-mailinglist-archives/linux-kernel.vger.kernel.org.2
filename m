Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510CD330967
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCHIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhCHIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:30:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989ABC06174A;
        Mon,  8 Mar 2021 00:30:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z5so4521503plg.3;
        Mon, 08 Mar 2021 00:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFZnRQT1kh3PTofEu3jThuC4HSujQlKB7AiJII7TDhg=;
        b=e8G2IdhgdYzEj4NyoxKGd4j9H+Q0jDro8g03Ih3nwovl5NhcyGmEpwCbQPHg/7w+pq
         S+J7O2aXPFfG7VtgiNde7//uWfLPMHMTjMg+wBncpRRNnjXjmwPJ6puL/ZUwZrcAGx2j
         jc6InRDkiUTn2FPydikTbMy6ijETrx88u+Tp+EaQZD+Et9b/5WzHH+rJRRzwe2DnMxr7
         sy9nM/HfkALTemt4ssI6nSrIfOvr2WIRPQCzas6ybfYMi8Y81a30erxcEIlWUDTaLZEz
         R62jVpOL/xe0qGZ1qC/VN5mER41Y+Z0JgFMlW4Ab/ANTnN9A4Jvmyanpld5IolvbCrmp
         JQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gFZnRQT1kh3PTofEu3jThuC4HSujQlKB7AiJII7TDhg=;
        b=SAI7ks1hwcApJQDRssJve7FIfEVZLmAhd1p36/RdoNZJHvwb48+CezkNR1iApffGEV
         qYIZFxj6m2BNdBvTelrJRd/Spm5JPVnJXOXw9hoGD7Y+5xgcg+ZqwuVbTloB7n/E7YhV
         45AB8xDUivRiZAAhExd2auAVgdSbipjd28FySRaVSs2RMFSmeKPJqQl7STrADRsAkPMJ
         HwHdoEtMd+nSTRiw95iTyCMkx2EPkPwyVrXJhphUzRlFY9yDrlUStQtaCnYaAyFGDcC4
         bFOB4X20vwIjumEANNPINcsKxUue/FqXUbswWZbeLz1h4OzgZ0QPv4r2v+7a1eL55EQe
         GHSQ==
X-Gm-Message-State: AOAM532QhMnc5E/UHTsGvQMJJLIwt/iRWK2Je5wlHv97hnj2Q4FUQ4gS
        DY3MSPEQvqv6ob8j/2DHe7H/Kz2SSf7H3g==
X-Google-Smtp-Source: ABdhPJy6nEPP/Yq0QpvN1WDe/4pXFncw5Az5O0fVS2Cf3YfGD29HjwBVgcqW5rRM5M67DmvsPrk5iw==
X-Received: by 2002:a17:90a:f195:: with SMTP id bv21mr4408922pjb.26.1615192204108;
        Mon, 08 Mar 2021 00:30:04 -0800 (PST)
Received: from lenovo ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t10sm10099306pjf.30.2021.03.08.00.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 00:30:03 -0800 (PST)
Date:   Mon, 8 Mar 2021 16:29:57 +0800
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haidong Yao <yaohaidong369@gmail.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mailbox: Add interrupt-names to SPRD
 mailbox
Message-ID: <20210308082957.GA23482@lenovo>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haidong Yao <yaohaidong369@gmail.com>,
        Orson Zhai <orson.zhai@unisoc.com>
References: <20210213122143.19240-1-orsonzhai@gmail.com>
 <20210213122143.19240-3-orsonzhai@gmail.com>
 <20210305212221.GA667054@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305212221.GA667054@robh.at.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Mar 05, 2021 at 03:22:21PM -0600, Rob Herring wrote:
> On Sat, Feb 13, 2021 at 08:21:42PM +0800, Orson Zhai wrote:
> > From: Orson Zhai <orson.zhai@unisoc.com>
> > 
> > We add an optional supp-outbox interrupt support to SPRD mailbox driver
> > with newly added sc9863a support and change to configure interrupts with
> > names in device tree files.
> > 
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >  .../bindings/mailbox/sprd-mailbox.yaml         | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> > index 26a5cca3f838..67736450ee93 100644
> > --- a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> > @@ -15,6 +15,7 @@ properties:
> >    compatible:
> >      enum:
> >        - sprd,sc9860-mailbox
> > +      - sprd,sc9863a-mailbox
> >  
> >    reg:
> >      items:
> > @@ -22,9 +23,18 @@ properties:
> >        - description: outbox registers' base address
> >  
> >    interrupts:
> > -    items:
> > -      - description: inbox interrupt
> > -      - description: outbox interrupt
> > +    minItems: 2
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    oneOf:
> > +      - items:
> > +          - const: inbox
> > +          - const: outbox
> > +      - items:
> > +          - const: inbox
> > +          - const: outbox
> > +          - const: supp-outbox
> 
> You can do this instead:
> 
> interrupt-names:
>   minItems: 2
>   items:
>     - const: inbox
>     - const: outbox
>     - const: supp-outbox

Does this mean only the first 2 items in the minimum range?

For example, "inbox" + "supp-outbox" is not supposed to be a valid combination. 

Only "supp-outbox" is optional and the other two are mandatory.

Best,
Orson

> 
> >  
> >    clocks:
> >      maxItems: 1
> > @@ -40,6 +50,7 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > +  - interrupt-names
> >    - "#mbox-cells"
> >    - clocks
> >    - clock-names
> > @@ -56,5 +67,6 @@ examples:
> >        clock-names = "enable";
> >        clocks = <&aon_gate 53>;
> >        interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > +      interrupt-names = "inbox", "outbox";
> >      };
> >  ...
> > -- 
> > 2.17.1
> > 
