Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F158436D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhJUWLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJUWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:11:14 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41625C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:08:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p142so2978560iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqZxwkNZdtY+AmxpVqiu8oRyIKMc8nkoF7xX0TxdGMM=;
        b=DxFzh8izuSj3f21gBDsqxezhCxiQf2U+q6Pbj/jhaDZp3Ih77PRJt7BG75TY9Uqv2X
         BaeIGKTYfqWI408L03PxnDyKeLBAAxIbfsqlFdr5Z4A1pyKeops5RRWFjCUs238zJT6D
         xBpC34/bXBAIbFymWUHdkqDSkBds16cpCuge4HOgfCXG4fCcHFu+ta/a6rtY65b2hiQr
         EWLSB8zjQx8vIJVqdjMAHB7gG4bvF4RHxK2jwJaQ/bc8UhHQs85BkOdBZx9J0VhkFmqT
         1NzAsZ8LjHImIkNNK+6wMdchyn0qa7HFEtdF6RHzz3Ij0TffhM2osLhIqeUwKVE8zPiq
         YNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqZxwkNZdtY+AmxpVqiu8oRyIKMc8nkoF7xX0TxdGMM=;
        b=YuG282VgI4bWnbrXnI8nSU98FigjwKKVkk5RGhKv06A9EhblamHXKvIcJiZ5B25ssv
         Kuh8ZNwZwHhw8uGCpcfN4euoRhU7spWYhnwb3jv34Tq3ewL5kCzGj/8Vrcg+GUhWhIJR
         BhUI5wE0IBh6sifO42MV8idztN0aufAhPKpNldjdJUJliD/eWevsUjvhYuFS0NeD7mhw
         D6YAaIt59S8QL4+s52KcNrc7QEH8KzwNfn19NjPJea6OZuapsZu2GNxqc9aL8oN1SxAr
         VtZzm1gV/jS/gZEQNr6MG/bepPamvxrn/rJFUw1PusrdVZFwvZ6wQHJ6wLk7HY4hfp6E
         xk3A==
X-Gm-Message-State: AOAM531mv2safnWdU8Pfj93yxqDKWGlDohwgoOpXESj62qd9zj0XPV3N
        2p9tGVBbYc+H9OFVu0kSv39CEcpiRMnLNE5xvyM=
X-Google-Smtp-Source: ABdhPJwZ8jj5XE75N5yrFDIEos5z5ScIi5UtNdZ9p7O4xUVmk492fZvp2YCotY+Tas53zTlY19ZRzlW3cXfN+3i4N7I=
X-Received: by 2002:a6b:8e52:: with SMTP id q79mr5901579iod.64.1634854134639;
 Thu, 21 Oct 2021 15:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210928191509.3806-1-liumh1@shanghaitech.edu.cn>
In-Reply-To: <20210928191509.3806-1-liumh1@shanghaitech.edu.cn>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Oct 2021 00:08:43 +0200
Message-ID: <CANiq72nf6gH0mvrBxe8bGRH4AmGMFt_EDO2s=LbHYajWJ1RoZg@mail.gmail.com>
Subject: Re: [PATCH -next] drivers/auxdisplay/ht16k33.c: remove superfluous
 header files from ht16k33.c
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 9:15 PM Mianhan Liu <liumh1@shanghaitech.edu.cn> wrote:
>
> ht16k33.c hasn't use any macro or function declared in linux/slab.h.
> Thus, these files can be removed from ht16k33.c safely without
> affecting the compilation of the drivers/auxdisplay/ module

Applied, thanks!

Cheers,
Miguel
