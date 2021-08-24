Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509AE3F5955
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhHXHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhHXHre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:47:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:46:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h9so42427069ejs.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VsqAfZyJN9OD0IHKahj/HoL7bz40akh7jyRwrbfEuro=;
        b=sYIl27axHaB+KXgccTTOy8Qba71m+Sa9jlXykBz++PO0nNjkG8wWEE3xuRhGlQrvt9
         a+ohGsHPJr6zRAsi3BIRyW3sUNSkgh8NhllNXtp3JyY6G4Zz3EO1ZhMnfZr/sUcivssh
         AXwbez1OHsikoUQSjOUhUcCPswF0hx6/JbsMLdkGbX+AKVcF9wIESmhc3hBQainRQmKa
         N+lwjoY8v1wdFBfvv0xjQdl6wphqmczUqkyoCN4dkZmJVrWLRsJ8m4D5zR+0SaBP+90A
         BukrkrvJe2xJK2Tp6XRcZkQ1KLy6ntQ2txeIjB3v/MRkaFRlWLLN4vKiT7Ov9DapqY+i
         3RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VsqAfZyJN9OD0IHKahj/HoL7bz40akh7jyRwrbfEuro=;
        b=WTyRvQ12TfyKYCOXhjZEHSKlQVbGcD7xnxn+YEJ5dWA6TeJOF0NXlfruZmKXkVEq4z
         66EY1DAdXtF1Z9ImHuWZBQdmtIoGeGPnFA+u+lCG/ULfqfoGx/wS8J6YNgG2YwMJ4xX7
         lroemUu6g26070I8ZR6ofWVsjIizbBhmLOZRWBXx2tlohq3xcgFEgrtwtab6BJupvCOp
         8/uN/Gpmc5dLU99A4Z1uhkGN6ZD70PFyQvIfkzUQ7XvzDJrMJKEwG0DFf5YSCixGJy3y
         x1hxCqB2d4d+i1hkiyuWK9YHU9qgQyhgEMSojspbYtUk0aWlmcbpHT5ArXXNUUQc8c47
         Hvtw==
X-Gm-Message-State: AOAM533pKsGSbpQSk3o6++eKgmkg3gOqlMpuJc3L/g3++pvFrxs48PXo
        i0WRZRi4xUmCaD63lN/mJYQ=
X-Google-Smtp-Source: ABdhPJxythtgfsRHsaQp3r6YiC/KoRrK4F8Sl2mh9Coz7edIEsHiRlIpTEGQe2OGXQoFhIDTZMERVQ==
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr38802644ejb.108.1629791208425;
        Tue, 24 Aug 2021 00:46:48 -0700 (PDT)
Received: from agape.jhs ([5.171.73.5])
        by smtp.gmail.com with ESMTPSA id s2sm1524732ejx.23.2021.08.24.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:46:48 -0700 (PDT)
Date:   Tue, 24 Aug 2021 09:46:44 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     iLifetruth <yixiaonn@gmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, Qiang Liu <cyruscyliu@gmail.com>,
        yajin@vm-kernel.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, Martin Kaiser <martin@kaiser.cx>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        paskripkin@gmail.com
Subject: Re: staging: possible buffer overflow in rtw_wx_set_scan function in
 driver/staging/rtl8723bs
Message-ID: <20210824074643.GA1731@agape.jhs>
References: <CABv53a_q4jzsXib7ovRs=eOwqcQ-oKb8c7DA7uUSPf+0tt6aog@mail.gmail.com>
 <20210823170624.GA1420@agape.jhs>
 <CABv53a9aR8mXE_quxRX06aX3WAKGSOyMqrG8AmqrsvftjH7xyg@mail.gmail.com>
 <CABv53a_9GstHzLbbbghFxU_YDxC0ckh3+bGu4RqAmGL39BHMMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABv53a_9GstHzLbbbghFxU_YDxC0ckh3+bGu4RqAmGL39BHMMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[sorry for resend, I updated the CC field]

