Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A043F350A52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhCaWlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaWlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:41:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:41:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so21210285wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL02aTh2+xB20mrzZTojWu/p9mboxJJMVbqdRwrxVWU=;
        b=adqroYbVZMOn6aywcuL5FiFj/TTSYhza0g/b3jWAXGkMbxgka2FAwP2vwkFuKh5YKR
         sBzIeT+qEa1cE8HG0ukQctjtt1Os2zzGE/bpKid0jlqSIorrQb3A4KuCGhvHAIsbMm/r
         K0Lu7AUyvzUA6cbYk1h9WWFaO9HeqnZkLoLhnPg2i9U5OX/H3PB3CH1o3KMrnyv7HkdE
         jcVD++Q0NuQp9d8GG3B5E0U6KPWh4W+UnxDsTquo1JARfUEjBHtEzss+Kds4RLOjN+Y5
         p2yAGvybkIlSHcnOo4Lv36R51cyXwC1+OH6oRyUgmsWAFtqR7Jhdsy9461shUQzIaYgI
         KV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL02aTh2+xB20mrzZTojWu/p9mboxJJMVbqdRwrxVWU=;
        b=H2eD12pMg3Kk2RXr0lILdk3SwXVD9PRmqkNxecAmuZZJYjT5xAqhF1WjWB7a7tNg7R
         hV7LMHAnKiCUniariO6PkNa3vVKQ2R/ZGRCGPmgxsd0w6qgKGtTNJOY0LGyrfxl6g5wy
         AmCp7zcD/ef90PrN1HvdoenTGbxYmpHW+ohcMlCKe4B/ZUzM7pessLTX27USRa4Y95pC
         eC3sQYDc9jDRaoN1d6KquXHwj7FzjYfoKJaRkQiakZnbgJGJhRIg9ores/hd6icypKsp
         iww9kfzdYd9eaMSy4jM1zOxHdNw0fa1yr/bZwgzso4SxKcIxdEG/0gJCcpIX4joQ1hz9
         rirA==
X-Gm-Message-State: AOAM530Mh3dSHdgRN2jxd1/wuYZuaV1Oy/GCc1ei6G4EJ1Yp3wQtMsdj
        KraT89aaLnwLw2q1rFcXAdTYGyTBMdPxYwk105M=
X-Google-Smtp-Source: ABdhPJzweIdnxhLeaiHOfcBP3GgWZUWJ0OWvZt5FEH6yBIZLAVjYG4OgES7RTLr/BWfJJImn3MtWWDxPyBcSdMcriyY=
X-Received: by 2002:adf:fb42:: with SMTP id c2mr6066632wrs.83.1617230467404;
 Wed, 31 Mar 2021 15:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210325143700.1490518-1-jordan@cosmicpenguin.net>
In-Reply-To: <20210325143700.1490518-1-jordan@cosmicpenguin.net>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 31 Mar 2021 15:44:31 -0700
Message-ID: <CAF6AEGuf45zpE67YEBjgtYWbrr7zGhEY6xvsZpwXSDM1OFoyeQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] mailmap: Update email address for Jordan Crouse
To:     Jordan Crouse <jordan@cosmicpenguin.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Lobakin <alobakin@pm.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 7:37 AM Jordan Crouse <jordan@cosmicpenguin.net> wrote:
>
> jcrouse at codeaurora.org ha started bouncing. Redirect to a

nit: s/ha/has/

> more permanent address.
>
> Signed-off-by: Jordan Crouse <jordan@cosmicpenguin.net>

Acked-by: Rob Clark <robdclark@gmail.com>

> ---
>
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 85b93cdefc87..8c489cb1d1ce 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -165,6 +165,7 @@ Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
>  Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
>  John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>  John Stultz <johnstul@us.ibm.com>
> +Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
>  <josh@joshtriplett.org> <josh@freedesktop.org>
>  <josh@joshtriplett.org> <josh@kernel.org>
>  <josh@joshtriplett.org> <josht@linux.vnet.ibm.com>
> --
> 2.25.1
>
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
