Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E87840F4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbhIQJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234265AbhIQJji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 488CD60EB6;
        Fri, 17 Sep 2021 09:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631871496;
        bh=LcaAXhsUQp+yLFCh3WEuiolKi8ixI5lQSBUjEkFCBZc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=RYAlaM3sRsan4glS7tFrIMOkVlhVTzxYLp2FcP3LKubgwwyfKEXzsAelVt3QCpPkg
         iXymoK+8LDjDE3QdUV/gkVVEK16KBki5XLgh7CZ3vAL/uuJjBO5kHcCK3x/aPZhN0P
         RQyHa2QaBeBW3SiVctuL5+ooWxTa1b+OOebf8ncta3mNezscsBHvVvYEjPmlmo6FQe
         WYXqJG2M8QzqRQItmWjLC9yR2yEfU+zgvZ3RofVzN1LuDJrtv0XUTb/0WqmAFYAat7
         hj0bwM4B2mjxYAp2n7En+R/UOeo3h/f9nMv7Xy7YY8N4jIZZyRxdEf6apR1MkqTUJb
         o1MQsorrXdI0Q==
References: <20210917021852.2037-1-wcheng@codeaurora.org>
 <87y27vai3p.fsf@kernel.org>
 <474148e5-37e2-ea0c-7d78-9e71155314d9@codeaurora.org>
User-agent: mu4e 1.6.5; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid starting DWC3 gadget during
 UDC unbind
Date:   Fri, 17 Sep 2021 12:37:55 +0300
In-reply-to: <474148e5-37e2-ea0c-7d78-9e71155314d9@codeaurora.org>
Message-ID: <87h7eja6ey.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wesley Cheng <wcheng@codeaurora.org> writes:

> Hi,
>
> On 9/16/2021 10:17 PM, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Wesley Cheng <wcheng@codeaurora.org> writes:
>> 
>>> There is a race present where the DWC3 runtime resume runs in parallel
>>> to the UDC unbind sequence.  This will eventually lead to a possible
>>> scenario where we are enabling the run/stop bit, without a valid
>>> composition defined.
>>>
>>> Thread#1 (handling UDC unbind):
>>> usb_gadget_remove_driver()
>>> -->usb_gadget_disconnect()
>>>   -->dwc3_gadget_pullup(0)
>>> --> continue UDC unbind sequence
>>> -->Thread#2 is running in parallel here
>>>
>>> Thread#2 (handing next cable connect)
>>> __dwc3_set_mode()
>>>   -->pm_runtime_get_sync()
>>>     -->dwc3_gadget_resume()
>>>       -->dwc->gadget_driver is NOT NULL yet
>>>       -->dwc3_gadget_run_stop(1)
>>>       --> _dwc3gadget_start()
>>> ...
>>>
>>> Fix this by tracking the pullup disable routine, and avoiding resuming
>>> of the DWC3 gadget.  Once the UDC is re-binded, that will trigger the
>>> pullup enable routine, which would handle enabling the DWC3 gadget.
>>>
>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>
> Thanks, Felipe!
>
>> 
>> This looks okay to me, but needs to be tested by a few folks ;-)
>> 
>> Acked-by: Felipe Balbi <balbi@kernel.org>
>> 
> Yes, would be good to get some functions using
> usb_gadget_activate/deactivate().  It should be OK for those situations
> as well, but just to make sure :)

IIRC, the UVC function relies on those. You could give it a shot ;-)

-- 
balbi
