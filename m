Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF63F71BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhHYJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhHYJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:32:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:32:00 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a10so17450262qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nIK28OMLuwRHSdvdEpMN380N/Y1YA/9aI7TDeyqQyqQ=;
        b=o1MLlo1fb70lP/IE1cPh9PvxqcSLDJJa2QXKLuRK6NT7yNvMscJTJ++gYXCz8UYmNY
         ZZLwsAxwOVQ85UGanSOfsvtnXkVHtgFr0ryPXJSGLneZ9yjpMOREPom1XLXequnTr1mX
         qU8ocyNBeHlLK4DNJc6zKaMJ3QKbQq8l5NQdHITOIsNVgrLCVLyDMOfenUVXS2kZ1Hod
         FTiAjCmlG0KO3IBUTmM4ZlBfCms5XcVr7miH5x/cS2PVgXg+lDrWrg6kUZmHXIr/4Y4O
         Tth/o9LJ+0V1UsccrIcMfx/072V6dG3Uo/HjamUteqV3zSAMpvyGeqHjYlECCtou2/Cn
         6iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nIK28OMLuwRHSdvdEpMN380N/Y1YA/9aI7TDeyqQyqQ=;
        b=KWhX0caPCst6iuQtz9ECsVYYnuChMkHXc7IE8E8bH7DZcDK1vpxKlD1TZOqjnzSQWr
         0PBvgVPn+SvCaC84E6FrH9vgGmelTaQq+C8zRd/WEnP6eesZ03cYEFDXvA+a8mH1QoPB
         IYugzm4I4UXuFE3oX5dhpIsKrAjkUZZHOW4x5/cYlY6zqnwvYmBMFJ+rU8q35HEcnPoa
         M6WshNx8wRSsK2D6EOG/tlc6ogfUYGOV8Pbmf0N4/n7kSoVaZ5ny5Zj1SqmTFxJatI0K
         uf4DZkZJTn5hDpDP6ly/CcOdQgQHuejg26n/glxSxfTwy7bof3cDmzl6FQWnwkXlGtcf
         +WHg==
X-Gm-Message-State: AOAM530N9pbwYnLv0VIngC53b/3tDnJoZg0Kym5VJP5/WjDgFayX3mxD
        DKsBww4HlJnu4fhxW3ZpPwoSw0FQkNk+d6J18BgpKg==
X-Google-Smtp-Source: ABdhPJzBem+slprvXJ3F7sK5OK6dN+qBleyVPFL1msS3NrVqoD77XjvCLk5WpGUitSvjizouRex4gsmajlC2lf/5yR8=
X-Received: by 2002:a05:620a:d54:: with SMTP id o20mr30711262qkl.326.1629883919020;
 Wed, 25 Aug 2021 02:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com> <20210825092116.149975-5-wangkefeng.wang@huawei.com>
In-Reply-To: <20210825092116.149975-5-wangkefeng.wang@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 25 Aug 2021 11:31:22 +0200
Message-ID: <CAG_fn=X9oaw0zJrcmShNcvd3UsNSFKsH3kSdD5Yx=4Sk_WtNrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: kfence: Only load kfence_test when kfence is enabled
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:17 AM Kefeng Wang <wangkefeng.wang@huawei.com> w=
rote:
>
> Provide kfence_is_enabled() helper, only load kfence_test module
> when kfence is enabled.

What's wrong with the current behavior?
I think we need at least some way to tell the developer that KFENCE
does not work, and a failing test seems to be the perfect one.

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/kfence.h  | 2 ++
>  mm/kfence/core.c        | 8 ++++++++
>  mm/kfence/kfence_test.c | 2 ++
>  3 files changed, 12 insertions(+)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 3fe6dd8a18c1..f08f24e8a726 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -22,6 +22,8 @@
>  #define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZ=
E)
>  extern char *__kfence_pool;
>
> +bool kfence_is_enabled(void);
> +
>  #ifdef CONFIG_KFENCE_STATIC_KEYS
>  #include <linux/static_key.h>
>  DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 7a97db8bc8e7..f1aaa7ebdcad 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -51,6 +51,14 @@ static unsigned long kfence_sample_interval __read_mos=
tly =3D CONFIG_KFENCE_SAMPLE
>  #endif
>  #define MODULE_PARAM_PREFIX "kfence."
>
> +bool kfence_is_enabled(void)
> +{
> +       if (!kfence_sample_interval || !READ_ONCE(kfence_enabled))
> +               return false;
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(kfence_is_enabled);
> +
>  static int param_set_sample_interval(const char *val, const struct kerne=
l_param *kp)
>  {
>         unsigned long num;
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index eb6307c199ea..4087f9f1497e 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -847,6 +847,8 @@ static void unregister_tracepoints(struct tracepoint =
*tp, void *ignore)
>   */
>  static int __init kfence_test_init(void)
>  {
> +       if (!kfence_is_enabled())
> +               return 0;
>         /*
>          * Because we want to be able to build the test as a module, we n=
eed to
>          * iterate through all known tracepoints, since the static regist=
ration
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20210825092116.149975-5-wangkefeng.wang%40huawei.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
