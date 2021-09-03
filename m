Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB66740044C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhICRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349916AbhICRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:49:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2CC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 10:48:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso62813pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2RwvGxxkwgPp1kC7OUNpSHVKhmd69dXp1tT7aj4N4gg=;
        b=FUaUag50ob2Eqb3yiH+FdjIbjocFosp5iaSENleFndT7apgR77KU3A5ioFl1HKxOZq
         YKREVYFNT5Z+uQdr1cgUgo1uIneWdyQeQ97SzWdiy8N2t5ZBPf8T1SrEahe/5MvE4uFm
         m2/bcenZ7FMb8p+865QmY2ETiregCBuNR3diuL0qKpuxl4/gu6+vhLDvWmTkk+0JNtJQ
         IkibDjcOeHP8vJoB79rCSfPMT0jIO6SD/LcxGZx6Qb51dygHTo6V13QFodvOtc2a4zaB
         0JHveZ6MJQCc583r7YLuZcIFNdRdRD44myJjng0ygqHIWFpK7NuE+UPejRljJ+XC+3Us
         5raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2RwvGxxkwgPp1kC7OUNpSHVKhmd69dXp1tT7aj4N4gg=;
        b=hrm1GGdRMBX//GPUuryaGcxwGrGSi8RDq5O3bb4eJZmB7O2NRhxYiCGFnciVW2uH0w
         /wH/DfmsWmZ1WuDk1ELITNlfhSLu6E+K4TwYgwuzZOK70kB7nhRw9T7GLx86QKk3D9aC
         /Y3I6Y96nPSqdLzi+OourfvHfbaOZXSqRYQvnPWs9syNHHE2YlNM4aFBEhQ5y31TetrJ
         12d/rIcm5Yr5OgCGxg4iDQv5Gs2yWD5AFwUMyoC/Rebhdca9rFMoY//JjOUOHwsdzSjD
         AWBtwbViylv5A+MMZE5VvWVmwursd9WckK6ot2WS8KjmP16Y/EYIUX4TENZqhPjjpnyl
         UCCw==
X-Gm-Message-State: AOAM530hXgWNY4+6FKHSYcpjb6cOv9h/COfQnRXgqJh7u+PduNeOF4Al
        m5OED/bmJu+OD9gKpfS6kAU=
X-Google-Smtp-Source: ABdhPJydzohBvdITs+K1x4HKM7Kxmexw20vOxzGAKL4JzKbqnWDK5Er0TA1+iGiOyGWrEIN7un9/yw==
X-Received: by 2002:a17:90a:8c8b:: with SMTP id b11mr90687pjo.14.1630691324349;
        Fri, 03 Sep 2021 10:48:44 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id i5sm5746049pjk.47.2021.09.03.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:48:43 -0700 (PDT)
Date:   Fri, 3 Sep 2021 23:18:38 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: os_dep: use kmemdup instead of kzalloc
 and memcpy
Message-ID: <YTJf9odBRwxHZTs8@user>
References: <YSp9z2/JmvHGhW5m@user>
 <YTCXef5o9JHtQhuD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTCXef5o9JHtQhuD@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Sep 2021 11:20, Greg KH wrote:
> On Sat, Aug 28, 2021 at 11:47:51PM +0530, Saurav Girepunje wrote:
> > Fixes coccicheck warning:WARNING opportunity for kmemdup in ioctl_linux.c
> >
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > index 81d4255d1785..495fadd2b8c8 100644
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -585,14 +585,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
> >  	}
> >
> >  	if (ielen) {
> > -		buf = kzalloc(ielen, GFP_KERNEL);
> > +		buf = kmemdup(pie, ielen, GFP_KERNEL);
> >  		if (!buf) {
> >  			ret =  -ENOMEM;
> >  			goto exit;
> >  		}
> >
> > -		memcpy(buf, pie, ielen);
> > -
> >  		/* dump */
> >  		{
> >  			int i;
> > --
> > 2.32.0
> >
> >
>
> This patch never showed up on lore.kernel.org for some reason.  Please
> resend and see if it was a mailing issue on your side...
>
> thanks,
>
> greg k-h


Ok, I will resend this patch.

Thanks,
Saurav Girepunje
