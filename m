Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397AA35738E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhDGRvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhDGRvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:51:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52CCC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 10:51:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w3so29093045ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Vls4/3zvc2Jbgm4jryJRtoq1uc7/NcDLPeC8cMRFac=;
        b=kW7FnULX8k4nFVFyKv57LJLG/yhCAwFlox+xyV/Dm/Vw3jprixAq59+NftEXZnSL/4
         p3Cb8MUuY4hxLpEbX4H6xNK6pVvqOkjoYiKLmrhnMRDF5jmkdzOpZM6F3yncrP83I3GU
         IwBBWcrGAfMmjG7XsLkbKaWUuyhx0ffCHaiI3mQuzCTUyDtiAEjvUpOYsiISC3NbZOYK
         5fzTai400rwvYVzEdzFC2PhtH2yzW4qVKxgYw5XzWLw9zIBtm4y+9QzZXJPjpd4brWd3
         gN4n2jHhYVcKO/4gM5SpvMySRdYlm058saMM3b2CNJX4ked0GDVRFpzlf3n5fctY+nmd
         Lrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Vls4/3zvc2Jbgm4jryJRtoq1uc7/NcDLPeC8cMRFac=;
        b=IZOq+0teP4ajg8LR22hMP3EurwGZNEOJPgQ7JaGV1FbbLIGiDkmbYab66EQHf/QLpi
         wLMHOMYAdINjU2UM1WaCpo7xWSKJZA9TysoIYuKwmMkPEVGlIRSpFRfPxCvJwhOrKC4i
         +z3+QVz+H435BGMA+BmP8FLWjY+Tpn4Tvxzn6f4WPySvk4TiMf41ARr3Mtla4MQEQId5
         us6uZm2UUvJ+ptR2YUF+twYJn+EYEqfpLPC9RoMvWUvXHxgwLvENiK+K08EI+iO0THBN
         LwM5DxycVkSdoZhpGRsv7czYCqr2KW5hffbMIjqFLrkVFd2NG+HJdfxbOHXaKp+xUTlS
         ETqA==
X-Gm-Message-State: AOAM5336a8OKunR7XhAoKjYt0CVFBNFrVLUnymWZMvGmNQ8u3OC75KNF
        dfZVJ1gj9mgZCxUmbsJWeB4=
X-Google-Smtp-Source: ABdhPJw4oRDBrwlfgp2GPfGvNi99A51KD7P01NjcUfkVjS6NtC0Kf0ZV7+0elnVYhYdEOLc6u/77jQ==
X-Received: by 2002:a17:906:3609:: with SMTP id q9mr5194541ejb.119.1617817870503;
        Wed, 07 Apr 2021 10:51:10 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id oz1sm2952186ejb.80.2021.04.07.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 10:51:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove camelcase
Date:   Wed, 07 Apr 2021 19:51:08 +0200
Message-ID: <53939680.76uNBjAIv9@localhost.localdomain>
In-Reply-To: <YG3rihKrS2tvr1tS@kroah.com>
References: <20210407163000.27611-1-fmdefrancesco@gmail.com> <YG3rihKrS2tvr1tS@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 7, 2021 7:27:38 PM CEST Greg KH wrote:
> On Wed, Apr 07, 2021 at 06:30:00PM +0200, Fabio M. De Francesco wrote:
> > Remove camelcase. Issue detected by checkpatch.pl. For now, change only
> > names of static functions in order to not break the driver's code.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/sdio_ops.c | 44 ++++++++++++------------
> >  1 file changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > index b1f02bb9f0a9..5e28818e58e0 100644
> > --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > @@ -19,7 +19,7 @@
> >  /*  */
> >  /*  Creadted by Roger, 2011.01.31. */
> >  /*  */
> > -static void HalSdioGetCmdAddr8723BSdio(
> > +static void hal_sdio_get_cmd_addr_8723b_sdio(
> >  	struct adapter *adapter,
> >  	u8 device_id,
> >  	u32 addr,
> > @@ -97,7 +97,7 @@ static u8 get_deviceid(u32 addr)
> >  
> >  /*
> >   * Ref:
> > - *HalSdioGetCmdAddr8723BSdio()
> > + *hal_sdio_get_cmd_addr_8723b_sdio()
> 
> What does this comment even mean?

Who can tell? Maybe we should ask the author :(

> 
> I think you can delete it.
> 

Mission accomplished. I'm about to send a new patch.

> But really, that's a crazy function name length, can you make it any
> shorter?

Device drivers developers have their own "style": functions names must have 25 characters or more! 

> thanks,
> 
> greg k-h
> 




