Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E453144DAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhKKRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:08:08 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A686C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:05:19 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id az37so13190970uab.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpH5aIz9YnVDHI1tp8iTZZAenfgFZ0zd85byr9qx2Vg=;
        b=UdpJvinnJT+rLEFmcyE1XHdkYN5/vP9xkk5tjrHpQIiw4ffxoGhvbphUSs2mcUdX4D
         3r+xBe/0FJFrmNU4CbxYY2TdLL7CXWcvqB93caoIZdPwyJU/IgPt1NlEhwcFv53BWXf/
         qXqQFrmYNBd8smXfy/EhORtC667VtYArv9JzSNOJXozAK/ywKHZEv1xASbPwo0dx/pjg
         TktB1xI1teAGUwEa0ZB7Bkkun+VtcUmnNa38vGhhj+RHSYUllNIHBrRg1UA2SrZK34kR
         INkzZajs/okE0aVh48P1gDCtumnEJ4UfVHj910U9DcCdjHeMcu9ltMNPEPYP+gsrM/RD
         Ffpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpH5aIz9YnVDHI1tp8iTZZAenfgFZ0zd85byr9qx2Vg=;
        b=PVIVRCQqwV5k57xFynPicwJX7ogq8m5vvNEJvlkcWBnjsyGnOcldPk5sNYJjLgeNqJ
         x5UyJh3nXmTQJmZKKwMe9UixY4KWmnZ9pL/AUePkBDNLtGTExfU9NNZLvoKh/vN/m8M7
         GIZtIz5A51RafwOX8bkQSZjpES6ah8jYG0aKTAoIkABC7I67VsjfUxkOFVcTiJTxTeVT
         IpI5GoehFd85Atdxfz34ucfmD7ifSUu/w8TgEiH3biqp5onU4AoUsBYmB19c69cUtTiA
         5jdG6JxnixL1tvI5UglOrpk8hp6mPiIjXHRWC9LXmn5codFjSIl1kzZugmYwjdwyA4kj
         iTrw==
X-Gm-Message-State: AOAM53138ohRhx+JJ4I46su1eskquwzDf+EwaByqq6cf4mzAyRNzvlg1
        XH2uZVYUEqMswCyZw3zKDaNxTZ2fkCTqAcgY69oMZQ==
X-Google-Smtp-Source: ABdhPJzj9aD0XnB8FKZNP4f62gsXxPkbQXP07nxLWlCQRJ6aFNZfRb5dxpkDED6uVInZTLrnALcpuJSMqBG4Ju7YfXY=
X-Received: by 2002:a67:1781:: with SMTP id 123mr488406vsx.1.1636650318135;
 Thu, 11 Nov 2021 09:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20211021202256.28517-1-semen.protsenko@linaro.org> <163502632457.411308.6365977083733513077.b4-ty@bootlin.com>
In-Reply-To: <163502632457.411308.6365977083733513077.b4-ty@bootlin.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 11 Nov 2021 19:05:06 +0200
Message-ID: <CAPLW+4mBKH_-A5rWGKgpA=r8as6UqhmHf6h1DRg0fEY9jSmJQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rtc: s3c: S3C driver improvements
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 at 00:58, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On Thu, 21 Oct 2021 23:22:53 +0300, Sam Protsenko wrote:
> > While working on Exynos850 support (where this driver works fine in its
> > current state), I've stumbled upon some minor issue. This is the effort
> > to fix those.
> >
> >   * [PATCH 1/3]: moves S3C RTC driver to newer API usage
> >     (no functional changes)
> >   * [PATCH 2/3]: refactoring/cleanup (no functional changes)
> >   * [PATCH 3/3]: adds time range, as [PATCH 1/3] made it possible
> >
> > [...]
>
> Applied, thanks!
>

Hi Alexandre,

Just want to check if this series is going to be merged during current
merge window, or is it scheduled for the next one?

Thanks!

> [1/3] rtc: s3c: Remove usage of devm_rtc_device_register()
>       commit: dba28c37f23a09fc32dbc37463ddb2feb3886f98
> [2/3] rtc: s3c: Extract read/write IO into separate functions
>       commit: e4a1444e10cbda2892a4ea7325ef5efa47c75cfb
> [3/3] rtc: s3c: Add time range
>       commit: a5feda3b361e11b291786d5c4ff86d4b9a55498f
>
> Best regards,
> --
> Alexandre Belloni <alexandre.belloni@bootlin.com>
