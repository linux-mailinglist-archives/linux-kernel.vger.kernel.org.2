Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AD3C894E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbhGNRIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhGNRIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:08:19 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C858C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:05:28 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z11so3065543iow.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoppZ81SO7cdpIYO5rAuDgcrGuCGGX8aIn/E/Lu8O6w=;
        b=CZQ7F8tiiHRbmjcFtJESkuSqCLutmUH0RhUE7nzZGCfx3AX8CYcSTAgWT3DnsOGmOl
         spKkvKy/SOy8TnvWgm71n1owU3rVJoiqwnjHiRxpjaIQsJzYbthf7Lq+o64fWeXgzsNV
         rjLMdE0N1qaAUk5MP/56QBeqcUHkSKbWDkE1/PC1mXL/PmTGpFQPmndnn/FHHYziLx+k
         YDwK4FKOtCC08j6FG7JCrn2tzKtNz2AwXLD77ihO1GcTaHVYdEUWBDTMdOkSHhrc2xXC
         3c6aJV5ORC5UPKEDfcOTg8inkJ2cB7zOzUuHF0LNT/TErF8t8lmIn7ir1VUb2Lxq+zup
         8NEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoppZ81SO7cdpIYO5rAuDgcrGuCGGX8aIn/E/Lu8O6w=;
        b=nImEJ2uxRGUus18V5318/prkksOAnZrH+7jMqdMSfkJE6R+hXhHzYVpYN/7MilP0j+
         FaDHkxirKTpoFl3Ac8OsI8+1mSsQZ+KKp+HakaGWVCipn+Mi5SjiVulpmw5wsPVfiPuB
         LK7pWSH9/e+oqYEhhnEE69isfDUes+Keksl3OSNNj9hsqzZN9k6v/dIbg2uzjPWq0YvX
         kQJzLCMiB9qROEFtEacThTXoBKlIldNETyDnV1HxHwBN3LEIW4m4ZaJXHRj7AhNLMs7l
         pzQJdWaGxzn3KGSBoqWiV8gV0AmeTFKI+m6Riaf2YoC+ptsb7928WOnuCXKjIsCjHY9k
         hIuA==
X-Gm-Message-State: AOAM531zzdyQZuzwpYp84NvLIeNHY+gK5oCxREtjWx4MoFl5aZvWIdX7
        1MKP53+u3wsM98e6LsbLRiKQVuAOozDcGJ6sw4g=
X-Google-Smtp-Source: ABdhPJyyZj9OCpe8Dz2gck/G1enSeN3JrfUyv8SQDMWKvGLnilC0MNAxTfRKsUl2L6vFoLqMLwv//tdnmXtC3ZT6gtQ=
X-Received: by 2002:a6b:490d:: with SMTP id u13mr8022132iob.176.1626282327601;
 Wed, 14 Jul 2021 10:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210714150159.2866321-1-elver@google.com>
In-Reply-To: <20210714150159.2866321-1-elver@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 14 Jul 2021 19:05:16 +0200
Message-ID: <CANiq72kV7KOKcWCQ6p9LdMGmO+KV1ssnADmT_PAHALtLu=t53w@mail.gmail.com>
Subject: Re: [PATCH] compiler_attributes: fix __has_attribute(__no_sanitize_coverage__)
 for gcc 4
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 5:02 PM Marco Elver <elver@google.com> wrote:
>
> Fix __has_attribute(__no_sanitize_coverage__) for GCC 4 by defining
> __GCC4_has_attribute___no_sanitize_coverage__.
>
> Fixes: 540540d06e9d ("kcov: add __no_sanitize_coverage to fix noinstr for all architectures")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Marco Elver <elver@google.com>

Looks good, thanks -- I will pick it up tomorrow.

Cheers,
Miguel
