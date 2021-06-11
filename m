Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BB3A3DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhFKIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:05:46 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38575 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:05:45 -0400
Received: by mail-pf1-f174.google.com with SMTP id z26so3802600pfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LDgM09avav4+UDwSVPDUyVX9fC/xyLrUq2y0119ifY=;
        b=Of7RsDN1ourkXkFz28xwcBBwlV1LnGpowUbOypEnN88UW0qKKR/izCn53T5Pe2fsDt
         8c6Xnc78l9U0gaY/5qiK4aoiUGpyIPSLL9ahzsOQZMy144kk72cbyH0h2Xds5JDgF9X7
         Ka3K5cefyhEje5M3nc/A+oLjep3mUYCtUz4JSfWdisKkV/7eaN9Ayn6a8TY7JjG6JQDC
         NT/MdYiOFn3sg6RI5uz4Dk41OY1/UggyPTyJOmiXNBhyGyKLS9jAdPzVfevWDDHOTpc8
         wL2BLLbyMGY+eDtyVp+V7MsfE80F8BXz6FD4/sI2Vk6t85m8Au7kQI+G1IxAMAI7uTpZ
         wMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LDgM09avav4+UDwSVPDUyVX9fC/xyLrUq2y0119ifY=;
        b=ZHXkRulex1Zrd98kZBKI/nNG/+/6+PTWBWtgU9i2XKnztnm+e8itM//0Cete4gbtFU
         WgRyMME+Ic+YTOEAOQpy7WtjvC94CEloobCLDSzXttKiYxUmTV+6ZcGW1/82Hb0UYJgm
         7G3iub6iohK58TCs9wS+dH1um/3ZYoPUigz5rqE0Ggx9bHg22CUSGDH8NUeN3QsLKdbf
         OdcEI9XUodOHZv+nWYPVK2p9JiAhmegBaUv7VzWXE9lw4j5ejSGOeKE0hjEG8IC7qc/M
         CZHhryoXAzHf34AnWucRICats5j2sbFEsPuqgEFCrwhmB9pYr6EawI6jJAvoWZdr2QRY
         Gq/A==
X-Gm-Message-State: AOAM531L7UDdqWTasTAXl2sbIuNEpQ3/2KQi2mg7fCkDmBAxdudS2RTb
        zKtoIPPLuQSWNtw3ywU/Sq9XBO2ouI0IP5Xxma8=
X-Google-Smtp-Source: ABdhPJyAP1EOOe0XVRG3PTziDRyDgGTKy70ZbehSrcsxTYHwNjw2qfVgXaMG72JoOKjejU5VA1IL+YbsJONWGJNkQBs=
X-Received: by 2002:a63:b00d:: with SMTP id h13mr216243pgf.74.1623398553804;
 Fri, 11 Jun 2021 01:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210611071241.16728-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210611071241.16728-1-thunder.leizhen@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 11:02:17 +0300
Message-ID: <CAHp75Vdpgpa=TDt5RgG2Eq_+iLZrRSj9XqB97y01SxhdKUYYgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] scripts/spelling.txt: add some spelling pairs and reorder
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Add spelling_sanitizer.sh and use it to reorder, then add some spelling
> "mistake||correction" pairs.

The sorting idea is good, but the order is not.
What you really need is to use language corpus [1] instead. So in such
case you will eliminate false positives (to some extent).

[1]: https://en.wikipedia.org/wiki/Corpus_of_Contemporary_American_English

-- 
With Best Regards,
Andy Shevchenko
