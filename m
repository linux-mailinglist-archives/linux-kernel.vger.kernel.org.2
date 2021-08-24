Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517C03F5936
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhHXHmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhHXHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:41:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:41:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n11so1012714edv.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AVUOj85ab2rxVkbkIuTaVVXX8dgBhUK5deI1aUHWkqA=;
        b=rIFGbHbPK7UVyf5aVOa6PG7KQ9uZEmG7QJ2aJg0IZlLsfU9eL1fPkhvhrYWufhTE+0
         Zo6c4izNu8/ow1ODPtWph7/jvD0lSA3IhezH8j48A6xqzhz7LxwPetmOd7pNBeJ71g8D
         f8d47e2p64Xrx3zdFe0WtjKQvyWrpseBhw9gXqNpe26RLKDUIpAqeOqrXKzmakSAmOz+
         OJVomBT2iLwdqSRKCfMQ2cpIIUQdgBJOYSZSvrdLC4K0yNvM18B6rM/GZEdQTFJW0vw1
         adG1ObUI2NsMoZXtSESH0viE4d7XSuyw77eqpkXHmr5valVHetFHLCEsuNVVag0Bj2gf
         3iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AVUOj85ab2rxVkbkIuTaVVXX8dgBhUK5deI1aUHWkqA=;
        b=hoDiMJROEW6Ct8H1HczkIm1LLaNkVz4B6MzZmRKkdeq43nnaWUpRQ7DcT/MTmyc4Ou
         XLqiN/Lut9BKVz5hCes+uJx5N5SVXXnZbcgx4f7AsxL7LBg9FEdlc8zM5McFwD/MDNY2
         l16YYrI8hfF1g3Tf3Oxhg6C7JsrlBGAQEhhuTQDuj6/AA1P7XvX2TlBYiZ/5CvsWpwS8
         732qIQAMQjJxmeOf0potCCOwETKcHMRiEAcr+s4mrhaw21MfBRDH9iS2bv/VM/585Kes
         KJjRyk/c81Z4iqJc0E8cQfavweHp4mAOkxzaHynB2r0tKbVxkB+n9eILwm2xil4a6ta8
         4m+Q==
X-Gm-Message-State: AOAM5329mjAeWs8O58icq1NLYViVDgnHEXFMoqmR1BtaegvkaH2YzJng
        NIisa4++J8/x/wDkKQyyaXo=
X-Google-Smtp-Source: ABdhPJw+FDd41GjD4CqbgT6UuoSfFuhUKJ3bgCb+Du49pmXt773RKp3TRphmQSevyXyxMrrR9aU0HQ==
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr6569520edc.21.1629790860359;
        Tue, 24 Aug 2021 00:41:00 -0700 (PDT)
Received: from agape.jhs ([5.171.73.5])
        by smtp.gmail.com with ESMTPSA id ay20sm10982069edb.91.2021.08.24.00.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:41:00 -0700 (PDT)
Date:   Tue, 24 Aug 2021 09:40:56 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     iLifetruth <yixiaonn@gmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, Qiang Liu <cyruscyliu@gmail.com>,
        yajin@vm-kernel.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, Martin Kaiser <martin@kaiser.cx>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        fmdefrancesco@gmail.com
Subject: Re: staging: possible buffer overflow in rtw_wx_set_scan function in
 driver/staging/rtl8723bs
Message-ID: <20210824074055.GA1421@agape.jhs>
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
