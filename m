Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9650410616
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhIRLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhIRLnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:43:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6634C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:41:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z94so40030639ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyPW0Wbd2+9O7EwnvjL3EIdzD7ouM/ffNlI77HQ464A=;
        b=dZU2bNfL2HLKz9omH7N3zdjyCqYlfV2krt/0F7IKAzHbA1kDdMIgIQ+wColt1LTflz
         A0HUbEneKBlOqx1T+EmTd59OQFzdx7Fs8IYKAjy8ta4oZC4UMiV3QNfOwkOrvYwkyJ9e
         /HRhShWgBY56vXP6Va+M2L+kCnc9NtpFxYfdOt9DG14O07DC4a2mYTkiVtmUfsznuHhf
         V4NHXBtAxQCB7eAGGbcbCgyNcOe7hGnHckMvrhigEvylNloVgNyYD+AC2UpXgkOc9+L4
         A/YKwXXGOd0daPOv9g5IuIqaDk6jilPjvPtwNhk7lZ+HHCsF+/v3D0/yMv04D/xMdZqv
         lz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyPW0Wbd2+9O7EwnvjL3EIdzD7ouM/ffNlI77HQ464A=;
        b=67ngP8sMNWlTknCK/PnDk3qhp67f20aO1VUcyzDcQb7IBJ8A1019xKTDNhMC2n8lz2
         zsLiS8bK3TQyzvtwgPYACvwAbYCTRK4ERQED/RKbrSiZ29RzpHjcpiKFX1rGb1yqcDeT
         vtP69B00EnHCHvexi5WuFn6mM0kd3/lI9NGsZechocV10WWUaLLtt9viaziWsvTj7Utm
         MYporhB0N/rVpOrilyQHLGae0vwF2dj5f8odK/S/1Dak+1kHuLqTYAbpDQGIBbVM+BSa
         qNvP2/9NcAcFcKh/D1bTiUBBTUsS19qUvb57cEzGoU06k+4mIkB3lDh6q+gI4pvD1eGd
         KtqQ==
X-Gm-Message-State: AOAM530UUjY4ngbYPuFbZUY1Epaiy80sNM4WjzwOBcyxLYVa+K6kATNT
        ILJlx9rJcTW47/AvPpAKMcA=
X-Google-Smtp-Source: ABdhPJwVWcoSpeSseyyTv7UAgYJM2PnWiRkiGcgaUvWeAk4hdCzdP0pPw/8eYQu2YOC7hcI1sa0Xcw==
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr18108769eji.385.1631965315346;
        Sat, 18 Sep 2021 04:41:55 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id 10sm3546343eju.12.2021.09.18.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 04:41:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 16/19] staging: r8188eu: clean up rtw_read*() and rtw_write*()
Date:   Sat, 18 Sep 2021 13:41:48 +0200
Message-ID: <2291806.MQVBmByTbm@localhost.localdomain>
In-Reply-To: <YUSqCYKOulGjk1lZ@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com> <20210917071837.10926-17-fmdefrancesco@gmail.com> <YUSqCYKOulGjk1lZ@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 17, 2021 4:45:29 PM CEST Greg Kroah-Hartman wrote:
> On Fri, Sep 17, 2021 at 09:18:34AM +0200, Fabio M. De Francesco wrote:
> > Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in 
usb_ops_linux.c.
> > 
> > 1) Rename variables:
> >         length => len
> >         pio_priv => io_priv
> >         pintfhdl => intfhdl
> >         wvalue => address.
> 
> Wait, why are you changing wvalue?  Isn't that the USB name for this
> variable in the USB message sent to the device?  Check the USB spec
> before changing this, that is a common field and probably should not be
> changed.

Oh, sorry. This was due to my very limited knowledge of the USB subsystems 
and its Core API. So I misunderstood the semantics of this "wvalue" argument 
and we'll change it to "value" (just to remove that unnecessary 'w', that I 
guess is for "word"). 

I had thought that the mere knowledge of C and OS kernels (from a theoretical 
perspective) would suffice to work on the code that we change in our patches. 
Now I understand that such a naive approach is clearly wrong.

I have been too lazy to open your LDD 3rd ed. for reading but now I have 
decided that it is time to do it. Furthermore, I have found one more book 
about Linux device drivers and I'm about to read also its "Linux USB device 
drivers" chapter.

I think that by this evening I'll have some basic knowledge of the USB 
subsystem, at least of what is needed to avoid future mistakes like the one 
you noticed. :) 

Thank you very much for the time you spent reviewing our code and for taking 
the first 14 patches,

Fabio

> 
> thanks,
> 
> greg k-h



