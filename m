Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DAA3F08C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhHRQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHRQOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:14:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6312C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:13:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b200so3508888iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ucSXPveGZfGZujRFzGNWdZuGQzT8wdbpdWwozLwL7y4=;
        b=CNIuGp3+mMZmcPeBKYjYA/B3uSrpZlmWUBctSheQHbSUwNM+DkUx+PwRX17DSL73vY
         XUwARE/vMF4BP8U2DD68FxdBcG26qzurbm6SUsgnRRV758mDFISoh/d9FobIeSGHxA0s
         nzOt/jC4jAdlKXckfsUaSVUNO9QIADfeCnF1Azlc4qrpXw/6YuKOTrDX0Nzrruey+YxC
         HRX6zixnfuhbm4B4A139UIerHbTu4lnVCIPN36CfZse0N+LX2y8yHJ87Rt2meNeDY/K9
         92dsPk3SK4OpfF6mj3WWA3FN0IQ4wZ2x8e6tuoHttdRxP0YGgNS2shEcMbBFxPaAapJe
         Yf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ucSXPveGZfGZujRFzGNWdZuGQzT8wdbpdWwozLwL7y4=;
        b=hL6YSfpnRE6jXW6LawbHz1so0eSBi27O+qyef0vbx6NKqRzTEJfyUzZ4kb5yAwuADp
         cEiJfH8/hgLkCLkR1q+orwpwAaNf2SijJZdt+WebfAGzR3bxdVmvD1HVqhJLA8jFMku+
         MZsvBGiDdSm+ct7pRAOU7HRJ3c7eKv7tWVvnDSwFQMpdXhJYjV5wBIk/138yDX+gEBD9
         QQ5JjMsej6kKu2H9Ubzr8UTH+xxqSNprAnmIwAJMxO9QHHQ49kLMBJsJ4aZDiSzHPiZ7
         OiKM7V9C+uzQCgQhuyq9YhTfiIVsjuoCICVNmhK6ZpD3H7fZGQQrQxR/WEIKkUBqrcx2
         zh4w==
X-Gm-Message-State: AOAM530iM1V8fj11J8vcrCVlqd+IWrfuR9kRadvBmF5mpOeWGO9djXii
        74sKEuhV9sv0SLVtO0zC5/PVS3R6/33tWB6Lk/YQYQ==
X-Google-Smtp-Source: ABdhPJwdGarHa20VspdIgfHdXKq5+5mdWwwXlFQBCijaigBiwLiVR3OFJV2h4BnbWJubB/3u7hO/+6Ff9y7gaoL+5Bk=
X-Received: by 2002:a6b:6a14:: with SMTP id x20mr8029277iog.177.1629303211993;
 Wed, 18 Aug 2021 09:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210813043131.833006-1-icenowy@aosc.io> <YRuDG78N2mB5w37p@kuha.fi.intel.com>
 <E91C97D0-7DB9-4455-AED2-4C25B7D2D22D@aosc.io> <YRuW0fENBEcIVkZb@kuha.fi.intel.com>
 <YR0Rlj+jk9dnoG6N@kroah.com> <E1804EE0-CBA1-4BE8-875B-57E82EDECDBE@aosc.io> <YR0bw+k0S94cmeDS@kroah.com>
In-Reply-To: <YR0bw+k0S94cmeDS@kroah.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Thu, 19 Aug 2021 00:13:15 +0800
Message-ID: <CAGZ6i=2a6ueLghhDTPCP_gumZ=HUYWRLCKkveyVnNQLgP+zyow@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:40 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 18, 2021 at 10:02:24PM +0800, Icenowy Zheng wrote:
> >
> >
> > =E4=BA=8E 2021=E5=B9=B48=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=889:56:38, Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E5=86=99=E5=88=
=B0:
> > >On Tue, Aug 17, 2021 at 02:00:33PM +0300, Heikki Krogerus wrote:
> > >> > >Why is it necessary to do discovery with data role swap in genera=
l?
> > >> >
> > >> > I think it could be possible for devices to expose different altmo=
de
> > >> > with different role.
> > >>
> > >> OK. FWIW:
> > >>
> > >> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > >
> > >Is this conflicting with https://lore.kernel.org/r/20210816075449.2236=
547-1-kyletso@google.com ?
> > >
> > >Which of these two should I take, both?  Neither?
> >
> > Don't take this, it's against spec.
>
> Ok, now dropped.  What about the linked patch above?  Does that work for
> you instead?
>
> thanks,
>
> greg k-h

Hi Icenowy,

Could you revisit the patch for the tcpm_unregister_altmodes part?
I think that is still a problem.

thanks,
Kyle
