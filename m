Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3188A42D2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhJNGvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhJNGvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:51:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A7C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:48:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r18so16094233wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tbshLX4iQMb9Vn7zjhDZQ6BLeAzJL58tLLtT5Oc9Dyw=;
        b=I2fHaN3SeLVf9AvOIVBuIk8A4RiG2X+cOS+8PIYpKXwXpREvI0UYUa3AmutRXJY64P
         4bfUqx39QdhxEMiaLoI4Yw6w0u9e1tf5xvKOcaSqYLeTxBLbUyBNxVSz8PVwMd6pCYod
         JBs3CS7I3Z+CcHLLsmWM55Y9rB94vXZDUCwV91qtTf8zLe4WuYpVmR+38WZI+v5VE56+
         u5+5yywIjxW8478iGD6VPrZxETHyeFSKHh5eXS+y8h/wNhdgsRb1F19Q8awkWe8gArWh
         OrGPDREEMcWFcE/44ApebQDNTMr3icPhUh5/jWErfauFvdooYEzBaHYP5grV1Y9H6CNk
         huYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tbshLX4iQMb9Vn7zjhDZQ6BLeAzJL58tLLtT5Oc9Dyw=;
        b=kzxsrNTs2BnauedrLu89f5370hrhUIeIRFyPTUopl927ZV99SdEitfk073zL1+dIlW
         +VuVrYGWF1l3yltLBTT5Oy6qJ2ZY1w99oOM10Bv23N6EUvWzzc+8APiDuTn/PUC5B2Va
         GogVET+M/VlN0TGAEVSIlFLBb8/Z5oCdD4X6XyAgyBK0V2wbMEUhaf0lq2JE84l5nW7m
         7SFfGKhVSyRJadLh23vMuioQXPl1+IISu2W8lb0Y4R7MohhTFWW6YNfNU3CnlpdKONT4
         AVxo3RYbXN/YXoGQja+BFEkYBMTG/ciVtumr5jqrAX6Vmuy4tRKhVRfSUKzrT1lHf3Sd
         8png==
X-Gm-Message-State: AOAM533u5j5V1xHJBJoETsq9ev+WW6t9qL7tVyj7o+Wuo9gT5q63OMgK
        fwZoBGFw9EhXAX+BAKnM5hB18w==
X-Google-Smtp-Source: ABdhPJwAtr+FLRUkC+UlVcvalCv0LKlHgZ+gVNPU1pBCubjLqcZDhzl9BvNotbQ8efjygcpi2Ovdeg==
X-Received: by 2002:adf:b1c7:: with SMTP id r7mr4568194wra.392.1634194131265;
        Wed, 13 Oct 2021 23:48:51 -0700 (PDT)
Received: from google.com (176-35-142-29.xdsl.murphx.net. [176.35.142.29])
        by smtp.gmail.com with ESMTPSA id w8sm1543502wrr.47.2021.10.13.23.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 23:48:50 -0700 (PDT)
Date:   Thu, 14 Oct 2021 07:48:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YWfSz00Rj5AVhkgT@google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com>
 <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com>
 <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Tue, Oct 12, 2021 at 10:15 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 11 Oct 2021, Rob Herring wrote:
> > > On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> > > >
> > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > >
> > > > > Add bindings for Unisoc system global register which provide register map
> > > > > for clocks.
> > > > >
> > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > > > >  1 file changed, 68 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> > > >
> > > > Unapplied v3 and applied this (v4) instead, thanks.
> > >
> > > What about the clock binding this depends on:
> > >
> > > Unknown file referenced: [Errno 2] No such file or directory:
> > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > xargs: dt-doc-validate: exited with status 255; aborting
> > > make[1]: *** Deleting file
> > > 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> > > Unknown file referenced: [Errno 2] No such file or directory:
> > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > make[1]: *** [scripts/Makefile.lib:385:
> > > Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> > > Error 255
> > >
> > >
> > > Once again, all the components of MFD bindings need to be applied together.
> 
> Just ran into this, too...
> 
> > I can't apply what is not sent to me.
> >
> > This patch came in on its own.
> 
> Then please reject/postpone patches that don't build (yet) ;-)

I don't explicitly build DT documentation.

Since I use the build bots to let me know if there are strange !(C,
ASM, arm, aarch64, mips, ppc, x86) build issues or ones with odd
configuration possibilities (randconfig) in the repos I maintain, you
might have to convince them that this is important too.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
