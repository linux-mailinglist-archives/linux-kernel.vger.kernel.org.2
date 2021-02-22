Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039AD321B85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhBVPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBVPcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:32:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E2A564E76;
        Mon, 22 Feb 2021 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614007898;
        bh=XMEZ7PH/ni+hF/4PzC80cUBZVOIDoDWFydw/tU/lfhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pz+ySTl/03N7Tyvbc8xOkfaa/v61t91srPxX0mzW7+7fEpiM+U55PDXRlAZE5uOSw
         unbPjWJBEnZ69vAvjjCsy5BuQ2QWWFstuzBRkkbNsDzxBR1Ljay6jYq3beAZvgzya8
         bieDwiFexYbtu+ADcBO/xQIoz/W2VZ5snJ0J4rLs=
Date:   Mon, 22 Feb 2021 16:26:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Gopinathan <atulgopinathan@gmail.com>
Cc:     tiwai@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH 2/2] staging: rtl8192e: Change state information from u16
 to u8
Message-ID: <YDPNKTHZqaS37XPe@kroah.com>
References: <20210220182154.9457-1-atulgopinathan@gmail.com>
 <20210220182154.9457-2-atulgopinathan@gmail.com>
 <YDJbSgqTpBpIsbVB@kroah.com>
 <20210221165721.GA10040@atulu-nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221165721.GA10040@atulu-nitro>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 10:27:21PM +0530, Atul Gopinathan wrote:
> On Sun, Feb 21, 2021 at 02:08:26PM +0100, Greg KH wrote:
> > On Sat, Feb 20, 2021 at 11:51:55PM +0530, Atul Gopinathan wrote:
> > > The "CcxRmState" field in struct "rtllib_network" is defined
> > > as a u16 array of size 2 (so, 4 bytes in total).
> > > 
> > > But the operations performed on this array throughout the code
> > > base (in rtl8192e/) are all in byte size 2 indicating that this
> > > array's type was defined wrongly.
> > > 
> > > There are two situation were u16 type of this field could yield
> > > incorrect behaviour:
> > > 
> > > 1. In rtllib_rx.c:1970:
> > > memcpy(network->CcxRmState, &info_element->data[4], 2);
> > > 
> > > Here last 2 bytes (index 4 and 5) from the info_element->data[]
> > > array are meant to be copied into CcxRmState[].
> > > Note that "data" array here is an array of type u8.
> > > 
> > > 2. In function "update_network()" in staging/rtl8192e/rtllib_rx.c:
> > > memcpy(dst->CcxRmState, src->CcxRmState, 2);
> > > 
> > > Here again, only 2 bytes are copied from the source state to
> > > destination state.
> > > 
> > > There are no instances of "CcxRmState" requiring u16 data type.
> > > Here is the output of "grep -IRn 'CcxRmState'" on the rtl8192e/
> > > directory for reviewing:
> > > 
> > > rtllib_rx.c:1970:			memcpy(network->CcxRmState, &info_element->data[4], 2);
> > > rtllib_rx.c:1971:			if (network->CcxRmState[0] != 0)
> > > rtllib_rx.c:1975:			network->MBssidMask = network->CcxRmState[1] & 0x07;
> > > rtllib_rx.c:2520:	memcpy(dst->CcxRmState, src->CcxRmState, 2);
> > > rtllib.h:1108:	u8	CcxRmState[2];
> > 
> > You just changed the logic in line 1975 in that file, right?  Are you
> > _SURE_ that is ok?  Do you have a device to test this on?
> 
> I'm sorry, I didn't quite get you. By line 1975 in rtllib_rx.c, did you mean
> the following line?:
> 
> network->MBssidMask = network->CcxRmState[1] & 0x07;

Yes.

> network->CcxRmState is being fed with 2 bytes of u8 data, in line 1970 (as
> seen above). I believe my patch doesn't change the logic of an "&" operation
> being performed on it with 0x07, right?

It changes the location of the [1] operation to point to a different
place in memory from what I can tell, as you changed the type of that
array.

thanks,

greg k-h
