Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A274232D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhJEV3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhJEV3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:29:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2886EC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:27:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so737857pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoiQAn46ClahFaLRpc/gAkc33WV9lEU+0xQGA/BMNT8=;
        b=EzCZBtPbGPOonc3QyLryZd/pemw8aHvTL2IBGwShTC3lXsD9+Mnb3ep4O2wdrajBCS
         AsEwP/ODKw+6Ko6E4isxRpNix0lWda/zPJd8UcU7l8+ko6KWaM3LTRsn3m1DAVhwWhW5
         0Rik3/kQrTZHzmrelEFqtGnv0BphbmnCDtAo4DwC7wFo1rSkTXwy77cqMyKEz8qUNP6S
         ML1Sm/p09bPAi6IJcYAn66RN+O/jqqizM/qCXt9PdNoC5GnfdW7lb0AlANML03SuT+Vw
         kEXMMQPFdtHGR0CxIMq9vD7E4L3U4IJpV2HafZIQB/iHzEPIiWHl12JgEjyAge8g1eU9
         McQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoiQAn46ClahFaLRpc/gAkc33WV9lEU+0xQGA/BMNT8=;
        b=ANelKqJRsgCpwdns1WO9Vr06SK44UPh6Bof/pGHPWBE5j12bTz6fqE7qmbafmesLEX
         8ZJH0YDllxIFTlHWW9R+eeL4gVURpt7KuUYx+xmf2V0HfLcXVdmM0SCW+FsPHGcZz57Y
         CQHMZjeY50L/7fjA47ZeJvSZWCR2EIcJuhIDXdAm6dXprVWiGiFC6yq6f3fb95IyD8qf
         0AVYaDTqFv+FY8XeAFtpKk445MkEh15Q5Uz6fB8ThQp423br8iJwu5IOeHn4cv6K5ouY
         YyirJfn50whMlqno/Fv9GE3s+v3W+GYL2YLGt6upyBNY65C7F15niKIAWD0Dt55DQBJk
         U4JQ==
X-Gm-Message-State: AOAM532h6MRpDFJTxOU4G0hOZXwpo5AFxDsTGDw0HEIJfXqV7BYXjeyP
        X/fleSEiZn1Ei2j9sgdJ+UWX8mcA+3iMpvKlcFYNyg==
X-Google-Smtp-Source: ABdhPJwTs+XgdJR1uVjkk1E958Cqm+tyyyNonaR58H4o1z5QfLNS1MGp/4LGU2Xvbe0XJCB394hglZ8hnsr1IbiQl9o=
X-Received: by 2002:a17:90a:9a8f:: with SMTP id e15mr6482032pjp.198.1633469277424;
 Tue, 05 Oct 2021 14:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210929232534.1433720-1-dlatypov@google.com>
In-Reply-To: <20210929232534.1433720-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Oct 2021 14:27:46 -0700
Message-ID: <CAFd5g44TTBTcPctT5m7QDa0iCSt21oBHrL-PTqmnNo4d8ejr0w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: show list of valid --arch options when invalid
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 4:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Consider this attempt to run KUnit in QEMU:
> $ ./tools/testing/kunit/kunit.py run --arch=x86
>
> Before you'd get this error message:
> kunit_kernel.ConfigError: x86 is not a valid arch
>
> After:
> kunit_kernel.ConfigError: x86 is not a valid arch, options are ['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc', 'x86_64']
>
> This should make it a bit easier for people to notice when they make
> typos, etc. Currently, one would have to dive into the python code to
> figure out what the valid set is.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Yes! Thank you for fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
