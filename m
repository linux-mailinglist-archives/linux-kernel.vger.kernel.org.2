Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647E433A788
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCNSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhCNSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15EBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 11:47:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w34so18088401pga.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmm4U6ogcZrimFUeHMdXjx969kmaGqhFanMQM5+X4yM=;
        b=Z7vv+Uzd4Jm0zUxFhxl24jAkU5lSuqBLqqKe6xaRoqiqBvoLLU5ZS1xdejWoa4ZCwI
         WdfuyWR+xW6jPKEVme/XkRRnNeQE7NggWOJo6I7bfjja5zruik4eAkjlxKbSuJeXssg8
         8mSye50wj6w8ta0+VNB+/69MWlPMj1wtmCvUN8hiuhuwaGnmcBbfJNoS7jMIXGReoigu
         7PBiY5f2poPRXeG/GPTvg9ARZ5SpcrCQCFfeEVshzzkt+NGKK1WugfHKJrTUZaLMnaID
         qUPOL6BC+yOJowzBErv9rruHUjwMVQiMenxqc21u1WSO4mDnmsHyrkYMLIdq6dbRO3wb
         eMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmm4U6ogcZrimFUeHMdXjx969kmaGqhFanMQM5+X4yM=;
        b=ITl+OtRIXpikbfr+zSF/tfe4TRCGI9I4fOt9e57fN7uykWuu/yDYWAusqrNAw1U/Ua
         lf5RjiDRHfOkzuZCt3F/XbswaG5xlfi/QsyDWwKEXmjooHZ0k5H9/+ZiJ1gQGo8y8pLh
         JSi/W9ZfTHc/NdqMPZ8ZbZH35JVWoDA6a0J3RP8SZf+w28TIh3ukPmoeEzvJJjalEHS5
         YXI+4MmTf35milTdtvQPIexFreRGcD2tpVqI9tx1YrnZbLBUfEofmeeukYfz6joMfQf5
         /rdJGA8NyZz6ranDRhcjw8MKcEzig8TswGFg5rZb+x84yB1zNkFVJx6wC7/1m1AkX/CQ
         Fj2A==
X-Gm-Message-State: AOAM532eKYLZUmAV14lW7PF/btp5Lkpy1/kobvagChue/crdGo2r3B/C
        O+xS+xl8TgC/gNBHBqHC6tuhluJd7MJcB3+YxNVjWg==
X-Google-Smtp-Source: ABdhPJxZewfUb1hWrdsR/tdnYPgU2n4V0NjZmx8a4iH7FIAcDuSBXFL7b0ZsQ860ldrvmnDJWWtIYJcMgIJ6Rv8xr2M=
X-Received: by 2002:a62:ce4e:0:b029:1fa:b601:6681 with SMTP id
 y75-20020a62ce4e0000b02901fab6016681mr7449992pfg.2.1615747656027; Sun, 14 Mar
 2021 11:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210309231259.78050-1-jbhayana@google.com> <20210309231259.78050-2-jbhayana@google.com>
 <20210311210844.34371d8d@archlinux> <20210312121639.00001c31@Huawei.com>
 <20210312133101.GG30179@e120937-lin> <CA+=V6c0boA1Q+k4rM0NOcK4ek_FYU7omEWhvMowqACH_t44sAQ@mail.gmail.com>
 <20210313171107.4c8215e7@archlinux> <CA+=V6c0a8z9+gkD_M6KNviN-VActtmpTgkuCBn-sgC4Fm2C6QA@mail.gmail.com>
 <20210314154033.3facf1a2@archlinux>
In-Reply-To: <20210314154033.3facf1a2@archlinux>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Sun, 14 Mar 2021 11:47:25 -0700
Message-ID: <CA+=V6c341JjXQ+QFpiSES_Lm7PT0qCh2WU0uQWrmrFaPr_2QiA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based Sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

No worries. Thanks for the update. It looks good now.

Thanks,
Jyoti

On Sun, Mar 14, 2021 at 8:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 13 Mar 2021 11:55:39 -0800
> Jyoti Bhayana <jbhayana@google.com> wrote:
>
> > Hi Jonathan,
> >
> > I still see the old version 6 in ib-iio-scmi-5.12-rc2-take2 as well.
>
> OK. I'm completely confused as to what is going with my local tree.
> I have the right patch in the history but it didn't end up in the final
> pushed out version.  Fat finger mess-up I guess and too many similarly named
> branches and the fact I didn't check the final result closely enough.
>
> There is now an ib-iio-scmi-5.12-rc2-take3 branch
>
> This time it definitely has your patch from the 9th of March with no
> instances of long long in it.
>
> Sorry I messed this one up (again!)
>
> Jonathan
>
> >
> > Thanks,
> > Jyoti
>
