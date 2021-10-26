Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42643B3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhJZO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhJZO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:27:16 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E0C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:24:52 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id s3so17508129ild.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2olkS+wNvtNXuDLdqRh1t7HO6U6185aIFi7TwZF15Mw=;
        b=UPSietClie6DUknw01DRNsyzUdnrz2k9Hed2dITwFgv+zU0zSfNxnKmE76fCSu+S27
         1MUh+WodleDNiTKnuAPOxKsIriA+sGSGttCektjcy84W1N4DvL1H2v57fdXgrMd+QUKo
         o9rGIlsMKlsLF1VF1wU4t0HFFDiAoB/IvfclD3fAGLB8fNcE/TzLA6Vcd6RQgx1aRFkf
         0dnHeEy9d2JO4PMAuKFcaf+Y2J1qHCDuuj9cb7sehsryOYA45G622cEb0eSI9NOpqipB
         g12NJ+oVFCR5ZLHAPn/tPB5MLTxF/nTmQlV1G7tmEndbUurUya4Htz6Z5r0ihss+qR9q
         hYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2olkS+wNvtNXuDLdqRh1t7HO6U6185aIFi7TwZF15Mw=;
        b=FwpHdm6iN+cssGK4MHqJYQaDL+mM1fsEL2fGZ7Row+op7fD8bWuSlsa1pflUsKAs0E
         bBfOWeTytnNshx6w11UsAAaT7I/GaC01wjyv7Tn6hRx4tqL/fujZrlVYLBNn6sWdUPrJ
         QldWKIKln7CB7azSPSoDrdoUSOdgEj4xbKy9DbBjSmVj9OzsHhc9iInEXkeKIDVPmKSO
         Nwwc2LwIc3/0BC1C5A3gGugQQEKnkOEiJSOU9f30oBBqHf6ocTCB5+ECC9KfUegVFZOY
         Vpvbc5lkwobacTGDNochnFhIJfCTeD55yMLodVrdUYn2kIJ385JTK43xnZM9LxTkadkx
         SyiA==
X-Gm-Message-State: AOAM532d+FITwLlDmXlUZLTq0hS4ZxQL/2l2Up9r6uqsrKrmrpbEK4FI
        2cmkvkUK1MBM6KNyQRUH6BoU462cS34o6bHB5YI=
X-Google-Smtp-Source: ABdhPJwe670JRxvUA8r+0q9An1SyFUxn9je2QzhUo8dLZJ1VdslWXR2JlDvxCO0yrQWfUW0pLf2rP11W4ADOwmqtjjE=
X-Received: by 2002:a05:6e02:1ca6:: with SMTP id x6mr7335858ill.72.1635258292143;
 Tue, 26 Oct 2021 07:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211026141420.17138-1-jiangshanlai@gmail.com> <20211026142058.17702-2-jiangshanlai@gmail.com>
In-Reply-To: <20211026142058.17702-2-jiangshanlai@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 26 Oct 2021 16:24:41 +0200
Message-ID: <CANiq72mFoiP8BpSoidOmrAR52GTQBabn-GzySQt3ieo+VGsJQA@mail.gmail.com>
Subject: Re: [PATCH V4 06/50] compiler_types.h: Add __noinstr_section() for noinstr
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 4:21 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> And it will be extended for C entry code.

Thanks for the `__section` change!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
