Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E13AC081
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhFRBWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:22:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33663 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233492AbhFRBWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:22:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623979196; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Te1OEokvJhjTR8jBU8EtGwNCNTt2ynnj5hYiv5wlBvY=;
 b=PXEJ6obaLDFFN4Cgmy10ofViuUv/dBPtE8Ut0bhHDBjiw1XZK2s4ac42djToTogNIVS8QZff
 gZdhM4k5L74sGu+Zd7kQsix1HQNFYgc+cSyn8/pq0LS2QbcqKlm4Qnk+/KL4rQV9HN5sTvjd
 omE1+5z+DpLr3YWexilXHWUz3OQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60cbf495b6ccaab753b4d76c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 01:19:17
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96760C433F1; Fri, 18 Jun 2021 01:19:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C67CC433D3;
        Fri, 18 Jun 2021 01:19:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jun 2021 09:19:16 +0800
From:   linyyuan@codeaurora.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linyu Yuan <linyyuan@codeaurora.com>
Subject: Re: [PATCH v3] usb: gadget: eem: fix echo command packet response
 issue
In-Reply-To: <YMtMlmwuIU3YmwAq@kroah.com>
References: <20210616115142.34075-1-linyyuan@codeaurora.org>
 <YMtMlmwuIU3YmwAq@kroah.com>
Message-ID: <5b55b8b8649cbe9049e088cdd7b0d24f@codeaurora.org>
X-Sender: linyyuan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-17 21:22, Greg Kroah-Hartman wrote:
> On Wed, Jun 16, 2021 at 07:51:42PM +0800, Linyu Yuan wrote:
>> From: Linyu Yuan <linyyuan@codeaurora.com>
>> 
>> when receive eem echo command, it will send a response,
>> but queue this response to the usb request which allocate
>> from gadget device endpoint zero,
>> and transmit the request to IN endpoint of eem interface.
>> 
>> on dwc3 gadget, it will trigger following warning in function
>> __dwc3_gadget_ep_queue(),
>> 
>> 	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
>> 				&req->request, req->dep->name))
>> 		return -EINVAL;
> 
> Is this really a problem?  I am guessing the request will not work at
> all?  Or just warn and continue with it?
yes, it is a real problem of f_eem driver which request from it will 
queue fail,
which means following error happen.
       if (usb_ep_queue(port->in_ep, req, GFP_ATOMIC))
		DBG(cdev, "echo response queue fail\n");
> 
> How was this ever working?
i think for eem link command packet, normally we will never seen it if 
both side arelinux system.
as eem driver will add data header and send it to peer.

only it is eem driver bug which read network data as link command packet 
(this issue fixed in my last change).
> 
>> 
>> fix it by allocating a usb request from IN endpoint of eem interface,
>> and transmit the usb request to same IN endpoint of eem interface.
>> 
>> Signed-off-by: Linyu Yuan <linyyuan@codeaurora.com>
>> ---
> 
> What commit does this fix?  Should it be backported to older stable
> kernels?  If so, how far back?
yes, we can backport to all active LTS kernel.
> 
> thanks,
> 
> greg k-h
