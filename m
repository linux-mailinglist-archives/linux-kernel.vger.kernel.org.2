Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6741DDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbhI3Pr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345865AbhI3Prz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:47:55 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED72C06176E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:46:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r16so6058827qtw.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8d6xo5L9QevHc/0Sduv9NQkae1fLgboqRLN/cOlHL94=;
        b=iR/rfVgiWHq5rw4NLK5OT9v5lYhcLGBGwNqvqBTHa8uM0K3LSI6Qds40sZdhqy343D
         nKF1AalapkTkhy/ypRBVypdug7o8/xaqtmHaWv9UPFEGjb1UhHpm/4rTjAiBbtASwfKx
         3JH/kVbQPqPEjk5/0bNv7k1/Y2BIonRHJ0vWOSQM3zvPY70Uxrv2rSgTrqGgUv6GDu7E
         chrKKhinXiSRYk/xsds2GtV3wz6HxpGI4jq2FDoKpBIlG6t+6bi34LoQK0m5uh10NjJQ
         5mDPrpUbvxQNLMegc4nJJFYKUu1kf5g3ZYgnxHtFO6ahoMuizo6fqj2+osS40oUSZmZK
         mhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8d6xo5L9QevHc/0Sduv9NQkae1fLgboqRLN/cOlHL94=;
        b=shU5y1KxCXIbNXGUMfPvCTpCzXsfnmn2jlsDC6M+M2JmZLTgoFRFbDD7hkG5cUkJJn
         oLc60hi7QTVy4JrqnQ3G73QxZq7zdBW3gupTraBje4vRLjmQGamtF7jeX6FdsAfpMGKX
         LREb7zS7uGxvXQI8MiIjtEQIt0Wsnk/NZwsquQf+Oq5cKzsz4aSlAzj8WI86D+KbxAfW
         F6tcfS8kNSTY5ZSjhRXFI/Aq4LxEuRVvqJg7GKaz/uvP+OeWpsCgPnyNlvPa4twEplaZ
         xK3iMHXlEkod5ILsZKaHKxYlUTk2K1qbf6/vj1wooDrBUz7nNGpIJ07FWlCJ66x9gTky
         40nQ==
X-Gm-Message-State: AOAM5338V3q0/bc7oa05RRd2y7u/ngfNwpmbaJQW73GB1UDpBAwj0buf
        O5weH43ZGKU6L8eaaNx0cGbClK21+WyhTGR734nBSe615SQ=
X-Google-Smtp-Source: ABdhPJwZ3uxL8AigS1SCTssbBbBxtSyTYvRLlSFXF7X1iRF0BIcI7ZsH6TQi0ZjmX4wm1iehH5EIvAVb3aaD1X5z2aM=
X-Received: by 2002:ac8:5ed1:: with SMTP id s17mr7389237qtx.196.1633016771378;
 Thu, 30 Sep 2021 08:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210930071143.63410-1-wangkefeng.wang@huawei.com> <20210930071143.63410-8-wangkefeng.wang@huawei.com>
In-Reply-To: <20210930071143.63410-8-wangkefeng.wang@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 30 Sep 2021 17:45:35 +0200
Message-ID: <CAG_fn=XD+nVgVRgj7KFsPWSuia+gZzpA3KAdqucjKodOvxSF6w@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] mm: kasan: Use is_kernel() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, bpf@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 9:09 AM Kefeng Wang <wangkefeng.wang@huawei.com> wr=
ote:
>
> Directly use is_kernel() helper in kernel_or_module_addr().
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3239fd8f8747..1c955e1c98d5 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -226,7 +226,7 @@ static void describe_object(struct kmem_cache *cache,=
 void *object,
>
>  static inline bool kernel_or_module_addr(const void *addr)
>  {
> -       if (addr >=3D (void *)_stext && addr < (void *)_end)
> +       if (is_kernel((unsigned long)addr))
>                 return true;
>         if (is_module_address((unsigned long)addr))
>                 return true;
> --
> 2.26.2
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
