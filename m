Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00C377FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhEJJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhEJJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:45:52 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B94C061761
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:44:47 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id x9so5027611uao.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rEPEMkDJ95/FEpu1ZRMcuPYaf30wKnn+hqKQvejaMQ=;
        b=OoG66rN3+QleL/aze1/iCDcqvMqGnPJBDZp7xQOkIbZcg4L5UdE7mUhVcgOTDlBD+S
         uVmzQDx7r2pdJ9peqNu11kWstwPMQNm2fQ8Oreibu/hiPGzuaODR4KD4rQJwLNRK7hpJ
         PZ0Ze+BqRPMDdovYluCZW3hBnT41Vb3PImOGW2gyyS8Za6+VqDxeJoa9mZqdR24Phvru
         PpZm4KGq1dP4LZkBKK+PkGd4Erjs3kVbz+6MYCUC592sIL27yVnBBVNKKfJyv7WIfzLB
         2hOwrXXOOsuC0E5wqu/K5cGw7t/MkXqgl/2qMc/EfdoD+Wm7mnUZb4AQpErzlLXftWCR
         3FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rEPEMkDJ95/FEpu1ZRMcuPYaf30wKnn+hqKQvejaMQ=;
        b=fsmykSXC0QRZ78svJnWtYYmBrBWJgH0ots6CZ6SGBXCCpfpqAImwd6YnDBIWAvThPn
         V34pgG2+5w4SVt7BAwEciDOSV4oW2XAtvtWuI0JnF5PB3XEohGtl37lf66Vngi3VniTj
         MXVXZzW3GEROAni1/5pdqJ2gm9WV9i1LajdvVni6N7CARbaohidzfpxL2uJD33nCw9lR
         xS4qVDroS9lY0lwX0eE/94Tg6+aTmPlmKEh9GWILZ9P1k7iOZSQGFlUuDTva2K504dv1
         VRW5I8Rxkbeb6TIX0IifPVtWQKlx1eSYggfu5ImmPHW3cZ0/5qntI/nPIlepUw7hA892
         DQIA==
X-Gm-Message-State: AOAM531knzRJThtG3YfIojTW4elNVpxOmOYIo6tArPgOunEpeSlApWCj
        EzbmUuMN9RAzITofUs2iCF9GqZn3XVOL0Ek4EcdOcA==
X-Google-Smtp-Source: ABdhPJwOKJnss0sPhuipimi5yGGczAkCy/WjIhtbRAGDnzNs/Aj5YwuVeGIT25TK+KLrXoXDm139iodfuhY5syawILA=
X-Received: by 2002:a9f:35b3:: with SMTP id t48mr499011uad.129.1620639886549;
 Mon, 10 May 2021 02:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org> <DM6PR04MB657511CDCE94264D080F006CFC549@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657511CDCE94264D080F006CFC549@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 11:44:10 +0200
Message-ID: <CAPDyKFqQe5aYqF6iNppY66EfkVNPce_sRF6NJgSn26Rs=_=jxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD cards
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 at 09:40, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > In the SD spec v6.x the SD function extension registers for performance
> > enhancements were introduced. As a part of this an optional internal cache
> > on
> > the SD card can be used to improve performance.
> Just to verify that you are aware of that:
> In addition to the extension Registers that were defined in the physical core spec,
> there was a separate document that was released that suggest a common OS API's to those registers.
> It is called "SD specification part A5, SD Extensions API specification".

Thanks for the pointer!

I did have a very brief look at this. The conclusion I made is that
this is way over designed to enable support for features like cache
and poweroff notification. However, there may be other use cases that
could benefit from a user space library, along the lines of the SD
Extensions API, but I can't really tell.

Do you have an interest around this that you can share?

Thanks for reviewing!

Kind regards
Uffe
