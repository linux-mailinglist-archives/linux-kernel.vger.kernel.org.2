Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08572409E04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbhIMURM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242914AbhIMURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:17:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA9C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:15:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i7so7439992lfr.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoWCjgCD64bkl6Rl+nektnSUWvwg8toSzdX9vNtNqOY=;
        b=NWtyu5HjELRthReuCBEZBKC/XHkat6LXkh/bLYeAtKdT1tGGvRmEk7O77/dovde6RT
         GiOmCwq924I5k7N6IaTYQ+IWhTxOdZjoeyfHUhXEiow+Lclsw+ETyhT80y6QtI72EuLx
         m4/CbCLJMTxQ6V85ClhpmTzWBEyzSAB+V0hNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoWCjgCD64bkl6Rl+nektnSUWvwg8toSzdX9vNtNqOY=;
        b=dxlqhs+FIHw+eW+LKPbXvYJ+GEmQ0np1U4y4TR5H1cmvm7P1diCKWf8nWAwwmpNvtk
         OY6Ur0RkJhrd/dawnU62F7M6EjAUZDMEfw65mGZhh7IrKZNJ1W9GROjP8WQzzQ7IBPoS
         A2NGuBE8spwvuLqtZcJjmXotsZH1vsK0Qs5YJe6l1NboGEpfss4BJYIZZi2FCgTEcoC0
         IEP5blj74vo/BF/wtpu6ujB/mG4ngsBFndqrwNtgnnxpAe/vrhh0TIjpY0Y2mMNQdhYS
         jQWNIcksOezgrg9vYxAdFhpQSRRGud0FYxgla91M5SI5riEfnl9YMy4qe3tjqfDF6oDS
         Pbcw==
X-Gm-Message-State: AOAM5310a8mG2wYU58NMWtrWL+ol0QklD4qlbF4wUqDalIshH6pT4NCH
        c7UmctW0Yqmlji6Rx9O21k+aneh2mTBCpecBDBE=
X-Google-Smtp-Source: ABdhPJwXlXXD6hymhXC9gTtb6N+DV2Lv2Ph9j7G+YW/4WghPUBGjvX5SXdL3v3IT+WEkUBuutnH4Qw==
X-Received: by 2002:ac2:4e0d:: with SMTP id e13mr10020285lfr.244.1631564153023;
        Mon, 13 Sep 2021 13:15:53 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id e24sm923978lfs.212.2021.09.13.13.15.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:15:52 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q21so19476257ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:15:52 -0700 (PDT)
X-Received: by 2002:a2e:1542:: with SMTP id 2mr12255814ljv.249.1631564151997;
 Mon, 13 Sep 2021 13:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk> <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <CAHk-=wgUJe9rsM5kbmq7jLZc2E6N6XhYaeW9-zJgWaDC-wDiuw@mail.gmail.com> <18e101d9-f94c-1122-1436-dc3069429710@gmail.com>
In-Reply-To: <18e101d9-f94c-1122-1436-dc3069429710@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 13:15:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUTGWz9GL8Y126rkvTK-aGHoe8a3R3t70boJDUAH_n4g@mail.gmail.com>
Message-ID: <CAHk-=wiUTGWz9GL8Y126rkvTK-aGHoe8a3R3t70boJDUAH_n4g@mail.gmail.com>
Subject: Re: Linux 5.15-rc1
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:11 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> No. The timeout is not the issue, otherwise you would see the message
> "VPD access failed.."  over and over again.

Ahh, I did check that that error did exist, but you're right, it's not
there all the time.

> The issue here seems to be
> that this call in PCI config space access to adress
> vpd->cap + PCI_VPD_ADDR stalls.

Ok. Regardless, we shouldn't do this since the boot code shouldn't
need any of the VPD information.

        Linus
