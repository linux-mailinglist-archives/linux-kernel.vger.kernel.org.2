Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32533F5A35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhHXIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhHXIx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:53:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577BC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:53:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d11so42658567eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KchTKU3OTyx4fIEVz6kFgXk9gVOceFXcIF7F4XX2QJA=;
        b=Az7/YPEWAQmJ/pH1jQ4FfIN/YG+FL19RVNpRvIddo4L61nVXKgSNgF4uzp82HaX2UE
         rO9iXKRh8n0Ex2q9OamfciJNS2047kSDCkExR9u6fiu+3GcbRBvfY8Sg6V6P1BclJgRT
         jDeRTTYPnqw4wNicRUFrWpju4PXLBTk/mS4WyqRkcCGs/4vVcpVibjxjWc1WkJl2ufaY
         Xnu+57sVcHR7ZL5p/7LxZbdKcR33NOt1mfg8RUVZg6bDctGbE+sQaoJCtKMZlIoKIpAF
         5LoUTnBszNXDXPA/faQMcPOO8tL7EvvAHt4PvDkLwevKXgrGaIIsPNPZEGYe4neayxp7
         3eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KchTKU3OTyx4fIEVz6kFgXk9gVOceFXcIF7F4XX2QJA=;
        b=bsao/NfZJilThTizICxkb1PsDKe3pa2GvowslAtNrogcUY8cCegiItU0jNA8Jlplj2
         nPYm2u7QvUE9OfbZiwsk+j2DUpyXoBIK8KmxTT6MxVS2FLZ4i3vcUd3xl8xy/gC+3fUc
         Sb3gsDs5lSG1lEuyqEbcgNgMd6z/2XqV68vWPQgjDc662K9OIlRC5AxVTJGAFWhHtW2h
         zpqbdvqlwQ5TOhZAmiQzU6Dz9D8nlvqHhy/2o63PB+Xsv+8x2CqMgUNKhYqs3XUDMwj0
         2Ui6Uyi4Su6Tco5uXMEPqrcQPOAqnH/w+kuli/gtMsXSBJ5Ex0jhj3GHEZ7c+9IXvN/M
         QiOw==
X-Gm-Message-State: AOAM5330t6RUWpwKM9wEPfX5TsDOJSCzzftN0nfKxUWutlI7PEZ5NyTR
        /T3IeSw2oYXe63kBbrBgqJQ=
X-Google-Smtp-Source: ABdhPJwq3eWorCB9QGeZKXl53/047RtAFkG9EOLac4I5mz7r1CQUdKcRtgyS9j8sMWeB/1gw/MYjbw==
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr40761873eju.295.1629795192909;
        Tue, 24 Aug 2021 01:53:12 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id br16sm8819806ejb.34.2021.08.24.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:53:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 10:53:11 +0200
Message-ID: <3198276.4iybWabFxt@localhost.localdomain>
In-Reply-To: <68eebfaf-50a3-a7ec-12ba-cde33c74c9ce@gmail.com>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com> <20210823223751.25104-2-fmdefrancesco@gmail.com> <68eebfaf-50a3-a7ec-12ba-cde33c74c9ce@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 10:13:46 AM CEST Pavel Skripkin wrote:
> On 8/24/21 1:37 AM, Fabio M. De Francesco wrote:
> > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > Thanks to Pavel Skripkin <paskripkin@gmail.com> for his review of the
> > RFC patch.
> >   
> > drivers/staging/r8188eu/hal/usb_ops_linux.c | 25 ++++++++++-----------
> > 1 file changed, 12 insertions(+), 13 deletions(-)
> > 
> > [...]
> >
> Hi, Fabio!
> 
> Christophe is right about semantic part. 

Hi Pavel,

I haven't yet read Christophe's message (but I'm going to do it ASAP). 
I hope he found out what is wrong with the code, what made Phil's tests
fail.

> Also,
> 
> if (!status) {
> 
> } else {
> 	if (status < 0) {		<-
> 					  |
> 	} else {			  |
> 					  |
> 	}				<-
> }					
> 
> Extra if-else is not needed, since status can be 0 and < 0, there is no 
> 3rd state, like it was before.

Correct, thanks!

Now I read the following from the documentation of the new API...

"Return: If successful, 0 is returned, Otherwise, a negative error number."

I'll remove that status < 0 check and whatever else is no more necessary.
Thanks, again :)

Regards,

Fabio

> With regards,
> Pavel Skripkin
> 




