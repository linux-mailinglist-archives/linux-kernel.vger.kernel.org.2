Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754C43FA5B3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhH1Mq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhH1Mqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:46:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5BC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 05:46:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s29so3375430pfw.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCHVrZHXKCU1H+5v0eNhhS2fzXulwWS9z4uFv6L4bSA=;
        b=hO1VRgqe5cZTyYKXcExM01SXO5zG0rpjx9TSpTOvov/BIu3ukaZIdqLjXdrYnZRJ2S
         1v/hWlUKtJQMUrMEkXz0daKx780PS7csu0/NMId//y9fPFhewtVygoDCt80W8tW3+BFX
         kGpsDd9ESSuVxeB1O+S2FqFeEVmYhPBRWvh7JZFMkuwimuPT2lOzjhAqchyQy80Wr/K/
         t5ot4RoQOukw/CqIw7XYk3AEuDXN0vkviHHF8O0ldNi7xMhXNbAzQXw/mZKpLcTpXQk3
         zseCdMqzmA2ClXhms7XJRoH+W8ctXsgwZFlrKproxuRMTsvDeC6qLN8AXLC6bis0Aaj8
         cC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCHVrZHXKCU1H+5v0eNhhS2fzXulwWS9z4uFv6L4bSA=;
        b=SM7tpFdL/kBSCOnZwMwuoooS+xrlbGGpjs04BPaIFOFCvBKBngi38oUvLhvS4bZnkq
         i7pbpmWJsdkkU4OEJ09DKxia2j8bwlgtqOkaOTba5SQ9vmr58AeCZ1AtNajpdnpIOWH7
         Cn5tZfQzJX17+r4AQ2olTd5EJyQTS+ojGBs94JyeHHQ11D4U52ZsHyPe9z177Ipp3rlX
         BhItOj/0vDSutOoqi3M2Ih5cdP+NxF19HAspSpFNE7ofIeTgx6oz5VvxxQa2aEOHH0AU
         tu5jjWwWmyndZteziSba6ScHAXuImIlGKG+Kj0U6nA6KWgMT6+jaowvlq6kgcRBE95LY
         DkOg==
X-Gm-Message-State: AOAM5309zXa72RiCAf+n3+qjDM/NWmO1jWp7Rq0OdO4Jus+19bQxFvE5
        DXSdZL2qurjZqTuIFZv7JhY=
X-Google-Smtp-Source: ABdhPJzJ6p62Y2+g2YvTwf/XpUpKNoL3y/nawrlNwL58JaYJtFtCych5NSQBvZA/vEfazQ7HjpO9pQ==
X-Received: by 2002:aa7:8c41:0:b0:3e3:1279:105 with SMTP id e1-20020aa78c41000000b003e312790105mr13924020pfd.80.1630154764625;
        Sat, 28 Aug 2021 05:46:04 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id u17sm9257665pfh.184.2021.08.28.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 05:46:04 -0700 (PDT)
Date:   Sat, 28 Aug 2021 18:15:59 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu :os_dep: remove condition with no effect
Message-ID: <YSowB14taJnsZfRM@user>
References: <YSoCfTaR66C6iJFw@user>
 <bc0c9cd1-d915-2cb0-ef57-3b9dc5410bbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0c9cd1-d915-2cb0-ef57-3b9dc5410bbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2021 12:19, Michael Straube wrote:
> On 8/28/21 11:31, Saurav Girepunje wrote:
> > Remove the condition with no effect (if == else) in usb_intf.c
> > file.
> >
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> >   drivers/staging/r8188eu/os_dep/usb_intf.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > index bb85ab77fd26..849563b54727 100644
> > --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> > +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > @@ -496,10 +496,8 @@ static int rtw_resume(struct usb_interface *pusb_intf)
> >   	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
> >   	int ret = 0;
> >
> > -	if (pwrpriv->bInternalAutoSuspend)
> > -		ret = -	else
> > -		ret = rtw_resume_process(padapter);
> > +	ret = rtw_resume_process(padapter);
> > +
> >   	return ret;
> >   }
>
> Thanks for your patch. Perhaps this could be further simplified to:
>
> int ret = rtw_resume_process(padapter);
>
> return ret;
>
> or even:
>
> return rtw_resume_process(padapter);
>
> Best regards,
> Michael


Yes, Thanks Michael. I will make it more simple and send v2.


Regards,
Saurav
