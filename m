Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFA3F1C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhHSPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhHSPGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:06:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12A5A6113D;
        Thu, 19 Aug 2021 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629385539;
        bh=LGZKmQwPGywDOK76NamejmfBRkmI5bWYX8EQHyNOtYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFMkEnqsoWtwZiEbZiGpyS0Cg4duOAjVf+cB88adbS/SQPyw/B0t6tB4HsKmsV5T9
         xfHrzvrYdKScH/pudb7r5Encmn61xEI0bjk83hVcUB0NF13czFCdXjkRBYo/bXuGR6
         cveAfJS3wou7w5lghZrKJYZoecX+XIhnUfe9WvV4=
Date:   Thu, 19 Aug 2021 17:05:36 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Chunfeng Yun =?utf-8?B?KOS6keaYpeWzsCk=?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] usb: xhci-mtk: Do not use xhci's virt_dev in
 drop_endpoint
Message-ID: <YR5zQD8dFWsXu5Ns@kroah.com>
References: <20210805133731.1.Icc0f080e75b1312692d4c7c7d25e7df9fe1a05c2@changeid>
 <2593ac262cdf0088e937b9fbc907bb23a6736fb5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2593ac262cdf0088e937b9fbc907bb23a6736fb5.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 11:56:59AM +0000, Chunfeng Yun (云春峰) wrote:
> Hi Greg,
> 
> On Thu, 2021-08-05 at 13:37 +0800, Ikjoon Jang wrote:
> > xhci-mtk depends on xhci's internal virt_dev when it retrieves its
> > internal data from usb_host_endpoint both in add_endpoint and
> > drop_endpoint callbacks. But when setup packet was retired by
> > transaction errors in xhci_setup_device() path, a virt_dev for the
> > slot
> > is newly created with real_port 0. This leads to xhci-mtks's NULL
> > pointer
> > dereference from drop_endpoint callback as xhci-mtk assumes that
> > virt_dev's
> > real_port is always started from one. The similar problems were
> > addressed
> > by [1] but that can't cover the failure cases from setup_device.
> > 
> > This patch drops the usages of xhci's virt_dev in xhci-mtk's
> > drop_endpoint
> > callback by adopting rhashtable for searching mtk's schedule entity
> > from a given usb_host_endpoint pointer instead of searching a linked
> > list.
> > So mtk's drop_endpoint callback doesn't have to rely on virt_dev at
> > all.
> > 
> > [1] 
> > https://lore.kernel.org/r/1617179142-2681-2-git-send-email-chunfeng.yun@mediatek.com
> > 
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > ---
> > 
> >  drivers/usb/host/xhci-mtk-sch.c | 140 ++++++++++++++++++----------
> > ----
> >  drivers/usb/host/xhci-mtk.h     |  15 ++--
> >  2 files changed, 86 insertions(+), 69 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-
> > mtk-sch.c
> > index cffcaf4dfa9f..f9b4d27ce449 100644
> > --- a/drivers/usb/host/xhci-mtk-sch.c
> > +++ b/drivers/usb/host/xhci-mtk-sch.c
> > 
> 
> I see the patch is already in usb-next branch, but find some new bugs
> introduced after I test it (one NULL point dereference oops, two memory
> leakage due to no error handling). 
> What do I need to do? revert this patch then send new version or just
> send fix patches?

Which ever you want to do is fine with me.

thanks,

greg k-h
