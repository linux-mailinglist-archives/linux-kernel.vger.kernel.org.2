Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0263B6230
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhF1Omj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:42:39 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57635 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234871AbhF1OeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:34:24 -0400
Received: (qmail 658330 invoked by uid 1000); 28 Jun 2021 10:31:58 -0400
Date:   Mon, 28 Jun 2021 10:31:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "i.kononenko" <i.kononenko@yadro.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fms: Add TOC/PMA/ATIP DVD-ROM capabilities
Message-ID: <20210628143158.GD656159@rowland.harvard.edu>
References: <20210626211820.107310-1-i.kononenko@yadro.com>
 <20210626211820.107310-4-i.kononenko@yadro.com>
 <20210627142952.GE624763@rowland.harvard.edu>
 <3f9c6e4a-18b7-db11-8b23-f0473a649d06@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9c6e4a-18b7-db11-8b23-f0473a649d06@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 09:45:07PM +0300, i.kononenko wrote:
> 
> 
> On 27.06.2021 17:29, Alan Stern wrote:
> > Is any of this really needed?  What usage scenarios require
> > f_mass_storage to emulate a DVD-ROM that couldn't use f_tcm instead?
> 
> I can't see any impediments to supplement the already existing 
> implementation of MMC-(2/3) specification of multimedia devices to 
> represent the DVD/BD features. If the kernel presents the CD-ROM SCSI 
> commands, why the mass_storage:usb-gadget-function still doesn't include
> that for DVD/BD?
> 
> Many modern embedded systems (e.g., BMC, OpenBMC) implements their 
> required features, e.g., Virtual Media Device, which is based on the 
> usb:gadget:mass-storage. 
> The purpose of that features is extensive, and their use the mass-storage
> not only as a cdrom-device.
> 
> The required features of such systems might expect image back-end files
> that size is significant than 2.1Gb, but such medium is not the CD-ROM 
> device. USB-gadget consumers can incorrectly interpret such device by 
> loading the wrong driver. I believe that should be the DVD-medium device,
> at least. 

You should include this information in the patch description, so that 
people will understand why you wrote the patch.

> Additionally, please note the current patch also fixes the incorrect 
> implementation of retrieving TOC/PMA/ATIP data, which is required for the 
> CD-ROM. One system might correct works with retrieving first with the 
> last session together, but for some systems, e.g., OS ESXi, OS Windows, 
> should retrieving first and last border sessions in separate SCSI-request. 

What's wrong with the existing implementation?  Are you talking about 
the do_read_toc function?  The driver only supports one session in any 
case.

In general, fixes to existing code and additions of new code should go 
in separate patches.

Alan Stern
