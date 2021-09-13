Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95E408A85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbhIMLwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhIMLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:52:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:51:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h16so20497115lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcxL95DIl7E0Surm2fYVh0FLQdkw8xdl/2I8gB6Ck0A=;
        b=F/FAqgSC2yHhGt81eMsu5irZzsSG7lnTScaJlLQars0vcimQ5j+chCBZ/sqyDjOVaw
         zszBu+9roSDnBN6pLYP9I9oePiq0cMyRp8H4tQOYuzrHPrLmUFng3Qz3sElUBeK3X4AH
         4WS1j8hhHZyjGQMijZ25Y0LF9sNe21zcaq2Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcxL95DIl7E0Surm2fYVh0FLQdkw8xdl/2I8gB6Ck0A=;
        b=kPBoeKZMsPi8uBT/Nx0yVyIOI/t/K6rHxLc5x1elgdT4L5CbKlhK2jEM/jOy+UclGd
         pj+7PrCdzGTZYivHbQ8O3RUnGXYySXabMFrr0eCXLksLj5LbJ2LxDziKGxEJshtSMUwv
         5HkvjYX8TVqaH11e0EXiL9WN3ghDKPeJU3JCLt8Ot5y8asnhvZCylP4e+vGLpd2Zo9ws
         8CJZaO7hiFfgLYYMNsw8lJrrmHJpAkLllzzlUJCN2l2aoVFyvccFIeNfDXhkbe6k4BJG
         rJniALRb+kURnUOnDgpgboQ2/dWC2nRlAN5HYI+Eu9F9aEbhVpohm+9kpu3Z4j1PRSvu
         bFKw==
X-Gm-Message-State: AOAM532M6Jb4vYMBriCe4iYauyhujafeBLDbK4zEkiD7jF9OWBEePnC1
        1YEKxx1rV+PjRYTaKVpZtpi+6If1BTLNSEemVaGvHY28GJQ=
X-Google-Smtp-Source: ABdhPJzQUy1rsa2nwHauTUnzipk89JG7Ch4EPsaNLW/0YP4N/Py2u4+AEqdTBjHV7GUlDd2hGYO0QrK02PPjy89yJfM=
X-Received: by 2002:a05:6512:118e:: with SMTP id g14mr8493571lfr.661.1631533883167;
 Mon, 13 Sep 2021 04:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com> <20210912015740.GJ13220@brightrain.aerifal.cx>
In-Reply-To: <20210912015740.GJ13220@brightrain.aerifal.cx>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 13 Sep 2021 20:53:42 +0900
Message-ID: <CAFr9PXk_w_+4mec1OfQLzsYHta2P4rEFGwsJJv+LSQo+hzKGeg@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rich,

On Sun, 12 Sept 2021 at 10:57, Rich Felker <dalias@libc.org> wrote:
>
> On Thu, Sep 09, 2021 at 06:08:58PM +0900, Daniel Palmer wrote:
> Hi. I see there's a situation that needs my attention here. I will
> plan to review and merge anything important/blocking that doesn't have
> problems this week.

Great. If you want to have it tested on real hardware please let me know.
I have an ecovec24 (SH4A) board connected to CI so I can easily build
and boot test.

> At the same time, I am open to the possibility of a new maintainer or
> co-maintainer if that ends up being what makes sense. Are there any
> candidates?

I think the problem is that while there are hobbyists out there the
number of people that are still familiar with how the SuperH stuff
works is pretty low.
I don't have the debug dongles etc anymore so if some treewide change
breaks everything then I don't know how I'd debug it.
Maybe we could add a few people that still have working hardware as
reviewers so they see patches and build test them for you?

Cheers,

Daniel
