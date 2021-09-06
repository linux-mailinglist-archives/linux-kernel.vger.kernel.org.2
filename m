Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F352401841
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhIFIvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhIFIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:51:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74CAC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 01:50:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i21so12070646ejd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxXQTshxIsbfAl89WtIQKw+Tm3yOn99fm9Kqix9sEs4=;
        b=V1PsecuWiackqz4fr1D6pSuEkJwHJGTg6WKDk6WUH0ngOwEM1tombwa+Wo/Kkxr0jv
         Ce/rrmx81JRm9ZqM0e+eu9lQk+ZopOTjJrguL1KgZqHPe7eKBp9+S9tpib9oaScE0rbh
         v0JcOPnx2n5+pEjL8JpTCI5voTtYllWuUyD8jEQIDxNmYJuspo+z4SejBCsv6RsME6T8
         zG7pUdlE86CdIISrYFu/hBOtloZa91B5/VhFg3UoJAQR6rh+j+sIcoycmW/MEi8r5EYY
         dldMJ1Xcx7LexypKtC00cqr86UMP0ulQBsulrpyzcamd+X5BoaNGxL0uro+B7aIfoJ0q
         4l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxXQTshxIsbfAl89WtIQKw+Tm3yOn99fm9Kqix9sEs4=;
        b=D5ZBd067QhEGNzvuZbwkZjgjjB1kWBbnM743wKFFt1KSwNuRuys3hEBViP82bsc27V
         AwisOwkbwkZDCbsXo9VWryAkpR8t93iL6zvXqt3VG+I+0UkD5+sD0Uw84tznSmSfugK5
         TNOdP5bBAikgYrmJs7cSMLcmB3p4werJa/zTer/qQ6A5NJiCitAvbRn6kwnNDP24CxBj
         0hbHJrgMMFYutAzSr2CAx68dmMnNDxnaxjmqe9m4xNxDo8qFKYJCNA12Y5k+KZSxX1qm
         fDgovYqHW//wtuBNcKVzPXHZ9GFo02zon3sGMFeYeMpTIC6FrZd+vYVzcEN/6VGbw0AN
         UW3w==
X-Gm-Message-State: AOAM530gujvHq3A92b263XCy3E2jP8VgGB1i7ovVM++kt3POj1gWQHYh
        iD+QIiUm1TpbE9tH9wE1ISzmU15/cvoP/QEQdFP3v+B5IGxIGw==
X-Google-Smtp-Source: ABdhPJzJzT1V0vNO4H/k+xnAI7Yh55AhQQ+U/iK9heibJ2xmjL2vxxyE8zxVGkc0i3GwBtlf5ZwAVDvRYbNLYNMu0P4=
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr12690482ejy.493.1630918202321;
 Mon, 06 Sep 2021 01:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
 <YTTbD+BKRpd0g4hq@kroah.com> <CA+G9fYs-K2f+eZW55u5uh1gQedTQpm=TGDNk7K1uOk8AeDNUQA@mail.gmail.com>
 <YTXMsxY9I6VdtVsS@kroah.com>
In-Reply-To: <YTXMsxY9I6VdtVsS@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Sep 2021 14:19:50 +0530
Message-ID: <CA+G9fYvzqidCJYOoA9eX4ayf9HGyJ_jBjMS42NuuzFK_tFAmzg@mail.gmail.com>
Subject: Re: kernel/kexec_file.o: failed: Cannot find symbol for section 10: .text.unlikely.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sept 2021 at 13:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 06, 2021 at 01:10:34PM +0530, Naresh Kamboju wrote:
> > On Sun, 5 Sept 2021 at 20:28, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Sep 05, 2021 at 07:28:35PM +0530, Naresh Kamboju wrote:
> > > > Following build errors noticed while building stable rc Linux 5.13.14
> > > > with gcc-11 for powerpc architecture.
> >
> > <trim>
> > > Is this a regression?  Has this compiler ever been able to build this
> > > arch like this?
> >
> > Yes. It is a regression with gcc-11.
> >
> > stable rc Linux 5.13.14 with gcc-11 - powerpc - FAILED
> > stable rc Linux 5.13.14 with gcc-10 - powerpc - PASSED
>
> Ah, ok, and does 5.14 or newer work properly?

No.
stable rc Linux 5.14.1-rc1 with gcc-11 - powerpc - FAILED
stable rc Linux 5.14.1-rc1 with gcc-10 - powerpc - PASS


I will check Linux mainline and Linux next and get back to you.

- Naresh
