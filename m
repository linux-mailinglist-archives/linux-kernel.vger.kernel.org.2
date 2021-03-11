Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD5337576
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhCKOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhCKOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:23:04 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:23:03 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id v123so10755687vsv.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2lmq7UN+PmMWLB8VNTF2xiPvPnbMeNnR+7xE2jeGyE=;
        b=P+awflMVOwasBIyDbsiIehZrlVRtgMnKvsfLI+odsvbZ3p4nBkLMEQYjkmF0kaH1gY
         q/R07ji3S99brIXbrzbw95i7oI8um638380kUdpsS/DfAA1hFQPPLAw4ZJjszeB2/hUv
         z1zUja6G21eGC6NoiRK1/r8lN/8mrhNd8MetxC2Jl8MjjT8vM3SEurWxriBziKcHC6fo
         oBg1kPRUPXAj0DZ4eK3G4GcR/fCV88+oV8tnjqHY8M3LpHXpOVfQnd/Z2V8UYSne7gM5
         ZxFWC3D+SUKW97YXRWheW0/Z+M1hqVYyanjLJGBbwd5/HBMSzRoLeCAXBVqBkUqpCezr
         p2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2lmq7UN+PmMWLB8VNTF2xiPvPnbMeNnR+7xE2jeGyE=;
        b=ZLKxhF+uomodMliK49p0ze+dnDJVY7M61nylC4z0z4C4Gq2ZEn3pP4LyOOtFjfd0Jf
         dWZOmb3A22ole64ZQqitumIZ1FLeOq8+zE4qoHa3THiTRz5UxfSWlLl7TueKFYbJ6OHW
         jheF/Bi3t0DEdjSVY/p4vaeWTAdwLzs/7qLDhOatJT4M8NxvkaQ1QIU4u6jC0HY7fcu/
         xib5cY+HiXWnAWiR2ckMQpYoJolvR2O3h5MJ3YuxrgsFZi+nyiU5LKfWVZW0eCY/EteZ
         Wgc+Sg62ZF8jlOgave7pho2RGJsAd9Zmo281NUXtclV65ZkwjGfOWe47otvkcyxBQPNw
         5Xuw==
X-Gm-Message-State: AOAM530Sot/1pclMHz0ZqXouyKU24S+iBz+UidZAzuc0dkD8l7elo2ws
        C03lb/sP1wMJ1mj/6Rz/yYFyGTSiF3JsyvvbObzHROdJa+zYZRtZ
X-Google-Smtp-Source: ABdhPJxeiBueEjaeexTTaSOAXg92u30nvIqQYongr8i8pEDGjPA+ZvgECpnBFDRtv5j1Q0sn12lxiVjYZ8QQhlNljBs=
X-Received: by 2002:a67:f68c:: with SMTP id n12mr5390998vso.42.1615472582853;
 Thu, 11 Mar 2021 06:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20210310081516.27b949e0@canb.auug.org.au>
In-Reply-To: <20210310081516.27b949e0@canb.auug.org.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 15:22:26 +0100
Message-ID: <CAPDyKFobBbHra3KH6B+jg1d2=zp0xFZebRKWh68YMpR5Q3PXwg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the mmc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 at 22:15, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   a7856f326331 ("mmc: dw_mmc: simplify optional reset handling")
>
> is missing a Signed-off-by from its committer.

Taken care of, thanks for reporting!

>
> --
> Cheers,
> Stephen Rothwell

Kind regards
Uffe
