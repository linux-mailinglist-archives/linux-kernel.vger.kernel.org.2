Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEDD39C340
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFDWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFDWIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:08:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3ADC061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 15:06:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f11so16165540lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nz4QFsqdAR6oQ/HCwfJe4SCa4/szCk48V9kJk5ytCmc=;
        b=rVPkfpEYsd3PtiJwoC1FpgyVlpyPZAsMpOZw7BUHvdDoHjIrlNPDtTVGCPhlvmHyKi
         OmGj1HeftCbZ/LPidGrbzn6w/bLg3Rue2MGIDbH2qSIUkdMJ+Do+CelYGM1tHKoyx8YE
         4LqPri2R5aikfT1YwfJDWwnv0Jpxh09jKkC69jNQL3kPdp+MEVWuyfaXvREYFDStgBZM
         vqExRr/yeJ5iFy+JsbYIeMycwxHEupdbcsOpR9P0mNw27a0U2u15Phhkf3aC0vQB3TtQ
         g08npX9O1UPEmqz+7A67EjG2chfs4a40yYB8p/J9QWSMAA6n9h9wFQ/N4gXAVWdvTq4Q
         Lufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nz4QFsqdAR6oQ/HCwfJe4SCa4/szCk48V9kJk5ytCmc=;
        b=HiwWSO/6PdR9iN8Sto+0kvc2VWk3TwGho3jNyBHtcf1dRZUwAm5r5df4ZwMEABIP/J
         EB4+xt/O/+RfAXaN/lS7QEyHmEAO7fTxdKnOY0O1cpwrR5N9718ScnDxh3nKdFwdW1x5
         Ahy1SNNC3ONmkZGCyS/TCVCthObvoEUQMoVZc4S7o4HlnD7jNIDU2+LjgFOm6Sm+7XsS
         dvZpOoxc8WmgJ8l7i146fCwImnXklLflpY/Hpj3TXWZZcXY1LSXcqPqt1i5KOmjv4Xv0
         jkGsRIfBk4wplD2ScIuzyRp9i7pVfrIqODKrVvYaSCCfyrfeYZm1fAY8cbBMaWkDM9LH
         LTLQ==
X-Gm-Message-State: AOAM532tt0/sjrjaMnef4IJPizDSlDtszMWp+nV3V+PWOYjAzTRJmU3P
        0DO7N9IegFzkSWtc7J8MpxB7Qjtof+W2IV+Kd8aktw==
X-Google-Smtp-Source: ABdhPJxZuBCUE4c68IteCQbT8/iSI2k40U6RnJYDv4rh2zLmaSiwfgAV+B6e5L7GtAIzreUlQVR3wa+LH8Bgt0KKO/E=
X-Received: by 2002:a19:f616:: with SMTP id x22mr3980083lfe.291.1622844404733;
 Fri, 04 Jun 2021 15:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210604185013.86662-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210604185013.86662-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Jun 2021 00:06:33 +0200
Message-ID: <CACRpkdb-fkWUjUXAdta94qjnYt24+e+LD_ARJKPsEeYgjMZQ8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio-dwapb: Drop unused headers and sort the rest
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 8:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Drop unused headers and drop the rest.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
