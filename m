Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20E540CD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhIOTUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhIOTUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:20:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FFBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:19:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i7so8382108lfr.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRAe5/tE1Mx+glbEumA/10LHbf2sLTrpOcfg2d46p4U=;
        b=VWatl0Tg6Rs2+8cyQ1nNI7llz+Jwjnz45GyA7Ialu8h0m7yH1LKoqAuI6k/Ywlygil
         KDQQX525bUWsnQP59sCymg2Xi7UR5AijXzfqK2/Z2O+QbzWUet5is4fYAxM3ieQOdqUi
         Q6n8XepF4xgcAuR6YdqHkkzo9csOkkBGuEk5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRAe5/tE1Mx+glbEumA/10LHbf2sLTrpOcfg2d46p4U=;
        b=1q6XN4OrZ0Q5OTqL047vKEK5Z3G0SBn4W245YSwIwNs4LxqzUkWG08XcZ4yb0arfqG
         u2tdFlcBMsNUqQZRiS2HYzcTe08CLAF41VAwXuDcFIuiUd4dHh/VI4J6Frf1oYbexeY9
         DjPX9fE7KJD6pM9v9og8B87JRdjPOWmWPnMIau/7KcGL4WbnDX6en5M23JRowFsAOaGB
         z+xE+UlvrhbWRq19rXZnnwvhg7hLywdHRizUzz4G80XubUGVFUG/Hhy67JOpzXVlHfqK
         MGaeWDLWNKc4PPrcdjUL7SZxwbDjoMHX+BYwtsAICSWvW/fFhf/vQMhyDq8NE2peTNT5
         NGMw==
X-Gm-Message-State: AOAM530WsOXxBRprl+09FLJrijyRj86Uu6tghMKU9xA5Npyg9n8QVJfD
        nf0zgRn4/EqHdpwEew+lrWEQJdm0MmjNq7GoI/o=
X-Google-Smtp-Source: ABdhPJwQAMwrSHqalDbP8fYek1YfhdfyVcTvXx2E040NFvcNT6RnM23SF8wNoElL3LYlQil9IhunGQ==
X-Received: by 2002:ac2:4c97:: with SMTP id d23mr1126887lfl.15.1631733557050;
        Wed, 15 Sep 2021 12:19:17 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r23sm86232ljd.86.2021.09.15.12.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:19:16 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id t10so2893670lfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:19:16 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr1121103lft.173.1631733554128;
 Wed, 15 Sep 2021 12:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net>
In-Reply-To: <20210915035227.630204-1-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 12:18:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
Message-ID: <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch series introduces absolute_pointer() to fix the problem.
> absolute_pointer() disassociates a pointer from its originating symbol
> type and context, and thus prevents gcc from making assumptions about
> pointers passed to memory operations.

Ok, I've applied this to my tree.

I note that the physical BOOT_PCB addresses in the alpha setup.h file
might be useful for things like MILO in user space, but since I
couldn't even find MILO sources any more, I couldn't really check.

I suspect alpha is basically on life support and presumably nobody
would ever compile a bootloader anyway, so it's unlikely to matter.

If somebody does find any issues, we'll know better and we can ask
where the user space sources are that might use that alpha setup.h
file.

                Linus
