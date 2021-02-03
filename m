Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD630E073
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhBCRC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhBCQ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:57:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F49964F7C;
        Wed,  3 Feb 2021 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612371424;
        bh=I+g8x9mYX7X8vykWccvemJU19qt28o5A6TRl10sMrI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2CCg+31Wd2u3fNfOUCiJBtfZzbZ9QK4fiA9EFMoBaxez5C5VE3VHiCrsVNjjUbi6
         sIlL5JxN8+kdyMibj+G3Xczs1auu6GYr7Fo/wn0Y18P5gxMiS8NgYBcrxteEhXhXxE
         nOUOmWqn0DE9gbMky+cAgaqxHk0aVLLP+terDeIOBbszItkyq8U7h0BSjjlcAEZbcP
         q0IadN+iLpXJ47mIfiVVMcU6gUlOWHE8os7heWnvloFj0aM8CCERjB6y1oAOs68kaz
         KUMLpzlV2ZsY7RCHWqklmYQmEKuju1RAaf1DhTimxTVuyCaynbl5lpsik/F+hddGsc
         ATdhvUH/Lo30Q==
Date:   Wed, 3 Feb 2021 08:57:01 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, serebrin@amazon.com,
        dwmw@amazon.co.uk, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Message-ID: <20210203165701.GB2182779@dhcp-10-100-145-180.wdc.com>
References: <20210203094338.19473-1-sironi@amazon.de>
 <20210203095148.GA8897@lst.de>
 <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
 <20210203111548.GA11075@lst.de>
 <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:22:31PM +0100, Filippo Sironi wrote:
> 
> On 2/3/21 12:15 PM, Christoph Hellwig wrote:
> > 
> > On Wed, Feb 03, 2021 at 12:12:31PM +0100, Filippo Sironi wrote:
> > > I don't disagree on the first part of your sentence, this is a big
> > > oversight.
> > 
> > But it is not what your commit log suggests.
> 
> I can definitely rephrase the commit.
> 
> > > On the other hand, those controllers are out there and are in use by a lot
> > > of customers.  We can keep relying on luck, hoping that customers don't run
> > > into troubles or we can merge a few lines of code :)
> > 
> > Your patch does not just quirk a few controllers out there, but all
> > current and future controllers with an Amazon vendor ID.  We could
> > probably talk about quirking an existing vendor ID or two as long as
> > this doesn't happen for future hardware.
> 
> I know that the hardware team is working on this but I don't know the
> timelines and there are a few upcoming controllers - of which I don't know
> the device ids yet - that have the same issue.
> 
> To avoid issues, it is easier to apply the quirk to all Amazon NVMe
> controllers for now till the new lines of controllers with the fix comes
> out.  At that point, we'll be able to restrict the application to the known
> bad controllers.

Just set the quirk for the known device id's and append more as needed
(which should hopefully never happen). Sure, your future broken devices
may not work with the first kernel that introduced the quirk, but this
is how the quirks should be documented in the code.
