Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6757349A44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCYT30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCYT24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:28:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D64C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:28:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v15so4189406lfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6IpCqk7ZVsSsT8AX4jBcdjphM88rT8TJumIWs6YRKs=;
        b=Nt4d9eut9Cvol4g91u4UC29pqLSJLo517jT8sGdWBNi9cfmLv8H7lSVz0jAIxlx46o
         sWrEHaEuJgr8UXD/gw6TpAB/m7mbZzDbLHBwxJccWjUff/eabBobuj19N6PkeGJEW3iS
         N0Vg+Fha6fYRxjkiuXAOSrrWRgmE0NooIQMnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6IpCqk7ZVsSsT8AX4jBcdjphM88rT8TJumIWs6YRKs=;
        b=C0BG1OdnYA95fZpsGlMGUYtDhkVUSmZeS6Av4yFCO8F51J6sbLsErETGaBT5txo8UP
         pMwbpdHf+1MsLnpoQ9ULbXhpzxiP2UmQsS05iCSwX4/5b7wCj0VGELGENvtm8G4kZT8K
         l3TFaMz2wFQQySfZ0c5Mb2YYoC71rRTImEHQ63q3P4zmqr96Ax1OS0LxG6LzveTPIMM0
         74Mztipg6X9VmvRS837j/0FU6pY0p2XZQ61Nh1Qq2A9IRvC3gTPXyHA6wRwwhJ4mV+0f
         XRKfuKJNRUY7wX7zZnlAMTb/YZPdXBTUGYE71ebcPDjAjBAByyfrp+SMHbbJkaZ0n/J6
         mLTw==
X-Gm-Message-State: AOAM532Nbw9NlZCmd1hzFcxwLmJCbNT2Ihvxw8IOdWvSUwugmrlZtoct
        2m3FJ369395HGLhx6pZi0idOAZDXqz8tnA==
X-Google-Smtp-Source: ABdhPJxhNwtGfcD/dgM80ddo1MzGgzWw8r8I4SRs5/+/MJ+UCT5baztyX1v6ydYoBV4MuaRHk/J+Ug==
X-Received: by 2002:a19:e08:: with SMTP id 8mr5579967lfo.199.1616700533069;
        Thu, 25 Mar 2021 12:28:53 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id r15sm874805ljj.88.2021.03.25.12.28.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 12:28:52 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id m12so4164674lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:28:52 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr5643296lfv.421.1616700532278;
 Thu, 25 Mar 2021 12:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210325192347.67326-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210325192347.67326-1-andriy.shevchenko@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Mar 2021 12:28:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDQ_YFwXi2aC5r=mswSdkERxX0kQ=D-c_pFawSoQJ96Q@mail.gmail.com>
Message-ID: <CAHk-=whDQ_YFwXi2aC5r=mswSdkERxX0kQ=D-c_pFawSoQJ96Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace cell parameter by bar and assign local pointer res to the
> respective non-const place holder in the intel_quark_i2c_setup()
> and intel_quark_gpio_setup().

Thanks. I assume/hope this got tested on hardware too? It looks
ObviouslyCorrect(tm), but that's never stopped bugs before ;)

             Linus
