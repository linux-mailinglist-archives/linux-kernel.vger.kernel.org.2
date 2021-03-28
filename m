Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1434BBC9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhC1JTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 05:19:17 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40701 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhC1JS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 05:18:57 -0400
Received: by mail-lf1-f48.google.com with SMTP id a198so13966854lfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 02:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9t1HXwJgW2S2ZfNksRuzYLWjlCorc6U0pokm1Fs3exk=;
        b=Oh2arEeShUaicPqrcmjwLumjX7HLHpS4qKPd2MDmmKcEW86Av4yQmgAk8qjWDzhH7F
         KxDnkxPqM1v/Jk3ymrX5GQURpvKtibwxTx2y58OB39daMhZIujQvQUBw1doRAs7QlL0i
         fTmxBksAS319ABQdDOrV+NcU3Faf2iAkXxXf9GkhrUTNTG8jkOAZJoi/EYBGiHbSNPw+
         5ulqVq6IPljIYcbWIfx0M8pt1uhrypDEG/t0zlraWpUnkdoXMCMrQ81WfMa7BoP2Awid
         eOHus7pydlAk3ngX9Em2fezafyw0CnzB1yfXFiCdW/MrafHbgUFrWCnt8UmviZRlidJh
         CPmA==
X-Gm-Message-State: AOAM533jYotPPBoOQyz9f24x/8ptkGMxQmykvudTERr5omwycRWFYDDW
        2do4gnY9OAp7qlYZXFQNv6POBdOixs4=
X-Google-Smtp-Source: ABdhPJwU9gS8ZAXrB4+souEfCkng6WTG94m8924uBIUhyv2TjnBaYvuS5MU6sXU/MDat2LSuFqF+Mw==
X-Received: by 2002:a05:6512:3e26:: with SMTP id i38mr13596130lfv.140.1616923136264;
        Sun, 28 Mar 2021 02:18:56 -0700 (PDT)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id y25sm1943292ljc.73.2021.03.28.02.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 02:18:55 -0700 (PDT)
Subject: Re: [PATCH v3] coccinelle: misc: add swap script
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210216080133.455456-1-efremov@linux.com>
 <20210305100956.6222-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <afb06bbc-5c28-8a92-f205-c9a1c87c707c@linux.com>
Date:   Sun, 28 Mar 2021 12:19:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210305100956.6222-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 3/5/21 1:09 PM, Denis Efremov wrote:
> Check for opencoded swap() implementation.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>   - additional patch rule to drop excessive {}
>   - fix indentation in patch mode by anchoring ;
> Changes in v3:
>   - Rule added for simple (without var init) swap highlighting in !patch mode
>   - "depends on patch && (rpvar || rp)" fixed
> 
>   scripts/coccinelle/misc/swap.cocci | 122 +++++++++++++++++++++++++++++
>   1 file changed, 122 insertions(+)
>   create mode 100644 scripts/coccinelle/misc/swap.cocci
> 
> diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
> new file mode 100644
> index 000000000000..c5e71b7ef7f5
> --- /dev/null
> +++ b/scripts/coccinelle/misc/swap.cocci
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for opencoded swap() implementation.
> +///
> +// Confidence: High
> +// Copyright: (C) 2021 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: swap
> +//
> +
> +virtual patch
> +virtual org
> +virtual report
> +virtual context
> +
> +@rvar depends on !patch@
> +identifier tmp;
> +expression a, b;
> +type T;
> +position p;
> +@@
> +
> +(
> +* T tmp;
> +|
> +* T tmp = 0;
> +|
> +* T *tmp = NULL;
> +)
> +... when != tmp
> +* tmp = a;
> +* a = b;@p
> +* b = tmp;
> +... when != tmp
> +
> +@r depends on !patch@
> +identifier tmp;
> +expression a, b;
> +position p != rvar.p;
> +@@
> +
> +* tmp = a;
> +* a = b;@p
> +* b = tmp;
> +
> +@rpvar depends on patch@
> +identifier tmp;
> +expression a, b;
> +type T;
> +@@
> +
> +(
> +- T tmp;
> +|
> +- T tmp = 0;
> +|
> +- T *tmp = NULL;
> +)
> +... when != tmp
> +- tmp = a;
> +- a = b;
> +- b = tmp
> ++ swap(a, b)
> +  ;
> +... when != tmp
> +
> +@rp depends on patch@
> +identifier tmp;
> +expression a, b;
> +@@
> +
> +- tmp = a;
> +- a = b;
> +- b = tmp
> ++ swap(a, b)
> +  ;
> +
> +@depends on patch && (rpvar || rp)@
> +@@
> +
> +(
> +  for (...;...;...)
> +- {
> +	swap(...);
> +- }
> +|
> +  while (...)
> +- {
> +	swap(...);
> +- }
> +|
> +  if (...)
> +- {
> +	swap(...);
> +- }
> +)
> +
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> +
> +@script:python depends on report@
> +p << rvar.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> +
> +@script:python depends on org@
> +p << rvar.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> 
