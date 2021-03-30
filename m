Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC0634DE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhC3CVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhC3CV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:21:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863E5C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:21:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j3so16319998edp.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+I2LTRrSaD2dqgTJnFDZlqBmSmIDK6EKGUUsBab+3o=;
        b=HLDo2eGRdzM47z7enXblhtI2tqUN4TtD8jk6QPQhFJKesQjp3M7yYrPupBoBSkpP1X
         aO2fEd87vwh83DTc8THjJR9QwqvjUyOIc57BV7Aav/5g1QkWdU4hgGnvHj2zRJFl/bdp
         Bdr/qyZCVkg3XRxhKZVK/UYOeK0/uqNcaeAPt9V4K2ljVwjNZ17Vcqb+UWJjAmF3ORin
         a8KzeHayQhJre0vyCwjuOdDUaRRT/kwqiA34YyR8QazWrpn6fc8uM8TJeMKbaZ6JXCrH
         rPeQZOK3tvFtPQaSBC+TDf8I9mWthsWo+wu22aXM77ViuY8tdH6/k3dNCEc69fxgVunX
         xmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+I2LTRrSaD2dqgTJnFDZlqBmSmIDK6EKGUUsBab+3o=;
        b=ug8+cV6cs23RCnrdJayAMb5XI7/hJ/nNrTW/VykMsQT6a6Me/YctKkAYfyPAPX0+S0
         dHNE/P4DQmmXOsREhlMiSpFUMI+m+RAvLDPNVHHuzgU9SAyanYhdY3DQ41RvS8fonJAv
         M/EODHlI6JT/0WiaSEESNeHZzKyX8J/eJdzz3TVPC3UL+xq21o6ZMnXYZPYJjB86F0lg
         domU4x0bi3PvjSx2c7ZTdhTXTREHd8WdQwALGZHgULa8ZUZHx47MoFhqcW9eZVfg8d1+
         FS874xJxHMO1Y8qRkxmaoALynKgwFfBRGTJ16MPXzrfgx9/d7Vje+PHo74HD0fkN7BBM
         rBag==
X-Gm-Message-State: AOAM5308w/r2YhVlwlGjPXY1G2ICZa+l9/pKepizNL7E/M9yTFpKbma4
        1cPjPTDv4F0o+ZiUxAD4Y4TqG0b5eWj5RnGCr41mPA==
X-Google-Smtp-Source: ABdhPJxfqm7YZC2568oVlgVk1D9T7OgNKLSW4S2O8WC4BB56ERwwox1eQbRb3WV8Yh2HTJvLiho2iJMRUKdDm0c9BLs=
X-Received: by 2002:aa7:c3c1:: with SMTP id l1mr31986991edr.208.1617070885249;
 Mon, 29 Mar 2021 19:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-14-brad@pensando.io>
 <CACRpkda78p=aU5xfT+HtC9OCkZdkVEiN64F1jck2FDJB02C+Rg@mail.gmail.com>
In-Reply-To: <CACRpkda78p=aU5xfT+HtC9OCkZdkVEiN64F1jck2FDJB02C+Rg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 19:21:14 -0700
Message-ID: <CAK9rFnx+xcbp8hL0Euw4gdZL8_JV8i02S=_VJQ+qct5fn0dg-w@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] gpio: Use linux/gpio/driver.h
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 6:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Mar 29, 2021 at 4:00 AM Brad Larson <brad@pensando.io> wrote:
>
> > New drivers should include <linux/gpio/driver.h> instead
> > of legacy <linux/gpio.h>.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
>
> Fold into patch 1 as indicated by Greg.
>
> Yours,
> Linus Walleij

Yes, thanks for the quick review.
