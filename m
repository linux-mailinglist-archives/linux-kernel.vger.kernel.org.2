Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3B35A46B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhDIROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:14:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E21C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:14:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so9819963ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+KsrNGMheQyZi6tgUyj6QXCX6Kc00oXKAtfc1s77Sw=;
        b=sZYo2nvCM4l6vMu3KfhEwMtWHpcMwuW5poG9qPZXIF8hkF5nQHvd4rkz1M+zDN5UJ1
         LPrQWgwKrZ10cd8jr7TgD6B0foDoB+RqcrdFMXEdaH2dupWyUbAoNlLgyI2nwxHuVTSN
         /2EwZj8DpaBBz/9RWWW8C7iQ4AKoXByFXlTKAvwiWoQqAIUkvR3/AEttkTVsQ1F8qi9d
         /A+5nwNZHEO7atzA7NNfY9eWYuqTDdEISW1Y9fhU9dMwRn8YivdgmCDf3F/bVbRxwfnj
         qv3FKpAI1wkzq5au8CFMJpm43Ju7nz8rGRKZGjOgShKBTbLfqRsqwBnv5BvYCxeP48Hv
         UuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+KsrNGMheQyZi6tgUyj6QXCX6Kc00oXKAtfc1s77Sw=;
        b=RQr/VUfe0yWLa0oGnWW2luVF2+2EZ/gWfcq8Uqpw1+UxVALiSo3yz7Vy5CbCgJ6qJE
         oNKy+9UfKFDXu6vuqkyHrrILJkfooFCxk1kWQd3jxkw6NoDdIK24X/KVUBVz8KQLqYIq
         KYd3cJGOpRaipc/a+nigZBDTL64V/uTJkqBV8Mf4+5yHXPoONYtgm6p4m4CzyxC90Keu
         KTxa/87rO2g00Wkt7C567nSrstZbFTWAZ5LNH/ae6PpGSjO1Vvfr7q2qxV9f9UPWPm+y
         qJ3MnPu7UrqGd9nb5Jbwk4VIWmA74z/hSlzrwFgrd2rhYM01bwseusATGCzMATiSRemS
         Hc3w==
X-Gm-Message-State: AOAM532qMdEmOok1b43cBRp3YdG56BQkxpmXgA92uxG2dpxb78WD1OWz
        BPPa28CAlDeiGSTBMA1+Ujw=
X-Google-Smtp-Source: ABdhPJzbeU2BPiQjV4xbjv2bNbjvRmMmf9xCB+mMv1+4RHhWLc7aosOiI5xpIxtJA83tyYNYINCigg==
X-Received: by 2002:a17:906:4f15:: with SMTP id t21mr6385260eju.338.1617988441921;
        Fri, 09 Apr 2021 10:14:01 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id m29sm1512592ejl.61.2021.04.09.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 10:14:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Change the type and use of a variable
Date:   Fri, 09 Apr 2021 19:14:00 +0200
Message-ID: <2106328.ujm4fZfeqs@localhost.localdomain>
In-Reply-To: <YHBg1Sy2509vBtrA@kroah.com>
References: <20210408111942.19411-1-fmdefrancesco@gmail.com> <YHBg1Sy2509vBtrA@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 9, 2021 4:12:37 PM CEST Greg KH wrote:
> On Thu, Apr 08, 2021 at 01:19:42PM +0200, Fabio M. De Francesco wrote:
> > Change the type of fw_current_in_ps_mode from u8 to bool, because
> > it is used everywhere as a bool and, accordingly, it should be
> > declared as a bool. Shorten the controlling
> > expression of an 'if' statement.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> I now have 3 patches, I think, for this same driver, from you, and I
> have no idea what order they should be applied in.
> 
> So I'm going to drop them all.  Can you please resend me a patch series,
> with all of the outstanding patches sent to me from you that I have not
> applied yet, so that I know which ones to look at and what order to
> apply them in?
>
I just sent in the series of patches you requested. Hope the work is as you 
expected. 

Thanks,

Fabio
> 
> thanks,
> 
> greg k-h




