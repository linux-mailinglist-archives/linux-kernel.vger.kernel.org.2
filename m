Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DF3399623
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFBXEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 19:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:04:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AF1C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 16:02:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso2569542wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQ3zJHAGrzkcIOMFd58YKH+8xRtJGPXf1kt35EHrK5M=;
        b=NfyXzG5fCAIiS41LLk7QTQVL/x0O8UOkuOWDToDl1U8/ju7y5wpLP3eqLyafZbxsLE
         uEe5OS8xqzA/WcR7hUrSEBO8N6QBTTEn6LyFoN7+bZlsqBubu7xji5LTHbStEXsT9mzd
         bqceTbAdjkajLL1PR7Cu3NmZn91lEaikqoUjf9SPFf8BjqSz7+vQgkoFGuV1L0DOXJEm
         BPKyqLHwveIpfnSYi7IynO+fpeAxgh2Ppvbt9z5nVPtegIM8CxehNh+Q/K7DE8INhokK
         sNSNa2IiPHjJVaMBuq4eqCkmFk+Ov/BmamUvdUsog6ENN4nBDxSkvBv+0qaC3FFRdvzO
         qjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQ3zJHAGrzkcIOMFd58YKH+8xRtJGPXf1kt35EHrK5M=;
        b=gXbwICZQm6/T5JiDUF6UzoSJm8GzV2GCd9ZoW3KXTeJxeoonT2F4eG09XkNFfM9AlR
         ealmOU4gGpo8j8QgeU9z8CY8OfxNx5xY/tghCcZMFNQlX6C8YjANbpVzKYEGurHmwyLG
         GUrIYfR62vKp+GAcTFdQDoVZqEBfQhWGwlAz7WvtjqFig42WQTo6tV5omTnes6hi8PXC
         CpmeH8JsAcUNfOwvXvxBW1e3UOIQgEnwwvxUZG/CPXup9As7eDn2RNihzWVPfx9q6wV/
         z1kc0au12XTt7Rv+ilZFXui4Po5omBTM62H42mZ9A+htrtwrIQxv8hBvcg1sJ5Lus4Zr
         22bQ==
X-Gm-Message-State: AOAM532gcLFUmV+YaolorsQaqt7q01SZ8WNlAKFQ3XJ21doqWRTkI1Tv
        89TZ1Q+leCeTOcVe0uA8aCIJsxik48NnFcE1GTHNYLhoVBBLLw==
X-Google-Smtp-Source: ABdhPJyArNDOrqfDp038gm6qqfxY1+X9KvE3W762ygB8KcW2dtHaHdSDC0XUu1sjDb8oIA7WDvriDE5g231Uaj1zzYU=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr34850699wmk.68.1622674958498;
 Wed, 02 Jun 2021 16:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
In-Reply-To: <162262192121.264090.6540508908529705156.stgit@devnote2>
From:   Devin Moore <devinmoore@google.com>
Date:   Wed, 2 Jun 2021 16:02:27 -0700
Message-ID: <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under the
 same key
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 1:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 4th version of the series which updates bootconfig to
> support mixed subkeys and a value under the same key.
> The 3rd version is completely wrong. I missed to picked up the older
> (v1) patches to v3. So please ignore v3.
>
> Since the kernel cmdline accepts options like
> "aaa.bbb=val1 aaa.bbb.ccc=val2", it is better that the bootconfig
> also support it.
>
> Here is the previous series (v2):
>   https://lore.kernel.org/lkml/162157886618.78209.11141970623539574861.stgit@devnote2/
>
> In this version, I rebased on top of the latest linus tree and
> add the build error fix [1/6](*) and a cleanup patch [6/6].
>
> (*) https://lore.kernel.org/lkml/162087519356.442660.11385099982318160180.stgit@devnote2/
>
> Changes in v4
>  [1/6]:
>      - Added from separated thread. This is a fundamental fix.
>  [6/6]:
>      - New cleanup patch.
>
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
> Masami Hiramatsu (6):
>       tools/bootconfig: Fix a build error accroding to undefined fallthrough
>       bootconfig: Change array value to use child node
>       bootconfig: Support mixing a value and subkeys under a key
>       tools/bootconfig: Support mixed value and subkey test cases
>       docs: bootconfig: Update for mixing value and subkeys
>       bootconfig: Share the checksum function with tools
>
>
>  Documentation/admin-guide/bootconfig.rst           |   30 +++++++-
>  fs/proc/bootconfig.c                               |    2 -
>  include/linux/bootconfig.h                         |   58 ++++++++++++++-
>  init/main.c                                        |   12 ---
>  lib/bootconfig.c                                   |   76 +++++++++++++++-----
>  tools/bootconfig/include/linux/bootconfig.h        |    4 +
>  tools/bootconfig/main.c                            |   62 +++++++++++-----
>  tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 -
>  tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 -
>  tools/bootconfig/samples/bad-override.bconf        |    3 -
>  tools/bootconfig/samples/bad-override2.bconf       |    3 -
>  tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
>  tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +
>  tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +
>  tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++
>  tools/bootconfig/samples/good-mixed-override.bconf |    4 +
>  16 files changed, 205 insertions(+), 71 deletions(-)
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


Thanks for the updated patches.
I tested the v4 changes on an Android virtual device(Cuttlefish) with
a variety of
parameters that included array values. I checked the output in /proc/bootconfig
before and after the changes.
I added a new parameter that failed before these changes and it worked great!
Added 'androidboot.hardware=cutf_cvm ' which worked with
'androidboot.hardware.gralloc = "minigbm"' that was already present.

These changes really help Android simplify some boot configuration
processes. We will be using it ASAP.

So,

Tested-by: Devin Moore <devinmoore@google.com>
