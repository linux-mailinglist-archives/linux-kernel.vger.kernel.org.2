Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8732A96B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835166AbhCBSWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447342AbhCBPda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:33:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E83064F26;
        Tue,  2 Mar 2021 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614695935;
        bh=ydwXkzdGhOj9zcgCANyD7fxEOPed/pe6TMwr9IlnaY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgqhXCSMxj8vTFl3sd9lG0URscBcRsXAxSQBwFeTbx3Wlr8i172tXm4gl0vBP6s4t
         u1kxxXNsqAQt/oNCMvBNbz/15QjUTHG3yLpP7jdsoePsOhyPsawvQWJpEr6VaH37mT
         +KfYhUqRjzL2UiwlNzTK34viKvN0CIMul0+oLzU4=
Date:   Tue, 2 Mar 2021 15:38:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Gopinathan <atulgopinathan@gmail.com>
Cc:     tiwai@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH 2/2] staging: rtl8192e: Change state information from u16
 to u8
Message-ID: <YD5N/LYgzQwYX+N1@kroah.com>
References: <20210220182154.9457-1-atulgopinathan@gmail.com>
 <20210220182154.9457-2-atulgopinathan@gmail.com>
 <YDJbSgqTpBpIsbVB@kroah.com>
 <20210221165721.GA10040@atulu-nitro>
 <YDPNKTHZqaS37XPe@kroah.com>
 <20210222172330.GA2507@atulu-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222172330.GA2507@atulu-ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 10:53:30PM +0530, Atul Gopinathan wrote:
> On Mon, Feb 22, 2021 at 04:26:33PM +0100, Greg KH wrote:
> > On Sun, Feb 21, 2021 at 10:27:21PM +0530, Atul Gopinathan wrote:
> > > On Sun, Feb 21, 2021 at 02:08:26PM +0100, Greg KH wrote:
> > > > On Sat, Feb 20, 2021 at 11:51:55PM +0530, Atul Gopinathan wrote:
> > > > > The "CcxRmState" field in struct "rtllib_network" is defined
> > > > > as a u16 array of size 2 (so, 4 bytes in total).
> > > > > 
> > > > > But the operations performed on this array throughout the code
> > > > > base (in rtl8192e/) are all in byte size 2 indicating that this
> > > > > array's type was defined wrongly.
> > > > > 
> > > > > There are two situation were u16 type of this field could yield
> > > > > incorrect behaviour:
> > > > > 
> > > > > 1. In rtllib_rx.c:1970:
> > > > > memcpy(network->CcxRmState, &info_element->data[4], 2);
> > > > > 
> > > > > Here last 2 bytes (index 4 and 5) from the info_element->data[]
> > > > > array are meant to be copied into CcxRmState[].
> > > > > Note that "data" array here is an array of type u8.
> > > > > 
> > > > > 2. In function "update_network()" in staging/rtl8192e/rtllib_rx.c:
> > > > > memcpy(dst->CcxRmState, src->CcxRmState, 2);
> > > > > 
> > > > > Here again, only 2 bytes are copied from the source state to
> > > > > destination state.
> > > > > 
> > > > > There are no instances of "CcxRmState" requiring u16 data type.
> > > > > Here is the output of "grep -IRn 'CcxRmState'" on the rtl8192e/
> > > > > directory for reviewing:
> > > > > 
> > > > > rtllib_rx.c:1970:			memcpy(network->CcxRmState, &info_element->data[4], 2);
> > > > > rtllib_rx.c:1971:			if (network->CcxRmState[0] != 0)
> > > > > rtllib_rx.c:1975:			network->MBssidMask = network->CcxRmState[1] & 0x07;
> > > > > rtllib_rx.c:2520:	memcpy(dst->CcxRmState, src->CcxRmState, 2);
> > > > > rtllib.h:1108:	u8	CcxRmState[2];
> > > > 
> > > > You just changed the logic in line 1975 in that file, right?  Are you
> > > > _SURE_ that is ok?  Do you have a device to test this on?
> > > 
> > > I'm sorry, I didn't quite get you. By line 1975 in rtllib_rx.c, did you mean
> > > the following line?:
> > > 
> > > network->MBssidMask = network->CcxRmState[1] & 0x07;
> > 
> > Yes.
> > 
> > > network->CcxRmState is being fed with 2 bytes of u8 data, in line 1970 (as
> > > seen above). I believe my patch doesn't change the logic of an "&" operation
> > > being performed on it with 0x07, right?
> > 
> > It changes the location of the [1] operation to point to a different
> > place in memory from what I can tell, as you changed the type of that
> > array.
> 
> Oh yes, earlier, the network->CcxRmState[] array had memory locations as:
> [x, x+16]. With this patch, it's locations are [x, x+8].
> 
> And I strongly believe this is how it should be based on how the original
> author is using the CcxRmState[] array throughout the codebase:

