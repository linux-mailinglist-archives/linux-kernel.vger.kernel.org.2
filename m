Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7163B53AB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhF0OVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:21:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51627 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229973AbhF0OVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:21:01 -0400
Received: (qmail 625832 invoked by uid 1000); 27 Jun 2021 10:18:36 -0400
Date:   Sun, 27 Jun 2021 10:18:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Igor Kononenko <i.kononenko@yadro.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb:gadget:mass-storage: Improve the signature of
 SCSI handler function
Message-ID: <20210627141836.GC624763@rowland.harvard.edu>
References: <20210626211820.107310-1-i.kononenko@yadro.com>
 <20210626211820.107310-2-i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626211820.107310-2-i.kononenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 12:18:14AM +0300, Igor Kononenko wrote:
> SCSI command handlers currently have an ambiguous return value. This

(I dislike very much this way of writing patch descriptions.  Unless
the reader has already looked at the email subject line and remembers
that this patch affects the mass-storage gadget, he will think the
sentence above is talking about command handlers in the SCSI core -- a
completely different part of the kernel.  When writing patch
descriptions, please do not assume that the reader already knows what
the patch is about.)

> return value may indicate the length of the data written to the response
> buffer and the command's processing status. Thus, the understanding of
> command handling may be implicit.

The return value is _not_ ambiguous.  If the value is >= 0 then it is
a data length, otherwise it is a status.  Yes, this is implicit, but it
is a very common pattern used throughout the kernel and everyone
understands it.

> After this patch, the output buffer's size will be set in the
> 'data_size_to_handle' field of 'struct fsg_common', and the command
> handler's return value indicates only the processing status.

What is the reason for making this change?  Does it fix any problems
or prepare the way for any future patches?  It seems like this is
completely unnecessary.

Alan Stern

> Tested: By probing the USBGadget Mass-Storage on the YADRO VEGMAN
> BMC(AST2500) sample, each SCSI command was sent through HOST->BMC; the
> USBGadget MassStorage debug print showed all sent commands works
> properly.
> 
> Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
