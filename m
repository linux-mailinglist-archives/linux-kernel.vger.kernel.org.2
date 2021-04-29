Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB6B36E485
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 07:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhD2Fht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2Fhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 01:37:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D112C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 22:37:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so63498498lfp.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 22:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZdjO0RFzZ36whN0nqHe2gpIIEZmqiH1THH/jtnnt+U=;
        b=CWIBXDifnBdQIfmH7fbeslO7HP2eB+tTmyS2+tE28FSFjzEoZbGTu0dwfbn2UFv+gO
         5GC4piK1lG0xbMdstaNzlVQvx+loNPyJ77w2K99aZCLdLZzAsUJeEg/qqDPNCmcGa61c
         EufhXxsrRrt/3dTxVhgt7dfueNJVuDHmw1hpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZdjO0RFzZ36whN0nqHe2gpIIEZmqiH1THH/jtnnt+U=;
        b=MlrKzYLp3mwtSgvgNK77jzVONT/wjhyo9e5Lybz8fSC3+hv/LzUs0UgEmNtpnUUcjS
         I4hoL5Mq06wQ+xmBaIgZA48p0mXCpwXQR9r6xraAnGMMGM6/ygbiSUy6rAMhksRtf3vq
         hD4ZV+G+fEL7gDNBL/seaPDNyQJ3W67ua1aGP9m/MOrzwdm8NCKfSyi2bG7Sx1Gzu4wj
         DYnVza86qFnRfqIr0RI0ZTRZZ9Di4uCU49VxndZSWt8tLCv0i7i25NlNLOOwYmkA+G/S
         7UdWSdwAZa/0Yf4c1ksWYNn7IR6XaysFuM1Muv3NdiROaONuThLHW+13IhHY0Mx6+f6u
         iEMg==
X-Gm-Message-State: AOAM530/E0tk1ywNLizzOnoRKA9GCFge3n8Hln1sboqzR6nWhkLhuwcW
        iF+TjtNq1IBbbSVaVurqX1Kxh8IEYG6NKYc2KaMuCA==
X-Google-Smtp-Source: ABdhPJyQ2IZxORPjDeTCdOrxZkBNm/7PwLV9TJURE53nbZgLwQeggPI1ZudCFD1WHsd77x8hIsDt4W34NsAy5o90BhQ=
X-Received: by 2002:a19:6d10:: with SMTP id i16mr19428164lfc.126.1619674618681;
 Wed, 28 Apr 2021 22:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200909224226.2177401-1-swboyd@chromium.org> <CABXOdTeWfuZHLywMU1d+No-NSZ4uusAgkhs=2hNZGFM-uYz2wA@mail.gmail.com>
 <c3ba5d92-8bfe-30d7-44f0-c8a3e40d1906@collabora.com> <CABXOdTdsVyae9oHKEMSbXOsi5VWUZhLbKVxeNVedc4redZineQ@mail.gmail.com>
 <6b546379-d5ce-f0bd-7907-be36f90c15ed@collabora.com> <159978558757.2295844.13766111546939928492@swboyd.mtv.corp.google.com>
 <161801995912.3764895.7559313428958998666@swboyd.mtv.corp.google.com>
In-Reply-To: <161801995912.3764895.7559313428958998666@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 28 Apr 2021 22:36:46 -0700
Message-ID: <CAPUE2utFmQ6YJxi4zi90i8iBSq6QCDii-HoUW-X1w1bFQ6MqEw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: Don't populate lightbar device if it
 isn't there
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 6:59 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Stephen Boyd (2020-09-10 17:53:07)
> > Quoting Enric Balletbo i Serra (2020-09-10 08:49:42)
> > > On 10/9/20 16:52, Guenter Roeck wrote:
> > > > On Thu, Sep 10, 2020 at 7:32 AM Enric Balletbo i Serra
> > > > <enric.balletbo@collabora.com> wrote:
> > > >> On 10/9/20 16:18, Guenter Roeck wrote:
> > > >>> On Wed, Sep 9, 2020 at 3:42 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >>>> @@ -206,6 +209,17 @@ static int ec_device_probe(struct platform_device *pdev)
> > > >>>>                 }
> > > >>>>         }
> > > >>>>
> > > >>>> +       if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> > > >>>> +           !cros_ec_get_lightbar_version(ec, NULL, NULL)) {
> > > >>>
> > > >>> Any idea why the lightbar code doesn't use cros_ec_check_features() ?
> > > >>> There is a definition for EC_FEATURE_LIGHTBAR, but it doesn't seem to
> > > >>> be used. It would be much more convenient if that feature check could
> > > >>> be used instead of moving the get_lightbar_version command and its
> > > >>> helper function around.
> > > >>>
> > > >>
> > > >> IIRC it was to support a very old device, the Pixel Chromebook (Link). This flag
> > > >> is not set in this device but has a lightbar, hence we had this 'weird' way to
> > > >> detect the lightbar.
> > > >>
> > > >
> > > > If that is the only reason, wouldn't it be better to use something
> > > > else (eg dmi_match) to determine if the system in question is a  Pixel
> > > > Chromebook (Link) ?
> > > >
> > > >              if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> > > >                  (cros_ec_check_features(ec, EC_FEATURE_LIGHTBAR) ||
> > > >                   dmi_match(DMI_PRODUCT_NAME, "Link")) {

check_features supporting lightbar was introduced with crrev.com/c/263463
in 2015. It is present devices with lightbar like Pixel C and
backported to Pixel 2 (samus) with crrev.com/c/274047.
Remaining boards that have lightbar support and not check_features support are:
link
bolt (reference board for early samus).

Therefore, that solution is right. I will send a patch based on that
code snippet.

Gwendal.

> > > >
> > >
> > > That looks a better solution, indeed. And definetely I'd prefer use the check
> > > features way.
> > >
> > > Gwendal, can you confirm that the Pixel Chromebook (Link) is the _only_ one
> > > affected? This one is the only that comes to my mind but I might miss others.
> > >
> > > I think that Samus has this flag (I can double check) and this was discussed
> > > with you (long, long time ago :-) )
> > >
> >
> > Sounds fine by me. I'll wait for Gwendal to inform us.
>
> Anything come of this? I haven't seen any updates.
