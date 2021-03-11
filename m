Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8089A3370BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhCKLAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhCKLAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:00:01 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE006C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:00:00 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id n195so21252988ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FH9Tuemr6yEKKZ7zMO/X3RVvrhnQrqKx7Lo2YU1iHrI=;
        b=ooY3IFfYBXB9sWaYggyj/4jO1MUUeZ2RUoy2hxC+9X5Ae/rzs2DVmUn+2y/E4fBEe6
         XUjvPhSE/2ZODIgG+FWAEgLsRHQp1fLYjtppnYt5HGZ0eTZLXLcFjOBnrBFVMTKZdPeP
         kHqmyvE54Awn+HPODCrobdr9BAvVs1xNLcVDprQdRR7M6y7hxlJ94PPaZ/7CrNeh+IVJ
         yE17DY3w5Ir+63lRwMoIRiikJl+tb1Q3fpCGNasgiF8BI+wyx5RZZIMpmdotVlaIq0jR
         DG3Axiy89gj1noB2bQ5zUEDtVnmACT+NUEfl+73bgvQh+vwYJCWr5VugWW3+dhSq23mu
         98QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FH9Tuemr6yEKKZ7zMO/X3RVvrhnQrqKx7Lo2YU1iHrI=;
        b=n+ugk5osPcKdhnOIwsN0i8tYTORRTFc2gw31j9L99AB03cFEeBaD419zGbN/Vn4dML
         na4jI1fcQSRbK0M9/gafEon7bUI2O1qJR2H3WLMfM6vrPx/aBNn7U6SG8CdKOIHZtzRQ
         r5c31kdEJifkJSYwVYXtyb54KkmjISavT2x4gCVGiRggWt2ywdQfYNeMMv6EcPURqJ57
         Ab1ZWstdR+FjPJofFczaS3wPT7jg110WM5a3TkbbTYP8f0xPGqzbGYCqlXx0Rr15iMNx
         /GMPMD0QqpdLbM6HN4vmiZLP82g7bI3uynP412SMTjSuvOweRkZwGKPzwlb+qYyjgMbd
         wU5g==
X-Gm-Message-State: AOAM530nu1RqFYSOJvFNCZPw/iQdGPsZvmM0QI9/ZTGxo+bEndw616Qm
        h2C8T7ctsS4gMUU+D1gQNWMe2eMpb8nG2DN8NW7yWA==
X-Google-Smtp-Source: ABdhPJw0rCRE8+qk/fPMpU0L9aogYiBwnxnxNWMrbbrimxvuY5FG9nvFEhzFPwzcg4hN1ro/ywbvb+xY48F5XutTO78=
X-Received: by 2002:a25:2307:: with SMTP id j7mr11255547ybj.518.1615460399894;
 Thu, 11 Mar 2021 02:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20210311103446.5dwjcopeggy7k6gg@kewl-virtual-machine>
In-Reply-To: <20210311103446.5dwjcopeggy7k6gg@kewl-virtual-machine>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 11 Mar 2021 11:59:48 +0100
Message-ID: <CANn89iKyFJdBu4fuRaMHRy0zdzR2Jcisy7bz=5iNkoo8HB4h8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: core: datagram.c: Fix use of assignment in if condition
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mchehab+huawei@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:34 AM Shubhankar Kuranagatti
<shubhankarvk@gmail.com> wrote:
>
> The assignment inside the if condition has been changed to
> initialising outside the if condition.
>
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
> ---
>  net/core/datagram.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 15ab9ffb27fe..7b2204f102b7 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -427,7 +427,8 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
>                 offset += n;
>                 if (n != copy)
>                         goto short_copy;
> -               if ((len -= copy) == 0)
> +               len -= copy
> +               if ((len) == 0)
>                         return 0;
>


Quite frankly I prefer the current style.

It also seems you have not even compiled your change, this is not a good start.

Lets keep reviewer time to review patches that really bring an improvement,
since stylistic changes like that make our backports more likely to
have conflicts.

Thanks.
