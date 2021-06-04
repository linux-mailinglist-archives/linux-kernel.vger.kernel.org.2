Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6459A39BB7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFDPPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:15:42 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41584 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:15:41 -0400
Received: by mail-wr1-f47.google.com with SMTP id h8so9647834wrz.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=MDeGfSOld04qEQUDmCqC+elxeKhTaZfQS1sxhyZdy0Y=;
        b=d5MDz4Zcs9bzXxzzD6J6cD5EERCnWZkQiBtJR5sSos112Wxg0vjLR/3rJhzlGG3Yax
         XEjP2GMX2gXwgxvVbWkfdSD3cmrnencbp5mtxnYQpq+8c7yyG7Hpx3UWr0RKFdjGTXe/
         FnlW4x86W1l/I5Eb7Hmx74h9Gr/fs+zhuDxwkV4rQlWdko8pt+d6l5gtzogqaNv8txZ6
         /9HRqo7iImdMUDw+2K6y+hsM6smVmOOqEQaVkwKJpgEj57jJgLD+PzjRGJoiT+IYfVxr
         zu+avRfVJKF8JATHMUwXQzDCTMtorPLPrXjo8hBpOsUhggsjgNskOPyQyt0YIGw3LZeV
         /gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=MDeGfSOld04qEQUDmCqC+elxeKhTaZfQS1sxhyZdy0Y=;
        b=pPUrloMBwww03MWQetXN14AMay8ojQVV5Ex4Xo27ItwKYtIO+s5lgzwPOw53JMlD9r
         TrqS7I4BxmjNTHEdj3Dmgm2DmqQxcCs5kZKbx90DjwjaA+9QipjyXcUK7QFKYqLFPziC
         DN+uM7TMt373GOlz23Ws7aLWG1h55TNY2xvhpcTrzfW1dh8KhjyvgUVpskoRQgcLjFsD
         zsv12SPMt92OkgruOkrYd2cAz9IoQk7TcEfDIdMiIBCTH3am2NvA37ZGVZyuMIj/mjj/
         b8m95D41ZoyWk2O0gNiYJIioWhEVc1PLnPkzLqcl4rAudQtqNH3Lp8f7gLvNCAOawqsv
         j+Nw==
X-Gm-Message-State: AOAM531clOGCHNR0KReUUPYC8zOTewIrqeqSAKD38LuhMqast3CdSzY8
        Aptgwrvy96zcLcEEmvoOH+vMkQ==
X-Google-Smtp-Source: ABdhPJxOOBkqtmSGRq5uBC35IeEVOExCMPn+wThxkwQOhppV58DDG+bt3IdDk6y9AOOuq35kRbLKrQ==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr4420402wrt.133.1622819574228;
        Fri, 04 Jun 2021 08:12:54 -0700 (PDT)
Received: from localhost (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id z19sm8247865wmf.31.2021.06.04.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:12:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 04 Jun 2021 16:12:52 +0100
Message-Id: <CBUXIZOCOIXC.3V1ERV326ST89@arch-thunder>
Cc:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] usb: isp1760: Fix meaningless check in
 isp1763_run()
From:   "Rui Miguel Silva" <rui.silva@linaro.org>
To:     "tongtiangen" <tongtiangen@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20210601100311.70200-1-tongtiangen@huawei.com>
 <YLjAweuyJXzDn9pe@kroah.com>
 <bb426fd3-ec56-ec95-0c6a-092627d547b6@huawei.com>
In-Reply-To: <bb426fd3-ec56-ec95-0c6a-092627d547b6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Managed to test this and looks good. Everything is working as
expected.

On Fri Jun 4, 2021 at 3:09 AM WEST, tongtiangen wrote:
> On 2021/6/3 19:45, Greg Kroah-Hartman wrote:
> > On Tue, Jun 01, 2021 at 06:03:11PM +0800, Tong Tiangen wrote:
> >> There's a meaningless check in isp1763_run. According to the
> >> similar implement in isp1760_run, the proper check should remove
> >> retval =3D 0;

however I think a more descriptive changelog instead of comparing to
similar function would be better, maybe something around:

"Remove attribution to retval before check, which make it completely
meaningless, and does't check what it was supposed: the return
value of the timed function to set up configuration flag."

> >>
> >> Fixes: 60d789f3bfbb ("usb: isp1760: add support for isp1763")
> >> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

With changelog changed you can add:
Tested-by: Rui Miguel Silva <rui.silva@linaro.org>
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

------
Cheers,
     Rui

> >> ---
> >>   drivers/usb/isp1760/isp1760-hcd.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/i=
sp1760-hcd.c
> >> index 016a54ea76f4..27168b4a4ef2 100644
> >> --- a/drivers/usb/isp1760/isp1760-hcd.c
> >> +++ b/drivers/usb/isp1760/isp1760-hcd.c
> >> @@ -1648,7 +1648,6 @@ static int isp1763_run(struct usb_hcd *hcd)
> >>   	down_write(&ehci_cf_port_reset_rwsem);
> >>   	retval =3D isp1760_hcd_set_and_wait(hcd, FLAG_CF, 250 * 1000);
> >>   	up_write(&ehci_cf_port_reset_rwsem);
> >> -	retval =3D 0;
> >>   	if (retval)
> >>   		return retval;
> >>  =20
> >> --=20
> >> 2.18.0.huawei.25
> >>
> > Did you test this change to verify that the driver still works properly=
?
> > You are now checking something that never was checked before...
> >
> > thanks,
> >
> > greg k-h
> > .
> Sorry,  this fix was not send to Rui.
>  From the point of view of code logic, there should be a problem here. I=
=20
> don't have the actual hardware to verify whether it works properly. Rui=
=20
> may know if the patch affects the original workflow.
>
> thanks
> .
> >



