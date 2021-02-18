Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2531EDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhBRSCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:02:21 -0500
Received: from verein.lst.de ([213.95.11.211]:48730 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhBRPZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:25:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70B5268D07; Thu, 18 Feb 2021 16:24:25 +0100 (CET)
Date:   Thu, 18 Feb 2021 16:24:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: 6eb0233ec2d0 ("usb: don't inherity DMA properties
 for USB devices")
Message-ID: <20210218152425.GA19470@lst.de>
References: <ef15869a-fe87-aef2-591d-2ca909a66217@suse.de> <20210218150746.GA18220@lst.de> <ef51698a-cd93-47b3-b79f-8c86a4c215fc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef51698a-cd93-47b3-b79f-8c86a4c215fc@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 04:21:26PM +0100, Thomas Zimmermann wrote:
> Sure, it's at [1]. For udl, the dmabuf would need to be in system memory. 
> The driver creates urbs from the framebuffer content and sends them to the 
> device for displaying.
>
> My question is more: what's the best interface to do this? Is there example 
> code somewhere?

URBs do point to system memory most of the time.  I'm not a real USB
expert, but usb-storage or uas would be classic examples for drivers
that take arbitrary memory controller by another layer and do DMA to/from
that.
