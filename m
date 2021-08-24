Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF13F540D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhHXAVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 20:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhHXAVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:21:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:20:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s25so16172021edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QKdBZxDFHndwOQG1Un1Lk4xYZnYyIdDtym0pAYP0928=;
        b=K/LBXXmvkKXexztWTE3wz9eJvBMeLh8/L0naG1NpnJC2CdcbfDAaTfFl6uNf6VKtfl
         VKilNQa4EFp3TrvSScnX2NNwJ52zJiqL9gd12ZZ26/fzeG2Oyweylx+JQB4SPdvmxodl
         PhLXGAtolSmny6upEWqno2H/JeTtMv397OpIubI+2ui+fIlY2FwqhQikr2CXRzObegNR
         ZaiiidXK2DMmpc243PgT33Haz5OHGSI3EC0STMWQHTheupQ4aFotCl+x461bQNIgLyjd
         FDl9xUwWMlKJ6dNQ8UCxXg7TTZwb+L8BBnAaEogj+FszMuoWZwub0VtMGeTTLtOw7xPf
         mMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKdBZxDFHndwOQG1Un1Lk4xYZnYyIdDtym0pAYP0928=;
        b=O4+IFz82rdd+L2wrI86hgp6jBCHSJTwkz+oc/eeDlg6BLEgqLEcJz1rKQiqevct9YO
         rbMhh8jPtRdJw+3bl5ISVrQCVppcn2VsKBeJIA7vZNiSP7Uqok1qkoADWeSCS5FFH9rH
         mbXWoYu57D3sKhCCra/rxR5FZtihbOuNv18hARIKdogHqmaZcdgopRCIe2inTPPgeyfW
         2QloxhWK9tdqQlw4Z2jqp3OfVTMlkpXyIWfZjzGLerIFzG67nVxC3jR6aI8EAO9CfDjk
         AHamHkPTHP5gluOUegl8BXieQO0uuTT8VSTWtzh5iF9R6sMoTKHiS+exTk8OSSfNlQhx
         hjtA==
X-Gm-Message-State: AOAM532+hucWYQtQR9WNQAJsgx7o9KYJo/QA4HYES2VqiDN2MaiSiQzc
        byvtvqnEsLJzxHI1UDTsrrI=
X-Google-Smtp-Source: ABdhPJz01PB6DdPLd7d/mkqNO2gsfep56Mq8yBVumeVZDPPPQY/KUosqJYvMEeihpBzZDQv7TNr+JA==
X-Received: by 2002:a05:6402:318c:: with SMTP id di12mr8068153edb.55.1629764431113;
        Mon, 23 Aug 2021 17:20:31 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id o3sm8175697eju.123.2021.08.23.17.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 17:20:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH RFC] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 02:20:29 +0200
Message-ID: <1935919.xT9xXRIY7p@localhost.localdomain>
In-Reply-To: <7ce23fb2-3c8b-352e-1f2e-421ac7c64200@gmail.com>
References: <20210822230235.10953-1-fmdefrancesco@gmail.com> <8275282.m2tVFbhrJk@localhost.localdomain> <7ce23fb2-3c8b-352e-1f2e-421ac7c64200@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2021 1:05:17 PM CEST Pavel Skripkin wrote:
> On 8/23/21 1:47 PM, Fabio M. De Francesco wrote:
> >
> > [...]
> >
> >> I think, we can pass REALTEK_USB_VENQT_{READ,WRITE} directly as 
> >> requesttype argument and get rid of u8 reqtype. + we can define these 
> >> macros:
> >> 
> >> #define
> >> usbctrl_vendor_read(...)   usbctrl_vendorreq(...,REALTEK_USB_VENQT_READ)
> >> 
> >> #define
> >> usbctrl_vendor_write()    usbctrl_vendorreq(...,REALTEK_USB_VENQT_WRITE)
> >> 
> >> This will make code more nice, IMO  :)
> > 
> > Dear Pavel,
> > 
> > I agree in full: nicer and cleaner :)
> > 
> > I'll do that, but please notice that I will also need to change the code of the three
> > usb_read*() for calling usbctrl_vendor_read(). Furthermore, "else res = 0;" becomes
> > unnecessary. Please take these changes into account when you'll send them again
> > as "regular" patches.

I have reconsidered the tip above and, while I appreciate your suggestion, I think it's 
not so necessary to use the macros only to get rid of "u8 reqtype".  I finally got rid of 
that variable by passing the request types explicitly to usb_control_msg_recv/send().

> It depends on which patch will go in first.
> 
> There are a lot of upcoming clean ups, so I am waiting for merging my 
> series with random clean ups :) A lot of fun...

A lot of fun... Sure? :)
 
> I biggest hope is that my series will go in before camel-case clean ups, 
> because rewriting this for the 3rd time will kill my mind...

 In this case, I wouldn't want to be in your place :)
> 
> With regards,
> Pavel Skripkin

Thanks again very much for your review,

Fabio




