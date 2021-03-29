Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413B034C3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 08:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhC2GR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:17:56 -0400
Received: from verein.lst.de ([213.95.11.211]:52215 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhC2GRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:17:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80D5868B05; Mon, 29 Mar 2021 08:17:35 +0200 (CEST)
Date:   Mon, 29 Mar 2021 08:17:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20210329061735.GA27510@lst.de>
References: <20210326070214.6719-1-rentao.bupt@gmail.com> <10920f34-289c-feac-79b6-71bff2aea67d@arm.com> <20210326120526.GA14169@lst.de> <20210327221759.GA2997@taoren-ubuntu-R90MNF91>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327221759.GA2997@taoren-ubuntu-R90MNF91>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 03:17:59PM -0700, Tao Ren wrote:
> On Fri, Mar 26, 2021 at 01:05:26PM +0100, Christoph Hellwig wrote:
> > On Fri, Mar 26, 2021 at 12:03:03PM +0000, Robin Murphy wrote:
> > > This might happen to work out, but is far from correct. Just wait until you 
> > > try it on a platform where the USB controller is behind an IOMMU...
> > >
> > > It looks like something is more fundamentally wrong here - the device 
> > > passed to DMA API calls must be the actual hardware device performing the 
> > > DMA, which in USB-land I believe means the controller's sysdev.
> > 
> > The shiny new usb_intf_get_dma_device API provides the device to use.
> 
> Thanks Robin and Christoph for the feedback.
> 
> If I understand correctly, usb_intf_get_dma_device API is mainly for usb
> host drivers? I just found usb_gadget_map_request_by_dev API: does it
> make sense to replace usb_gadget_map_request with
> usb_gadget_map_request_by_dev so we can pass the actual DMA-capable
> hardware device (aspeed-vhub platform device) to the API?

Oh, right you're dealing with a gadget side driver.  Not sure about
the API there, I'll let the relevant maintainers chime in.
