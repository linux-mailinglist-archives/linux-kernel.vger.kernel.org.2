Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98003F3EEF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhHVKKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 06:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhHVKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 06:10:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6851DC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 03:09:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l18so18076261lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vcNozNLiELsOkaLftabobubDY4L64Yc6cQ2FcWqWBwc=;
        b=AFzTJUh5WbeVl60l5ScI4OD/h0pdCopHPcUgEUZFjjGFgIUG/Am9kwC2//d8jRsMb/
         GVLUwObKjQdbGvKU5v8p3ppN93tPqUg5WnEjut7KYGes8TlQXaM9pt5bzOQc0wnPbpwo
         +b/EopIXzIfVaKKOyj1uXR/2Khby+vAOi/opmcmKS43ZF3HOGtpgcv3lBLimPVIHs+nf
         WQXJwN+XFfMSoM+gfyo1RnFom70IC9xk45tWGwxJL7aO/s6g81QEGBQjMYGFCmeYSMVu
         IPwvvu55HKOO7asNeVUUU2gCr3y6Uafq2TqczBMWjNCPYwZ2lPj4993N8S+nxeSAoHjc
         W8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vcNozNLiELsOkaLftabobubDY4L64Yc6cQ2FcWqWBwc=;
        b=caHzYBDQXQ0ESNmNoxnIlYEq9ARZrf2jK2Exrg8d0mMVIZMShMJOUjAzkDOUeDkU2R
         RFMJR94mYXsIU02H7jogM3CnOEJ1KDYsbb89Y2NZpTydLeIw+aZL5SFVYEOBK3k5HaLO
         U75kgkUzh2YUWAayQrAha02Lw6mJgOSoKASxoLVmKyz7xTBr8hCJgHZC7ZRhB3KJJLPa
         xHhi3vJ12RMb5twkAuYoBi5GY8PTydvM/q1smUK/PKlR3PsszfLn0trQBaCGnKQNgdVV
         ehPYfDd4w2a7DOCBDDuV1BAFPDU/+W9QoJNa98uQhK7cBISlAsm8Z8NVbE0H7q1nnK2F
         N1Mg==
X-Gm-Message-State: AOAM5308PLvNUO5PVa8qZ6mBKayqSJoemYi4kgLBWpkKcQnGVRw+SbsW
        g7G74Qj/dstoWk6VxvWEFRM=
X-Google-Smtp-Source: ABdhPJxptblskllBGDsN7QLRA5pwdqKM080g9LWwy7oYDzbKhQBq+unHX2UY758PcBm36jHbvncoZg==
X-Received: by 2002:a2e:a288:: with SMTP id k8mr22538870lja.315.1629626972669;
        Sun, 22 Aug 2021 03:09:32 -0700 (PDT)
Received: from localhost.localdomain ([185.215.60.67])
        by smtp.gmail.com with ESMTPSA id o6sm1268933lfo.110.2021.08.22.03.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 03:09:32 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
References: <cover.1629479152.git.paskripkin@gmail.com>
 <10584649.zhyk0TxWeL@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <ae27d6a0-dc00-459f-7b36-acf7f4c08d72@gmail.com>
Date:   Sun, 22 Aug 2021 13:09:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <10584649.zhyk0TxWeL@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 12:53 PM, Fabio M. De Francesco wrote:
> On Friday, August 20, 2021 7:07:28 PM CEST Pavel Skripkin wrote:
>> Hi, Greg, Larry and Phillip!
>> 
>> I noticed, that new staging driver was added like 3 weeks ago and I decided
>> to look at the code, because drivers in staging directory are always buggy.
>> 
>> The first thing I noticed is *no one* was checking read operations result, 
> but
>> it can fail and driver may start writing random stack values into registers. 
> It
>> can cause driver misbehavior or device misbehavior.
> 
> After the messages I wrote yesterday, I had some minutes to look deeper at the
> code that would be changed by these patches.
> 
> I think that it does not look like that the driver could return "random stack
> values into registers" and I think this entire series in unnecessary.
> 
> As far as I understand this driver (though I must admit that I really don't
> know how to write drivers, and I'm not interested in understanding - at the
> moment, at least), all the usb_read*() call usbctrl_vendorreq() and the latter
> *does* proper error checking before returning to the callers the read data.
> 
> Please, look at the code copied from usbctrl_vendorreq() and pasted here (some
> comments are mine):
> 
> /* start of code */
> static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void
> *pdata, u16 len, u8 requesttype)
> {
> 
> /* test if everything is OK for transfers and setup the necessary variables */
> [...]
> 
> status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
>                                           reqtype, value,
> REALTEK_USB_VENQT_CMD_IDX,
>                                           pIo_buf, len,
> RTW_USB_CONTROL_MSG_TIMEOUT);
> 
>                  if (status == len) {   /*  Success this control transfer. */
>                          rtw_reset_continual_urb_error(dvobjpriv);
>                          if (requesttype == 0x01)
>                                  memcpy(pdata, pIo_buf,  len); /* pdata
> receives the read data */
> 	} else { /*  error cases */
> 
> [...]
> 
> }
> /* end of code */
> 
> So, *I cannot ack this RFC*, unless maintainers say I'm missing something.
> 
> Larry, Philip, since you have much more knowledge than me about r8188eu (and,
> more in general, on device drivers) may you please say what you think about my
> arguments against this series?
> 

Hi, Fabio!

Thank you for looking into this, but I still can see the case when pdata 
won't be initialized:


pdata is initialized only in case of successful transfer, i.e len > 0. 
It means some data was received (maybe not full length, but anyway). In 
case of usb_control_msg() error (for example -ENOMEM) code only does 
this code block:

if (status < 0) {
	if (status == (-ESHUTDOWN) || status == -ENODEV) {
		adapt->bSurpriseRemoved = true;
	} else {
		struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
		haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
	}
}


And then just loops further. In case of 10 ENOMEM in a row,. passed 
pdata won't be initialized at all and driver doesn't do anything about 
it. I believe, it's not good approach to play with random values. We 
should somehow handle transfer errors all across the driver.

If I am missing something, please, let me know :)



With regards,
Pavel Skripkin
