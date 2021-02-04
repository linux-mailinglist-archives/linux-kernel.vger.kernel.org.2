Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96130EC82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhBDGbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232623AbhBDGbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:31:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E53CC64DFF;
        Thu,  4 Feb 2021 06:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612420258;
        bh=KiqsDmwoOQBWMdKETEVcciZtR/5mNdfe3xrYoqgAiew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXBLYF+4J1h7scQUbCEycVWnDj7dmRPygVWhY8ghGCWTCEBd7RLxBAEpozurtLn+k
         gRz+moIQpZpbfIGkn6KD5zAtYR/FM6Y8DH7zdehq2QtaRkihnLO0I8bM7Eu+fJD1ai
         Rot1O8jvr1w+iGzbHvOEPV8g6ZqpuW+UhZF2l4pc=
Date:   Thu, 4 Feb 2021 07:30:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] usb: cdnsp: Fix spelling mistake "delagete" ->
 "delegate"
Message-ID: <YBuUnyFPvPNhkXEu@kroah.com>
References: <20210203111239.18313-1-colin.king@canonical.com>
 <20210203130440.GV2696@kadam>
 <BYAPR07MB5381361C15E436BE54D25C93DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB5381361C15E436BE54D25C93DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:07:16AM +0000, Pawel Laszczak wrote:
> Hi Dan,
> 
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> There is a spelling mistake in a literal string. Fix it.
> >>
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  drivers/usb/cdns3/cdnsp-ep0.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
> >> index e2b1bcb3f80e..e30931ebc870 100644
> >> --- a/drivers/usb/cdns3/cdnsp-ep0.c
> >> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
> >> @@ -45,7 +45,7 @@ static int cdnsp_ep0_delegate_req(struct cdnsp_device *pdev,
> >>  {
> >>  	int ret;
> >>
> >> -	trace_cdnsp_ep0_request("delagete");
> >> +	trace_cdnsp_ep0_request("delegate");
> >>
> >
> >This printk is useless and should just be deleted.  Use ftrace instead.
> 
> Maybe this printk is redundant but it's more comfortable in use.
> To debug I can simply enable cdns-dev events (echo cdnsp-dev:* > set_event)
> and I will get the full  picture of what the driver is doing.
> 
> Otherwise, I must remember which function I need to add to set_ftrace_filter.
> Of course, by default I can simply add all cdnsp* functions (echo cdnsp* > set_ftrace_filter) but it
> increases the trace log and makes it a little more difficult to analyze.
> 
> So maybe in some cases we shouldn't complain for such printk ?
> 
> It's my private opinion and not necessarily correct :)

Please don't have duplicate tracepoints for something like "this
function is now called", it's redundant.

thanks,

greg k-h
