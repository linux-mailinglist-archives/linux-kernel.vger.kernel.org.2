Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8F3F4956
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhHWLGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhHWLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:06:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:05:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l18so23231923lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=62CG5FAwbYbHLuK7wsjeor0Z+AOZ5C4DhMlnKDlbXtw=;
        b=TOM//u8UUBYIc4mSeepYO3t1NmwooE12nusPUzvOgQ+yLNjP8WlVLNjyHNR2omONFs
         XHW+X+M9yKWeLndqwrYO5UQaEJPBJbKVMlV0GKOvULUaqa5+c/U9PjQfJrHn+9xIbYZF
         uTzZe++0zhW6fTLiRyXNRtUiEPfj9eh7ZIrjBSQW/uhTbtWtQ2fsT4++OV9WYouCbe1U
         qOA4IiSDrwCIttRhOkfa6Mf730izslJ45O2M0qANWsrjVBttoSF0MVjvLtm68FudpJm3
         t5jhDQjDjhxBK4ymTevFk7wkdDLHz/8qOPFTUj7/9Qm7ywt4KiCLtdbBq3a4TO3kf9wk
         wNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=62CG5FAwbYbHLuK7wsjeor0Z+AOZ5C4DhMlnKDlbXtw=;
        b=XDAf8d8WLk+/itetKq95QwC1VaTJ6HeCBT5eTJcTW3nHavd77Hy0JiDVIPFph32E/k
         YKf2n5mS1B0gXxz/YUPXXougQ3r4QmBV/EAcNMOLyB8plk/UlFzZjXDewHQiXjs2HMSV
         Gb4r6rGtZX3+O22qlWOWE0U53VKJEh5S+tZy+9DN4aMn/HuwqCnY2UaeadiIqOQYg6y9
         oooGp3CxMgDfvELGiGM7XddTp6aJM7uYztV14iXHvxyDQpAHpZn5cRa8SP9Ill5uw0XR
         3HFrb1zkSCAS3TbXctpNUPCuUn+CngbVm/gc40DEyJbyrapAjHrOqVG9GBK5tbQfDCv5
         Qlnw==
X-Gm-Message-State: AOAM533KCMZrwg0FP1CNdFNLDR5JbgqyXhzmHSNIvgQtvYbv9KLBSYO0
        5nGRCy9I9zBJ4tlAY/Qwdsu5u4Plb8B3hQ==
X-Google-Smtp-Source: ABdhPJzzVp2aBbfYX6ian7zNSn+RPbW1PFFcBr2bb/oTwSJjuNqPU1zqJc6ei1oG/83tFGEtxXJmZg==
X-Received: by 2002:a2e:98d0:: with SMTP id s16mr27000876ljj.115.1629716719951;
        Mon, 23 Aug 2021 04:05:19 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id d20sm1419269lfs.155.2021.08.23.04.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 04:05:19 -0700 (PDT)
Subject: Re: [PATCH RFC] staging: r8188eu: Use usb_control_msg_recv/send() in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20210822230235.10953-1-fmdefrancesco@gmail.com>
 <69bbb80c-2b30-28b9-ad8c-6862a6c3b911@gmail.com>
 <8275282.m2tVFbhrJk@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <7ce23fb2-3c8b-352e-1f2e-421ac7c64200@gmail.com>
Date:   Mon, 23 Aug 2021 14:05:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8275282.m2tVFbhrJk@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 1:47 PM, Fabio M. De Francesco wrote:
> On Monday, August 23, 2021 10:11:52 AM CEST Pavel Skripkin wrote:
>> On 8/23/21 2:02 AM, Fabio M. De Francesco wrote:
>> > Replace usb_control_msg() with the new usb_control_msg_recv() and
>> > usb_control_msg_send() API of USB Core.
>> > 
>> > This patch is an RFC for different reasons:
>> > 
>> > 1) I'm not sure if it is needed: while Greg Kroah-Hartman suggested to
>> > use the new API in a message to a thread that was about a series of patches
>> > submitted by Pavel Skripkin (who decided to not use it), I cannot explain
>> > if and why the driver would benefit from this patch.
>> > 2) I have doubts about the semantic of the API I use here, so I'd like to
>> > know whether or not I'm using them properly.
>> > 3) At the moment I cannot test the driver because I don't have my device
>> > with me.
>> > 4) This patch could probably lead to a slight change in some lines of
>> > Pavel's series (for sure in usb_read*()).
>> > 
>> > I'd like to hear from the Maintainers and other interested people if this
>> > patch is worth to be considered and, in this case, if there are suggestions
>> > for the purpose to improve it.
>> > 
>> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> > ---
>> >   drivers/staging/r8188eu/hal/usb_ops_linux.c | 19 ++++++++++---------
>> >   1 file changed, 10 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> > index 6a0a24acf292..9e290c1cc449 100644
>> > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> > @@ -15,7 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>> >   	struct adapter	*adapt = pintfhdl->padapter;
>> >   	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
>> >   	struct usb_device *udev = dvobjpriv->pusbdev;
>> > -	unsigned int pipe;
>> > +	u8 pipe;
>> >   	int status = 0;
>> >   	u8 reqtype;
>> 
>> I think, we can pass REALTEK_USB_VENQT_{READ,WRITE} directly as 
>> requesttype argument and get rid of u8 reqtype. + we can define these 
>> macros:
>> 
>> #define
>> usbctrl_vendor_read(...)   usbctrl_vendorreq(...,REALTEK_USB_VENQT_READ)
>> 
>> 
>> #define
>> usbctrl_vendor_write()    usbctrl_vendorreq(...,REALTEK_USB_VENQT_WRITE)
>> 
>> 
>> This will make code more nice, IMO  :)
> 
> Dear Pavel,
> 
> I agree in full: nicer and cleaner :)
> 
> I'll do that, but please notice that I will also need to change the code of the three
> usb_read*() for calling usbctrl_vendor_read(). Furthermore, "else res = 0;" becomes
> unnecessary. Please take these changes into account when you'll send them again
> as "regular" patches.
> 

It depends on which patch will go in first.

There are a lot of upcoming clean ups, so I am waiting for merging my 
series with random clean ups :) A lot of fun...

I biggest hope is that my series will go in before camel-case clean ups, 
because rewriting this for the 3rd time will kill my mind...



With regards,
Pavel Skripkin
