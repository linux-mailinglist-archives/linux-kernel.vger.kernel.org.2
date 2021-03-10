Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8677E3333EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhCJDpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhCJDpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:45:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2175C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:45:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u18so7776473plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhWQQNXXhBl9V6m34E/2PgUYDDDOUR9yglVAy9KAsHY=;
        b=wZtFlrFINw2Eair2VU4xp47Y+Zi2XmPCnVs7/PeQQ+qZL4KJz7TIbM4fSs7rkGdkWR
         Tl0SPi8DxbMK8n35d2WfRZLLZq4vPNMNMHbSFMmDEzlJFbNrHYjyFJSXibqvB6mvIPuD
         rujaYePPrZWDrQl7ZM7yyKgguW+gm+ZdWMmhJdy5CCVN12yHflTVRMooqqaZjBXgX9Kt
         cAmLiJrc1A1N7FR0ipezYhyPkO0X/Y7qlZyQlyR8kFhaSqV47S6YisodCt2dGdZPBJfi
         7LkD7ptdMN+fdaTf4amIBaL5YBjSVwYLMZjIj0Yz5VYlgXYqGz9aqnewwYhzjiUJKmF8
         xJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhWQQNXXhBl9V6m34E/2PgUYDDDOUR9yglVAy9KAsHY=;
        b=hTW0rvRzj6jXuq/G+jHHCeM530OOqvViQYD48M+8oEQQMwxbCGgO+fbu4OS9Ttb6Ly
         rafo2gJIx3FXqMAdJ4MadwSgmT9pDC63gwBclVSZF+I00DAcVrCUEoR6BZdL97Zw+Eht
         wXT9bQThyawkAncQUG0RQ880maB3vhMPznaoh6rwM5eTVMcHZ/v14HW4wRiWWh1b+v03
         epuABrTqUtLEJaN8FX7BH9ik82KxOrwE9H2McozI5VI9N3Kvab/aNfQkCJsTdkWpUsQX
         YZWFwH7hANQ2BWpLpBoCRzEc99ctYGPPyG5zRNWcf6x0DUgvJHrr7GRfeosVYoZCISAv
         YtQw==
X-Gm-Message-State: AOAM532vemLPlFAaNEKSkWWWpjldBkHW2UEO7je5/NUaCxmFgFqXfA+p
        ZMEPBwe7OfJKddqUrnt27nC/
X-Google-Smtp-Source: ABdhPJww3LXcQIsgNxaSJHDT5/xWPeMIY19nocTKUL5cDKhnuEj6JBzU0U6CZYxIYaCnJ0FAoncP0w==
X-Received: by 2002:a17:902:d114:b029:e4:87c7:39f5 with SMTP id w20-20020a170902d114b02900e487c739f5mr988931plw.72.1615347919127;
        Tue, 09 Mar 2021 19:45:19 -0800 (PST)
Received: from work ([103.66.79.59])
        by smtp.gmail.com with ESMTPSA id l2sm2149788pji.45.2021.03.09.19.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Mar 2021 19:45:18 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:15:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add a property to declare secure
 regions in Qcom NANDc
Message-ID: <20210310034514.GA11114@work>
References: <20210222120259.94465-1-manivannan.sadhasivam@linaro.org>
 <20210222120259.94465-3-manivannan.sadhasivam@linaro.org>
 <20210305233657.GA839767@robh.at.kernel.org>
 <20210308053140.GA5457@thinkpad>
 <CAL_JsqKOfQ8v=Adp_3k64-WW-YXan_1kCG9mab6rE62VkSwmhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKOfQ8v=Adp_3k64-WW-YXan_1kCG9mab6rE62VkSwmhQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 07:32:28PM -0700, Rob Herring wrote:
> On Sun, Mar 7, 2021 at 10:31 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Mar 05, 2021 at 05:36:57PM -0600, Rob Herring wrote:
> > > On Mon, Feb 22, 2021 at 05:32:58PM +0530, Manivannan Sadhasivam wrote:
> > > > On a typical end product, a vendor may choose to secure some regions in
> > > > the NAND memory which are supposed to stay intact between FW upgrades.
> > > > The access to those regions will be blocked by a secure element like
> > > > Trustzone. So the normal world software like Linux kernel should not
> > > > touch these regions (including reading).
> > > >
> > > > So let's add a property for declaring such secure regions so that the
> > > > driver can skip touching them.
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/mtd/qcom,nandc.yaml | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > > index 84ad7ff30121..7500e20da9c1 100644
> > > > --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > > +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > > @@ -48,6 +48,13 @@ patternProperties:
> > > >          enum:
> > > >            - 512
> > > >
> > > > +      qcom,secure-regions:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > >
> > > Don't you need 64-bit regions potentially? Though 4GB should be enough
> > > for anyone.
> > >
> >
> > Yes, given the size of current NAND based systems around, I thought 32 bit is
> > enough.
> 
> Huh!? I was joking. 4GB is small nowadays. Make this 64-bit.
> 

Well I was speaking in the context of Qcom chipsets making use of NAND. Mostly
the Qcom modem chipsets have <4GB of memory. But since this property is now not
specific to Qcom, I agree with you and will make it 64 bit.

Thanks,
Mani

> Rob
