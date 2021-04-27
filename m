Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B443D36C75D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhD0Nzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:55:55 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33392 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbhD0Nzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:55:51 -0400
Received: by mail-ot1-f54.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso32841882otl.0;
        Tue, 27 Apr 2021 06:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qezdgbyatE1l8zypI4FJQjmH7o9oUZIhojul/qRpkU0=;
        b=es2sgGVuQfPz1pJ9FbCY7bG/5+cNf9bOHB4NaThUtE9WNKNa6Fv3JsC7GsO0arYgZR
         dGqMZHUBFzFRLo34OQWUI50ype7dG/xy8AQiXjRxsa+9MPWSO2/73/3WEIlC8CXLApxt
         N65E/90m9+/yDlXEnTQkN2PLQcnfl7N2cqLF6hewm95cKXPNsD1GwXyWa1ERaSmLxIe8
         Fol85w1fG9BO+zKxcWCQ66Y/Gpq6cITvjVzHGx+JwX56drPCaPt6pJ4Jp5ygnInrI+/J
         RlKk6Q+tbcFZroX7PAMLJoiiPJj5ZNFOmIBJ5u34css+EFjW0mlrAouqg4eXrVu0O0qQ
         6wSA==
X-Gm-Message-State: AOAM53292AD9sKyXMmhXfhLuG8tqZzahh8Z+IUC8B1ThfbAWicQQ0Qo4
        5UObtYsIN7usT+xNLADnDxt5fRwjWyfjD+sawmY=
X-Google-Smtp-Source: ABdhPJxCYPLWLZ+In6uL5ea3rfA/sRsYCBbR83vXiHsXVds9LKZjv4AmhBg/RtM2rhV2GrS2/X/KWjb6BDPFY05bQlc=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr19534881otb.260.1619531707610;
 Tue, 27 Apr 2021 06:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
In-Reply-To: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Apr 2021 15:54:56 +0200
Message-ID: <CAJZ5v0ib-RegkeXf7G3mHjp2oRu7cSpCYBH_3BqGfKSe39fh4A@mail.gmail.com>
Subject: Re: [PATCH v3] coccinelle: api: semantic patch to use pm_runtime_resume_and_get
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 3:51 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.  Specifically, the
> change is only done when pm_runtime_get_sync is followed immediately
> by an if and when the branch of the if is immediately a call to
> pm_runtime_put_noidle (like in the definition of
> pm_runtime_resume_and_get) or something that is likely a print
> statement followed by a pm_runtime_resume_and_get call.  The patch
> case appears somewhat more complicated, because it also deals with the
> cases where {}s need to be removed.
>
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

This patch looks good to me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
> ---
> v3: add the people who signed off on commit dd8088d5a896, expand the log message
> v2: better keyword
>
>  scripts/coccinelle/api/pm_runtime_resume_and_get.cocci |  153 +++++++++++++++++
>  1 file changed, 153 insertions(+)
>
> diff --git a/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> new file mode 100644
> index 000000000000..3387cb606f9b
> --- /dev/null
> +++ b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use pm_runtime_resume_and_get.
> +/// pm_runtime_get_sync keeps a reference count on failure,
> +/// which can lead to leaks.  pm_runtime_resume_and_get
> +/// drops the reference count in the failure case.
> +/// This rule addresses the cases where the reference count
> +/// is unlikely to be needed in the failure case.
> +///
> +// Confidence: High
> +// Copyright: (C) 2021 Julia Lawall, Inria
> +// URL: https://coccinelle.gitlabpages.inria.fr/website
> +// Options: --include-headers --no-includes
> +// Keywords: pm_runtime_get_sync
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r0 depends on patch && !context && !org && !report@
> +expression ret,e;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +-     if (ret < 0)
> +-             pm_runtime_put_noidle(e);
> +
> +@r1 depends on patch && !context && !org && !report@
> +expression ret,e;
> +statement S1,S2;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0)
> +-     {
> +-             pm_runtime_put_noidle(e);
> +             S1
> +-     }
> +      else S2
> +
> +@r2 depends on patch && !context && !org && !report@
> +expression ret,e;
> +statement S;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0) {
> +-             pm_runtime_put_noidle(e);
> +             ...
> +      } else S
> +
> +@r3 depends on patch && !context && !org && !report@
> +expression ret,e;
> +identifier f;
> +constant char[] c;
> +statement S;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0)
> +-     {
> +              f(...,c,...);
> +-             pm_runtime_put_noidle(e);
> +-     }
> +      else S
> +
> +@r4 depends on patch && !context && !org && !report@
> +expression ret,e;
> +identifier f;
> +constant char[] c;
> +statement S;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0) {
> +              f(...,c,...);
> +-             pm_runtime_put_noidle(e);
> +             ...
> +      } else S
> +
> +// ----------------------------------------------------------------------------
> +
> +@r2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression e, ret;
> +position j0, j1;
> +@@
> +
> +*     ret@j0 = pm_runtime_get_sync(e);
> +      if (ret < 0) {
> +*             pm_runtime_put_noidle@j1(e);
> +             ...
> +      } else S
> +
> +@r3_context depends on !patch && (context || org || report)@
> +identifier f;
> +statement S;
> +constant char []c;
> +expression e, ret;
> +position j0, j1;
> +@@
> +
> +*     ret@j0 = pm_runtime_get_sync(e);
> +      if (ret < 0) {
> +              f(...,c,...);
> +*             pm_runtime_put_noidle@j1(e);
> +             ...
> +      } else S
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python r2_org depends on org@
> +j0 << r2_context.j0;
> +j1 << r2_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync"
> +coccilib.org.print_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +@script:python r3_org depends on org@
> +j0 << r3_context.j0;
> +j1 << r3_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync"
> +coccilib.org.print_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python r2_report depends on report@
> +j0 << r2_context.j0;
> +j1 << r2_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync on line %s." % (j0[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
> +@script:python r3_report depends on report@
> +j0 << r3_context.j0;
> +j1 << r3_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync on %s." % (j0[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
>
