Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7C39B441
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFDHsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:48:12 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:41756 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhFDHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:48:11 -0400
Received: by mail-lf1-f46.google.com with SMTP id v8so12677449lft.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=un0F/vMB1as+8PlF4+ud9qIkBU19hc8DoD6YAjyWcy0=;
        b=Fwupc6a/DGTOQ8oMq0bGNwyIcz7ZET0LwWu6M/eKzjcQXl1Jh6Ett+hbBZcTy64rGi
         JVxlS3+hi9Jlbd3dnE6RN7lGqJt0+G07bnsojvdx2HwX7ptHC/7zXWcOpDKAciOBZn/p
         9DXWZNP6ErZaz4liObuPSLBYGQFDPDCKHgKbLD3TQZjGKIf2diSYSQb/Kyq7nZLI+pz+
         l1JqDaK3Cbi80PkIFW+D07pUBTk/bVr4QlZ9ezzO5QVJUldMpTI/aAokfqZV99gaVA65
         Rq4G9yjmP7vkyb8UKVZM9kd/NtTXwcZiNMH1uSppbVELQbBq49/hAdStrNWxemYxDGtj
         jfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=un0F/vMB1as+8PlF4+ud9qIkBU19hc8DoD6YAjyWcy0=;
        b=YqAsxwfLiqckoClS6Qdja/BvvUt81is+laJFqcS/AkukUAnGNLmACgOMpjnBHi6UQk
         Y31EVJ98RymN2QaA7j/AVmr/yMovQjITyURL+F0pWcyzkB/ohWCBetmOqmJRVQ7R+e7x
         zOMs0/kUsVg9DheAiTdGuoTrVwxGRcLpglXFd72e0jIEIdLoRZlEHJfaDgX+o32LGwdC
         SNcjgaotM6OhtsHMO2uZNWZ945NKY9fxQutQa8EsjFIeWmUpPOUQh1z+IVY4DTMiGnxE
         dLsXNdWQoMs9QCmgpY5PGMk1/FNLJAYo2RUax3wVkIpLjkNgjLQqnMUb+UDg2mW/mUmn
         88Iw==
X-Gm-Message-State: AOAM533ugRE4IAXX6oTXfJ9qK8jQ8Vd1zAwdexhIXqOvjBS40BWNX7B7
        tSu/KeuakbWNljfVawrM8cj221Kx9BkI/sErQbjgwQ==
X-Google-Smtp-Source: ABdhPJyCL1nfxZX8uruHiA3tWdgiKaudqb70qSKVJdKsGXH4fPxr3neGY82tPW/2tqrKSJshAPLxXaZK31Xfsw0ae6I=
X-Received: by 2002:a05:6512:2105:: with SMTP id q5mr1858743lfr.649.1622792711079;
 Fri, 04 Jun 2021 00:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210604014055.4060521-1-keescook@chromium.org>
In-Reply-To: <20210604014055.4060521-1-keescook@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:44:59 +0200
Message-ID: <CACRpkdZEQ+C7tSppcJ83Go70CaBLe4XYKBqYqJfZWAYq-H2+wA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 3:41 AM Kees Cook <keescook@chromium.org> wrote:

> VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
> pl111 is modular. Update the Kconfig to reflect the need.
>
> Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")

Yeah that doesn't work, thanks for fixing this!

> Signed-off-by: Kees Cook <keescook@chromium.org>

> -       depends on VEXPRESS_CONFIG
> +       depends on ARM || ARM64 || COMPILE_TEST
> +       depends on VEXPRESS_CONFIG || VEXPRESS_CONFIG=n

That's the right solution,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
