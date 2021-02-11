Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6931878F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhBKJ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBKJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:52:23 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E23C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:50:25 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f14so9064915ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7GSnrM7B6crv8pKwIgz6vsLju5oSgUNsyvhwhxtSk0=;
        b=AFqOYKAiQVjfJdddLl3PUYgeUj/DPJbKc+Ks6t7ycM1u3h3esGS8bu+Sb3NNunfKCU
         60quMh3VjgLP/84CnylNGhuEk3SoeQGuE/rAEV56MOfKUc2cYpZVarp5iS/CLaTK0Zib
         2BNXleo2gLc16cMWOdBMmOPUC08pK57eqs19KVIBQCI/MIt7FlopElXB5PVgzd1Jk2BO
         NEcpTxeCT7p/RTt7qcqMkUkfFoq38ypovqbFUrixv3k5FcFLPcmLGhCyy7YZfOAwALzd
         LOm8RJfeasr1tUtO+DHp2B/BTzs69shTTNQWVJ3oxL0fnkqJHQLs3i2gUQ0BIZH2uQAo
         6FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7GSnrM7B6crv8pKwIgz6vsLju5oSgUNsyvhwhxtSk0=;
        b=mPM96WykJMwzMw5y4gCDZCLJ57FkJn04LD5t1DeUZYGGJq4PPN71Gt1StW1O8YQFMW
         c0F+JiVe03jCztcdKuNDmhTP9L2xUIXMzRsZP4iYqYVvqSz5Y84mn0T/O85ntRaQ2Lf6
         B76RVfBu9GaJqCE2RwzKxVszRrcxiOdP+fL2g3hVsyDzx+WRqiHm/9PYomSR3za7lzw5
         nP4QI7f9xxpEWHImFLpI8XMLd1Da9R/TsNpHqgf3/RGtVFwzl9eFcMwLmefGiIDV4bIc
         TYm+8mSOZWZETo+BgvdEtb/ajOqLQ/oMGc0jnZ+J6L0pTKZkO08lGq9Lzo1/mVW4RRHB
         p/zg==
X-Gm-Message-State: AOAM531HynpV6IxseWR1ziNEpHlucfg1Av+PZMLJALVqFvoDpydGK/yh
        zYwdvig842R9q5mF6DLHWlYvRjHsIaIOYFieRhhpEg==
X-Google-Smtp-Source: ABdhPJzqkkQOSYy6alf0j16Q93rb52p9AEJKYyTDVXr843L8/xeXbztnPxJKzF6gVpV2miPa62v4zOn5yQABP5xncsM=
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr7497164ejw.470.1613037023687;
 Thu, 11 Feb 2021 01:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20210210230800.30291-1-sakari.ailus@linux.intel.com> <20210210230800.30291-8-sakari.ailus@linux.intel.com>
In-Reply-To: <20210210230800.30291-8-sakari.ailus@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 11 Feb 2021 10:50:13 +0100
Message-ID: <CAMpxmJVfn034_4NxbhT3xh60vC9HCZpF7fCF4CGJ7-OiC7A6uw@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] at24: Support probing while in non-zero ACPI D state
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:08 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> In certain use cases (where the chip is part of a camera module, and the
> camera module is wired together with a camera privacy LED), powering on
> the device during probe is undesirable. Add support for the at24 to
> execute probe while being in ACPI D state other than 0 (which means fully
> powered on).
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---

I like this much better now, thanks!

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
