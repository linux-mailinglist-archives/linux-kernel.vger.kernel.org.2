Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C871E341C16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhCSMRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCSMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:16:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:16:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l1so2872977plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rr62kvdI+jVNyeq/XYk+9hQihPrvCb+jP5s+Yn8CaNs=;
        b=VSnovSkTGgj4jB2N5zRZSHAx9Hhij+eplAfOA0aNVD3ri2MuqDBjCMiJJekrqhOJbz
         PLk9AnDCEOteFl+USLQKByq7ptWl/sNqDG25WRTPDKaxhixbY13lEkKY6c3eoipVuvYa
         vtGgJheTT+LURHN9FqoOJ2A6Onqa0OOf0Uc3cvYpxwSsfXYtehpGTK5DkWlcjQk54pbc
         BdrCNj44gE25cVXsl5tX0jzqVOiKpwavrPyFqWUlbDUblQNHtvnhfZDTMK+qdqlV0rmg
         C1JDFWt9t1kXRWghJo+KndE6LKmYbZXqm1B2BdxQKW1OmPNpQroiLPvs2Yt/dXswj7bV
         5b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rr62kvdI+jVNyeq/XYk+9hQihPrvCb+jP5s+Yn8CaNs=;
        b=o7Z5DUiZbDUTt7Tvp7KuzJNrK7/Za4LvhvKs20CKUFAESPRRyZrSnJUyuwuiSv15ov
         u7j2R5Lyn/Temrjwas4zxjIXgeXQr09/o8iMvoLOLTyYfxsO8BE0weRW+XAGtuf046Za
         5/dOFvt7QXY08P5LxMWf2nDVDKoS4paSvaHJkSjUpEIB3KUFt5PJlOwZBuPkwtk16rvH
         DH3+62tdkeDMZPsPHMW4cFtQsSM6reiu8Ch5LcRApPly5W4uAR9SQ7i8pod9S9Tz+7j3
         HxIkUM3rBGeA8Jd3oRoH1hBILrT38a6AI5iit8c/M2B57DXVPwbFFceaVXjbiV5MXRSV
         y6DA==
X-Gm-Message-State: AOAM532E8L9gxWf9/WgoMqG0r5pHGbQK6WGudSCueH/42UPYH3+IjLQM
        ikGWTz3SgTthUNT2Wp25KMTXMQPjx/egcb8hR10=
X-Google-Smtp-Source: ABdhPJx7IaIlDRm3rwmiM8Zop/6Z1jWa2tOc1g3Ijk1PnFzzc7dMOz6ba6OCHY+cbOY/cIxK6aU7PDvrsZvxU/PI4mA=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr9570103plb.21.1616156208463; Fri, 19 Mar
 2021 05:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210319110459.19966-1-a.fatoum@pengutronix.de>
 <20210319110459.19966-2-a.fatoum@pengutronix.de> <CAHp75VdjefJHMu2ot7RoZZZis0aNyV097J34wxDSwLgh3bQ8Pg@mail.gmail.com>
 <d8317cce-f5de-062f-70f5-6317032d6991@pengutronix.de>
In-Reply-To: <d8317cce-f5de-062f-70f5-6317032d6991@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 14:16:32 +0200
Message-ID: <CAHp75Ves0+oebnSSYNNb=DcAuiN6-BFwp4jyDD9pSeg6FX2HKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] driver core: add helper for deferred probe reason setting
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 1:46 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> On 19.03.21 12:13, Andy Shevchenko wrote:
> > On Fri, Mar 19, 2021 at 1:05 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> We now have three places within the same file doing the same operation
> >> of freeing this pointer and setting it anew. A helper make this
> >
> > makes
> >
> >> arguably easier to read, so add one.
> >
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Thanks will add for v3.
>
> > Now I'm wondering why deferred_probe_reason is not defined with const.
> >
> > Can you check and maybe squeeze a patch in the middle (before these
> > two of this series) to move to const?
>
> The deferred_probe_reason is only used in this file and it either holds
> NULL or a pointer to a dynamically allocated string. I don't see a reason
> why the member should be const.

But we want to be reliant on the contents of the string, right?
I would put this why it shouldn't be const.

As far as I understand the strictness here is for good.

--
With Best Regards,
Andy Shevchenko
