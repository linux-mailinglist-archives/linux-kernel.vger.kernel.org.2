Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90634F79F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhCaDrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaDrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:47:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF5C061574;
        Tue, 30 Mar 2021 20:47:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f3so4006088pgv.0;
        Tue, 30 Mar 2021 20:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U0ybPJ4IUj7A9WiPX6++C9vlgGXr5Xx8nEXJ1UKkhm8=;
        b=Ovm3ccj1Gkreg3858fKpv3NAk23NEwwFzrJg8scUGuiVgd/lWz9MV0+716OM+d2wFf
         gtcf02bbchFFt2TP6DA8kMYhX7viY9Wew0V1iC3mcNZRAsp513LCmXMy4CZpIzn0KkE1
         qbNcE8wQd5P7SSBE1YJfEaMYr0t5Hxlrj4wFiH4lpRQgLugscp24O73O7B5pWaqjbUfi
         XRYzC5hNE/RECINx2jT9IsZ4mb5J9PkMW5QUXqwUj2d++OodhwmXi4501PPLOUokfDua
         c1CMXcXooDtcBxA8ELHbVp4w1hQfej39OQU9Zi7FgudIQSmHLNFBdGKBVycCiXOWx/s3
         GRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U0ybPJ4IUj7A9WiPX6++C9vlgGXr5Xx8nEXJ1UKkhm8=;
        b=pfD2cWo3crhoZJGy4+P+C6TAk1r+0dgpJrC1WdypWRAgao/zZHGLlKZer4uhdDLvhu
         bXxHoH/miXMZmWPttX1xWJIwVwiIA/29PbhiDUtrx+XtnhXjyAcMOQxswx5CAZ0HKNIm
         nc4ocCtUl08oKQofHjOl1o8ZFg4FICspEOsWyUNHPbKDyfZAuQmjiH1NwSOWovklSO//
         DhbgQO00PWlSalYINgJULatm9BcAUGHVtYlQGaGJ1RcHe2H5fQmVSgBU7orerjaNw8iS
         XbVoq0mSKBVqhsm1ZJDldNT2S67/cSo34KXdk8PrD7sd85i7FKNuMTEsAsRX5eALRTXf
         BzLQ==
X-Gm-Message-State: AOAM531ZY/+CIuDgV/h9xAs66bWzITXtGOvt1tVZEzPegjf9s920ILk2
        nz0KMJPMidZQ4mX8YtIQdek=
X-Google-Smtp-Source: ABdhPJyauHHwpjyiuukvlQwcFr75L5EGfWTiT3+42JyY+XkZ0d42RuforqZEr35yuq0JFRrmYydfXQ==
X-Received: by 2002:a65:53c8:: with SMTP id z8mr1284073pgr.340.1617162429825;
        Tue, 30 Mar 2021 20:47:09 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id j3sm407019pfc.49.2021.03.30.20.47.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Mar 2021 20:47:09 -0700 (PDT)
Date:   Tue, 30 Mar 2021 20:47:02 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tao Ren <taoren@fb.com>
Subject: Re: [PATCH] usb: gadget: aspeed: set port_dev dma mask
Message-ID: <20210331034701.GA3185@taoren-ubuntu-R90MNF91>
References: <20210326070214.6719-1-rentao.bupt@gmail.com>
 <10920f34-289c-feac-79b6-71bff2aea67d@arm.com>
 <20210326120526.GA14169@lst.de>
 <20210327221759.GA2997@taoren-ubuntu-R90MNF91>
 <20210329061735.GA27510@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329061735.GA27510@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 08:17:35AM +0200, Christoph Hellwig wrote:
> On Sat, Mar 27, 2021 at 03:17:59PM -0700, Tao Ren wrote:
> > On Fri, Mar 26, 2021 at 01:05:26PM +0100, Christoph Hellwig wrote:
> > > On Fri, Mar 26, 2021 at 12:03:03PM +0000, Robin Murphy wrote:
> > > > This might happen to work out, but is far from correct. Just wait until you 
> > > > try it on a platform where the USB controller is behind an IOMMU...
> > > >
> > > > It looks like something is more fundamentally wrong here - the device 
> > > > passed to DMA API calls must be the actual hardware device performing the 
> > > > DMA, which in USB-land I believe means the controller's sysdev.
> > > 
> > > The shiny new usb_intf_get_dma_device API provides the device to use.
> > 
> > Thanks Robin and Christoph for the feedback.
> > 
> > If I understand correctly, usb_intf_get_dma_device API is mainly for usb
> > host drivers? I just found usb_gadget_map_request_by_dev API: does it
> > make sense to replace usb_gadget_map_request with
> > usb_gadget_map_request_by_dev so we can pass the actual DMA-capable
> > hardware device (aspeed-vhub platform device) to the API?
> 
> Oh, right you're dealing with a gadget side driver.  Not sure about
> the API there, I'll let the relevant maintainers chime in.

Given this is not the right path, I will drop the patch and work out a
new fix soon (by calling usb_gadget_map_request_by_dev, and with
modified subject).


Cheers,

Tao
