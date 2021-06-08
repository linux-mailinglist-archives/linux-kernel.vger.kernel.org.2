Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D139039F949
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhFHOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhFHOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:38:46 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D50C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:36:41 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id z15so10962080vsn.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpsV4sDHB2cyK5C6lyt/mnQ+XnkOkcY+7DRUUxVnjl8=;
        b=p5f8j36w8Ntn49cmYv4MvwFWK/AOerSOIgCmJp4QT0LjyYd60aJ67szVOzuYOwVgIk
         G0GlUXBYXTO41rP9p78c0LFY2Y8jlVAHEiBh6jNedWVhxqhFlv1qbuoSrtk+2gkY3gw4
         tWGUrqD6WDLROS+x6cb77ZmfDPHPylL9+At/nsum5kM4RQjRvnlgyF0oQnAlMQ9HrKQg
         X496YWYsLdr/tuV8yIFSepwpA6CxmDNZAHPGjuaMr87i+0KlzxN4zQoRt7Iw2tOfo4A4
         LUHyvgqkg2q5duUjAWuRJOPNYpj4UZJMfY4AvCVDpgO3+EopHv4P+rxU5tgFWKc3ev3u
         cmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpsV4sDHB2cyK5C6lyt/mnQ+XnkOkcY+7DRUUxVnjl8=;
        b=n/pooTEtgdVsLIjn2wZYwkz1TePazncUspAXZr1v9a10qHvSF4+mFGPXjdCCEI/6s9
         r0T4ofW0QLJ0xTZ446TW1ZVwPq5UvFKToiVwRZ52IL0BWv16xWgGnJII/ieNhwCfVVxz
         SWTU/QZB8F7S3oL4HncYW/Yldqx8V6AWtJYEolfitPNgenG3dfEWdXj3JZKqjirkZF1k
         Znt3F9hwgCX8jnPZiH2gb4rwzpRFv0HmzkRVBaExAutVmiEvIj3FyMA4nv//w3aNOIfA
         Yyls4i5bin4cUQhexqnWHLLzlEMPpL1mG6Emaf4IG6XoPm2JcwCY7bYn9t//7CTm5Vlc
         gOAQ==
X-Gm-Message-State: AOAM530irDmGOIXSGwXDGqAf/+DY31tATWJT+6tJC1KrfXg3waThWk9u
        cmUFbsoTqXhCihjhwf7/dJVPf54KvM8bFtyGPokbwYIrvxI=
X-Google-Smtp-Source: ABdhPJxgu6VRQIYnVR8042ZEZftV+daJ9LRJsXp14S0KbDSYuzrMWkGkQVTh/DaRfcSvz067m+URDyywJKx8rt2iqQE=
X-Received: by 2002:a67:7cc7:: with SMTP id x190mr433160vsc.30.1623163000809;
 Tue, 08 Jun 2021 07:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com> <20210608083418.137226-12-wangkefeng.wang@huawei.com>
In-Reply-To: <20210608083418.137226-12-wangkefeng.wang@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 8 Jun 2021 20:06:28 +0530
Message-ID: <CAFqt6zZWanzsy=F4LVUkovQE-wqKd0CNG-n=Sx7SBddord6Gcg@mail.gmail.com>
Subject: Re: [PATCH v3 resend 11/15] powerpc: convert to setup_initial_init_mm()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 1:56 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Use setup_initial_init_mm() helper to simplify code.
>
> Note klimit is (unsigned long) _end, with new helper,
> will use _end directly.

With this change klimit left with no user in this file and can be
moved to some appropriate header.
But in a separate series.

>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 74a98fff2c2f..96697c6e1e16 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -927,10 +927,7 @@ void __init setup_arch(char **cmdline_p)
>
>         klp_init_thread_info(&init_task);
>
> -       init_mm.start_code = (unsigned long)_stext;
> -       init_mm.end_code = (unsigned long) _etext;
> -       init_mm.end_data = (unsigned long) _edata;
> -       init_mm.brk = klimit;
> +       setup_initial_init_mm(_stext, _etext, _edata, _end);
>
>         mm_iommu_init(&init_mm);
>         irqstack_early_init();
> --
> 2.26.2
>
>
