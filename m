Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35B23F3EE9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHVJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhHVJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 05:54:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE3C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 02:53:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d11so30085736eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjVzYNZvbB9du5sq9s4xok+aFh0LQbHUUqZaZOClsU4=;
        b=J8wmz066FMU3qfAfKNdVCxAhXGXGcoRS2SI5doKn7jOqZ8bmfBRmuWKq82WrMjpceD
         2xAUsMl66p2QO5kHkXQ3K2L10/GdacOHEXnev1SgAP3u3At3klzf672EwEwvuiI3LvOR
         VDaXA2QyNvI2CuNCPzzoP/kQoI8HHr9I9JphE5KCX9bErtnAXUThu4PPr05VJEY2dEfd
         DhIMwlaZXSL2FEAz0iQQb3l/Izl55rHqbQUZKsd9AEtSN4FMPmsxZt+7NNkfmhYOWh/E
         CLR7DmMusTXGmxdd0XqtlkZ728CAJPzTJaAETGh2xlzVFCoDh46NxPzeLTrTCfp691U4
         QGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjVzYNZvbB9du5sq9s4xok+aFh0LQbHUUqZaZOClsU4=;
        b=MaXssLmWp1QAbtOSxfePmxG0gB92IMI34ApvYxshKhORTvjj3dTgpoFbCJRPbvkZZy
         lINQBx465PVag1H2CCm3ZQaqn4DvvAzHaoz50UUcZVrDivvTKFZHzR1ZbteuzNT2dqJS
         DWJXL3ByrZfT5Za/ZH+Bln2actQFKxFqrYXMNqND5pbHsmKwydDDsdUtgAkZhz+zrBUz
         vb/aHSZl0KSpJWsA3D4E+42K9cgGLacOYdvQYFvTblG+QJdmxyxQbvIimHUQO6ZOPqKg
         q7HJC827sPSr3ivnpQTIfrk9pi9O8rN7EXwkdZnZBaeP8Q+xLMX15aeUorYLE9cykpkF
         7uvg==
X-Gm-Message-State: AOAM533SOTKRtSE8PWzXKYxpuPf48Juc7gtnZR3GackIaYHOJ+Gp7FVR
        CE77s9Yxa9/ugIecy9wTrbU=
X-Google-Smtp-Source: ABdhPJzZi1PTo0iBgxjeGKJKIS1HADfYriQ3yQZdrcF2FN7I0KazdEqHxvC6lJV6jaBnhXKxILsEYw==
X-Received: by 2002:a17:906:4e11:: with SMTP id z17mr415581eju.483.1629626037194;
        Sun, 22 Aug 2021 02:53:57 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id t8sm5526399ejc.8.2021.08.22.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 02:53:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
Date:   Sun, 22 Aug 2021 11:53:54 +0200
Message-ID: <10584649.zhyk0TxWeL@localhost.localdomain>
In-Reply-To: <cover.1629479152.git.paskripkin@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2021 7:07:28 PM CEST Pavel Skripkin wrote:
> Hi, Greg, Larry and Phillip!
> 
> I noticed, that new staging driver was added like 3 weeks ago and I decided
> to look at the code, because drivers in staging directory are always buggy.
> 
> The first thing I noticed is *no one* was checking read operations result, 
but
> it can fail and driver may start writing random stack values into registers. 
It
> can cause driver misbehavior or device misbehavior.

After the messages I wrote yesterday, I had some minutes to look deeper at the 
code that would be changed by these patches.

I think that it does not look like that the driver could return "random stack 
values into registers" and I think this entire series in unnecessary. 

As far as I understand this driver (though I must admit that I really don't 
know how to write drivers, and I'm not interested in understanding - at the 
moment, at least), all the usb_read*() call usbctrl_vendorreq() and the latter 
*does* proper error checking before returning to the callers the read data. 

Please, look at the code copied from usbctrl_vendorreq() and pasted here (some 
comments are mine):

/* start of code */
static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void 
*pdata, u16 len, u8 requesttype)
{

/* test if everything is OK for transfers and setup the necessary variables */
[...] 

status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
                                         reqtype, value, 
REALTEK_USB_VENQT_CMD_IDX,
                                         pIo_buf, len, 
RTW_USB_CONTROL_MSG_TIMEOUT);

                if (status == len) {   /*  Success this control transfer. */
                        rtw_reset_continual_urb_error(dvobjpriv);
                        if (requesttype == 0x01)
                                memcpy(pdata, pIo_buf,  len); /* pdata 
receives the read data */
	} else { /*  error cases */

[...]

}
/* end of code */

So, *I cannot ack this RFC*, unless maintainers say I'm missing something.

Larry, Philip, since you have much more knowledge than me about r8188eu (and, 
more in general, on device drivers) may you please say what you think about my 
arguments against this series?

Thanks,

Fabio

> To avoid this type of bugs, i've expanded read() API with error parametr,
> which will be initialized to error if read fails. It helps callers to
> break/return earlier and don't write random values to registers or to rely
> on random values.
> 
> Why is this pacth series RFC?
>   1. I don't have this device and I cannot test these changes.
>   2. I don't know how to handle errors in each particular case. For now, 
function
>      just returns or returns an error. That's all. I hope, driver 
maintainers will
>      help with these bits.
>   3. I guess, I handled not all uninit value bugs here. I hope, I fixed
>      at least half of them
> 
> This series was build-tested and made on top of staging-testing branch
> 
> 
> With regards,
> Pavel Skripkin



