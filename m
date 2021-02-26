Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED771325BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 04:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBZDfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 22:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhBZDfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 22:35:06 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 19:34:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id n195so7601162ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 19:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCLOCkZfcktctstbvLCUj8NcVRDZM3ove1QcBc5lnhY=;
        b=hCJus5y12fxkCAARRkZtBqaspNgbM5dnFfL155opWmrxvKXRtuNVSlEW/C8hFxlKb/
         HoUcm77wE87abi1OJB2qSby0INcFXNyZmvlO3isEo99VjlIk5Uvtf35YjiHINT+pj3rU
         VedllEOiB1TL/bxXcihpE6W5l1mVUSJQ/A/wv8F3HZRqGJjMaPY59/00KOFeFUO5TYk/
         ANKrDFOBqeVsQ+zmvBfNjh64PHI5la1wzkHzjBaA01aJJJEzYGxM+hFYQzweu4JnXRRI
         IKCOgLnwRPpvd31SxQc5Qlh2gY4Lhfr0VpVnVQjgXU3BiJC5oO+1IMClt8PkcSiOshlW
         g1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCLOCkZfcktctstbvLCUj8NcVRDZM3ove1QcBc5lnhY=;
        b=eP+JhVDVgg+3haU3QGLAcRZjGSfHNs6CcAjs6K2L6epUnwvoW0dfa92O6Hv319lhlO
         X0r2wNbgoffElNDXrMjSUy1ncEra1v7jhmRJwfFHJKR07RuR2zY/q5bryydWS6zE2YK1
         RurpscBL9ubGVU9eMpV8HCeVsAnXktapKj4YBc/+gwxuLaUcT+T5mz7EHaKl0at7eeAB
         zp2BW1unA5hA+xqr68uRU0Kp1r+XIF8EgDIOfGUxrEIzqqVvS0fLziWLdDXhOVnqbYwm
         PJdA4wItU6y8UiYjen72LGG0VJTtAX2cZGX+F1Jzhmk4+R8XGdjMDlMfnxjyJeaNN8Gw
         LbOw==
X-Gm-Message-State: AOAM531u0PCmxVix2mbAEv3N2ZjLSaC32KD7gnubm67VtfW//5Z75nfz
        o3lTQi7p+yoLBN9KqOuZLhLbR6wQA/cpKf0wUds=
X-Google-Smtp-Source: ABdhPJwE5s/APyzYAxcOL86Y7Z22UnWsAGUmuLw52By0tNCg4IId8AdfTyQkK+ISQoCz6Urgc5ZkGoJt+RzaS/z7CMg=
X-Received: by 2002:a25:6e02:: with SMTP id j2mr1521515ybc.247.1614310465345;
 Thu, 25 Feb 2021 19:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20210225164513.3667778-1-arnd@kernel.org> <202102251203.03762F77@keescook>
 <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org> <202102251213.5815C9B33@keescook>
In-Reply-To: <202102251213.5815C9B33@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 Feb 2021 04:34:14 +0100
Message-ID: <CANiq72nP6Db4y8dKeO=iOQb8K1EE=fWactFswv+HPh-Pc69rvQ@mail.gmail.com>
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 9:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> It's a trivial change, so I think it's worth it?

It is simple, but it is not trivial since it may change codegen.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
