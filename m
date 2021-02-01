Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B918530B21F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhBAVa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhBAVax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:30:53 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B26C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:30:13 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b21so12984293pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyWshTJy8JoRpyyUXEZJz9pHNXzVDwMTi0TYPALmTT4=;
        b=Nj5DxMn/lfkylqkBNZSlsgZ9FMeSEQ+FcyyyPkMi18wpHo+oMhLyKmsDGjCDdKTGO4
         qDhaQ5AOuliPb5bmA9upxW/Xc0dcGo72EWeXHnak9PlrbgTTmlzEQYYUg46uTtT4at4Q
         BRuLWrRoN5g+W+EtZhsCFaULF/BUkwXusENtuGgD9Qmofqje5gYg5IMHFpnr+nilDwAO
         1igHaZLA8ipAn5B4NlP7elpvX3Mg4vj/InXHzXM9b5Fh9BwZe50gJeW/h42Trz9lah4G
         wvzcRovQzvWZ+6mJQ1Lnf55Ss8vbB3Vvf1rnGpYAOUyilzr6/hty8USLXncFjB/n5eMz
         cAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyWshTJy8JoRpyyUXEZJz9pHNXzVDwMTi0TYPALmTT4=;
        b=UfvqjDyFIB7WH6UP+L2eaEBqZeGLK6XQ4gPFGisgidPvtKbuaN9toGZJK+9x2sP75q
         ai0VAQ/UK/xtql2zdHyrahAG0CkjT1EhaEbhQ+ejc2mZI6H12WGNKATeNQceN37x3Ntj
         ZVo9yqXLpyMomESG+luG1FjtDEj71q7XUDe5Nqoih/vLbIuu1/qwuO/PEdpuC3y3dh0e
         5TlMH7syegZ0+9ZTBN8V34A1EMMcyT6RxuiCjdOa08TUF7WNgNHn8V0XUw05t+CpOsS+
         7Wfji3R9y6vEtOPZWpQX/+VhzzbBgYg/bkdUv0kK4PXBg8Tz0DYjh0a3b95c2p+PXN7y
         PMVQ==
X-Gm-Message-State: AOAM531keCS1f4t4ZIvUJ0sajZzUfskX2rn89CiKQ1LlInbtz0eYrbsv
        /Crs4BYHJ7BOw1RXqrmTQd5SsTgGVGUbcMFUy4p5iHJ7GPH5EA==
X-Google-Smtp-Source: ABdhPJxNhwmHWlRYnf6DZR8K3qyJRAqcAz8ZT1Q6Ta30DnREeN+nTpViDL2Wqb8Cirq20aZQBCwwK9zPZK3eurfYrRk=
X-Received: by 2002:a62:683:0:b029:1c9:6f5b:3d8c with SMTP id
 125-20020a6206830000b02901c96f5b3d8cmr18347846pfg.1.1612215012748; Mon, 01
 Feb 2021 13:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20210201205514.3943096-1-dlatypov@google.com>
In-Reply-To: <20210201205514.3943096-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 1 Feb 2021 13:30:01 -0800
Message-ID: <CAFd5g45C7a1sRg_XpK5=MWOFeLza91H96gJ7W5XT2G5c4gMwjQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: make kunit_tool accept optional path to
 .kunitconfig fragment
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 12:55 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently running tests via KUnit tool means tweaking a .kunitconfig
> file, which you'd keep around locally and never commit.
> This changes makes it so users can pass in a path to a kunitconfig.
>
> One of the imagined use cases is having kunitconfig fragments in-tree
> to formalize interesting sets of tests for features/subsystems, e.g.
>   $ ./tools/testing/kunit/kunit.py run --kunticonfig=fs/ext4/kunitconfig
>
> For now, this hypothetical fs/ext4/kunitconfig would contain
>   CONFIG_KUNIT=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_KUNIT_TESTS=y
>
> At the moment, it's not hard to manually whip up this file, but as more
> and more tests get added, this will get tedious.
>
> It also opens the door to documenting how to run all the tests relevant
> to a specific subsystem or feature as a simple one-liner.
>
> This can be seen as an analogue to tools/testing/selftests/*/config
> But in the case of KUnit, the tests live in the same directory as the
> code-under-test, so it feels more natural to allow the kunitconfig
> fragments to live anywhere. (Though, people could create a separate
> directory if wanted; this patch imposes no restrictions on the path).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
