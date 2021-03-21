Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE4343548
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 22:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhCUV71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhCUV67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 17:58:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F0C061574;
        Sun, 21 Mar 2021 14:58:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m3so4558349ybt.0;
        Sun, 21 Mar 2021 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1G/wF3hyDKnqEu40AnD1bhMq6Qusfx8aUmB558U84aE=;
        b=YJyzc7877676oUKA2KCWxPxfZHLKtDFSCFznBsu4dpl2y2lUUnf677JHCogTSmkLv2
         OSR7pmIWRw2b+H8dWCSlZhB0nhIMWDzYY+2W6Aacn9K/HCY2FklIhQzuem34Mc+DQBNR
         1qLdKqjqNEg3dRnAqW2/p56jVS0xxC6ni6pNMir2yiq9r3LIzsPfJoE0OC3YbjJ8ihMI
         iNtERbcbWZkik1GmZU2UFSn746A9MIDAtvYE+3b9owPVerH00vfMocJl2hU/hOjoplOG
         miCVpfDCGctJEvtSKmFY/acUkGrJDhBVr8rRW04UdO8oGgpyBxRdYe9FhEn7FI0e3G5j
         lLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1G/wF3hyDKnqEu40AnD1bhMq6Qusfx8aUmB558U84aE=;
        b=baBa5T1pgWGMCkVxwJUiG2JN3w7RIViyToA1Ec5x6EDCyKqmout+jz3nqJjsnC8Zek
         2RQNKLYhV0uk+I4PGTbsE4FZw12JcHC8cEbXAnpqlGkVVbQl6Snu4H5IGA22K8RBTNdq
         jSTOAJp1stiQhGLPEdBhDhJCXavxqrduTJmDWj5iJXXzSGidoASoSI3jm0GkXug++9IT
         cICRFI7To8IdkpPpVavgh+pqMei+2HtRrfv5utxE7xFSfawyuqXr4bY0r5nFWp3Gs+mh
         Z5f3a+BWMVNVkPVNktvEdKZdGE4AGAYwfr1trBUfsfm0U3UNRVifkjwbJZIBk6y4mgxJ
         4c/w==
X-Gm-Message-State: AOAM532vn+5hsZp7k3J4N4PZKkmX1wunuqzq18HVsPc74kuHA8aeX95b
        b1HWlG3Lz/Ku1+5DJ5k8fhMmJKHmLnRHco5Yulc=
X-Google-Smtp-Source: ABdhPJyyxD3GsUUjjT3W6V972DEomE6nLI1jYgMnLdtT6PcPbgRFWV1RiSzaK8RR59mhI/1PU7Yle1diZW9HlRp/wMA=
X-Received: by 2002:a25:e651:: with SMTP id d78mr20501386ybh.93.1616363938165;
 Sun, 21 Mar 2021 14:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210321193705.GA13699@duo.ucw.cz> <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
 <20210321205619.GB28813@duo.ucw.cz>
In-Reply-To: <20210321205619.GB28813@duo.ucw.cz>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 21 Mar 2021 22:58:47 +0100
Message-ID: <CANiq72=FmY=MQrockHjKay=govJ=Wk51D2tnnLsM9N8HLh207g@mail.gmail.com>
Subject: Re: Getting Rust to work
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 9:56 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Done, in a private message.

I tried your config and it worked, so it looks like the problem is
your old libclang (7) does not recognize some of the flags. If you can
try a newer LLVM installation, it would be great to confirm it.

Nevertheless, thanks a lot for providing it -- it was useful to test it.

Cheers,
Miguel
