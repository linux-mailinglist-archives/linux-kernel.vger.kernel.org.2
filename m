Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B5933706C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhCKKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:47:29 -0500
Received: from verein.lst.de ([213.95.11.211]:40356 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232394AbhCKKrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:47:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 037A468B05; Thu, 11 Mar 2021 11:47:13 +0100 (CET)
Date:   Thu, 11 Mar 2021 11:47:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210311104712.GA16218@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru> <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de> <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 12:00:30PM -0800, Keith Busch wrote:
> On Wed, Mar 10, 2021 at 02:41:10PM +0100, Christoph Hellwig wrote:
> > On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
> > > Can you try this patch instead?
> > > 
> > > http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html
> > 
> > Actually, please try the patch below instead, it looks like our existing
> > logic messes up the units:
> 
> This seems like a good opportunity to incorporate TP4040 for non-MDTS
> command limits. I sent a proposal here
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2021-March/023522.html
> 
> And it defaults to your suggestion if the controller doesn't implement
> the capability.

I think TP4040 is good and useful, but I defintively want the pure
fix get in first.
