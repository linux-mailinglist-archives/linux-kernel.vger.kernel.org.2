Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B63F3F01
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhHVLAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhHVK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 06:59:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D54C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 03:59:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u24so2190045edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5El4UeIwytNtHF7+Wl/S50UjWu0HTthP81MaOtEjKg=;
        b=dfIVHso8nGPuVzo65G6iLskiJb7h5rbbdkh5Vkgq4RC92bzhdPoh4dFggygHPDuMME
         hW8bBij9RvKDdsT+sjmgcSah826YR+ZGLM77I5V/sPlgQd4NEfGaiK5TQC9o5Br/y2Dc
         RXIw4H6FjNUgRxWqxdJI9BPRj4+5a/0HgOb/FJjBOPcEm7Gzs+NFWzsxVWvTiSYN/Dkr
         GpP9vA08PJ/f4RHTNHBHJ81TFWgHXPHZzQXIPBwiqoLKXqaby5C2slSc4prAl95x6SOB
         Ea5VbLuHP89QQ5IcjUSLtOrbTrPEkfnXFecTbQP+NdaBn7svCEXBMHPwvp8TPuFKnMxx
         qSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5El4UeIwytNtHF7+Wl/S50UjWu0HTthP81MaOtEjKg=;
        b=Dc/BL8I5pXd7AgtDoy4nG4FJmlmjG2p6ya879z7eviNiaFXmmEXLpCXKN+4CDMUcaD
         Kdzj3V95c8AdVWiqQuooHV5p+hRlf4N6D52p1RlspukRzQVHi5LdIy6DszyQI+JF+4Rk
         GwF1ctnC+z8jFbG0wPqL0nU/UfAxuVc1ugIM1RyLcm1op2zR6TpJ90CYqrHkmcybkfmK
         8QEEPn17M5s9D5txhUmX6FWRl1PUZcgzA757h8JD/3os0PnzxkylBfHgz/stKi+5/B+a
         Bws+HPuTK1ZWgCPph2Rjyl+E8+DnOax2tObuCPHxxnPOdTBcOdeXiyZvcOJuBk1fEQ9C
         U/5g==
X-Gm-Message-State: AOAM531dQhcjC4doTMDXZe+Bnzu1ScQodxOFJrplaMoM+H+IG1ozJXHB
        YN3UuUkrqWkH4VzwpbRkgHQ=
X-Google-Smtp-Source: ABdhPJzh3y0IZMIYYDZdqjk1bsxOv5Jg6pkc47CgvHjY2LL9HeCjUPnTQxh+WIKSPVVuMSQDudGy3A==
X-Received: by 2002:a05:6402:34c7:: with SMTP id w7mr33410774edc.175.1629629956663;
        Sun, 22 Aug 2021 03:59:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id o17sm6864502edc.58.2021.08.22.03.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 03:59:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
