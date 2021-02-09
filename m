Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A722314984
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhBIH2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBIH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:28:02 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB7CC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:27:21 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id g84so4675454oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sILkwtDn3JoEPpo6zGHf10MfJG83PGIkgxT7Ix5AHqk=;
        b=JfjyV5DFxkq6jXX9kO2rx+JDUSmHvsqf8OrhXI5plYv8QYCBIl9tX6JewmcbYQGy+P
         sxLtTGkDLhG02mzvsi7uhcjYEk7fWuThRNezfd+mBAQlDTs5eWLb82eOdTUjqyS+tc8o
         7cogTGL60nZcIQBUsMnAZEO5gUX1/wZcEkkdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sILkwtDn3JoEPpo6zGHf10MfJG83PGIkgxT7Ix5AHqk=;
        b=HQNAIVm7v2khcl8P7w+eSdZkY+qvr1U+y8As/9OyNB+eANrfyVDnQyv0KFIJbZ5ot0
         s9Hl6Bx0HnhdeGJvkT6T7hFZJ3vKB9k98zLYxpCx8KJBU+loOegEq+f8ffrBiS1nADuh
         KxlvfXJloEeQI9C6TuGJaK010ASAiHsIUPuBMQJfkZjhB+EzI6Jeb59grB93uDjAUlF2
         zOGIUv1H8F3cfTb37bWKsp4yGByAD0jV87z8JwDrYR8j6pC90FK4ui577Q87yGTXH/Eq
         WJ/qL23JHjKM1DG9Tqpe8kkcLRmtdY/eW/7X+7SVcXBlpgskPzKEvJlM90PPf73Ig0JA
         Gh+g==
X-Gm-Message-State: AOAM531cNA/TZv0864dRZQkT9GZgdkg6eGn7xcw3JuCpDxMMTDLD/4j3
        A9cMvR8F65z7Y8V4zMxY9fgIMDF0oJuUdqArIhtNCg==
X-Google-Smtp-Source: ABdhPJwO9wTNm5HjwxSO/6hVcvFDDglf4pEhgq2b47TPZwEp7/NcpTfBUUP9WtrLK7xCQQ25aA+bOrW/vb6Xi0WC1nY=
X-Received: by 2002:a05:6808:294:: with SMTP id z20mr1605603oic.14.1612855641261;
 Mon, 08 Feb 2021 23:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20210208200903.28084-1-sakari.ailus@linux.intel.com> <20210208200903.28084-4-sakari.ailus@linux.intel.com>
In-Reply-To: <20210208200903.28084-4-sakari.ailus@linux.intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 9 Feb 2021 08:27:10 +0100
Message-ID: <CAKMK7uEsRvhrw4v5yGhbCZV1=EOVY3X7vzdQc6zroPT2EX4J7Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/fourcc: Switch to %p4cc format modifier
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 9:20 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Instead of constructing the FourCC code manually, use the %p4cc printk
> modifier to print it. Also leave a message to avoid using this function.
>
> The next step would be to convert the users to use %p4cc directly instead
> and removing the function.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 03262472059c..4ff40f2f27c0 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -30,11 +30,6 @@
>  #include <drm/drm_device.h>
>  #include <drm/drm_fourcc.h>
>
> -static char printable_char(int c)
> -{
> -       return isascii(c) && isprint(c) ? c : '?';
> -}
> -
>  /**
>   * drm_mode_legacy_fb_format - compute drm fourcc code from legacy description
>   * @bpp: bits per pixels
> @@ -134,17 +129,12 @@ EXPORT_SYMBOL(drm_driver_legacy_fb_format);
>   * drm_get_format_name - fill a string with a drm fourcc format's name
>   * @format: format to compute name of
>   * @buf: caller-supplied buffer
> + *
> + * Please use %p4cc printk format modifier instead of this function.

I think would be nice if we could roll this out and outright delete
this one here ... Quick git grep says there's not that many, and %p4cc
is quite a bit shorter than what we have now.
-Daniel

>   */
>  const char *drm_get_format_name(uint32_t format, struct drm_format_name_buf *buf)
>  {
> -       snprintf(buf->str, sizeof(buf->str),
> -                "%c%c%c%c %s-endian (0x%08x)",
> -                printable_char(format & 0xff),
> -                printable_char((format >> 8) & 0xff),
> -                printable_char((format >> 16) & 0xff),
> -                printable_char((format >> 24) & 0x7f),
> -                format & DRM_FORMAT_BIG_ENDIAN ? "big" : "little",
> -                format);
> +       snprintf(buf->str, sizeof(buf->str), "%p4cc", &format);
>
>         return buf->str;
>  }
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
