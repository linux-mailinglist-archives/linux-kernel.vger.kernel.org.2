Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EDA38D088
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhEUWIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:07:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A033BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:06:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n2so22473873wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKtHLNEkG5ikEcAniCk2p9NH9R4kONOaWPVK8r4Ykbw=;
        b=I55N+x/S0PAJRNsEJ3JJrfNPD89t97zw1no0Y1E/RP8/cWuh/RUfGRwUjZaXqRx4wP
         uXmcrMEbOg7eaHD1WM9ZFh+6yYmzb8skrsxNHAcQMbWxZqPaIE16zWkX1WA52bqcDKCc
         x5ZJ7o1dn6UbXr7uYwgXPUFMkOarLOhxjts1euR4S95BOfaOFQyBcHYK5S80uaXuJiKL
         h6tKtYWyChwYKHxHXRql5o8WTWNPs/7CaUV431V9jE813HgzpYldwwvyDHXYw1EQBD/R
         voWogRwfXT3SmGXTdf9AxOcjnLs9sPiZOOs0wTiLzrMr3NgicgKlt1oL1wFVlj+mM88A
         Xf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKtHLNEkG5ikEcAniCk2p9NH9R4kONOaWPVK8r4Ykbw=;
        b=sAftTQ3IVSiE4+zU22kEwKcU6APADWFNk14rwE4FqW9xLKgmqCMXxjcAptsoXVwh7p
         SsCBumrJT47TZg6mFbFITejz209Y1OQ5E4vznqh9sHuWaYu1HHr6Lm6rHAVTScvbxNk+
         3OPJTezF1dzXXnQEATXrOWikyhoUdk1blB6upX59rLu3EnVJduwVcWAxm2Hlh8UQXXnI
         CAFN2+AX6zyPRSdSqtZRjCABV6sffQobt4WqG2o/4X0XMU+6B2L0zcwNbiO6aaV/leBT
         6kCcEuRfYVriN44hwrPjTU/bsy2XBfR93EdDp5B5T7bokPyd7bwj5Lm+o2cNjZGjZG/C
         Y6WA==
X-Gm-Message-State: AOAM531vgb932XxmwW2eQWPZzm78Az28lKxbz6jG/e1rW1FG+IOJ4aKk
        cxTPI0x027PFrW8iLVVLCClHubz9ogSKL49w4q1PeQ==
X-Google-Smtp-Source: ABdhPJxy8Yr06ltRPmV5F+SmKN8otn8cEh3Oh6kGmexlDpq+ViuIq7FNMqo+QpNmrekGGQP/BdtL0mR6xPpAKoFC4wU=
X-Received: by 2002:adf:fb87:: with SMTP id a7mr11633746wrr.58.1621634793153;
 Fri, 21 May 2021 15:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <162157886618.78209.11141970623539574861.stgit@devnote2>
In-Reply-To: <162157886618.78209.11141970623539574861.stgit@devnote2>
From:   Devin Moore <devinmoore@google.com>
Date:   Fri, 21 May 2021 15:06:22 -0700
Message-ID: <CAOELnJyuaUSiHi84AF34_myBVOQ9BtyRNMpAh95bgPK0nvy9=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] bootconfig: Add mixed subkeys and value under the
 same key
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:34 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 2nd version of the series which updates bootconfig to
> support mixed subkeys and a value under the same key.
> Since the kernel cmdline accepts options like
> "aaa.bbb=val1 aaa.bbb.ccc=val2", it is better that the bootconfig
> also support it.
>
> In this version, I fixed [1/4] to show /proc/bootconfig correctly
> and update the description.
>
> Changes in v2
>  [1/4]:
>       - Fix /proc/bootconfig accroding to Devin's report (Thanks!)
>       - Update patch description to explain why, not what.
>       - Use xbc_node_is_array() instead of checking field directly.
>  [4/4]:
>       - Update an exmaple code.
>
>
> This series depends on the below bugfix.
>
>  https://lore.kernel.org/lkml/162087519356.442660.11385099982318160180.stgit@devnote2/
>
> With this series, sub-keys and a value can co-exist under a parent key.
> For example, following config is allowed.
>
>  foo = value1
>  foo.bar = value2
>
> Note, since there is no syntax to put a raw value directly under a
> structured key, you have to define it outside of the brace. For example,
>
>  foo {
>      bar = value1
>      bar {
>          baz = value2
>          qux = value3
>      }
>  }
>
> Also, the order of the value node under a key is fixed. If there
> are a value and subkeys, the value is always the first child node
> of the key. Thus if user specifies subkeys first, e.g.
>
>  foo.bar = value1
>  foo = value2
>
> In the program (and /proc/bootconfig), it will be shown as below
>
>  foo = value2
>  foo.bar = value1
>
>
> Thank you,
>
> ---
>
> Masami Hiramatsu (4):
>       bootconfig: Change array value to use child node
>       bootconfig: Support mixing a value and subkeys under a key
>       tools/bootconfig: Support mixed value and subkey test cases
>       docs: bootconfig: Update for mixing value and subkeys
>
>
>  Documentation/admin-guide/bootconfig.rst           |   30 +++++++-
>  fs/proc/bootconfig.c                               |    2 -
>  include/linux/bootconfig.h                         |   38 +++++++++-
>  lib/bootconfig.c                                   |   76 +++++++++++++++-----
>  tools/bootconfig/main.c                            |   47 ++++++++++--
>  tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 -
>  tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 -
>  tools/bootconfig/samples/bad-override.bconf        |    3 -
>  tools/bootconfig/samples/bad-override2.bconf       |    3 -
>  tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
>  tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +
>  tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +
>  tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++
>  tools/bootconfig/samples/good-mixed-override.bconf |    4 +
>  14 files changed, 178 insertions(+), 47 deletions(-)
>  delete mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
>  delete mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf
>  delete mode 100644 tools/bootconfig/samples/bad-override.bconf
>  delete mode 100644 tools/bootconfig/samples/bad-override2.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-append.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-kv1.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-kv2.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-kv3.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-override.bconf
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

Thanks a lot!
I tested this on an Android virtual device(Cuttlefish) with a variety of
parameters that included array values. I checked the output in /proc/bootconfig
before and after the changes.
I added a new parameter that failed before these changes and it worked great!
Added 'androidboot.hardware=cutf_cvm ' which worked with
'androidboot.hardware.gralloc = "minigbm"' that was already present.
So,

Tested-by: Devin Moore <devinmoore@google.com>
