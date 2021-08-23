Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4D3F42EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhHWBT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhHWBTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:19:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6CC06175F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:18:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s25so10976749edw.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+kfGuYJ8kZbfJ32DtNmBT+Sr+vpT6zetv/qActXZdI=;
        b=hrqz9valZsjGhJQOi9WV3auA8ydNJKqsUJ3Xa3QTWctog2cQGlOuEGuiIk+cBMo9Pl
         aLb9T7FlSmBOWBX6uLfFTFSjtJTn/6mJ/BIQcxMIHRhrMD32tJPZSxPaLxlb9xjHIZcN
         QLtvRt6ru7gkBHpleevmAPnlwlr6ssRHiYxQUctfjmHewVlw94tmixu2kmumFOodUvqy
         mzqY9+j36G2wSOIgXv2k6EsCbo/+yH/3y3cTZX2Ms6mnA2SRavm0YcKQw8zNYHBFpujn
         0n6y13rgAUqN36gQLtc0pvXCeJSOhACXo/k11haQnF7h4hDPvKJqpyDjBiIV7C6RloCK
         Mvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+kfGuYJ8kZbfJ32DtNmBT+Sr+vpT6zetv/qActXZdI=;
        b=KhomvptEneshmO/j4FMNLq1dtNfBb7b2v9YpEJGFBj+gWSXrledZ46XR50mRN7eC4v
         Rf4zCGNLO5aDUyYjrQky62e5ZicS+I9W5tdMq+oPknEouKaxipQoxq2btW0T0meP+uxQ
         oQhoXakREaNIqYwLY/mkiVA288gFK7HIhc3O+Nt326B/zW8ou7X2Eu6J7Au6r1eVdQKP
         JZFnJ/mNDsD1WHyosmPBeiTfA7p50diP8y/2WW+9brwLMKiLxMZzYnE7G3Ucx8D6h7h/
         aYO+TIak6ealQXLm7RtxXJJGnkyKhFk8sbStQ8ZSm2fpIx4x2/MGFGpIaF3wSsQAhOvb
         yLHQ==
X-Gm-Message-State: AOAM531aOb2J0nx4F0tZkP7+8K2QUFKir08x09YBdDXJ9admbk//Yp2y
        JqXCYhdy5BM+HbhKlOaigEfqiZnStN+3iLkMcbuwLg==
X-Google-Smtp-Source: ABdhPJyJV6zUoSxubmkxoBdH9Bzy3lUQF56HTECmqykuQheUTVsbLzn8LuQjYHAJsvldatW2wzO2hNCIGcCgqCkRTdM=
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr34987598edb.268.1629681520325;
 Sun, 22 Aug 2021 18:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210331161738.rc6oecz25z6ywqhl@mobilestation>
In-Reply-To: <20210331161738.rc6oecz25z6ywqhl@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:18:29 -0700
Message-ID: <CAK9rFnxrY7XGJ6QAxH0Wx7X9dQ_9RYe8uapgpRs6LWBBrE=ufA@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Support Pensando Elba SoC
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Wed, Mar 31, 2021 at 9:17 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hi Brad
>
> On Sun, Mar 28, 2021 at 06:59:25PM -0700, Brad Larson wrote:
> > This series enables support for Pensando Elba SoC based platforms.
> > The Elba SoC has the following features:
[...]
> > See below for an overview of changes since v1.
> >
> > == Patch overview ==
> >
> > - 01    Fix typo, return code value and log message.
> > - 03    Remove else clause, intrinsic DW chip-select is never used.
> > - 08-11 Split out dts and bindings to sub-patches
> > - 10    Converted existing cadence-quadspi.txt to YAML schema
> > - 13    New driver should use <linux/gpio/driver.h>
>
> That would be super-useful if each changelog entry was also added to the
> individual patches below "---" splitter.

I'll do that for the v3 patchset once the discussions are resolved.

Regards,
Brad
