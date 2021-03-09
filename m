Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480843326EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhCINXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhCINWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:22:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 935E564EBB;
        Tue,  9 Mar 2021 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615296158;
        bh=1EFXFdWdy9jqGH7GztwPtxJl3Ik8XXMI2QnXDTM9ISY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9883S8OhLtd2nNUeWjXlmOAJIH1xYbsN6y0lLnOBZukEeVnRGU9B14EuFaiDUpXa
         i9A9K+mLRYxj9K9DJqehHGrPur6wyRRr3ERnw3TxSw2EfP6jWbqzeuxR+ekWoeOHAy
         9RrR2ajS788+BsBkHKfmBNtdDF42d+jI5r0mIhRw=
Date:   Tue, 9 Mar 2021 14:22:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangkun <zhangkun4jr@163.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Kun <zhangkun@cdjrlc.com>
Subject: Re: [PATCH] xhci: Remove unused value len from xhci_unmap_temp_buf
Message-ID: <YEd2m3shhzq+Ihh9@kroah.com>
References: <20210306120644.74406-1-zhangkun4jr@163.com>
 <YEOs5w8AYutM27/u@kroah.com>
 <3ad81fd6-e88e-f55b-fe82-ac7804bc354c@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad81fd6-e88e-f55b-fe82-ac7804bc354c@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 09:14:26AM +0800, Zhangkun wrote:
> On 3/7/21 12:25 AM, Greg Kroah-Hartman wrote:
> > On Sat, Mar 06, 2021 at 08:06:44PM +0800, zhangkun4jr@163.com wrote:
> >> From: Zhang Kun <zhangkun@cdjrlc.com>
> >>
> >> The value assigned to len by sg_pcopy_from_buffer() never used for
> >> anything, so remove it.
> >>
> >> Signed-off-by: Zhang Kun <zhangkun@cdjrlc.com>
> >> ---
> >>  drivers/usb/host/xhci.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> >> index bd27bd670104..6ebda89d476c 100644
> >> --- a/drivers/usb/host/xhci.c
> >> +++ b/drivers/usb/host/xhci.c
> >> @@ -1335,7 +1335,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
> >>  
> >>  static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
> >>  {
> >> -	unsigned int len;
> >>  	unsigned int buf_len;
> >>  	enum dma_data_direction dir;
> >>  
> >> @@ -1351,7 +1350,7 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
> >>  				 dir);
> >>  
> >>  	if (usb_urb_dir_in(urb))
> >> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> >> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> >>  					   urb->transfer_buffer,
> >>  					   buf_len,
> >>  					   0);
> > 
> > SHouldn't this be checked instead of ignored?
> >
> 
> Hi, Greg.
> Considering your tips I checked sg_pcopy_from_buffer(). it copys data
> from urb->transfer_buffer to urb->sg, and only returns 0 or the 
> 'number of copied bytes', and seems to has no other exception branchs
> that need to be checked. So I think it should be ingnored.

Why should you not check that the number of bytes was copied properly?

thanks,

greg k-h
