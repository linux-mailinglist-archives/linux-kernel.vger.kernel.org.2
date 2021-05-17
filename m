Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2463829B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbhEQKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEQKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:23:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C5DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:22:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j6so5326792lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAW9u6WixqqPIeGw05JLtcm5cUUUK2Xv8xLSrk94EGQ=;
        b=H7Kheoimq2vnIYcfEU57WPjOJJCza2qo7ZnqMBjedS3mI69AhkeDkp56BsF+92Srxd
         bdnAiXfx+GvrsTEd0hb7EsTQHmL7cSiy/n4bii7ZLR14Bco6a3qJtFY5jLkrhpVWWzqg
         bLkH+5wQTwnl7rQF+E7rGZp0C2p/tXrlnW54J5ai9cora/NOEdaA+T1p6LZn7c01ejsC
         qbwgNVj6gLopAq47YD+oc9VQ8ULjGpg6lNvbpJ3JvPpgocfvHcXa2v7NtEnsPXXlhuSB
         vWhM/+YtNe35RviL0CEA5wOCTpKcwYpKHYEGesN+jKpkQKChYwqidduSn8Q+ty0suaeC
         eppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAW9u6WixqqPIeGw05JLtcm5cUUUK2Xv8xLSrk94EGQ=;
        b=Z8ERTGCZAz4IhOYHssMk7/I7/Vn4fyPI6mfScIk0ESSKMqsf1f/fEEy4cAKY4EOQnw
         mPH25Zy3RZw4kljTax+3WRaU5GP2js/4F/iKKnnim2ShsAV7+qutGPF18MzFQaz3UPF5
         PTLiDygKo29UqeU92rlw099qhENgaDuL0Bi/ahkbc984FBdMANJ/2dz4nKB3B1zLLdy7
         VqMpZ2qj66A8J44PNk/KmCaeZHCr4CQaCzIYbRQzXoFQH50i2ij2wBS2Wg7F+nQRZRrM
         OW2jw6Uh4gTAWAggs1/Yy5lJV/Kw3IY8N215qmes3RxMRtAKdZggs555xx5fZ/WoZOIU
         GZ9A==
X-Gm-Message-State: AOAM532JQ7+lZ+vTq+MhkdSZAevklR5shV0MLREA86yLe8/O3VCaGgxP
        xkOVMsd046JWYz3QQqw2v51ujowfZzvsVopw0cD+Wg==
X-Google-Smtp-Source: ABdhPJx6XCWG5U+cv2mn/virCkkVVvKjrky4ABwDYKdmusoKHDnOg+zSXiadJlUxYXKqzfQU13K567CZvJECVeDgZ44=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr12770921lfq.29.1621246930198;
 Mon, 17 May 2021 03:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210511090318.478586-1-arnd@kernel.org>
In-Reply-To: <20210511090318.478586-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 May 2021 12:21:59 +0200
Message-ID: <CACRpkdbCdvk45DNgnJVD8yOA8aNY5n42JyNh66EvfUgts4uK2Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: mark prepare_page_table as __init
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong Liu <carver4lio@163.com>,
        Changbin Du <changbin.du@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:04 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> In some configurations when building with gcc-11, prepare_page_table
> does not get inline, which causes a build time warning for a section
> mismatch:
>
> WARNING: modpost: vmlinux.o(.text.unlikely+0xce8): Section mismatch in reference from the function prepare_page_table() to the (unknown reference) .init.data:(unknown)
> The function prepare_page_table() references
> the (unknown reference) __initdata (unknown).
> This is often because prepare_page_table lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
>
> Mark the function as __init to avoid the warning regardless of the
> inlining.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Like the others say, drop inline, with that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
