Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E250236761C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbhDVAPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhDVAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:15:00 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144EC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:14:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u4so49748125ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqBWFt0vOYLAlBSeNw4pwzZTNa8z4I8AqEIVQWUKndU=;
        b=j4gOvLsSbJYxaKmmCewZI96c/Z9TLLOVjaGaeP/bJ2GwwdG7YtRGZ2i8Fy6XSDxtQp
         YtDOl97Ytw+Ce0BSJp50NK6hTW510ISi7XCY4JQz4D/DlW3UUFpGSjeZZlGsjTX36KoN
         iJriHneHlhp0uvJepBiLtrHlzIJk7yNKgnByqTFyUBZkWBfsjoD/7FHQFQfOI8Ets27N
         3j3MTxmftvD1CMIAHAREWEmSamxI1LkcaR21mxDUf4qsWeH4fUQT9mvOorI2Kwzum+RP
         pkA9WXAsqRb0yBMLJE0ZEIpbDZ2GAFhlOaX8SY90+M+5mR/weOhqwLVzB1fNqvt8IuIj
         995g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqBWFt0vOYLAlBSeNw4pwzZTNa8z4I8AqEIVQWUKndU=;
        b=Vzrn2OPCyW0G1VsgcwoF4Pu+CqIsYNSHuAlrTllcBKpMizB0eu8rbyiAek6e0ye8dw
         Hbu76niksDwLHkmf78y4Amh9zqt+XPTXWeoWTnzJef5udUzjOTOX8GdukYCKL1Je5lDx
         SYZHDuDrQrbCekQtaG04THfyCl7RPNeiQFub7Cxi7dttzHFYUc/kdUpU0KFtcquxQnip
         fJRV8cWyJ2I3QTrTZD9pWcB1XGJRaS7MT5C5u+p6F9iBNGk9hoYfHA6dUTSi3yEBBOWX
         pop9YnXWXDmdyQ9ij07cvb7upm/u/I5aWv6uIhdwiTueMRhIZCYgbT03BB4+VQno6Tlo
         Q4AQ==
X-Gm-Message-State: AOAM531cnutoVOdwO0PliAUETuVrEmTshqAxcAxBB4QteWcnxDe99/Ui
        PYffnMyg2LShFKcTcoVbSpMcOq4olCThMueGkP2/Mw==
X-Google-Smtp-Source: ABdhPJxvMDh6ml1vcci6TIsPbcmBQqPQhXN3xbBpqYsArOlZgd3W5GtI827RPnotHNLZ5JDAsjTeTzhlzNJemryJsOA=
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr562244ljp.368.1619050463537;
 Wed, 21 Apr 2021 17:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210415130356.15885-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210415130356.15885-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 02:14:12 +0200
Message-ID: <CACRpkdZTLnL1buOzH=atbCYpi2G0EpkYvnQCM8RJGacOm4TJZg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: core: Show pin numbers for the
 controllers with base = 0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 3:05 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The commit f1b206cf7c57 ("pinctrl: core: print gpio in pins debugfs file")
> enabled GPIO pin number and label in debugfs for pin controller. However,
> it limited that feature to the chips where base is positive number. This,
> in particular, excluded chips where base is 0 for the historical or backward
> compatibility reasons. Refactor the code to include the latter as well.
>
> Fixes: f1b206cf7c57 ("pinctrl: core: print gpio in pins debugfs file")
> Cc: Drew Fustini <drew@beagleboard.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied for fixes!

Yours,
Linus Walleij
