Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483FD3F55A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhHXCIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:08:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273CC061575;
        Mon, 23 Aug 2021 19:07:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e21so25073873ejz.12;
        Mon, 23 Aug 2021 19:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hQf5FJwAquDrQzpM6Ew8XOzGWvvn5Sn7hw5RC22dqYk=;
        b=dnttTSHKVZA/IaRhO2YBn0LLiyhEUOYoKcGxouyQP9am0PoMZyRXiesSbrJCCFn+EB
         NW49Dyi3dSvqXMX+6wL/KKVWXnrGd374XVPCoYKEOxnFnSitAsHEwNiVKtIU+TimU0CE
         VzU4LlHgs3qlw+7z54dkbqTk0rtYAoRy+jYcetlAkTuff9ao4Jy56jM/A6mBO/rn55Sf
         roEorV1T5OOIlzhrbge+SOyKQ/5FvHSsHhStlWCkyzrEqIbjM6+NQdgLB4hrLcASKfrm
         R/8mpc0D2F+OrFzN/j6GVmq7KMG09NQlMyYXl/Tyaigp1jmk7hBYyLrUyl0Yc9SscsGP
         0wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hQf5FJwAquDrQzpM6Ew8XOzGWvvn5Sn7hw5RC22dqYk=;
        b=GWkdrGgqALS13znuJ95Zsejg5ak6Q0H3otOIW0JQG5kM1hwrbsqusCdMiwrcEPB25s
         megre459dj8dJgbfFixUnbwQ0wFJnrybsvejKIyEWzdpKjxrepSK0fDBVxqgu8QwjzNG
         /TFUPaD0T132a4lUVJQGpaNiA7dsO8IbkA46oNWCTBduCc5vZ7N+/iMNiN2uQm87jKUV
         pkrUFjF7E0KQh5ueboaJpnufsbTjxWZcYg3j8tETO69u4+tyB+Gyy/ilbmV6hKc+5RrT
         VZPNgX+TBlqBVrVMGo5s1fs/D1R/S9ELfxlKwbhWS1/l8cz7BMUidvf1vFZNy+u7lme0
         PdIw==
X-Gm-Message-State: AOAM531S/PlHJd/J6u6qgwbnpxa9jhyzd8LsD9PfyZGty6+fmTAQCUk2
        Aqh5Iv2+/oL5lrbjJUBduBzn+vdiWoueVpfZGQ4=
X-Google-Smtp-Source: ABdhPJxxAwCa1ZFrfCTVfktnUsk6PXTaQrkyBxs6Wcz5sPdNjPE7Uz0YO6kTBTHr0Bjz8eSRH0J/8q3CzTi0mf7QJXg=
X-Received: by 2002:a17:907:a06c:: with SMTP id ia12mr38214669ejc.377.1629770875535;
 Mon, 23 Aug 2021 19:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABv53a_q4jzsXib7ovRs=eOwqcQ-oKb8c7DA7uUSPf+0tt6aog@mail.gmail.com>
 <20210823170624.GA1420@agape.jhs>
In-Reply-To: <20210823170624.GA1420@agape.jhs>
From:   iLifetruth <yixiaonn@gmail.com>
Date:   Tue, 24 Aug 2021 10:07:18 +0800
Message-ID: <CABv53a9aR8mXE_quxRX06aX3WAKGSOyMqrG8AmqrsvftjH7xyg@mail.gmail.com>
Subject: Re: staging: possible buffer overflow in rtw_wx_set_scan function in driver/staging/rtl8723bs
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Liu <cyruscyliu@gmail.com>, yajin@vm-kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't committed the patch yet since the Linux staging tree may
seem special. It's not clear to me where to submit the patch. So could
you please fix it?

Regards and thanks for your confirmation,
- iLifetruth


On Tue, Aug 24, 2021 at 1:08 AM Fabio Aiuto <fabioaiuto83@gmail.com> wrote:
>
> Hello,
>
> On Mon, Aug 23, 2021 at 11:19:09PM +0800, iLifetruth wrote:
> > Hi, in the latest version of Linux staging tree, we may have found an
> > unfixed security bug in the staging/driver/rtl8723bs related to the
> > CVE-2021-28660. Now, we would like to contact you to confirm this
> > problem.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Here is the description of CVE-2021-28660:
> >
> > "It was discovered that the rtl8188eu WiFi driver did not correctly
> > limit the length of SSIDs copied into scan results. An attacker within
> > WiFi range could use this to cause a denial of service (crash or
> > memory corruption) or possibly to execute code on a vulnerable
> > system."
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The staging driver "rtl8188eu" was fixed by commit
> > 74b6b20df8cfe90ada777d621b54c32e69e27cd7 on 2021-03-10.
> >
> > However, in another similar staging driver numbered "rtl8723bs", a
> > function named =E2=80=9Crtw_wx_set_scan=E2=80=9D remains the same probl=
em unfixed. And
> > it is detected in the
> > =E2=80=9Cdrivers/staging/rtl8723bs/os_dep/ioctl_linux.c#Line1354" witho=
ut
> > checking to prevent writing beyond the end of the ->ssid[] array.
> >
> > Therefore, shall we port the same fix from RTL8188EU to RTL8723BS?
>
> I think it's a good idea, moreover I've just sent a patch series
> aimed at removing that piece of code for it belongs to very
> old wext implementation.
>
> But until it's not accepted by the maintainer that security bug
> is present and harmful. If you fix it thank you, if you don't
> thank you for reporting this, I will fix as soon as possible.
>
> >
> > Thank you!
>
> thank you,
>
> fabio
