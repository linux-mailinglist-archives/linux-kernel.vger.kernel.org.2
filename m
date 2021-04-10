Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77E935ABC1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhDJH5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhDJH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:57:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E360C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 00:57:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bx20so7942074edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDz3jvFOwEc4wUnq/2xbNrKI18OHCzs173xEX28V0No=;
        b=n9juL8nY9gtyrFUHl8AS1kpInNH6B86eiKl34oAZg0sZCb4wHZzrwnXJoDXGziJ1Db
         szYD4zY6bXgb0M0MWmCwo4b14h1wO5vNMAIAryFxDb5ZVZJJhCrOPDX0tXz//g6b6001
         H1jbg4fuZ9mdBLSuzA995ZQJL9sYUBT1g/7n7+W3e6Qpen/c063j8vmrdaVuoLH54vR3
         SLU80W38bsAg71MGPUKQdoxHfIrRNFg0cFd20WljCqQpoFLgQo/S/l/dQmgIHLvTwHXG
         4COg+t5Fy3ClyxhwBVOnR+YO0+dtH+SBN+EooKwZGBuJcjG82/XY0gzkbLsujU1KLr54
         X2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDz3jvFOwEc4wUnq/2xbNrKI18OHCzs173xEX28V0No=;
        b=PRqnSySlvMlZzx/tt8r5W34vqk2psE+5vjPy8sGVttOvg79PyoxcclLy8H4mYDOZfX
         GCiiw0S20ybeAOLJtZB5pySEPvpQoDQdS6gMR83aH6UerdVgysMfMQePI2tEwKk21py1
         z70zbirqilQI49kPX4vk+BCM5TO4lSQo/TwqEWEpTKPINMDaGfhKa/icecBXnxryB8Bq
         76SgR2T3SCFgcfZlnAq2WQncL9++T42DsWmG1EbmeHwqqpnzGZiKQ2a/cceAcwOFWNEX
         kpJkSpLvKyAOX+tfKcMzDHVx2NDgnsGGbauT+u1aETIABUx6ptAHvNy2qqV09vz+HdEV
         OAOA==
X-Gm-Message-State: AOAM5329lcyyRa+pE2QuRf4QrgyfQ688OtXyNY+pB4+gEoETTHVygbDJ
        cEMVQzWtl+N3N/U1OTG41RPyOpFqWGHGnd+G
X-Google-Smtp-Source: ABdhPJwT0iXEVb/nTfcFvPgwg9YHCbHDcmSAfIYIR8OFR5s9iznlhxDvGpw8wJWcGuVZl5b4PeGg/w==
X-Received: by 2002:a50:bb05:: with SMTP id y5mr18490755ede.384.1618041422174;
        Sat, 10 Apr 2021 00:57:02 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id x24sm2708176edr.36.2021.04.10.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 00:57:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [Patch 0/3]
Date:   Sat, 10 Apr 2021 09:57:00 +0200
Message-ID: <2101069.1PIH1tPmJ7@localhost.localdomain>
In-Reply-To: <YHFT2S31kFy72DMv@kroah.com>
References: <6552860.D8CPca6BT0@localhost.localdomain> <YHFT2S31kFy72DMv@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 10, 2021 9:29:29 AM CEST Greg KH wrote:
> On Fri, Apr 09, 2021 at 06:29:59PM +0200, Fabio M. De Francesco wrote:
> > This patch series removes camelcases, changes the type and use of a
> > variable, and correct misspelled words.
> > 
> > Patch 1/3: staging: rtl8723bs: Remove camelcase in several files
> > 
> > drivers/staging/rtl8723bs/core/rtw_cmd.c       |  2 +-
> > drivers/staging/rtl8723bs/core/rtw_mlme.c      |  2 +-
> > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 18 +++++++++---------
> > drivers/staging/rtl8723bs/hal/hal_intf.c       |  2 +-
> > drivers/staging/rtl8723bs/hal/rtl8723b_dm.c    |  6 +++---
> > .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  2 +-
> > drivers/staging/rtl8723bs/hal/sdio_ops.c       | 14 +++++++-------
> > .../staging/rtl8723bs/include/rtw_pwrctrl.h    |  2 +-
> > 8 files changed, 24 insertions(+), 24 deletions(-)
> > 
> > Patch 2/3: staging: rtl8723bs: Change the type and use of a variable
> > 
> > drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > 
> >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > Patch 3/3: staging: rtl8723bs: include: Fix misspelled words in
> > comments
> > 
> > .../rtl8723bs/include/Hal8192CPhyReg.h        |  8 ++---
> > 
> >  .../staging/rtl8723bs/include/basic_types.h   |  2 +-
> >  drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
> >  drivers/staging/rtl8723bs/include/hal_com.h   |  2 +-
> >  .../staging/rtl8723bs/include/hal_com_reg.h   | 34 +++++++++----------
> >  drivers/staging/rtl8723bs/include/hal_data.h  |  2 +-
> >  .../staging/rtl8723bs/include/hal_pwr_seq.h   |  2 +-
> >  drivers/staging/rtl8723bs/include/rtw_cmd.h   |  6 ++--
> >  drivers/staging/rtl8723bs/include/rtw_mlme.h  | 18 +++++-----
> >  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 +-
> >  drivers/staging/rtl8723bs/include/rtw_mp.h    |  2 +-
> >  .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  2 +-
> >  drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 +--
> >  drivers/staging/rtl8723bs/include/rtw_xmit.h  |  2 +-
> >  drivers/staging/rtl8723bs/include/sta_info.h  |  2 +-
> >  drivers/staging/rtl8723bs/include/wifi.h      |  2 +-
> >  16 files changed, 46 insertions(+), 46 deletions(-)
> > 
> > Fabio M. De Francesco
> 
> I have no idea how you created this patch series, but I do not think it
> worked well :(
> 
> Please use our standard tools, that do this all for you automatically,
>
Apart from the fact that I forgot to save the subject, I didn't know that 
there are standard tools for doing Patch 0/N. Therefore I thought to make  
an email message that contained the information about the patch series.

I was wrong, sorry. I have to research this topic in the git manual or 
somewhere else.

Thanks,

Fabio
>
> and send them out in a series of emails that have a proper subject line
> (look at what you used here...) and are properly "threaded".
> 
> thanks,
> 
> greg k-h




