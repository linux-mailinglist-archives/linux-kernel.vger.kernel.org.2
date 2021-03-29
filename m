Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB034DC82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhC2XbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhC2XbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:31:05 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC3FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:31:05 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c17so12661198ilj.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=e2JYMGScRSVZMfFXQMv1S/5M/YAYIAEgmCeN/0UgUAY=;
        b=cBRwnZEYaK65xqJKBC3hSioYdLFSKIZW5Lh07w5lvRUPgNt59HLfeffOyGDtxj9BIj
         AwPi5NwPnqwepBMgJ16LnjiDaw3DbiD8Lpj4N1lpnNML4CTN7+TamhmpZyi8mxwY6n4I
         OGLbXO0u/gXX2iAfdz7Kw4OJSVbFRVvYsShc81f/A4rO0z4yZKoinE/byJNuQMZJsGhX
         jZBz4mYnZnzYjYLjgZCxJ0PpuWiMAWqESdd18CBnRSZS3kssWzQJKw2FpV4h62zqVX4O
         q0AB5+ujCjmuxvy3pAtTpMP5MNqLSfSocasryx7CQBYX81WO+c3XWhvXN8aWi7woN6T0
         hoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e2JYMGScRSVZMfFXQMv1S/5M/YAYIAEgmCeN/0UgUAY=;
        b=ha2dhh78aUtn9hD4qzSO9EstEw5d/IywKTpWh3VglwGfd3k8YnuBymbHSQO3ibczJt
         J5OM+AMav1GTYDBciGbaVlcVULoHa5PMQIlx/gGBTxzEogFn1kPsMx0G3UAqP1eSt4Lg
         8ucquCzKpY0WodTg9U1eyhxagU3bthTFPiXPx2H26n4qAPhmtzgP59I5+puv6EgnPkv1
         6T+RToT38bBxoosACt/ONFvOTWmJBuC14cHik6qfsHZ89mgpkaQKkbMHj/sQ+YZq9+2i
         LHk7HHx1WkXQw/r+E8PjKFZ/mB+SGMU3GYv8Ti/ew5o12+2do9g1KKG80ceCdu++CLX9
         RxeQ==
X-Gm-Message-State: AOAM533hPaGZigGS2mXPP3POFoCI+EY31lb0QJYu07k/WJ98ZLW8NRpU
        l1Q+YM4ZFllash2tWfTbqe9LSKVad50k46eF3cbC/FBL3NbbBQ==
X-Google-Smtp-Source: ABdhPJz1CmYETQu7opvCoLOh1iV/tNBU4v8dMI2UEmkxnXcyGy301rEPJqqtGPz7SQrUXE0mL1g9u+Yzz0oPT+pLEyU=
X-Received: by 2002:a92:3647:: with SMTP id d7mr24061090ilf.264.1617060663407;
 Mon, 29 Mar 2021 16:31:03 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Packham <judge.packham@gmail.com>
Date:   Tue, 30 Mar 2021 12:30:52 +1300
Message-ID: <CAFOYHZCoqSW3BDywr+u-pHTdupGQjqatD8hR_P1zCdjBWjy8aQ@mail.gmail.com>
Subject: Linux include/uapi/linux/libc-compat.h and Musl include/netinet/in.h
 incompatibility for __UAPI_DEF_IN6_ADDR_ALT
To:     linux-kernel@vger.kernel.org, musl@lists.openwall.com,
        carlos@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've come over from https://github.com/strace/strace/issues/177
there's a bit of context there.

Crosstool-ng has hit a problem when building a recent enough version
of strace in a configuration that uses musl libc.

The error is

[ALL  ]    In file included from
/home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/bundled/linux/include/uapi/linux/in6.h:26,
[ALL  ]                     from
/home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/bundled/linux/include/uapi/linux/if_bridge.h:19,
[ALL  ]                     from
/home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/src/rtnl_mdb.c:16:
[ERROR]    /home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/bundled/linux/include/uapi/linux/libc-compat.h:109:
error: "__UAPI_DEF_IN6_ADDR_ALT" redefined [-Werror]
[ALL  ]      109 | #define __UAPI_DEF_IN6_ADDR_ALT  1
[ALL  ]          |
[ALL  ]    In file included from
/home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/src/rtnl_mdb.c:15:
[ALL  ]    /home/x-tool/x-tools/arm-unknown-linux-musleabi/arm-unknown-linux-musleabi/sysroot/usr/include/netinet/in.h:401:
note: this is the location of the previous definition
[ALL  ]      401 | #define __UAPI_DEF_IN6_ADDR_ALT 0
[ALL  ]          |
[ALL  ]    cc1: all warnings being treated as errors
[ERROR]    make[4]: *** [Makefile:6660: libstrace_a-rtnl_mdb.o] Error 1
[ALL  ]    make[4]: Leaving directory
'/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace/src'
[ERROR]    make[3]: *** [Makefile:2404: all] Error 2
[ALL  ]    rm ioctlsort0.o ioctls_all0.h ioctlsort0
[ALL  ]    make[3]: Leaving directory
'/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace/src'
[ERROR]    make[2]: *** [Makefile:601: all-recursive] Error 1
[ALL  ]    make[2]: Leaving directory
'/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace'
[ERROR]    make[1]: *** [Makefile:506: all] Error 2
[ALL  ]    make[1]: Leaving directory
'/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace'

It appears that the bundled uapi headers definition of
__UAPI_DEF_IN6_ADDR_ALT conflicts with the musl libc definition. It
looks like libc-compat.h tries to co-exists with GNU libc but this
isn't working for musl. I've identified an egregious hack that I think
should make things work (CFLAGS+=-D__USE_MISC) but I wanted to know if
there was a nicer way to make this work.

Regards,
Chris
