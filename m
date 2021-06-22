Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992C83B091C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFVPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhFVPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:33:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13551C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:30:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w71so6672383pfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StF8dkt39UJQRnKgHWaMfh8evRK0yaAhW4+ZT6VaS3U=;
        b=esGtcwUWktU6tuzbeoWHXGTwO7akF/y7+trghnpd8imNx9TCn90YzLFknRH/vj9tVH
         XbwXpVASc4THBwmtJlgG3E02gb4TpV+/CGSnCl5T+rRWjx9OFYB5CvlzlyZPcOlIsuU/
         Y9neuYoX1E3xE31xurusD/jmTmrBgMscEhImGp8WwOdBgZHQAZIwQg2kM32fWp/azY3+
         IIl1IkYieIdsRIUxRrCIThiWpk49u0XKAORDCon5oF7ITUHzTaPX9BuG4fGAIXGKsWAg
         ZqCI7lDhuKkgO6+5KURwJmxXiHm65e5GRZZk58FPYqDcy6ukxXtETIce3Wy4D6wLx5Yd
         KGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StF8dkt39UJQRnKgHWaMfh8evRK0yaAhW4+ZT6VaS3U=;
        b=n8fnfj1o1YNU6IdwU2mxArW+cYPL5giLTXCdP8eq/MrAZlRbecflNrsMlFPz8rses6
         roVJvHfFFCiKn+tP7JrCG6YxFvJX1cEdLfuwOSTjT+DGIKHtZ7pgj+07Kd2UjlJl09D4
         bgm6xmIbpOxZ5yX7fwhT9iB45cJUJ5HLrGSZztpEuVedSaAwWEAFGIDWQbmcV/QpMZyS
         NAg0XMSWqlLL2RqfEF3+1HIpE3vjSdGX6RPm1vTfokFgO0NPEevwg7pxDPCRlFjdsSNT
         GYuXBj+ksPTYnMAy6J/Oepv2U0I/z6+rd3cedeWEmEdwbuRqzQM1Rltg+1QyF0E+syzm
         THxQ==
X-Gm-Message-State: AOAM5322FmPQAHlSnr/g+B67H35w8rvTZIzWAFFFh6+HMcqDFQqjUuI6
        YGu3qM2vkAJhAdp0eLoGeQm0a11LUb1oHPKWnBc=
X-Google-Smtp-Source: ABdhPJy3hjBbVHkHKZV7Xv8FzjolKZZaF29vnCk8mdKrE+k7QmJAtDSrBtgKodKNJr3AYUXRXaOu63KipUnhQ78eA4E=
X-Received: by 2002:a63:df10:: with SMTP id u16mr4310478pgg.4.1624375856609;
 Tue, 22 Jun 2021 08:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net> <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net> <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net> <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com> <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
 <YNGa021IIj+C8H7h@kuha.fi.intel.com> <YNHvZGLE9lgS/FRe@kuha.fi.intel.com> <CAHp75VfB2oa-YKTv9D2e6GEOnSGyUGUdqSi=GLuvL0v6BqPBFg@mail.gmail.com>
In-Reply-To: <CAHp75VfB2oa-YKTv9D2e6GEOnSGyUGUdqSi=GLuvL0v6BqPBFg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Jun 2021 18:30:19 +0300
Message-ID: <CAHp75VdEskqphUVvMnpkxympYxevpP9TamGjyXNVLYezaavCHQ@mail.gmail.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 6:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 22, 2021 at 5:10 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Tue, Jun 22, 2021 at 11:09:58AM +0300, Heikki Krogerus wrote:
>
> ...
>
> > Before I send the patch to Rafael and Greg, can you confirm that the
> > appropriate API (device_is_registered()) also works? I'm attaching
> > patch that should be the final version (if it works).
> >
> > I'm sorry to bother you with this.
>
> In the commit message: happenes -> happens.
>
> And you may replace my Cc to the Reviewed-by tag.
>
> Thanks for your help!

One more detail, shouldn't we drop _nowarn as well?

-- 
With Best Regards,
Andy Shevchenko
