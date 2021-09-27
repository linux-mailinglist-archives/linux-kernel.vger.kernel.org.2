Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13B419822
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhI0PpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234500AbhI0PpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:45:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87860610A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632757417;
        bh=Cc5X1sJEEQPcULf35qyYc/Hn2Ps0sveDqZRyZCG2UNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rCYdO2dE+g6M5Ii2LBzD22/JVeFvFIuM0mgrNJCZRYUxrkqWhMZUeiQ5f17RsqmJc
         iHrWd+ajJCHHFWPe5QQ50axOM2S0PsLtLqk1xBgCgKngam2eCENxrHRaUzrQIjkj5h
         V1LkVpYk9w8ku2tyPQwGeoyzDfJvfwJCNn4zq70REBlJUeLR4h3Q0z9E9sWVLD5geM
         4mV+oZ/+X9c+odz/ALSr1FUYMHm8KLRSOiRnwxwnc7162hW04AuHEApjaTuNF7Ngxn
         31tdgypzg2YN1dH9we8j1L7dlwIp/MbD0UYlYyYRKIIt5n1X/FEfC28wcgKC5MXLgO
         bUr+m7qD0tpVA==
Received: by mail-wm1-f50.google.com with SMTP id q127-20020a1ca785000000b0030cb71ea4d1so332485wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:43:37 -0700 (PDT)
X-Gm-Message-State: AOAM5316pMCgWCys+f3Y+YOsC67XkUd5EycPl0VZaD1P80v78Rh6mb5H
        jtGbN7ZJDaJKpttVh0Zr19R1cbS9ud/DHZOy8FM=
X-Google-Smtp-Source: ABdhPJxjfQ83nIG5/Jeik/CfgZn+LbCqM7rQ+uavHqWDflxWBvU/6lvz+BE06LlEEoXO8arCcQ2TyELklWXshWmxYSE=
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr16307785wmp.173.1632757416063;
 Mon, 27 Sep 2021 08:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210927124331.1487876-1-arnd@kernel.org> <7d90109f-7e25-ae2d-0dc9-80618593a3e4@suse.de>
In-Reply-To: <7d90109f-7e25-ae2d-0dc9-80618593a3e4@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 27 Sep 2021 17:43:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Fc8EQLP=vsRbajeF1xp8mX5xbgoCaa3dOn=XozYiWdQ@mail.gmail.com>
Message-ID: <CAK8P3a3Fc8EQLP=vsRbajeF1xp8mX5xbgoCaa3dOn=XozYiWdQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] bcache: hide variable-sized types from uapi headers
To:     Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kmo@daterainc.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 5:22 PM Coly Li <colyli@suse.de> wrote:
>
> On 9/27/21 8:43 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The headers_check helper complains about a GNU extension in
> > one of the exported headers:
> >
> > linux/bcache.h:354:2: warning: field '' with variable sized type 'union jset::(anonymous at ./usr/include/linux/bcache.h:354:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> >          BKEY_PADDED(uuid_bucket);
> >          ^
> > linux/bcache.h:134:2: note: expanded from macro 'BKEY_PADDED'
> >          union { struct bkey key; __u64 key ## _pad[BKEY_PAD]; }
> >          ^
> >
> > We could either try to shut up the warning or remove those parts from
> > the user-visible section of this header. This does the second,
> > under the assumption that they are not actually used.
>
> Hi Arnd,
>
> Yes, the variable part is necessary for bcache-tools to understand the
> on-disk format. If other program wants to understand the bcache on-disk
> format, IMHO such variable part might be necessary too.

Ok, got it.

> BKEY_PADDED() is a special usage of the variable size array. In this
> case it indicates uuid_bucket is 8 x u64, and 6 x u64 space for ptr[].
> And the bcache code make sure no more than 6 pointers are used for
> uuid_bucket.
>
> I know BKEY_PADDED() works, but I don't know how to simply remove the
> -Wgnu-variable-sized-type-not-at-end warning.
>
> Maybe Kent may offer some hint ?

Maybe instead of checking for __KERNEL__, we could check for
__STRICT_ANSI__ being unset. This would hide the definition
from user space applications that don't have this extension, and from
the header check but still allow it in all applications built with gcc
or clang that don't request the strict standard compliance.

Another option is to exclude this header from the header-test
in usr/include/Makefile.

        Arnd
