Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7E3F58AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhHXHFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhHXHF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:05:26 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B770C061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:04:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r19so30003078eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HvpDCJAsK6Y7M7I9F/1jNVCivdBEhOxs6abv+o4YhiM=;
        b=aIyk5k2M/YH+WvZbZetOjCX8JxhP18dSSl2F4CEEIpazIMg1Nbar9FOl9lfb6eZQ47
         afSDgyo0RTShxC2sBF0bNHBt6ivSIvisQoYK8ZV7YgOILhpF7u5L515Cg2gQkkuQMIXq
         fUiDmOufx0WKQyyW2BmBMl0rtOUdJW7/5NUnOGM8gOzrMZTq+BO/i4wJtspMqMqLtzu6
         sIlpIg0HvuaErWJzq88X8/zGRJ8WWgBwB/5ewbzfOar67H69E3rwqfJQll2+rasozIkR
         xBxyyoXMXDfIn6kBL+u/nYKGEVCvZDHtMzNd9dQbH1QIw8CdWLa/onrlbUyl3W5FkS4W
         gTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HvpDCJAsK6Y7M7I9F/1jNVCivdBEhOxs6abv+o4YhiM=;
        b=Btu2bqTyLXGSweg0UE7XE+or2jUsuPnyrM/Kbx1v4CKnrZW9VlvEzwAu7qMN4yfl0x
         fkJQi5gXH3c6T807FE+5IqvHktTzpZGWSKHmXyKnUAXPsirYeMQ1uAoMt2u42GZtrY77
         +Mw5xin3hi4n+/gCVRfonAOQduANNGHTtfCpOBZw4/KX0hCtUTwgasfPZBZRsTA1uMXC
         GgJvbQtkokQHuJ7PFZtzk+tz7ZvEm5ga9FKby21iW1IyWNWvi9U05nhBVf/Kyy3V0Jwr
         QmQhKI3ENpoSc14DhBpOh06yYzb4y85zNMLfIvbP7tbEMyeQvOMNfGkuABR72oAv6x3s
         xA7A==
X-Gm-Message-State: AOAM532FY2M5Wx6jNqEpJVcr/ACjeimIcxvp8Aq7CrAbrVqODVt9ku9F
        ygzZ6bQswW6+uJSQKp8R3E9MSJJ3DyFLuxuPnLc=
X-Google-Smtp-Source: ABdhPJzXLuI+jnG+wELMgX23SCag/qn4RdIJOknIbqu6fHs9EEqVve7EYZMTx6Yoq5gtA9pbB2oFwM4cQp+lpySMxXo=
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr41688935edv.306.1629788680772;
 Tue, 24 Aug 2021 00:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABv53a_q4jzsXib7ovRs=eOwqcQ-oKb8c7DA7uUSPf+0tt6aog@mail.gmail.com>
 <20210823170624.GA1420@agape.jhs> <CABv53a9aR8mXE_quxRX06aX3WAKGSOyMqrG8AmqrsvftjH7xyg@mail.gmail.com>
In-Reply-To: <CABv53a9aR8mXE_quxRX06aX3WAKGSOyMqrG8AmqrsvftjH7xyg@mail.gmail.com>
From:   iLifetruth <yixiaonn@gmail.com>
Date:   Tue, 24 Aug 2021 15:04:04 +0800
Message-ID: <CABv53a_9GstHzLbbbghFxU_YDxC0ckh3+bGu4RqAmGL39BHMMg@mail.gmail.com>
Subject: Re: staging: possible buffer overflow in rtw_wx_set_scan function in driver/staging/rtl8723bs
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, Qiang Liu <cyruscyliu@gmail.com>,
        yajin@vm-kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the fixes and the contents of the patch file we suggest.

[PATCH]staging: rtl8723bs: prevent ->ssid overflow in rtw_wx_set_scan()

This fixing patch is ported from the upstream commit
74b6b20df8cf(staging: rtl8188eu: prevent ->ssid overflow in
rtw_wx_set_scan()) which fixes on another driver numbered rtl8188eu.
This code has a check to prevent read overflow but it needs another
check to prevent writing beyond the end of the ->ssid[] array in
driver rtl8723bs.

---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index f95000df8942..3b859b71bf43 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1222,9 +1222,9 @@ static int rtw_wx_set_scan(struct net_device
*dev, struct iw_request_info *a,

                                sec_len =3D *(pos++); len -=3D 1;

-                               if (sec_len > 0 && sec_len <=3D len) {
+                               if (sec_len > 0 && sec_len <=3D len &&
sec_len<=3D 32) {
                                        ssid[ssid_index].SsidLength =3D sec=
_len;
-                                       memcpy(ssid[ssid_index].Ssid,
pos, ssid[ssid_index].SsidLength);
+                                       memcpy(ssid[ssid_index].Ssid,
pos, sec_len);
                                        ssid_index++;
                                }

--

Thanks for your confirmation,
- iLifetruth


On Tue, Aug 24, 2021 at 10:07 AM iLifetruth <yixiaonn@gmail.com> wrote:
>
> I haven't committed the patch yet since the Linux staging tree may
> seem special. It's not clear to me where to submit the patch. So could
> you please fix it?
>
> Regards and thanks for your confirmation,
> - iLifetruth
>
>
> On Tue, Aug 24, 2021 at 1:08 AM Fabio Aiuto <fabioaiuto83@gmail.com> wrot=
e:
> >
> > Hello,
> >
> > On Mon, Aug 23, 2021 at 11:19:09PM +0800, iLifetruth wrote:
> > > Hi, in the latest version of Linux staging tree, we may have found an
> > > unfixed security bug in the staging/driver/rtl8723bs related to the
> > > CVE-2021-28660. Now, we would like to contact you to confirm this
> > > problem.
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Here is the description of CVE-2021-28660:
> > >
> > > "It was discovered that the rtl8188eu WiFi driver did not correctly
> > > limit the length of SSIDs copied into scan results. An attacker withi=
n
> > > WiFi range could use this to cause a denial of service (crash or
> > > memory corruption) or possibly to execute code on a vulnerable
> > > system."
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > The staging driver "rtl8188eu" was fixed by commit
> > > 74b6b20df8cfe90ada777d621b54c32e69e27cd7 on 2021-03-10.
> > >
> > > However, in another similar staging driver numbered "rtl8723bs", a
> > > function named =E2=80=9Crtw_wx_set_scan=E2=80=9D remains the same pro=
blem unfixed. And
> > > it is detected in the
> > > =E2=80=9Cdrivers/staging/rtl8723bs/os_dep/ioctl_linux.c#Line1354" wit=
hout
> > > checking to prevent writing beyond the end of the ->ssid[] array.
> > >
> > > Therefore, shall we port the same fix from RTL8188EU to RTL8723BS?
> >
> > I think it's a good idea, moreover I've just sent a patch series
> > aimed at removing that piece of code for it belongs to very
> > old wext implementation.
> >
> > But until it's not accepted by the maintainer that security bug
> > is present and harmful. If you fix it thank you, if you don't
> > thank you for reporting this, I will fix as soon as possible.
> >
> > >
> > > Thank you!
> >
> > thank you,
> >
> > fabio
