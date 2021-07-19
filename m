Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0B3CEE62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359044AbhGSUkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352508AbhGSUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 16:30:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32EC061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 14:10:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i5so32538695lfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zb6rr15bSXQwTnBPqI4g1KEDBlw35vq1tATeF4vahZQ=;
        b=l4zG9dD7D5TRbenNJfZXIawPdQYAmC+6KoVsGyDr8lFRRQ+nMV8zf6CakVJ74ozmx8
         vECyxqO5TWTiHtWqFoi+uLPJxjW6P+c6KohNly84YXa5LEl918+v52vTCL8MUc04Fkg0
         FidoisJjEXwrJEZGeYj2xyRBG8xrNKwGwp0Jy+L4vyThjoK5911PpAW4hJ2AglZOFbbS
         jBycTJKlXbwBTmY1x+4yXw8i/eg9P80H1wR6TilaCK4a5Xo+m4xCFix+wNVNQ9hnJRTD
         Rqkpss14DPkVkhN/ICpG16/LdrQfUh3SMEyfzYX8HNliUh5LEHcAarapfkhyJkKBbSHU
         nzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zb6rr15bSXQwTnBPqI4g1KEDBlw35vq1tATeF4vahZQ=;
        b=VacJtUjQ1iQmKJfykFUU1nzsJb8lzC1kI/qSEOh7h3rEDoVREnIHl7GQxTOzZC0OSA
         4oKrsuQv/4EGfzNfy0iLcwxvvBrd+7VZyY9p5yNY5R7+W7nfUVzDh4jvfPZnERyHj3eJ
         9bgvGrXtb3u/IUx2axXkw2sxIunJFb1Vhyuv6CiEDLJQs8Y7YLyrO82tE4bnIwhD6Xa7
         hrizCFXtRfBhCL9J4/D7bwc4cWM6jCV/DCcM5Ew7c1tO25KSin0KVOQuiZ0USbhqRpFP
         YxRJcjr+mizPcd3ygn4RqqqXs9pzVdIFF/J7zeV+ZJw/h9tRw/NVrqJGrO+lF0Jpx7Vq
         UFew==
X-Gm-Message-State: AOAM530nK5SH6XnUZaHdX0/X7h8WC2ZAdWHBRgIAM6m3bqKEGLEWBlQv
        5VmI25aCAV9/NKGG6q50exV7bRc/XkHDzSmh3AQcBg==
X-Google-Smtp-Source: ABdhPJy0PZFmXCRTMOqx4byvOHdwlSuCDhdl5z9Ba70UxfA55JfR5WyxqS2xZlcRCm5/igJgrDDjUGdXBJsIXwQbZD4=
X-Received: by 2002:ac2:4ac6:: with SMTP id m6mr20508306lfp.73.1626729043401;
 Mon, 19 Jul 2021 14:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210707224310.1403944-1-ndesaulniers@google.com>
In-Reply-To: <20210707224310.1403944-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 19 Jul 2021 14:10:32 -0700
Message-ID: <CAKwvOdnG-E8HpK9txn4X=MiZSzfFHd90y1qny=0syNUWY3AaCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] infer CROSS_COMPILE from ARCH for LLVM=1 LLVM_IAS=1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro,
Do you have further thoughts on this series?


On Wed, Jul 7, 2021 at 3:43 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> We get constant feedback that the command line invocation of make is too
> long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
> target triple, or is an absolute path outside of $PATH, but it's mostly
> redundant for a given ARCH.
>
> Instead, let's infer it from ARCH, and move some flag handling into a
> new file included from the top level Makefile.
>
> Nick Desaulniers (2):
>   Makefile: move initial clang flag handling into scripts/Makefile.clang
>   Makefile: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
>
>  Documentation/kbuild/llvm.rst |  5 ++++
>  MAINTAINERS                   |  1 +
>  Makefile                      | 15 +----------
>  scripts/Makefile.clang        | 48 +++++++++++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 14 deletions(-)
>  create mode 100644 scripts/Makefile.clang
>
>
> base-commit: a0e781a2a35a8dd4e6a38571998d59c6b0e32cd8
> --
> 2.32.0.93.g670b81a890-goog
>


--
Thanks,
~Nick Desaulniers