On Tue, Aug 24, 2021 at 03:04:04PM +0800, iLifetruth wrote:
> Here are the fixes and the contents of the patch file we suggest.
> 
> [PATCH]staging: rtl8723bs: prevent ->ssid overflow in rtw_wx_set_scan()
> 
> This fixing patch is ported from the upstream commit
> 74b6b20df8cf(staging: rtl8188eu: prevent ->ssid overflow in
> rtw_wx_set_scan()) which fixes on another driver numbered rtl8188eu.
> This code has a check to prevent read overflow but it needs another
> check to prevent writing beyond the end of the ->ssid[] array in
> driver rtl8723bs.
> 
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index f95000df8942..3b859b71bf43 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -1222,9 +1222,9 @@ static int rtw_wx_set_scan(struct net_device
> *dev, struct iw_request_info *a,
> 
>                                 sec_len = *(pos++); len -= 1;
> 
> -                               if (sec_len > 0 && sec_len <= len) {
> +                               if (sec_len > 0 && sec_len <= len &&
> sec_len<= 32) {
>                                         ssid[ssid_index].SsidLength = sec_len;
> -                                       memcpy(ssid[ssid_index].Ssid,
> pos, ssid[ssid_index].SsidLength);
> +                                       memcpy(ssid[ssid_index].Ssid,
> pos, sec_len);
>                                         ssid_index++;
>                                 }
> 
> --
> 
> Thanks for your confirmation,
> - iLifetruth
> 

the patch looks fine. Just some points:

- If the patch related to wext support removal will
  be accepted, the patch isn't necessary. So I will wait
  until I know the community-maintainer decision.


> 
> On Tue, Aug 24, 2021 at 10:07 AM iLifetruth <yixiaonn@gmail.com> wrote:
> >
> > I haven't committed the patch yet since the Linux staging tree may
> > seem special. It's not clear to me where to submit the patch. So could
> > you please fix it?
> >
> > Regards and thanks for your confirmation,
> > - iLifetruth
> >
> >
> > On Tue, Aug 24, 2021 at 1:08 AM Fabio Aiuto <fabioaiuto83@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > On Mon, Aug 23, 2021 at 11:19:09PM +0800, iLifetruth wrote:
> > > > Hi, in the latest version of Linux staging tree, we may have found an
> > > > unfixed security bug in the staging/driver/rtl8723bs related to the
> > > > CVE-2021-28660. Now, we would like to contact you to confirm this
> > > > problem.
> > > >
> > > > ===========
> > > > Here is the description of CVE-2021-28660:
> > > >
> > > > "It was discovered that the rtl8188eu WiFi driver did not correctly
> > > > limit the length of SSIDs copied into scan results. An attacker within
> > > > WiFi range could use this to cause a denial of service (crash or
> > > > memory corruption) or possibly to execute code on a vulnerable
> > > > system."
> > > >
> > > > ===========
> > > > The staging driver "rtl8188eu" was fixed by commit
> > > > 74b6b20df8cfe90ada777d621b54c32e69e27cd7 on 2021-03-10.

- The driver rtl8188eu is deprecated. Now exists r8188eu which has
  the same security bug, so it needs to be fixed. Again feel free
  to submit your own patch.

- If you decide to submit your own patch I suggest to put
  your full name in the email address as you submitted a legal
  document.
  
  vim 409+ Documentation/process/submitting-patches.rst

> > > >
> > > > However, in another similar staging driver numbered "rtl8723bs", a
> > > > function named “rtw_wx_set_scan” remains the same problem unfixed. And
> > > > it is detected in the
> > > > “drivers/staging/rtl8723bs/os_dep/ioctl_linux.c#Line1354" without
> > > > checking to prevent writing beyond the end of the ->ssid[] array.
> > > >
> > > > Therefore, shall we port the same fix from RTL8188EU to RTL8723BS?
> > >
> > > I think it's a good idea, moreover I've just sent a patch series
> > > aimed at removing that piece of code for it belongs to very
> > > old wext implementation.
> > >
> > > But until it's not accepted by the maintainer that security bug
> > > is present and harmful. If you fix it thank you, if you don't
> > > thank you for reporting this, I will fix as soon as possible.
> > >
> > > >
> > > > Thank you!
> > >
> > > thank you,
> > >
> > > fabio

thank you for your report,

fabio
