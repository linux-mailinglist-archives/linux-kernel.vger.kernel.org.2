Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324BA427392
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbhJHWWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:22:04 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38511 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhJHWWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:22:01 -0400
Received: by mail-oi1-f177.google.com with SMTP id t4so13753807oie.5;
        Fri, 08 Oct 2021 15:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UU6kbMIJ6P0+5LUEJL0eEAN6Y3jPevBlPgH2FjrwHnA=;
        b=6m7l58ZqzCgBjCZUu6prLMLynijDqQh6An/+WJgR8By9uGRpyMwt+k91NWovCLMoZr
         E+a5MLXRoIx10N1Fwlf9sVcaujEUIAGc7JIXVnHa89VC1pbtQ+Pmy7WFKuHX3sSCGtjO
         a7DEz1k1Bvqfo3mtv99Y5KXpxJn97612riizPVLHShjtpHmrOR06GFaZ3voKvbfjGPQI
         BLlLxBQPBhXWIs9m9OCb0fQe4Oh3wMJpn3626srOmzdpBowwUXE64P2jsm7vflrz25Y/
         aVu8yI+YtKqS4UpaMosYDi5GRist2LpsI9rXqFmU77XDS7IuZIC4wpVUTF1xdhavu/0e
         0DJw==
X-Gm-Message-State: AOAM5316Yq2g5i7cWBqNSsHysvCLbzLwvrcCsR4K3qMeudfHjdXDPPUw
        jlJaq/7zkBx2K0EWZnji3NuSkvU/Kg==
X-Google-Smtp-Source: ABdhPJzy7BWI36byfDiSz/sSJ/LcU68rMB1Z+VoTQBSiuLbVB1C7jFa2dQsUtAsjty74pAZ7+8mnig==
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr9290273oic.61.1633731604863;
        Fri, 08 Oct 2021 15:20:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a13sm159169oiy.9.2021.10.08.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:20:02 -0700 (PDT)
Received: (nullmailer pid 3419237 invoked by uid 1000);
        Fri, 08 Oct 2021 22:20:01 -0000
Date:   Fri, 8 Oct 2021 17:20:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/16] dt-bindings: i2c: imx: update schema to align
 with original txt binding
Message-ID: <YWDEESYAuQSIfOSQ@robh.at.kernel.org>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
 <20211001000417.15334-3-leoyang.li@nxp.com>
 <CAL_JsqJShTL4zf2Bh=fYHfsujKu1rtuduxp7EKYsRqEXdkLCEA@mail.gmail.com>
 <CADRPPNRhVuHTxTpU8RCBMMTVe2V23pjqt8Z5vV=5efepWk6yPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNRhVuHTxTpU8RCBMMTVe2V23pjqt8Z5vV=5efepWk6yPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 12:37:54PM -0500, Li Yang wrote:
> On Fri, Oct 1, 2021 at 8:24 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Sep 30, 2021 at 7:04 PM Li Yang <leoyang.li@nxp.com> wrote:
> > >
> > > When the binding was converted from txt to yaml, it actually added more
> > > constrains than the original txt binding which was already used in many
> > > in-tree DTSes.  Some of the newly added constrains are either not valid
> > > or not neccessary.
> >
> > IMO, both of these should be fixed in the dts files.
> >
> > > Not all SoCs use ipg as the clock name for i2c.  There is no point in
> > > having SoC integration information defined in i2c binding.  Remove the
> > > clock name requirement in the schema.
> >
> > Any name you want is not fine. Your choices are remove clock-names,
> > add all the names used, or change everyone to use 'ipg'.
> 
> I understand that the name should be important as clocks are
> referenced by name.  But since the i2c controller only has one clock ,
> the name is never referenced in the driver.

Then just remove 'clock-names' from the dts file.

> If we really want to define the name, IMO, it should be from the
> perspective of the i2c controller like "clkin" or "i2c" instead of the
> "ipg" from the perspective of SoC integration which could be changing
> with a different integration.  I can list both "i2c" and "ipg" for now
> as a workaround though.

$modulename for $foo-names always looks made up and pointless to me.

> 
> >
> > > The original txt binding didn't require the order of tx and rx for
> > > dmas/dma-names.  Many in tree DTSes are already using the other order.
> > > Both orders should just work fine.  Update the schema to allow both.
> >
> > Doesn't sound like a case where defining the order is challenging.
> 
> No, it is not challenging.  But as dma channel is only referenced by
> name instead of index.  I don't see too much benefit in enforcing the
> order other than easier to create the schema.

Easier is nice, and that's the 'DT way' is the other reason.

Rob
