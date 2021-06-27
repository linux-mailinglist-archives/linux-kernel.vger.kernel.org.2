Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B753B53BA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhF0O0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:26:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55677 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230304AbhF0O0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:26:20 -0400
Received: (qmail 625898 invoked by uid 1000); 27 Jun 2021 10:23:55 -0400
Date:   Sun, 27 Jun 2021 10:23:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Igor Kononenko <i.kononenko@yadro.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] usb:gadget:mass-storage: refactoring the SCSI
 command handling
Message-ID: <20210627142355.GD624763@rowland.harvard.edu>
References: <20210626211820.107310-1-i.kononenko@yadro.com>
 <20210626211820.107310-3-i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626211820.107310-3-i.kononenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 12:18:15AM +0300, Igor Kononenko wrote:
> Implements a universal way to define SCSI commands and configure
> precheck handlers.

What is the reason for doing this?

At first glance, it appears you have added a great deal of complexity
to the driver.  The patch replaces a large amount of easily understood
(albeit rather repetitious) code with an approximately equal amount
of rather complicated code.  This does not seem like an improvement.

Furthermore, the code you removed is flexible; it easily allows for
small variations as neede by some command handlers.  But the code you
added is all table-driven, which does not easily permit arbitrary
variations.

> Tested: By probing the USBGadget Mass-Storage on the YADRO VEGMAN
> BMC(AST2500) sample, each SCSI command was sent through HOST->BMC; the
> USBGadget MassStorage debug print showed all sent commands works
> properly.
> 
> Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 540 +++++++++++--------
>  drivers/usb/gadget/function/storage_common.h |   5 +
>  2 files changed, 310 insertions(+), 235 deletions(-)

I don't see the point of adding 75 lines to the kernel source if they
don't accomplish anything new.

Alan Stern
