Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1724C42EF91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhJOLZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238457AbhJOLZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3B3A60F44;
        Fri, 15 Oct 2021 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634297028;
        bh=wyXEhEzOBvLAIMRDrGKRdIrm47BJjwyoash09jNKF+k=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=dDvEIVTVG9LSQrXHccTlcBaooUrllOdarq6rCDegFYktGHYRvjYPkVn4AejoYTr/G
         MwnpNdqclcDlxEK3+kV2Qfx2hhbwL8brvFd4eaZr/iRhT5N48PjWEdE+vTZj1flC/1
         H/U5G8Y7royz3iGKQWdJnyZQtBaBTjjG8itFRckLLM7uArXxJJTCnCaL8seIvMgdoj
         hRzVh5e6AMfeXChiMjj3Sn4fCueL7LKpiiEB8h86KzZj1mn9CylYnYnL02p50AE0Q2
         ZUmWS9AaA49Ox11rwqBARjoEx3ePL4zc7NjfV+EVvaGegXDRFczQicjqDK3Q7buQtm
         cRAyyMipmeQKQ==
References: <20211014233534.2382-1-wcheng@codeaurora.org>
 <YWkh1NXmmMbf59Ee@kroah.com>
User-agent: mu4e 1.6.6; emacs 28.0.60
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wesley Cheng <wcheng@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Remove dev_err() when queuing to
 inactive gadget/ep
Date:   Fri, 15 Oct 2021 14:23:13 +0300
In-reply-to: <YWkh1NXmmMbf59Ee@kroah.com>
Message-ID: <87bl3qbkfz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Oct 14, 2021 at 04:35:34PM -0700, Wesley Cheng wrote:
>> Since function drivers will still be active until dwc3_disconnect_gadget()
>> is called, some applications will continue to queue packets to DWC3
>> gadget.  This can lead to a flood of messages regarding failed ep queue,
>> as the endpoint is in the process of being disabled.  Remove the print as
>> function drivers will likely log queuing errors as well.
>> 
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/dwc3/gadget.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 4845682a0408..674a9a527125 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1812,11 +1812,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>>  {
>>  	struct dwc3		*dwc = dep->dwc;
>>  
>> -	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
>> -		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>> -				dep->name);
>
> Why not just change this to dev_dbg() instead?

I agree. A dev_dbg() would be better here. We don't want to loose this
message forever as it may prevent us from finding buggy function
drivers.

-- 
balbi
