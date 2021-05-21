Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A913238BB23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 02:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhEUBBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhEUBA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:00:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA8C061574;
        Thu, 20 May 2021 17:59:34 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c20so18237618qkm.3;
        Thu, 20 May 2021 17:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/0aFTfAprVVOTOCs/KR4CC/94aej7JpddKXuVpnZ6g=;
        b=gEX1PhKjxUNcZhruCsw9euBMfZTaMTfSw09jtMO0vu65Hc39DgRYS0mBz+THLpaHuq
         m2O3HM0FkvpWu3fxirPKwP8W7nlDVG4cby1czMlBnx223XJ2jPnX6uRCcJt+X/Pqyy0o
         QWVmm7/6JmyUE5O1hu6A9N6/tWL2ym3WiFaHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/0aFTfAprVVOTOCs/KR4CC/94aej7JpddKXuVpnZ6g=;
        b=YxfVZ4dcWwJQmHj0tL6OoOjFsxNGWH9jls8I3Dw2ujIwnFgSGguZ0uR038lQBMY0HX
         0GNhBt8lhMu9kJPWX9jgs+FIhrpSWkYSfLumoEwl908nF0nTw/mzHbFPF/8MgvWfXvO1
         WpG8fRolgWUvqu6eNrh3P6VSBRx1Lc7Lij1gnFX6i3mZU9NeujTJj8HDS6LxvkptGnAC
         lOqJZ3dtMyYmF5X09sGyleJvKyoRl77Xujxz2gco/n+jE2U3zj1wxgQVOAE9zf82X/gM
         FTUzRU4hGGNQYxCmhPjPkBn+SHPrpqp/+398+GNcKJXmyOJk8Q9LiXxu1XgbqSDN1rRu
         Duvw==
X-Gm-Message-State: AOAM532w8NO4NhGPud8GYH+/S/pCoXdOXG6stWuCiW4enuqpPc4apo9i
        lZlYua0wh/+T2+Yc/XBvXlIzMo2FI+0jBxxiUQ0=
X-Google-Smtp-Source: ABdhPJyOg85pbVP5qfGdda8bH9eLGYzaTgxUlVuD+D9zPYeernDU9rP22PyLTRyI8fLkxDMPzeS683iOIZwwY1pD25s=
X-Received: by 2002:a05:620a:704:: with SMTP id 4mr7822674qkc.66.1621558773301;
 Thu, 20 May 2021 17:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210520093949.511471-1-andrew@aj.id.au>
In-Reply-To: <20210520093949.511471-1-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 21 May 2021 00:59:20 +0000
Message-ID: <CACPK8XeBeQjYe8LeivFt69bf8-ipccwHnigpq9jZ8B5wTKJ7Vw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: checkpatch: Tweak BIT() macro include
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-doc@vger.kernel.org, dwaipayanray1@gmail.com,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 17:14, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").
>
> Since that commit BIT() has moved again into include/vdso/bits.h via
> commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
>
> I think the move to the vDSO header can be considered an implementation
> detail, so for now update the checkpatch documentation to recommend use
> of include/linux/bits.h.
>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Acked-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

...just a little bit
