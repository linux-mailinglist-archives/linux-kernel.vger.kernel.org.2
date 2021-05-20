Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59B38B3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhETQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhETQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:01:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F62C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:00:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 131so20390296ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fibiLYNzCSxzKlD/xDOC0kJ8IUe2xcxUsRVvcqtb5Bg=;
        b=XcMbHeaMyOr2NMd9nIssNN0jXKAFLyhnPJsMXHxNQkL/kEGlHAupO8YnLCpXxV/U3w
         qeC+GRSBYzd7C1Z2nlheBF6qlRS3LNSfqG4QLRiSEsMiF6wnXXRI6JYQPU8XH8NAu5dO
         nca8j7nK51v8x9XGTvsgRNsGgUPITDi3yVairw3Rqnt+Lb/ImVjSYgh7FoJkHivPt4XJ
         T+dRm0ekLqZ38rj9S4RtC/rz70VcmAMBd19kiPZKoJg5FX/BWeeHhIDDWLkzawYzDt1g
         gvJsjYTLdrabR5BGDy9oruoqj4D1E8I5pcS/CN2UcLZf+MqF6EQ3dTndpbLUqsJwQEzw
         jSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fibiLYNzCSxzKlD/xDOC0kJ8IUe2xcxUsRVvcqtb5Bg=;
        b=Z+2etkj29mZ2/n1wv3ubQMPLzpVNnLPkFL1OXrE6Fty1lRV2lCKDQFUH+zl9Fz6nIA
         g6Mf6FdUFMq8wv56qrJaah64ClyVHrsJF1W4EAPRxc4CkYlOL7BZrhJVWccT6I+tl6EY
         2pSAkUeZrcJKsmm4/lZSJW6QUyFR3ZZmcLW+D8kSydd+cSevuqC4SokZInajIPoT6F7k
         4qFv8S6Qep5EsOzjUtqF6ppmywA1rqYkATne4NaBlzzzOD1pZgOixW6J0OxoVwwc6oGl
         16agsBqdesh+imKrFy80HeuWrRMMeNND8fxdSrhnZffw6l88SqymQMcjcbNYM8BS8DSV
         Mrmg==
X-Gm-Message-State: AOAM532N+TFBS4/h7lcCVNIajUXQTlm8ZU/w3oi6zNnCglPbDIiy8LQa
        3HXRJGiApe/81WQJy26jqF4nIyVG5O2MPW5geG4Bl94H/Nk=
X-Google-Smtp-Source: ABdhPJxoQUYkYcVt6hLw7Lie95F5BPvQm3ceeDtHxM7FkF1cOFQylU2pJdQ+DMx5IapJpFCRxNF3Kdx1mzACi+ONFUE=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr3458982ljt.200.1621526415562;
 Thu, 20 May 2021 09:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210520114851.1274609-1-clabbe@baylibre.com> <20210520114851.1274609-2-clabbe@baylibre.com>
 <CACRpkda6ou1SJZzBwHXN_kWofnFw8w7XAkr7VcFO2NrqbQug_Q@mail.gmail.com> <20210520173619.26870bc8@xps13>
In-Reply-To: <20210520173619.26870bc8@xps13>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 18:00:04 +0200
Message-ID: <CACRpkdZhhNQupN_4Oh759bKL7sEM9M=yOW1y-mT69ugEkjRMZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: partitions: redboot: fix style issues
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 5:36 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Linus Walleij <linus.walleij@linaro.org> wrote on Thu, 20 May 2021
> 17:24:26 +0200:
> > On Thu, May 20, 2021 at 1:49 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> >
> > > This patch fixes easy checkpatch issues.
> > >
> > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > (...)
> > > -    uint32_t     flash_base;    // Address within FLASH of image
> > (...)
> > > +       u32       flash_base;    // Address within FLASH of image
> >
> > Does checkpatch complain about this? At one point the MTD maintainer
> > disliked the u32/u16/u8 types and explicitly wanted to use the C
> > standard library types, and it's the kind of eccentric maintainer
> > deviations we accommodate for.
>
> I suppose this happened quite some time ago? :)
>
> I've never heard Richard nor Boris complaining about it, nor will I.

Yes that was a specific David Woodhouse preference.
I'm too old!

Yours,
Linus Walleij
