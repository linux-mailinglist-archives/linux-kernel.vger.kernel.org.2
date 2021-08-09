Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF18A3E4674
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhHINXa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Aug 2021 09:23:30 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:33782 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhHINXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:23:21 -0400
Received: by mail-vs1-f54.google.com with SMTP id h17so5255544vsu.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 06:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dceVL1zlAS3o69TxNbD+bkbP10t3ohJU4T5KJ5aE8RI=;
        b=QGoqBaock+9JuQWUZuCNTy/cuixQ5sYaD5ciRLAnEu5428iul9//aVZjAWM5kIumbb
         6e5PrKyQbMhz+lBSsQKqxeuNlq5AD+HYRY77IKKtYPdjVguUXRZVrhucTZJ5tfLsXZTM
         QS7u4AWPj+yTTbyeQ/VWJLJOnpf4+TLGu7emen93SKq+9M11tw1i1BHeBA71Z2nJvBjC
         pk+9vuRFoWS81b7+Yr9vybDxlDhR2M0t+ZxgE5aqFEuJgDR14rKbtJKP7QwWCAVFPpOo
         8eX/+r/Tt+GvVPtconFPy7uFOvnoE+rc+9mAtkbhSwco0QbAY7StzQ/EGJOAdp+Ft64/
         JWwA==
X-Gm-Message-State: AOAM530pBRKcyFfxmcVi2sT3utZgtWJgD4gg08+rWCwxbS0iSunSKSnY
        qzmr0qtYd1lHRzOSGv77ydAnIbuuA6KKVPyyx6nuvzBACMM=
X-Google-Smtp-Source: ABdhPJwJoMjpAh7WO5FcQZo8zjjOGsDP151wKp5+tjtfJp/WkMg8gT/tj9AZ3Ld9iNo4TAtHEYXu2B1AUvafB06WTtw=
X-Received: by 2002:a67:b604:: with SMTP id d4mr9037657vsm.40.1628515380764;
 Mon, 09 Aug 2021 06:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de> <20210730191035.1455248-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210730191035.1455248-4-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 15:22:49 +0200
Message-ID: <CAMuHMdVXMST4eHPKiOjNzWp6==EACYv7ZrCkNETZ=z-Y94q0kA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] zorro: Simplify remove callback
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 9:10 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The driver core only calls a remove callback when the device was
> successfully bound (aka probed) before. So dev->driver is never NULL.
>
> (And even if it was NULL, to_zorro_driver(NULL) isn't ...)
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
