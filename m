Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C708341D45B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348659AbhI3HTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348531AbhI3HS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:18:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042ABC06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:17:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l8so18674369edw.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qJ/ajL0XPBH0mePIQVf+fjWOYAGb/vqwSUqSwxjSc5Y=;
        b=yJfmfqsf13s1blSAlBhi9+Cyp/LlyHLlGEGd+fkZcdSS9GHBfe/cmah5ymG32rH+9Z
         q9AFgptf/yAy2lmEiI2OrwjBd3e362cDvcX1w7E/eeHdhfSEmk16Rsw3+rUH4dWVyB8D
         vBu0gRYbCmPNRBHqRo/grOz5ywVEz37n4PWwCDWuj7vwCs1OZ2dlW/lwayHHgJok3ocQ
         1OcygxpcYeeW+gyB/cCKMhWJcVPohANpNPJKoxlnlul6sAa48AbcmcVs4MdRlIrSAyKp
         cxQmaTJ53jT0FcUbi4dEDZfViOs5lQTk8HXajfOmrs4czjsvaGcGawucZKCcyG/q//gj
         ibIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qJ/ajL0XPBH0mePIQVf+fjWOYAGb/vqwSUqSwxjSc5Y=;
        b=VaOOh+edmx7IJw5YyOqU9GYfjC7ffOdLcxHdjK/eyoeVExk8zm2H30pli1OU0Agz/3
         8mt3wkcvWat1WH4vi7xbH4RqP2cGTkgNkxg6r3ZViWCJ2TUNBlopv+7z4X6JDg7emnby
         XcGqiTOu6rEek5wFnFIiHRJWIx0ZY3jl3TyQq+2oFKgUFTXOBvyf5mOssfdqvgVx+S5b
         iGhpUHMjP/BY3+WKTxAnIfQHgrfTCxkMz6RlzAxzYXCu+IzvbRsUmExfTDhFSwmfYDyz
         LapsBSBBKtMKkFXLN1vgKSVt0US2aQtRSL8cv4QIcZhj7UDO0y8bA88vPNBXjhl5Ss1g
         Jlbg==
X-Gm-Message-State: AOAM5329ffUtzz5wtqmZ47xdQgqKDDEOnthP/hSABB5pF459FJQtCcrz
        sjKO5A6II/7FtQZMms1A8YASmt0mbCYcm66wnty3SQ==
X-Google-Smtp-Source: ABdhPJyb1dxuWcF8p4K/cJ4IiqetxpAiuJwZn0iy4FU1Z3iyrMUiiwU8aFP/XtiUTFCOSjlIanihKFKWkvMaUTaCmfk=
X-Received: by 2002:a17:907:785a:: with SMTP id lb26mr4943268ejc.77.1632986235433;
 Thu, 30 Sep 2021 00:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210920072842.30889-1-brgl@bgdev.pl> <YVTUKgXTUVIFPDFw@kunai>
In-Reply-To: <YVTUKgXTUVIFPDFw@kunai>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Sep 2021 09:17:04 +0200
Message-ID: <CAMRc=Me6=87JMc0=aN4=WQ+mrZKOrwYOvtcunC87pjF2EJeMFg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update my email address
To:     Wolfram Sang <wsa@the-dreams.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:01 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Sep 20, 2021 at 09:28:42AM +0200, Bartosz Golaszewski wrote:
> > My professional situation changes soon. Update my email address.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Shall I take this via I2C?
>

Hi Wolfram!

No need, thanks! I'll send it today with my GPIO PR.

Bart
