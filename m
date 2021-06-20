Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06B3ADC7C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 05:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFTDzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 23:55:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52676 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhFTDzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 23:55:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624161219; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tE+R1AzeEp0EUe214AcQa1UZC60tq85rg/F6OsM6CrY=;
 b=hPvk5BspQCWQfYL00co+4svZBd1TVb/RYd72Qdky1EvA2lu7hUENem+5xXcBdv3kJPwrBSJ0
 5NgMaFAsG8wIvzumP1cbQ72wmcqI1aDiiPINOlA3T5t4tJ1g4kdAe7bcJhoS/zcYotJtf90F
 mFALr7pqeaD27R4rSKcKNrR7PnY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60cebbb0e27c0cc77f932fde (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Jun 2021 03:53:20
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71BDBC4323A; Sun, 20 Jun 2021 03:53:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6DF2C433D3;
        Sun, 20 Jun 2021 03:53:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Jun 2021 11:53:18 +0800
From:   linyyuan@codeaurora.org
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH v3 1/2] usb: udc: core: hide struct usb_gadget_driver to
 gadget driver
In-Reply-To: <42b3ebc2316495328e2d0061af81ef17@codeaurora.org>
References: <20210619154309.52127-1-linyyuan@codeaurora.org>
 <20210619154309.52127-2-linyyuan@codeaurora.org>
 <20210620021337.GA361976@rowland.harvard.edu>
 <42b3ebc2316495328e2d0061af81ef17@codeaurora.org>
Message-ID: <018a4e222c2c3d6f5ca63b5f2036f8d8@codeaurora.org>
X-Sender: linyyuan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-20 11:46, linyyuan@codeaurora.org wrote:
> On 2021-06-20 10:13, Alan Stern wrote:
>> On Sat, Jun 19, 2021 at 11:43:08PM +0800, Linyu Yuan wrote:
>>> currently most gadget driver have a pointer to save
>>> struct usb_gadget_driver from upper layer,
>>> it allow upper layer set and unset of the pointer.
>>> 
>>> there is race that upper layer unset the pointer first,
>>> but gadget driver use the pointer later,
>>> and it cause system crash due to NULL pointer access.
>> 
>> This race has already been fixed in Greg's usb-next branch.  See 
>> commit
>> 7dc0c55e9f30 ("USB: UDC core: Add udc_async_callbacks gadget op") and
>> following commits 04145a03db9d ("USB: UDC: Implement
>> udc_async_callbacks in dummy-hcd") and b42e8090ba93 ("USB: UDC:
>> Implement udc_async_callbacks in net2280").
>> 
> thanks, this is better, lower driver only need change several places.
>> You just need to write a corresponding patch implementing the
>> async_callbacks op for dwc3.
> yes, i will do.
>> 
Alan, i want to discuss your suggestion again in b42e8090ba93 ("USB: 
UDC:
Implement udc_async_callbacks in net2280")

+                       if (dev->async_callbacks) { ----> if CPU1 saw 
this is true
+                               spin_unlock(&dev->lock); ---> CPU2 get 
lock after this unlock,
it will set async_callbacks to false, then follow call also crash, right 
?
+                               tmp = dev->driver->setup(&dev->gadget, 
&u.r);
+                               spin_lock(&dev->lock);
+                       }

>> Alan Stern
