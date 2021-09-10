Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93E7406E15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhIJPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhIJPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:21:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC034C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:20:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t19so4932898ejr.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y3tC4nDyVOsSkA0uvt6jkAqJXxoQ4QhFC8D3n1gWmeM=;
        b=ccMPMMdig5pYc+7VPBZnQ4mnFUWGTG7mZaFdqBT9Xd6nDf6cpl7WE75bCXUPBZPGl4
         wWgELNQlT/zOxFOIxv5i4T2mpvIQZm6wDUJf0NJf5kJvx4y/oj7kb23opd02XH/VIooU
         uqsLsbZnGehK1pQ/JnitY5m67RA0XQitRLSe5hdehUKQTCmucvHmWf3iOxJlddJZ5dkf
         H+lAQ3uH+BtVf6bXYPmXCzAl5sI5VGTQ1cvJA1tFP8QAhYg743NLQ2UQ6Psu8LxrRxL5
         G8CC4lnp2IVuKEr6F9jLiJ2i7VQygXG0al0ZVwSR+KfkVQDpWZDUGUzALiAFcEg5khgt
         dNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3tC4nDyVOsSkA0uvt6jkAqJXxoQ4QhFC8D3n1gWmeM=;
        b=AuZ4J4tk+y5+csPIon51Ar5wvpqOr6VnUZJnMe0elrLQHwy38pJH3Emq4y+LJjIob7
         AcDVREq/62Aj4MTKuLo8MJLy6YmtLdEdXCcRs+f57Yh7D0jnx9pPU8GpuTqj1VWlLROu
         innPZraablUJyorsC1GnWR43DGKsXQfDUpkzoBL0K/CoqysnX5utFrE2+HPgh21DIWFy
         zle5Fcm0CaA51IzeNfhs8ja9pAecb8ThTNSvKRcJS0fYrs1oiMFy1bWKLdYnEJ/vGYy3
         xU6vfhtGQNu/zyA3Ucu72Uiql7Hrq3x9Jpzmgpkwrr0JSuRlEzhd4fLB6bTBiMkLT0QE
         D2Xw==
X-Gm-Message-State: AOAM5305pXTBWlD4J0V6qPJUHUWDE7oTjWgMuYGTGZz+7JszOumhF6L2
        D66N6NBU7MkwgbctOo2fGBQ=
X-Google-Smtp-Source: ABdhPJz3kLbFrvosjlIym0GPjZG0FUPBwnXlHAOjGj9fbcmUnBGPHja0GDTZOaYuCjD+t5cWBIhSXg==
X-Received: by 2002:a17:907:c10:: with SMTP id ga16mr10343714ejc.174.1631287200402;
        Fri, 10 Sep 2021 08:20:00 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id j5sm2602039ejb.96.2021.09.10.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:19:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
Date:   Fri, 10 Sep 2021 17:19:58 +0200
Message-ID: <9324065.O9NRuxeco7@localhost.localdomain>
In-Reply-To: <YTYgnrvwxNt4+CvR@kroah.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com> <20210904220048.12822-3-fmdefrancesco@gmail.com> <YTYgnrvwxNt4+CvR@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 6, 2021 4:07:26 PM CEST Greg Kroah-Hartman wrote:
> On Sun, Sep 05, 2021 at 12:00:47AM +0200, Fabio M. De Francesco wrote:
> > Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> > For this purpose unify the three usb_read8/16/32 into the new
> > usb_read(); make the latter parameterizable with 'size'; embed most of
> > the code of usbctrl_vendorreq() into usb_read() and use in it the new
> > usb_control_msg_recv() API of USB Core.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >
> > [...]
> > 
> > +	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> > +		status = usb_control_msg_recv(udev, 0, 
REALTEK_USB_VENQT_CMD_REQ,
> > +					      
REALTEK_USB_VENQT_READ, value,
> > +					      
REALTEK_USB_VENQT_CMD_IDX, io_buf,
> > +					      size, 
RTW_USB_CONTROL_MSG_TIMEOUT,
> > +					      GFP_KERNEL);
> > +		if (!status) {   /*  Success this control transfer. */
> 
> Comments go on the next line.
> 
> > +			rtw_reset_continual_urb_error(dvobjpriv);
> > +			memcpy(data, io_buf, size);
> > +		} else { /*  error cases */
> 
> Again, next line for the comment.
> 
> > +			DBG_88E("reg 0x%x, usb %s %u fail, status:
%d vendorreq_times:%d\n",
> > +				value, "read", size, status, 
vendorreq_times);
> 
> These should be removed eventually...
> 
> > +
> > +			if (status == (-ESHUTDOWN) || status == -
ENODEV) {
> > +				adapt->bSurpriseRemoved = true;
> 
> Odd, but ok...

I'm not so sure that it is OK. Please correct me if I'm wrong...

The calls chain from usb_control_msg_recv() seems to be the following:

usb_control_msg_recv/send()
        -> usb_control_msg()
                -> usb_internal_control_msg()
                        -> usb_start_wait_urb()
                                -> usb_submit_urb()

Each of the above functions could fail for different reasons and if so they 
return the errors up to the first caller into "status". I can find no lines 
of code where the above-mentioned functions set and return -ESHUTDOWN.

Unless I'm missing something obvious, "status" is a non-shared variable. The 
variables that are assigned with errors in all five of the above-mentioned 
functions are also local (non shared) variables.

To summarize: how could "status" be assigned -ESHUTDOWN? Is any point in the 
chain that value assigned by a concurrent thread to a shared variable and 
then returned up to the caller (i.e., usb_control_msg_recv())?

Since the code has this "if (status == (-ESHUTDOWN) || ...)" it expects that 
sometimes it could be 'true', so I'm 100% sure that I can't see where my 
argument is not valid... :(

Can someone please help me to understand this topic?

Thanks,

Fabio



> 
> > [...]



