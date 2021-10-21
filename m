Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52671436D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhJUWLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhJUWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:11:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32BC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:09:16 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h2so2235942ili.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNTk5/QeDCOPyQ7S+P8GP4REfoBndwqYER63A1WV1hs=;
        b=NiO6qXJIlYBffZVgyGZ31AbOauHIA8ykmexW1kiVwBHhhlcT/nYNbNA3HZe98IG/Zg
         qHwJCX0gELOT/aDgaA5xgVTF16qV9dbb5zxfTcs+2VfP8PS5NBrM2X6d+X29oYRyIsEZ
         k6awq4gru6Wz4jrL28tIZcfkaDaYgGGDGeFrorGOSD7jpFqRJsh/B+IkH6SIrvJ71Z9b
         7hx6fWAvpX+KwLvWriP+A9+4t7RP1AFIqgc88wFr0mbt7hPGANdRMLhPgCWK9BuDWuRA
         K+CoRxy1IhOP6sQz46ZwTeuXEGq5tP7eoj9Sb3rIl8RY3rJ825QRwpoN6r4ZV4SqkFsL
         UXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNTk5/QeDCOPyQ7S+P8GP4REfoBndwqYER63A1WV1hs=;
        b=nxPJ0vsAUBp1mn6mb89D0HSjkvetpVj+70U932UizJXeQjEjGgDD0i7XDZ+YcB5Ic/
         sregYNIFVGfHrhi8JYw/YdmiuS3lRZ8oHiQhykADaaVxkP/j6FmkI037M+ex2L5Qs3DH
         vYSoq1/FR4bpw7dKKqZ+3p5bvDw+6ijHU55rspGNFNda6U5KW6KeZKQaJHGTJbju+Bau
         i0CoeYMvWo5rMPJKhXK+w2V1OFWi+2nB2518OzZfJjDdKGmB8xn8MFzBVfokfl7j2TIa
         82L2Gzfkm0RNfqZstb/k0eW6dWbfH+RhMCGVaoIIPEcq6IX/jYXxZqlZe5XglLC2T1tA
         ZXtw==
X-Gm-Message-State: AOAM530dP9EL2SpSSvjnM/ZpQJw2qpahAbTjQokSe/kvheNjfRiP44ll
        7oGeoT9qm/2pf8FXcvgLQhPHK+4Mp4bLzxl4kVs=
X-Google-Smtp-Source: ABdhPJx0KMBm3kok/+09xyGBLwA686BZINAQWFMKNArROkX3vldSDUKG9ZPa5fiwRllqu4rAlyXYN8iFmMlK91GQpGQ=
X-Received: by 2002:a05:6e02:1688:: with SMTP id f8mr5471384ila.72.1634854155626;
 Thu, 21 Oct 2021 15:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210928190644.25503-1-liumh1@shanghaitech.edu.cn>
In-Reply-To: <20210928190644.25503-1-liumh1@shanghaitech.edu.cn>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Oct 2021 00:09:04 +0200
Message-ID: <CANiq72=MGNfzPofKv9+rEp8buVxNTNTbzKNMeZhsibh5UghTkg@mail.gmail.com>
Subject: Re: [PATCH -next] drivers/auxdisplay//ks0108.c: remove superfluous
 header files from ks0108.c
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 9:09 PM Mianhan Liu <liumh1@shanghaitech.edu.cn> wrote:
>
> ks0108.c hasn't use any macro or function declared in linux/fs.h,
> linux/io.h and linux/uaccess.h.
> Thus, these files can be removed from ks0108.c safely without
> affecting the compilation of the drivers/auxdisplay/ module

Applied, thanks!

Cheers,
Miguel
