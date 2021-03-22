Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CC344E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCVS2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCVS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:28:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:28:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o19so20557399edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G3MqMffLi0copb1zWCtzI0GikwV8rWHY8BfxWSJz4Nk=;
        b=fo0paveVUL8GennHc3SNfjLEoez4Dfyf3qy9jMHuab2V6uWBjCk+OzNJmEL9vE5nWQ
         f7ICEPDpKCIxmPGytS/7S7dijhdksC0GoK4IiQIPiFE7yqcP+yJkKvUdXx7sop9DVQuF
         yQ0Do6iUy+EsT2uZPHo+e9S8GDB2YiJXUG8EF7JMWnJ8DFuX6CPHA9jvwY8J9KVkn7hz
         1umZf2z6Kn1QqWuHhk5/MftppPzh8M0kbAItBvSMZ+F46ymUm4z5HJ+X9BrwtOvJ1uxx
         kWho6QvY1ppqAa9oqIP2wMl8VO9SE2XtdgQRlzWsnldP1LsilR3un1tPI2wrMGoyfcET
         AGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G3MqMffLi0copb1zWCtzI0GikwV8rWHY8BfxWSJz4Nk=;
        b=Guqmqk/pD4rsAdOZ1a25RX8F4ygk/XufhoYNoQYzpfYCqT4YfhhSLfoM2EGfUwN6d6
         O9DldAo8HOA9A2fRwP3kn6VBzpOJBVpE+pKCkdY+qlSueRN/uSrnOVlKW7y8K5k6CD28
         FC9vAnEliJJuBfHQaUtEAo1Ohurhn/7iNVsdD7EMIIVkzINk5pxI+yKCVi52ZdS0g9kD
         Gwte+g8a3ILOY5SKbLkOawgZi6rgU8MtU0po126Whb+IsS7gGWS+OPUuscIbUuDO1oxq
         j50TC9kovSFZItfWxmeX9bX1uHghonZptq8rC4Cyd5WbuAfd/URTJ2inv+jEFGFlzwvO
         HtgA==
X-Gm-Message-State: AOAM531jeQsAOkqm0zkptpRz1SqiFRmDqeYlJPiN36FLAXVz1vWukp+u
        VSm7S0Xl4juxMKYR3yWNH9M=
X-Google-Smtp-Source: ABdhPJy0vLiGQ+y9OAqxLVXAy/vnZCiZ55CBaFbgS/2ENdw0fsU0hZs+65GpShcM+HH1oG7PZbkZRQ==
X-Received: by 2002:a05:6402:2695:: with SMTP id w21mr944135edd.99.1616437725737;
        Mon, 22 Mar 2021 11:28:45 -0700 (PDT)
Received: from agape.jhs ([151.37.41.34])
        by smtp.gmail.com with ESMTPSA id e17sm9959370ejb.54.2021.03.22.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 11:28:45 -0700 (PDT)
Date:   Mon, 22 Mar 2021 19:28:42 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] staging: rtl8723bs: moved function prototype out
 of core/rtw_ioctl_set.c and core/rtw_mlme.c
Message-ID: <20210322182840.GC1443@agape.jhs>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <81ccf18df5ca0acab5bb8da2b675a03626ef57ac.1616422773.git.fabioaiuto83@gmail.com>
 <YFjBHNkQFlFzZKpV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFjBHNkQFlFzZKpV@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:09:00PM +0100, Greg KH wrote:
> On Mon, Mar 22, 2021 at 03:31:41PM +0100, Fabio Aiuto wrote:
> > fix the following checkpatch issues:
> > 
> > WARNING: externs should be avoided in .c files
> > 40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:40:
> > +u8 rtw_do_join(struct adapter *padapter);
> > 
> > WARNING: externs should be avoided in .c files
> > 15: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:15:
> > +extern u8 rtw_do_join(struct adapter *padapter);
> > 
> > moved function prototype in include/rtw_ioctl_set.h
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    | 1 -
> >  drivers/staging/rtl8723bs/core/rtw_mlme.c         | 2 --
> >  drivers/staging/rtl8723bs/include/rtw_ioctl_set.h | 2 ++
> >  3 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > index cb14855742f7..7d858cae2395 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > @@ -37,7 +37,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
> >  	return ret;
> >  }
> >  
> > -u8 rtw_do_join(struct adapter *padapter);
> >  u8 rtw_do_join(struct adapter *padapter)
> >  {
> >  	struct list_head	*plist, *phead;
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > index 95cfef118a94..1ee86ec2dee7 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > @@ -12,8 +12,6 @@
> >  #include <hal_btcoex.h>
> >  #include <linux/jiffies.h>
> >  
> > -extern u8 rtw_do_join(struct adapter *padapter);
> > -
> >  int	rtw_init_mlme_priv(struct adapter *padapter)
> >  {
> >  	int	i;
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> > index 4b929b84040a..55722c1366aa 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> > @@ -28,6 +28,8 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
> >  u8 rtw_validate_bssid(u8 *bssid);
> >  u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
> >  
> > +u8 rtw_do_join(struct adapter *padapter);
> > +
> 
> This is already in drivers/staging/rtl8188eu/include/hal_intf.h, why
> declare it again?

I didn't check the rtl8188eu for that's not a module rtl8723bs depends on

> I'm stopping here on reviewing this patchset, please look closer at it
> again and fix up and resend a v2.
> 
> thanks,
> 
> greg k-h

Ok, I will fix everything and send you a patchset v2
