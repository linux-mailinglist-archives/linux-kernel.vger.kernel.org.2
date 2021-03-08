Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4C330772
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhCHFcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhCHFbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:31:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399CC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 21:31:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fu20so2392797pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 21:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6KPV3/KbWE2HuRXQZJZq+2hlPT8uhIFakoNQQIGrqls=;
        b=DX9cwjVgBK75Dkwx+YOKuf4B3lGYlteXC/BzinWqNppm9ZMjzbpTMH1Ivs0Tx9GMRF
         VkhMAIfLQSSE+lJJbbKVfzoqZQoHcNZlgLsAcR5ND6/iJoNKlJVe89V2b68fBwVRKf5C
         bKTfGm3C49XZbC/62uS5eLjx4lB8ZS1AMxEN2zxCKzvrh7mfTHOMfG+Uvm6IDVaFofES
         VU18HGQl6e36QdbqgbkP/F4lkbBJ4DC14nqHdDBBeL2i5VwD2GWYA5WKV5PTFKMu40Kk
         tK/MrA/zkvphtq4g4GcsEF7k0XNoxNA9khe9qiRxCKIHEtqEzcfDteHASfqDsU6FXqyj
         05CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6KPV3/KbWE2HuRXQZJZq+2hlPT8uhIFakoNQQIGrqls=;
        b=GpI+jrW/X5i5wYwfM4RgcoHNNkMPzI+gvgewPh9YNsExDCTfzydbWVccpbl/m4NzcP
         Ix3GyT1TunQSdO44tHQ1m7aBdHU0bQEYGHEh1Bz5w1kDvBlr4u14HXQs2FKYCkQtgfIR
         uPxNmTCoKS8dfEX2nWi95GYaOxvOvA38cv7lUqSJredTVZ4uhSls8Ul78A28gSuv0flg
         NFlZjjksJtK3dekJgXrkykjUci24cQKT8kIG+e5+foJlRcJ7P8D2FKCirXP71iVpYKEk
         P415mp9nJ69xftdhvRsXgRp4LL6EsZ+ehIAmyPpglxTGxEtjMhxzC4mk8dABbEhwHXLn
         m+dw==
X-Gm-Message-State: AOAM531EuzYOC67Wzhu3ZOHuW8wx59nBYPYqWA+BVgwyKJEJrnX9k9r3
        aYRpNuoCrpmFUJxaNhzeBmoT
X-Google-Smtp-Source: ABdhPJx31x9DVwCjlrBofFQyrwjvdvqlfdUbyu2xgtdfmFEquErlvlidAh6xBqgbkgdBxd/xWYxDsg==
X-Received: by 2002:a17:90b:4008:: with SMTP id ie8mr22112177pjb.231.1615181507921;
        Sun, 07 Mar 2021 21:31:47 -0800 (PST)
Received: from thinkpad ([2409:4072:6e84:fef9:1070:d306:6d0e:bf6b])
        by smtp.gmail.com with ESMTPSA id h13sm2411179pjv.52.2021.03.07.21.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 21:31:47 -0800 (PST)
Date:   Mon, 8 Mar 2021 11:01:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add a property to declare secure
 regions in Qcom NANDc
Message-ID: <20210308053140.GA5457@thinkpad>
References: <20210222120259.94465-1-manivannan.sadhasivam@linaro.org>
 <20210222120259.94465-3-manivannan.sadhasivam@linaro.org>
 <20210305233657.GA839767@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305233657.GA839767@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:36:57PM -0600, Rob Herring wrote:
> On Mon, Feb 22, 2021 at 05:32:58PM +0530, Manivannan Sadhasivam wrote:
> > On a typical end product, a vendor may choose to secure some regions in
> > the NAND memory which are supposed to stay intact between FW upgrades.
> > The access to those regions will be blocked by a secure element like
> > Trustzone. So the normal world software like Linux kernel should not
> > touch these regions (including reading).
> > 
> > So let's add a property for declaring such secure regions so that the
> > driver can skip touching them.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/mtd/qcom,nandc.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > index 84ad7ff30121..7500e20da9c1 100644
> > --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > @@ -48,6 +48,13 @@ patternProperties:
> >          enum:
> >            - 512
> >  
> > +      qcom,secure-regions:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> Don't you need 64-bit regions potentially? Though 4GB should be enough 
> for anyone.
> 

Yes, given the size of current NAND based systems around, I thought 32 bit is
enough.

> If more than one addr+size, then you need a matrix.
> 

Okay.

Thanks,
Mani

> > +        description:
> > +          Regions in the NAND memory which are protected using a secure element
> > +          like Trustzone. This property contains the start address and size of
> > +          the secure regions present (optional).
> > +
> >  allOf:
> >    - $ref: "nand-controller.yaml#"
> >  
> > -- 
> > 2.25.1
> > 