Date:   Sun, 22 Aug 2021 12:59:13 +0200
Message-ID: <2327383.5TodInGmHT@localhost.localdomain>
In-Reply-To: <ae27d6a0-dc00-459f-7b36-acf7f4c08d72@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com> <10584649.zhyk0TxWeL@localhost.localdomain> <ae27d6a0-dc00-459f-7b36-acf7f4c08d72@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 12:09:29 PM CEST Pavel Skripkin wrote:
> On 8/22/21 12:53 PM, Fabio M. De Francesco wrote:
> > On Friday, August 20, 2021 7:07:28 PM CEST Pavel Skripkin wrote:
> >> Hi, Greg, Larry and Phillip!
> >> 
> >> I noticed, that new staging driver was added like 3 weeks ago and I 
decided
> >> to look at the code, because drivers in staging directory are always 
buggy.
> >> 
> >> The first thing I noticed is *no one* was checking read operations 
result,
> > 
> > but
> > 
> >> it can fail and driver may start writing random stack values into 
registers.
> > 
> > It
> > 
> >> can cause driver misbehavior or device misbehavior.
> > 
> > After the messages I wrote yesterday, I had some minutes to look deeper at 
the
> > code that would be changed by these patches.
> > 
> > I think that it does not look like that the driver could return "random 
stack
> > values into registers" and I think this entire series in unnecessary.
> > 
> > As far as I understand this driver (though I must admit that I really 
don't
> > know how to write drivers, and I'm not interested in understanding - at 
the
> > moment, at least), all the usb_read*() call usbctrl_vendorreq() and the 
latter
> > *does* proper error checking before returning to the callers the read 
data.
> > 
> > Please, look at the code copied from usbctrl_vendorreq() and pasted here 
(some
> > comments are mine):
> > 
> > /* start of code */
> > static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void
> > *pdata, u16 len, u8 requesttype)
> > {
> > 
> > /* test if everything is OK for transfers and setup the necessary 
variables */
> > [...]
> > 
> > status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > 
> >                                           reqtype, value,
> > 
> > REALTEK_USB_VENQT_CMD_IDX,
> > 
> >                                           pIo_buf, len,
> > 
> > RTW_USB_CONTROL_MSG_TIMEOUT);
> > 
> >                  if (status == len) {   /*  Success this control transfer. 
*/
> >                  
> >                          rtw_reset_continual_urb_error(dvobjpriv);
> >                          if (requesttype == 0x01)
> >                          
> >                                  memcpy(pdata, pIo_buf,  len); /* pdata
> > 
> > receives the read data */
> > 
> > 	} else { /*  error cases */
> > 
> > [...]
> > 
> > }
> > /* end of code */
> > 
> > So, *I cannot ack this RFC*, unless maintainers say I'm missing something.
> > 
> > Larry, Philip, since you have much more knowledge than me about r8188eu 
(and,
> > more in general, on device drivers) may you please say what you think 
about my
> > arguments against this series?
> 
> Hi, Fabio!
> 
> Thank you for looking into this, but I still can see the case when pdata
> won't be initialized:
> 
> 
> pdata is initialized only in case of successful transfer, i.e len > 0.
> It means some data was received (maybe not full length, but anyway). In
> case of usb_control_msg() error (for example -ENOMEM) code only does
> this code block:
> 
> if (status < 0) {
> 	if (status == (-ESHUTDOWN) || status == -ENODEV) {
> 		adapt->bSurpriseRemoved = true;
> 	} else {
> 		struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
> 		haldata->srestpriv.Wifi_Error_Status = 
USB_VEN_REQ_CMD_FAIL;
> 	}
> }

It's up to the callers of _rtw_usb*() to check return values and then act 
accordingly. 

It doesn't matter whether or not *pdata is initialized because usb_read*() 
returns data = 0 if usb_control_msg() has not initialized/changed  its third 
parameter. Then _rtw_read*() receive 0 or initialized data depending on errors 
or no errors. Finally _rtw_read*() returns that same value to the callers (via 
r_val). 

So, it's up to the callers to test if (!_rtw_read*()) and then act 
accordingly. If they get 0 they should know how to handle the errors.

Furthermore, we have already either adapt->bSurpriseRemoved = true or haldata-
>srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL. Depending on contexts 
where _rtw_read*() are called, perhaps they could also check the two variables 
above.

In summation. if anything should be changed, it is the code of the callers of 
_rtw_read*() if you find out they they don't properly handle the returning 
values of this function. You should find every place where _rtw_read*() are 
called and figure out if the returns are properly checked and handled; if not, 
make some change only there.

Larry, Philip, where are you? Am I missing something?

Thanks,

Fabio

> 
> And then just loops further. In case of 10 ENOMEM in a row,. passed
> pdata won't be initialized at all and driver doesn't do anything about
> it. I believe, it's not good approach to play with random values. We
> should somehow handle transfer errors all across the driver.
> 
> If I am missing something, please, let me know :)
> 
> 
> 
> With regards,
> Pavel Skripkin




