Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4940A8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhINIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhINIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:04:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3281C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:02:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z18so26311729ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QeCcLNaALY3aZOJPHqqh+5theWDaLEd6ZFO9u6rK4E=;
        b=ieZQQ5JXNF2rTqt3gnyiKMb+FaXBAk21U9UkssNg7OlvQ9D9mgnLndndsiPejRpKVx
         FZvhadB+k5ZoswJg4EDEshjhDPYC6UIAFFEWapFclhoK8lPprHFO/XrSbHHYkGRnaHrD
         cDRD0bbPbcTGSv0Em0xMmZsBwnvywC7jWDfFgs9OozJ8BhJRRb89VS+2hnTiR5P5pVWI
         5+lRTFMpl94r7NMSkxLvoVJ2SwL8vXnhu9AyFYx3SZb/l4PI15gK6rAqWLOPjJ7v//+9
         PsfYozTfnzfIoV1G8DkMRxCVS/283J4hPvZLbNTbGVcBRRTQ5EJ5tYy+p39GpP3qPK0I
         HXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QeCcLNaALY3aZOJPHqqh+5theWDaLEd6ZFO9u6rK4E=;
        b=I0rqR+CYE6sWbDtA7bMJhsQkHIMdptpzU9CZSETbB+vdlpy9cVA+AeUj7ogs0vkDC4
         OrcywilGoRucnsXclz5kKOap6IYUfB7V0zdI3Xf9CYwcuF2c37aBP3/cFlBpqf3b3hDE
         pct8gxcD7BtUN0+VOj6ARdXWc4bYhjAHgdFo6S6OiRuPgFRnM+0vtfmlzuuiRSpJTC1k
         YeR+V+au4dgxMx5Lfsbu65kU9uZ/Qs1BnvaeQhpRurUXvBZVfGv7h5N08Rnl4W+zBAW0
         hwhUazG7Pw02HGLoR4FbrnqAmcpkki6ozxSRawiJzpg240LG06gF0IlvMh+Mij1+FucF
         bvJg==
X-Gm-Message-State: AOAM530xcvkwtv73ppbUT99aTYb/WUzGk3XCHEHvU0wcyRN9TvCQ0D5u
        H3C3djyq8mMYxnUxCKCWmo4J2HP3owhCuR8NZlJuhQ==
X-Google-Smtp-Source: ABdhPJz1kmSwBdDmnWrNRH38hzvpR3tXKGfbCoX+oI8sNlsg6EUADqfdLTeRBQcUKBTKHrxXsboOBsnoADHdAcQEfO4=
X-Received: by 2002:a25:21c5:: with SMTP id h188mr19316340ybh.23.1631606548762;
 Tue, 14 Sep 2021 01:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
 <CGME20210914043943eucas1p134f89c3399fb2bb6a5f24ea5b6119188@eucas1p1.samsung.com>
 <20210914043928.4066136-2-saravanak@google.com> <7756112c-0378-f48b-ef5a-aafc994dc662@samsung.com>
In-Reply-To: <7756112c-0378-f48b-ef5a-aafc994dc662@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 14 Sep 2021 01:01:52 -0700
Message-ID: <CAGETcx_s59Xga26uOp48g8eCr72ysgCtfu3eCQ8eK7F+dDau1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] driver core: fw_devlink: Improve handling of
 cyclic dependencies
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:16 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 14.09.2021 06:39, Saravana Kannan wrote:
> > When we have a dependency of the form:
> >
> > Device-A -> Device-C
> >       Device-B
> >
> > Device-C -> Device-B
> >
> > Where,
> > * Indentation denotes "child of" parent in previous line.
> > * X -> Y denotes X is consumer of Y based on firmware (Eg: DT).
> >
> > We have cyclic dependency: device-A -> device-C -> device-B -> device-A
> >
> > fw_devlink current treats device-C -> device-B dependency as an invalid
> > dependency and doesn't enforce it but leaves the rest of the
> > dependencies as is.
> >
> > While the current behavior is necessary, it is not sufficient if the
> > false dependency in this example is actually device-A -> device-C. When
> > this is the case, device-C will correctly probe defer waiting for
> > device-B to be added, but device-A will be incorrectly probe deferred by
> > fw_devlink waiting on device-C to probe successfully. Due to this, none
> > of the devices in the cycle will end up probing.
> >
> > To fix this, we need to go relax all the dependencies in the cycle like
> > we already do in the other instances where fw_devlink detects cycles.
> > A real world example of this was reported[1] and analyzed[2].
> >
> > [1] - https://lore.kernel.org/lkml/0a2c4106-7f48-2bb5-048e-8c001a7c3fda@samsung.com/
> > [2] - https://lore.kernel.org/lkml/CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com/
> > Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

-Saravana

> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >   drivers/base/core.c | 17 ++++++++++++-----
> >   1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index e65dd803a453..316df6027093 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1772,14 +1772,21 @@ static int fw_devlink_create_devlink(struct device *con,
> >        * be broken by applying logic. Check for these types of cycles and
> >        * break them so that devices in the cycle probe properly.
> >        *
> > -      * If the supplier's parent is dependent on the consumer, then
> > -      * the consumer-supplier dependency is a false dependency. So,
> > -      * treat it as an invalid link.
> > +      * If the supplier's parent is dependent on the consumer, then the
> > +      * consumer and supplier have a cyclic dependency. Since fw_devlink
> > +      * can't tell which of the inferred dependencies are incorrect, don't
> > +      * enforce probe ordering between any of the devices in this cyclic
> > +      * dependency. Do this by relaxing all the fw_devlink device links in
> > +      * this cycle and by treating the fwnode link between the consumer and
> > +      * the supplier as an invalid dependency.
> >        */
> >       sup_dev = fwnode_get_next_parent_dev(sup_handle);
> >       if (sup_dev && device_is_dependent(con, sup_dev)) {
> > -             dev_dbg(con, "Not linking to %pfwP - False link\n",
> > -                     sup_handle);
> > +             dev_info(con, "Fixing up cyclic dependency with %pfwP (%s)\n",
> > +                      sup_handle, dev_name(sup_dev));
> > +             device_links_write_lock();
> > +             fw_devlink_relax_cycle(con, sup_dev);
> > +             device_links_write_unlock();
> >               ret = -EINVAL;
> >       } else {
> >               /*
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
