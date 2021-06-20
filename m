Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62C43ADC75
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 05:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFTDst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 23:48:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31500 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhFTDsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 23:48:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624160796; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=koKa7803mYpU1PXBNms9YQCFvzub3rNxcfrVBDoQTEI=;
 b=eggmerCqZqSFdtv9sFm9d7tu9hca32eKm/igR22qVWf6ur8/BM2cVQrjjBMRZn33aPfnlrr7
 nCBFluCOE23UmYvCRnI6LHykJp0jA5RaKaygwrZbv70CWOrqJaaYuNEOoMKlpaXwECvgcArH
 a8oGn+60E/+4tDm1q/dMa8WiFHM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60ceba1ae27c0cc77f90d074 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Jun 2021 03:46:34
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BECB3C4360C; Sun, 20 Jun 2021 03:46:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E34AC433D3;
        Sun, 20 Jun 2021 03:46:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Jun 2021 11:46:33 +0800
From:   linyyuan@codeaurora.org
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH v3 1/2] usb: udc: core: hide struct usb_gadget_driver to
 gadget driver
In-Reply-To: <20210620021337.GA361976@rowland.harvard.edu>
References: <20210619154309.52127-1-linyyuan@codeaurora.org>
 <20210619154309.52127-2-linyyuan@codeaurora.org>
 <20210620021337.GA361976@rowland.harvard.edu>
Message-ID: <42b3ebc2316495328e2d0061af81ef17@codeaurora.org>
X-Sender: linyyuan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-20 10:13, Alan Stern wrote:
> On Sat, Jun 19, 2021 at 11:43:08PM +0800, Linyu Yuan wrote:
>> currently most gadget driver have a pointer to save
>> struct usb_gadget_driver from upper layer,
>> it allow upper layer set and unset of the pointer.
>> 
>> there is race that upper layer unset the pointer first,
>> but gadget driver use the pointer later,
>> and it cause system crash due to NULL pointer access.
> 
> This race has already been fixed in Greg's usb-next branch.  See commit
> 7dc0c55e9f30 ("USB: UDC core: Add udc_async_callbacks gadget op") and
> following commits 04145a03db9d ("USB: UDC: Implement
> udc_async_callbacks in dummy-hcd") and b42e8090ba93 ("USB: UDC:
> Implement udc_async_callbacks in net2280").
> 
thanks, this is better, lower driver only need change several places.
> You just need to write a corresponding patch implementing the
> async_callbacks op for dwc3.
yes, i will do.
> 
> Alan Stern
