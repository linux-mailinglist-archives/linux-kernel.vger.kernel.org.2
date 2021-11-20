Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A127457DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 12:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhKTLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 06:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhKTLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 06:52:23 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F8C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 03:48:49 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so20940056otk.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7G6QcmEBO/4QvVoA6Ewcl2g2FfnDVaOiHxvOLRJdhE=;
        b=W6AtvQrc60Zk2yIWCuynOG6WiJbcMZdvyYToENTnkU3jiLhWDr+IDiwCnyebto1mZh
         G3GIuDNr9JgukT9owzZPS8xTzRPjEItpf+nVC+l7zAOz8Gxgv1tl2wH5C4iPzaFGPX9i
         Ga9mCjDju440xEnyGYdAAA8yMJ94ByXiZoYRi4BCLpzjltQQgMEjj6T+U8srpM+0OF8D
         VuwhhKePhiOknIhskdaafqA54GYgqaVeyGrCnAoIQn4D7vJZSQQi4MnTPBuyMpcEJWlo
         iGNfqgSiW2lmo6587N3Xya12AHn9DiIo35dXtnNnGEQe9m4eqYZU4ZgXsoSXwG63r4pX
         q0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7G6QcmEBO/4QvVoA6Ewcl2g2FfnDVaOiHxvOLRJdhE=;
        b=7GbNChT0RtJx0sB9Fe+kLo7XsiEGXj+BkNWipsLXbpMPK/8NwsPpcfvJ3wxbeGUdt9
         NwFz3l/zOvihklU2cNPbZSN3b0yqSzft5R69pIGq09lOXXdQgCnEc5PlxYu/A2pOLaBd
         zteh5zOkX4nGwPKIyS/LAuGhIEx8hOkL4TVt2QOXAFyM+jLolw9f7Ro/r3YetzaQOSzQ
         YkTsNgaBkikDavUgfeygFjvwAfJxdnm4bxsT44PquaqS9PIs1MZkcqE1veCJG3xqVALa
         FbAgxOw4xL0Ul/TMFFXhXTOl3EgxNW2nWWoVvUhNxjmPbfDU3kWVDYN3Uxg2We6E/QJ2
         64Eg==
X-Gm-Message-State: AOAM531IUDZ61mWcvSkfTPT1aoriMH5Q27MLExvMzPZx4JRbTxpG/iyt
        qJ1J6Iy8AWhprxv0Hga9OSmvxqMq0zOLZL5vnLW/ZfKooOU=
X-Google-Smtp-Source: ABdhPJw966guRO0zl7dus0LA76BJpT77ax03oHV1BIU93Hpr2+ZCLJuLo1QLMSj2nihDJfGDWdDGfl1w2ZOsUbqkS0o=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr11323428otg.179.1637408928971;
 Sat, 20 Nov 2021 03:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20211120062719.21395-1-rdunlap@infradead.org>
In-Reply-To: <20211120062719.21395-1-rdunlap@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Nov 2021 12:48:37 +0100
Message-ID: <CACRpkdbcQc=gEeZiM65tauNMZpw5BhLQY6Ez5F=WvbKmfL4xTg@mail.gmail.com>
Subject: Re: [PATCH] clk: Gemini: fix struct name in kernel-doc
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 7:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix a typo in the struct name in the kernel-doc notation so that
> kernel-doc won't complain about it.
>
> Fixes this warning:
>
> drivers/clk/clk-gemini.c:64: warning: expecting prototype for struct gemini_data_data. Prototype was for struct gemini_gate_data instead
>
> Fixes: 846423f96721 ("clk: Add Gemini SoC clock controller")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: linux-clk@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
