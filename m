Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB932D98D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhCDSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhCDSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:42:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA63C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:41:52 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w9so20096573edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGAuQa1PUoEh5FNPfeCOcSMYAZSWyrSrhiaRmAC+sLo=;
        b=YVlyzmtAtju2fBUZIUHuYe4UO+bGNsChE/keiCLGA1MpdbuEKwlVaMdzqJal7fjdfX
         zbn61uczeQcCx9QdLukkkpEXwKpLg/2k3sEa35kOIZ0rC51/Vm38wWFtMRVymurHPhav
         c5RfTFHYw+hsu5hbjRFr2/fsB7YUExA0KwQsT1giezXdRQDlmdayFGgjZ+0u4MdjQsp8
         UP1gecAhHH5aZNJNAu7fuDNJAzeHon31iQoeZG/GStrAnJUMX5t7I4LMpwxy1PfUl69L
         ooAa2ZMeSG4TYs4+eIuppjIrjItmNKkZnYz2f08uRM/FqvncNhB5fgJGfA/Rs5ppn7fd
         3rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGAuQa1PUoEh5FNPfeCOcSMYAZSWyrSrhiaRmAC+sLo=;
        b=Ya3D5mP9CmkTCasi8+nbSc7YZVWC9qBOw3Tw6gvWIdLFO94U2S6KI6go/PLXfywj8Q
         rvOJIkNuXExKkhulDfUN7pZdk/gRurpjHDc93ZfYoVThMkrzy+cJKZ2ZbJ/2naGGbGHj
         YUurHixgkL6xwZPT/9a3OZCyfY3TLgoa6Sq+SGl82xUVOIEExQI+PRQkgJ0FFIEgrN0W
         2iWxZp2dOcZo9dUdAA3uTXiml6m5H+zstJysa1UBVIqALa6oVZpA2MDlDA9hslMx2+9n
         VTHluhRM5StEchyLzJg8Nk3KHSO8u3ScRWsO5eY6OYpZlwlmNcmsqa9qEhAXmxm3PD7X
         wMkg==
X-Gm-Message-State: AOAM531qYsgJUQTQ1rWUhlyIOQFuHnASj7BE6SONBbbKMp1ZtpbRMAnP
        6Z+WfvYkQ4XCQuEsHnxlYrdZg5I7sedopDrse4T9qQ==
X-Google-Smtp-Source: ABdhPJw51VJr6G077eQYamXJLrL3nXTygODsuW6wr3+TZzOpbk+Xd/YlahOGxDurRbb16/lu4byb+e0KjME54lb+DUA=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr5984770edx.13.1614883311038;
 Thu, 04 Mar 2021 10:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20210225182716.1402449-1-thara.gopinath@linaro.org> <20210304053027.GC25972@gondor.apana.org.au>
In-Reply-To: <20210304053027.GC25972@gondor.apana.org.au>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Date:   Thu, 4 Mar 2021 13:41:15 -0500
Message-ID: <CALD-y_y8qidsypp7=F-5OLitaq3B1E==c+eQgyqq7hv9t3xcmw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support for AEAD algorithms in Qualcomm Crypto
 Engine driver
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eric Biggers <ebiggers@google.com>, ardb@kernel.org,
        sivaprak@codeaurora.org, linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 at 00:30, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Feb 25, 2021 at 01:27:09PM -0500, Thara Gopinath wrote:
> > Enable support for AEAD algorithms in Qualcomm CE driver.  The first three
> > patches in this series are cleanups and add a few missing pieces required
> > to add support for AEAD algorithms.  Patch 4 introduces supported AEAD
> > transformations on Qualcomm CE.  Patches 5 and 6 implements the h/w
> > infrastructure needed to enable and run the AEAD transformations on
> > Qualcomm CE.  Patch 7 adds support to queue fallback algorithms in case of
> > unsupported special inputs.
> >
> > This series is dependant on https://lkml.org/lkml/2021/2/11/1052.
>
> Did this patch series pass the fuzz tests?

Hi Herbert,

Yes it did. The last patch adds fallback for unsupported cases and
this will make it pass the fuzz tests.

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt



-- 
Warm Regards
Thara
