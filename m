Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2440945E071
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhKYSOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbhKYSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:12:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD706C0613F3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:03:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so28840185edu.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eRCDhJ72bST7EguU+sg6EZXjnreWqf8nK7cNqJJh7w=;
        b=XxkhO0gDEl2hjpbL1VfA5z8zHm/zSSXQcsFe/o3liUEReOoicz20da/Th65Y+rUgua
         JpZiG5f3G8zdeMn6/MQlbGs9xepF50BTKIvD/oFnzJ1zg6m8+DvrvFfiY6D2NJj/6ZZC
         xXrfMOrsyUHDx7uKDYgFODE95dSxTfch472Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eRCDhJ72bST7EguU+sg6EZXjnreWqf8nK7cNqJJh7w=;
        b=QRxdG7tFgjXvBZjcqnEtNSrdlgLdc+J7NfzjtGNZUh7rgBSk+90Xi7b3633X7VqQh9
         uvJGlM7U+9B+3kG66gVnXX0LDCVXdyJRrpRSoSrKYaWtAtj5+RTsoiRIKJW3IwTpUlSN
         /DEwDk4ie1+PXPhH82ymHwmfMFHsO5j0Y/MTcJ+25KIQmYE+9axh8qMqkb85M9L1zWUi
         R8VW4m1dXHZwylmwdtbNt0eMDOxocxhKzRuH0sisAjByQcUyNQ6EGXy+Jw1NUSbRVI44
         U4GbQ68v83QGhD3yGlQ5lD66XO7o4Xx8S8WRxVUro3bq7A6hDJSdhb/PUfLDPZybeqXY
         eLUg==
X-Gm-Message-State: AOAM533Gy0wOf6LJkiH2jPA91vqUbJPLOD2VgahPArafN68EyDGd1jXA
        6jFIGBr/4o5/OEx/1SExjGwfGIiEedt0RKk4
X-Google-Smtp-Source: ABdhPJy3Eg/x06yOJqHM1E3Enp8tT1DxABtCG5KG98pvo6ZYFJmsHuxnOBa3hpwQ0BDw+Sx1zYPZ/w==
X-Received: by 2002:aa7:c301:: with SMTP id l1mr41745136edq.20.1637863430779;
        Thu, 25 Nov 2021 10:03:50 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id hx14sm1883950ejc.92.2021.11.25.10.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 10:03:49 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso8956038wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:03:49 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr9800856wmq.26.1637863429233;
 Thu, 25 Nov 2021 10:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20211125140816.GC3109@xsang-OptiPlex-9020>
In-Reply-To: <20211125140816.GC3109@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Nov 2021 10:03:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=widXZyzRiEzmYuG-bLVtNsptxt4TqAhy75Tbio-V_9oNQ@mail.gmail.com>
Message-ID: <CAHk-=widXZyzRiEzmYuG-bLVtNsptxt4TqAhy75Tbio-V_9oNQ@mail.gmail.com>
Subject: Re: [ramfs] 0858d7da8a: canonical_address#:#[##]
To:     kernel test robot <oliver.sang@intel.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     yangerkun <yangerkun@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 6:08 AM kernel test robot <oliver.sang@intel.com> wrote:
> FYI, we noticed the following commit (built with clang-14):
>
> commit: 0858d7da8a09e440fb192a0239d20249a2d16af8 ("ramfs: fix mount source show for ramfs")

Funky. That commit seems to have nothing to do with the oops:

> [  806.257788][  T204] /dev/root: Can't open blockdev
> [  806.259101][  T204] general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN
> [  806.263082][  T204] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]

Not a very helpful error message,a nd the KASAN comment makes little sense, but

> [ 806.267540][ T204] RIP: 0010:ntfs_update_mftmirr (kbuild/src/consumer/fs/ntfs3/fsntfs.c:834)

That's

        u32 blocksize = sb->s_blocksize;

and presumably with KASAN you end up getting hat odd 0xdffffc0000000003 thing.

Anyway, looks like sb is NULL, and the code is

  int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
  {
        int err;
        struct super_block *sb = sbi->sb;
        u32 blocksize = sb->s_blocksize;
        sector_t block1, block2;

although I have no idea how sbi->sb could be NULL.

Konstantin? See

    https://lore.kernel.org/lkml/20211125140816.GC3109@xsang-OptiPlex-9020/

for the full thing.

             Linus
