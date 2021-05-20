Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077DD38AE91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhETMlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbhETMlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92275C061239
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:58:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id v8so19110949lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbkeWKgFA087dOLlZvAZZU0ouqEITPuzLojLWaP9xgo=;
        b=He0rcQ1pm8qmSLHWyXUXLDdZX3NhP9wUjC9eRjni+SLRjb7nBpTYCTD7eCWHYETKgn
         IE++2ehevJ5sra2zlvCJwg6J7ohOssNN/+LAuU76MabvzXF4UihCJrk8A+e6d9288Pcx
         jsYXAGvRGfThd4TbMAJwJxF21Rh5+F4N+HL6QaRkEGxv9u0lFTHTu9i8E2PbEGk6bQQH
         8WGAFPU7/M2pQD6f8Ib4FdjnYJBQ+o8e8YsF1GmbibL4b08Ir3Vv7epxrVe4k9lmXBOj
         GfUCf2BgIcFT3usLor76MxVAvmserxnz/UdkXA2As99j8+qFtRNHW5RYwH+pCkiMk8yr
         5JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbkeWKgFA087dOLlZvAZZU0ouqEITPuzLojLWaP9xgo=;
        b=QqF6zEacS+xB2G6Ldtm1One2j0kRj++bhlebYnIqEHZvOcXCg5lWvlDV9+lry8j0vu
         w0s0Rk09sBQxRgXJwbuanM4uo5B8IIkX3nAX7yVHGUofVXUYJaqx7NZ86sbprn4A6crE
         iUjjnU+BcAMuGnLSVrrkrBWKWufOdGa2ZCSrDeaHluvUbWoxq6z7mxvwbcE4NUTTYKXa
         uCK4zMpFDUL4ojM7Wv4qxNezLnMz0pGfeMAs0a6I569MmRenMG8Pe7+BtSvqNpfQhu/0
         5TWQ0zM8GYd2xW+tNp2KI0arXKkDBdd8G8iCrRiKFg/7KyAsUsZxFoE16DBqpIZK2O8n
         OoSA==
X-Gm-Message-State: AOAM532jKJ3fRUGyMMLgi473GPQujXrx5IQSuydogH7Gb7RAei56tV6e
        TMhaRxTw7+eEXLHdYueYKkoRMtcngsuAxTF6Gc2WmA==
X-Google-Smtp-Source: ABdhPJz0GaV73IL6WOG3YMGMH+NwVtnjpzjMiH5B4CYLZw/pOXkIl6QIUxpIrzh9QE7l5VxiHKhXK6SOBLMzntG364c=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr3222302lfq.29.1621511930963;
 Thu, 20 May 2021 04:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 13:58:39 +0200
Message-ID: <CACRpkdao2DC7tVdAMce33ZgGi1By3uJi47mRHBntTziL=q0h-Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Olof Johansson <olof@lixom.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 1:01 PM Maciej Kwapulinski
<maciej.kwapulinski@linux.intel.com> wrote:

> This submission is a kernel driver to support Intel(R) Gaussian & Neural
> Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
> available on multiple Intel platforms.

I replied to v2 and did not get any answer:
https://lore.kernel.org/lkml/CACRpkdaHMKueLr9Q5CAXQXN5A5FwZScfroE-DYfK+NaGXaqN1A@mail.gmail.com/

Now more kernel maintainers are saying more or less the
same thing, please address and reply to serious
architectural comments instead of sending new iterations of
the same patch set.

Also include me and Olof Johansson when reposting, thanks.

Yours,
Linus Walleij
