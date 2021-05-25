Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF738FDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhEYJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhEYJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:22:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C40C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:21:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p24so44963683ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZTuEqLmGNl02YmfLP5PxVjqs62Ikettm3LSYBztvwU=;
        b=RL3Qqgi1li8RxeZRnGxuZnx649DfSgBleh19zT9AS8jkydT/2fnKCXMiWz5BHTkJob
         gPWlu5KDgWD39SHNCW5RYZ+4SlG3P9ZWLY6N5O4nQoU3Lcq5L7Sbcqmmvo7lHEkPrMNa
         WPwQtYJQ3BjiFtf12eUcfyt8Z+obnYHh1/mS9xoKePOgBV3OfDe/pnhMAKhtN9EW2wq3
         NXU6HLWpYBJ+kbjqCe81u20pJi/Pjnyynkc5uSuwxpEPYZOqkNdp3knkjtCWixNHZtPo
         jx9x9yDp/lO1JFnfoG8E24jcyiBT3RHh7FomQaL+zruKaOAESN9qDKJPrS6aHkW1gWkL
         R/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZTuEqLmGNl02YmfLP5PxVjqs62Ikettm3LSYBztvwU=;
        b=UaUwSPsgpDsXJF0UNuSqTvHaAZF7sq9meVoM3p5oS9KQi95CHri466RI5BrOMHZXu+
         q60mmo5FNN9sBwD+VnAdeuXpmjJQOmSAfKCrMc7NzqPPM7CPBYgtutoaDWkZYRchfJdP
         8fuAbrQk8qamDrSMouxqgQAKoQV9ibdHvq/EdoWTE1ZXnz55Y0ycqST6ZTsRiXHi2k2p
         gKZ/dfZ8FsbMDy6iejNXUrKmv3EDXuqIu6Wk+rltailvmXBkTjE3GXhDzUpafgTF4CXL
         x4gVqZy+qD4ae5wfTTwCXl2stjU+sYiZ1mKq5CEKMuiOL19Gg6I/VvBQ7kivFCLDtkVQ
         ATLg==
X-Gm-Message-State: AOAM531bc5dNG7rxUAXQO07anXEf91wHjV0pws3+Le43zpPjjJlbPFgr
        j7wlSPLdbM2mjknZi4rieIFt2xC0F4pshxXQNZM=
X-Google-Smtp-Source: ABdhPJwZt41wiN/C66srXKSL4bOqj1B7wdmXOGKfU21A8DSyOoxYSPs10Xth3CiLZRBcJ8G3MeR7F+s2EtbSzF7C7Mw=
X-Received: by 2002:a17:907:78cd:: with SMTP id kv13mr27315360ejc.360.1621934479619;
 Tue, 25 May 2021 02:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com> <YKy9PHIbuhsomsTq@smile.fi.intel.com>
In-Reply-To: <YKy9PHIbuhsomsTq@smile.fi.intel.com>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Tue, 25 May 2021 02:21:08 -0700
Message-ID: <CA+7tXihtuzw3+7boMFqmvHcpe-hr2qF0TnaduskbXUbfsFwb=A@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Daniel Latypov <dlatypov@google.com>, linux-kernel@vger.kernel.org,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 2:02 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 24, 2021 at 01:17:48PM -0700, Trent Piepho wrote:
> > On Mon, May 24, 2021 at 3:51 AM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:
> > >
> > > This misses the test cases (*). Please, develop them with Daniel.
> > >
> > > *) We usually don't accept changes in the generic libraries without test cases.
> > >
> > > Fixes tag?
> >
> > Is there a bug report on a tracker?  I just got the email from Yigua.
>
> Fixes tag refers to the existing commit that brought the bug.
> Also you may need to add Reported-by tag since Yigua reported it.

I did add a Reported-by tag.  Wasn't clear to me fixing a specific
commit was entirely appropriate since not handling out of range values
correctly has been there all along.
