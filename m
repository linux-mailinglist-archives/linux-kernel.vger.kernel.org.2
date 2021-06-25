Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B33B3C54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhFYFp0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Jun 2021 01:45:26 -0400
Received: from smtp1.hiworks.co.kr ([121.254.168.204]:47661 "EHLO
        smtp1.hiworks.co.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFYFpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:45:24 -0400
Received: (qmail 103729 invoked from network); 25 Jun 2021 14:43:01 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.162)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        25 Jun 2021 14:43:01 +0900
Received: (qmail 161327 invoked from network); 25 Jun 2021 14:43:00 +0900
Received: from unknown (HELO DESKTOP3HTLQGF) (tykwon@m2i.co.kr@58.75.176.98)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        25 Jun 2021 14:43:00 +0900
X-Authinfo: HIWORKS SMTP authenticated <tykwon@m2i.co.kr|58.75.176.98|tykwon@m2i.co.kr|210625144300_9053161325>
From:   "Kwon Tae-young" <tykwon@m2i.co.kr>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     "'linux-mmc'" <linux-mmc@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20210624061418.30361-1-tykwon@m2i.co.kr> <CAPDyKFrh9azyXNwFHxoe1svDQKRWbr5FpWz3V_JOD+Zv0cHcug@mail.gmail.com>
In-Reply-To: <CAPDyKFrh9azyXNwFHxoe1svDQKRWbr5FpWz3V_JOD+Zv0cHcug@mail.gmail.com>
Subject: RE: [PATCH] mmc: core: Added support for LED trigger only when SD  card is connected
Date:   Fri, 25 Jun 2021 14:43:01 +0900
Message-ID: <038801d76984$f672b0b0$e3581210$@m2i.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQM/ouEl57R0GPXs7J4RkiPdEOUrjgFbgzw3qEjedVA=
Content-Language: ko
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > f194940c5974..b3156f6c5cfa 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -352,7 +352,11 @@ int mmc_start_request(struct mmc_host *host,
> struct mmc_request *mrq)
> >         if (err)
> >                 return err;
> >
> > -       led_trigger_event(host->led, LED_FULL);
> > +       if (host->ops->get_cd)
> 
> No, this is not the right thing to do. Invoking the ->get_cd() callback,
> for every request is suboptimal and would likely have effects on
> performance.
> 
> Moreover, I wonder how big an issue it is to use the led here. If the
> card is being removed, the request will fail anyway, so the led should
> soon stop flashing anyway, right?

Thanks for the feedback.

When I think about it, it seems that an error should be returned from the mmc_card_removed() function when the SD card is removed.
However, in my current board, no error is returned from mmc_card_removed().

I'm guessing it's because of the NULL in the mmc_sd_remove() function in drivers/mmc/core/sd.c , but I'm not sure.
I think it was clumsy because I was a newbie unfamiliar with mmc drivers. :)
I'll take a closer look.

Regards,
Kwon

