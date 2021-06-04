Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2228639B4C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFDIZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:25:10 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38773 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFDIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:25:09 -0400
Received: by mail-wr1-f41.google.com with SMTP id j14so8403419wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=/SF7msZ6RZkO8FLmmvLTe36Mf4HzOKhqGaAVIdE3wOk=;
        b=PqHG/04wvWGhz4v745toSclNdYIcRJdEj8Gsg4OePpMsur6qz6W96zlfAtgVBtOd0v
         zJMM9MExH+ShqZLsYJDNjuhD7tCeHARYScYywghSmeAlCWMzIEqkrYNaq5ZdWu+t6WjD
         kSi2MBh2ttbJDqK+mtPtW3Vxn+Soyh2pdS+anxbiOGmQDsWmEblInyRh0pi2sJUbp7kQ
         wCkzoJs0V8S0gAcYOTtHAjG6prg/xG2/OWn0hauZGo8VquWrozH71Fn0neJ3WPC44hoN
         B1jXNdUsUNlyeA1Zb6Ww88xca6InwWefQmLuLzoJGnCF//vxlkU+beROOrpEEXOcatHu
         m0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=/SF7msZ6RZkO8FLmmvLTe36Mf4HzOKhqGaAVIdE3wOk=;
        b=o6Y58c1qU6+I4n0hlzzGYw9TBvgvhv7jMYwOnd7ugunNG8UliJziJQ3cI8FkFZc1iU
         9SB6xbj9sbCZUFN+g4Qii3KpoK0OlmxfnZYOz0cYHHLQKT8PDZpS0wrE88mmQN+z75dx
         mBn/R1fIfv8j84g8fzhq4WGPImz0w9m++OkjE494eMsNcx7g0xZZAdmuiN1BNjZyKo+p
         dc+L7bsJZYY9pvpo+vKw/Z8EACzThh6PjOJfdFiZQrFNA+aJ3+lH7obZFAWNHXp/wMd3
         gR6BiANW8t17h5IGXOa3ajzUb4OS3QCZpkN/Vf9AhUIkhKrRcXfJ6vVE3hN+Q1ti87Di
         gUlQ==
X-Gm-Message-State: AOAM533kpaTpMdPoNSkodCJlRl23w4u7RD1R5ir7KZ3hQTix6JiNfOL7
        4X8qWDQOmPANW6H2bDH4YD/PgQ==
X-Google-Smtp-Source: ABdhPJwj4w/NdZJEvVw2NG8tY4Pi2OeTw0UqTE6BV/Bc5tVUbnogr8hRm1Mctc++rcEUBXqL04vrbQ==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr2519579wrw.278.1622794942603;
        Fri, 04 Jun 2021 01:22:22 -0700 (PDT)
Received: from localhost (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id b22sm1674294wmj.22.2021.06.04.01.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 01:22:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 04 Jun 2021 09:22:21 +0100
Message-Id: <CBUOSO6T5NP7.FJOIWX8PSVP8@arch-thunder>
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

Hi Tiangen,
On Fri Jun 4, 2021 at 3:09 AM WEST, tongtiangen wrote:
> On 2021/6/3 19:45, Greg Kroah-Hartman wrote:
> > On Tue, Jun 01, 2021 at 06:03:11PM +0800, Tong Tiangen wrote:
> >> There's a meaningless check in isp1763_run. According to the
> >> similar implement in isp1760_run, the proper check should remove
> >> retval =3D 0;
> >>
> >> Fixes: 60d789f3bfbb ("usb: isp1760: add support for isp1763")
> >> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
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

Thanks Greg for asking the right question here :)

> >
> > thanks,
> >
> > greg k-h
> > .
> Sorry,  this fix was not send to Rui.

Yeah, I did not get the original, no. I will need to add entries in
MAINTAINERS for this driver to be easier for others.

>  From the point of view of code logic, there should be a problem here.

It looks like. Only if we fail to setup the Configure Flag,
something that it's not really expected to fail.

>  I don't have the actual hardware to verify whether it works
>  properly. Rui may know if the patch affects the original workflow.

Thanks for the patch and I will test this and get back to you.

------
Cheers,
     Rui