Ok, but this has changed the way memory is addressed, which is what I
was trying to point out when you said that nothing had changed.

> Allow me to explain (Based on the output of "grep -IRn 'CcxRmState'" that
> I sent previously):
> 1. At line 1970:
> 
>     memcpy(network->CcxRmState, &info_element->data[4], 2);
> 
> this is where the array CcxRmState[] is being fed with
> data. And one can see the source is an array named "data" which itself
> has type u8. The third argument is "2", meaning 2 bytes of data should
> be written from "data" array to "CcxRmState".
> 
> Also note that, the array CcxRmState has a size 2, as defined in
> rtllib.h, in struct "rtllib_network":
> 
>     u16 CcxRmState[2];
> 
> Say if CcxRmState[] _was_ supposed to be u16 and not u8, then both elements
> of the source "data" array will only be written into the first element of
> "CcxRmState", i.e, "CcxRmState[0]". The 2nd element, "CcxRmState[1]" will
> never be fed with any data. The resultant CcxRmState[] array would look
> something like this:
> 
>     [(u8-data and u8-data squashed), 0].
> 
> The 2 u8-data here refers to info_element->data[4] and
> info_element->data[5].
> 
> Instead, if "CcxRmState" was of type u8, then both elements of source
> "data" array will be written into the 2 elements of "CcxRmState"
> respectively:
> 
>     [u8 data, u8 data]
> 
> This makes a lot more sense.
> 
> 2. Line 1975:
>     network->MBssidMask = network->CcxRmState[1] & 0x07;
> 
> With point 1 clear, it should now be easy to understand that
> the the "&" operation in line 1975, will _always_ yield 0 if "CcxRmState"
> is u16, simply because CcxRmState[1] is never fed with any data at
> all.
> 
> Oh and "network->MBssidMask" is also of type u8.
> 
> 3. Line 2520:
> memcpy(dst->CcxRmState, src->CcxRmState, 2);
> 
> 2 bytes, and not 4, again.:D
> The above line belongs to the following function:
> 
>     static inline void update_network(struct rtllib_device *ieee,
>                       struct rtllib_network *dst,
>                       struct rtllib_network *src)
> 
> As you can see, there is "dst" destination and a "src" source. The author
> is essentially copying all the data from "src" to "dst" in this function.
> Throughout the function, "memcpy()" is being used several times to copy
> the data of all arrays/structs existing in "src" into "dst". In each
> of those instances, the author is making sure to copy the entirety of
> the respective struct/array by passing all used up size of the struct/
> array in the third, size, argument. Here are a few lines from that
> function (posting the entire function defintion would be inappropriate)
> 
> 	instance 1: memcpy(dst->hidden_ssid, src->ssid, src->ssid_len);
>         instance 2: memcpy(&dst->stats, &src->stats, sizeof(struct rtllib_rx_stats));
>         instance 3: memcpy(&dst->tim, &src->tim, sizeof(struct rtllib_tim_parameters));
>         instance 4: memcpy(dst->wzc_ie, src->wzc_ie, src->wzc_ie_len);
> 
> There are a LOT more instances, here is the elixir link to that
> function for a quick reference:
> https://elixir.bootlin.com/linux/v5.11/source/drivers/staging/rtl8192e/rtllib_rx.c#L2420
> 
> My point is, it's clear that the intent of this function is to duplicate
> the data of src into dst. If "CcxRmState" really is supposed to be u16,
> then why only write down the first 2 bytes into "dst->CcxRmState"?
> 
> What about "dst->CcxRmState[1]"? It never gets any value, again.
> 
> These are the only places where CcxRmState is being used in the entire
> rtl8192e driver directory. I skipped line 1971 as it just checks whether
> "CcxRmState[0]" is 0 or not, this should not require any explanation.

Ok, can you provide more information in the changelog text and resend
the commit so that it is easier to understand why you feel this change
is ok?

thanks,

greg k-h
