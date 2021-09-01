Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639103FDE7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbhIAPVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhIAPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:21:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AFC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:20:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso4923011pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR/bUY4CIHX9QEwg/un6BIIYxuxD5D3OcyVLAtXISWY=;
        b=LOd3elatHJFf7Gf2t37DAlQRgFANZpUI2tnhD8w15Wo10rbeqHHtfGzzBLG/LcV1gy
         e5u6AsS1VgZRp5Y3WA2wBQ/D6j3z7zMxYZkcLEvet100v33cSrZMGUfIXx1GA50OKwu5
         fBka8gaBIEsgVi5Dnh/A9MupJ2jQws7fBmJ6HclM5+hbo7zG1tA7dCjxv1v/06T8rC0P
         GFcs21spJ+h8ijM46Yg0+YVWRbGkRnTn2wa9q8Vty1g4SgC2vHl7blanHSLQcBKMWIi2
         N3/RnZ5BTVaxIxNBvIExBj6hazRou22EtZ6KjO3hdJwetp0lnXaEB1KuK0Uedx0VuUqr
         hHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR/bUY4CIHX9QEwg/un6BIIYxuxD5D3OcyVLAtXISWY=;
        b=FXfF9VrkdtnyJIA5ecfI2nsBzrHO6UlZGJcDGP161pPrzOwtRTPrLyOmUE3ygEI82W
         8yvg3iPU1wZhyhv+fZ7yPlr4LeimtXv92o7V4j6pSCt33t5hdVfikyzcNCo0X6QFXbdH
         KRp0Wg4xzEUiYIDAs+8IU76BZmjBwIVM2akhWiLzKrzhwnObGP/bVXgcrdJtl7KosYbL
         mT+Vc0jtCmFf9lyclFC0S9csXM3C5mJJjlpivIVBVR8ZqjsIAvwhrhVjhd0QZXhAa9Tg
         Z0iOMlRo88AZYxdhEi0CioYeRbuVhTcrNhCtcOTY15m1dtjDHeUR3rFUeReSEaQZVabx
         VWnQ==
X-Gm-Message-State: AOAM530YSoXLl5wPhTMvPrysqSHc1uwVwKnAIOG0DQiTtwc6kxzmYkF5
        sn19GIP2ID+Lg59lWl90V6Y6yDmgNK5q06E7tVk=
X-Google-Smtp-Source: ABdhPJxIgLhZBL45IOznzbHYHZCmTzMjImXoJJOCaE7zeKJ1SaSLhSQEupQx718O2F5WgW3hPkK4q7vd+uVbg364uwA=
X-Received: by 2002:a17:902:ab53:b029:12c:57a6:13ae with SMTP id
 ij19-20020a170902ab53b029012c57a613aemr10175518plb.53.1630509625523; Wed, 01
 Sep 2021 08:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
 <20210831133533.6aayzjghdakrhy56@h510> <13366651.n50aozgL3V@localhost.localdomain>
 <20210831230014.cp46vho2hnndacjp@h510>
In-Reply-To: <20210831230014.cp46vho2hnndacjp@h510>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Wed, 1 Sep 2021 17:20:13 +0200
Message-ID: <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 1:00 AM Bryan Brattlof <hello@bryanbrattlof.com> wrote:
>
> On this day, August 31, 2021, thus sayeth Fabio M. De Francesco:
> >
> > I just want to *really* thank you for the hard work you got involved and that
> > you carried out with one of the highest levels of professionalism (and
> > patience :)) very few of us could ever equal (not I, for sure).
> >
> > I thank you also not for the technical hints you gave to Krish, instead for
> > your your choice "to not rob [you] Krish the opportunity to learn".
> >
> > Actually I was tempted to write something like "first do this, than that, and
> > finally run this tool". But I was able to desist, by learning from you how
> > people should be helped for real.
> >
> > Most of us here should learn by your attitude.
> >
> > Thanks again, seriously.
> >
>
> Thank you for such kind words, Fabio.
>
> I was very lucky to be, and still am, surrounded by people who
> demonstrated this idea to me when I was young. I am very happy to see
> others here see how beneficial and helpful (in the long term) learning
> this way can be.
>
> I'm grateful to have found and be a part of this community.
> ~Bryan
>



Interesting.

"make drivers/staging/android/ " works now (finally!) and shows me the
errors when I mess up in the file  ashmem.c for example.
Furthermore, " make CCFLAGS=-Werror W=1 drivers/staging/android/    "
outputs the same errors too just more verbose. So it works completely
now, However, "make CCFLAGS=-Werror W=1 M=drivers/staging/android/
" just takes to new prompt line and does not output anything. Do you
know why?


Thanks
