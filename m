Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B34A3490E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhCYLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231818AbhCYLeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:34:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5803D6023F;
        Thu, 25 Mar 2021 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616671968;
        bh=g/bIFiK6seJ/7aRx12ycC3tXqepUm+lye/PgSndjMaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGv297QYJtp8ILIlaDyka1Bt1HTQl8fQTOfXpwTP/yFOT1gGYYc5w6MTNBzAjEikv
         BbiXkftm7xclrYROiK5zBBpfaKPSX8N9hYP9neO1ML9+2JMp7sbEyfPCkNJG6nIXsa
         yLLqymmAF7NrfLx2MFOfrWwFuv/DXLquaJap3MNs=
Date:   Thu, 25 Mar 2021 12:32:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jian Dong <dj0227@163.com>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org, vireshk@kernel.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH]  staging: greybus: fix fw is NULL but dereferenced
Message-ID: <YFx03qbeGbgBShkQ@kroah.com>
References: <1616667566-58997-1-git-send-email-dj0227@163.com>
 <YFxl8hyx7murtlzW@kroah.com>
 <20210325190339.00007921@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325190339.00007921@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 07:03:39PM +0800, Jian Dong wrote:
> On Thu, 25 Mar 2021 11:29:06 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Mar 25, 2021 at 06:19:26PM +0800, Jian Dong wrote:
> > > From: Jian Dong <dongjian@yulong.com>
> > > 
> > >  fixes coccicheck Error:
> > > 
> > >  drivers/staging/greybus/bootrom.c:301:41-45: ERROR:
> > >  fw is NULL but dereferenced.
> > > 
> > >  if procedure goto label directly, ret will be nefative, so the fw
> > > is NULL and the if(condition) end with dereferenced fw. let's fix
> > > it.  
> > 
> > Why is this all indented a space?
> this maybe caused by my terminal, I will take notice next time.
> > 
> > > 
> > > Signed-off-by: Jian Dong <dongjian@yulong.com>
> > > ---
> > >  drivers/staging/greybus/bootrom.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/bootrom.c
> > > b/drivers/staging/greybus/bootrom.c index a8efb86..0439efa 100644
> > > --- a/drivers/staging/greybus/bootrom.c
> > > +++ b/drivers/staging/greybus/bootrom.c
> > > @@ -246,7 +246,7 @@ static int gb_bootrom_get_firmware(struct
> > > gb_operation *op) struct gb_bootrom_get_firmware_response
> > > *firmware_response; struct device *dev =
> > > &op->connection->bundle->dev; unsigned int offset, size;
> > > -	enum next_request_type next_request;
> > > +	enum next_request_type next_request =
> > > NEXT_REQ_GET_FIRMWARE; int ret = 0;
> > >  
> > >  	/* Disable timeouts */
> > > @@ -298,10 +298,10 @@ static int gb_bootrom_get_firmware(struct
> > > gb_operation *op) 
> > >  queue_work:
> > >  	/* Refresh timeout */
> > > -	if (!ret && (offset + size == fw->size))
> > > -		next_request = NEXT_REQ_READY_TO_BOOT;
> > > -	else
> > > +	if (!!ret)  
> > 
> > That is hard to understand, please make this more obvious.
> > 
> if (A && B) else (!A || !B)
> 
> So, when ret is NON-ZERO, set next_request as GET_FIRMWARE, else set
> READ_TO_BOOT. but if second express is flase, next_request still
> need be set as GET_FIRMWARE, So, I initialze it as GET_FIRMWARE.

My point is:
	if (!!ret)
is odd, and is the same thing as:
	if (ret)
correct?

And the latter is the common kernel style, no need to be complex when
you do not need to.

Anyway, others have pointed out why this is incorrect, no need for
further discussion.

thanks,

greg k-h
