Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3273348E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhCYLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:04:59 -0400
Received: from m12-17.163.com ([220.181.12.17]:37592 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhCYLEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=k4Ptp
        EGNN7bW759zYtZmyz/dSMjxWWS3I+SUGjibQTU=; b=IkQG7A3N3vDEmYZL688Qc
        2MlLgDYbG2lh1Q5yeHRdwcPepGPnMnqKUioKn9JrLq8EwWi1i9Jz5SCho0UgCwEU
        S1PycnayGro9urtQg/QLNSPgYcjSIwRzqRLe5WtTWVxb+hmNgWwQQbsel53y4SeQ
        mby13qfAUK1yFJy4XbI1Uo=
Received: from localhost (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAAXZBH_bVxgjpGKrw--.47645S2;
        Thu, 25 Mar 2021 19:03:28 +0800 (CST)
Date:   Thu, 25 Mar 2021 19:03:39 +0800
From:   Jian Dong <dj0227@163.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH]  staging: greybus: fix fw is NULL but dereferenced
Message-ID: <20210325190339.00007921@163.com>
In-Reply-To: <YFxl8hyx7murtlzW@kroah.com>
References: <1616667566-58997-1-git-send-email-dj0227@163.com>
        <YFxl8hyx7murtlzW@kroah.com>
Organization: yulong
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EcCowAAXZBH_bVxgjpGKrw--.47645S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy8Wry8Xr4xWF17XrWUArb_yoW8ury5pF
        WxJan2ka1rXa4Ygas8ZFWDZryFg3yxC3yxG348K3s5tr15ZF9YqFyUtFy5WF18ArZ3Ja15
        Xanagr9Yv3W2yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjlksUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/xtbBEABg3VUMV7OYlQAAsd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 11:29:06 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 25, 2021 at 06:19:26PM +0800, Jian Dong wrote:
> > From: Jian Dong <dongjian@yulong.com>
> > 
> >  fixes coccicheck Error:
> > 
> >  drivers/staging/greybus/bootrom.c:301:41-45: ERROR:
> >  fw is NULL but dereferenced.
> > 
> >  if procedure goto label directly, ret will be nefative, so the fw
> > is NULL and the if(condition) end with dereferenced fw. let's fix
> > it.  
> 
> Why is this all indented a space?
this maybe caused by my terminal, I will take notice next time.
> 
> > 
> > Signed-off-by: Jian Dong <dongjian@yulong.com>
> > ---
> >  drivers/staging/greybus/bootrom.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/bootrom.c
> > b/drivers/staging/greybus/bootrom.c index a8efb86..0439efa 100644
> > --- a/drivers/staging/greybus/bootrom.c
> > +++ b/drivers/staging/greybus/bootrom.c
> > @@ -246,7 +246,7 @@ static int gb_bootrom_get_firmware(struct
> > gb_operation *op) struct gb_bootrom_get_firmware_response
> > *firmware_response; struct device *dev =
> > &op->connection->bundle->dev; unsigned int offset, size;
> > -	enum next_request_type next_request;
> > +	enum next_request_type next_request =
> > NEXT_REQ_GET_FIRMWARE; int ret = 0;
> >  
> >  	/* Disable timeouts */
> > @@ -298,10 +298,10 @@ static int gb_bootrom_get_firmware(struct
> > gb_operation *op) 
> >  queue_work:
> >  	/* Refresh timeout */
> > -	if (!ret && (offset + size == fw->size))
> > -		next_request = NEXT_REQ_READY_TO_BOOT;
> > -	else
> > +	if (!!ret)  
> 
> That is hard to understand, please make this more obvious.
> 
if (A && B) else (!A || !B)

So, when ret is NON-ZERO, set next_request as GET_FIRMWARE, else set
READ_TO_BOOT. but if second express is flase, next_request still
need be set as GET_FIRMWARE, So, I initialze it as GET_FIRMWARE.

this is will keep consistent with the origin conditional express:
both ret is ZERO and second express TRUE, then set as READ_TO_BOOT,
else set as GET_FIRMWARE. 
 

> thanks,
> 
> greg k-h

