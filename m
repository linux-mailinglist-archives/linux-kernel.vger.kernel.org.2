Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373B83CA504
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhGOSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbhGOSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:14:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D63C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:11:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v1so9401273edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXPAG28KbucvzwWJNYmUX3rMJn0+3EtU75a9xp4rWjI=;
        b=AVglhLSl+WRl4taiirYuKqBg86+Z9/1UQoENraulc/lDrN6yc/nkLFmodiLP3aDz0v
         bmYviQh33Zg+TVA87kNQMQvKdaGFC6Sd8Y3Lr7Bmv4wXHkWg91yTvk7H8XaKcaiwU8AZ
         ZgaPe01zLe4Zw+Lt5J0NTa7+zpcmH+v7+gB+eA9ieVbTOn+juP75g0UzFG/9kPb9Prb0
         cLUWCKDOX/Cf6gfO/ChzLLKV5fhRbrgeQ4tMgnpML/7qbAukJiqbTizRJKm3KMY3fk5w
         fuwKb4q0JhXZ3JF3W5WRC7p3xoKl7nZbTlvk39fQ8bFoDlBbhdZC/vYFE3QyOkgMShCO
         /oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXPAG28KbucvzwWJNYmUX3rMJn0+3EtU75a9xp4rWjI=;
        b=lJtqQx0gErj0LCfKpkWDDawWL7DB9ABDTwND2k5UVNQAQEPiLx2wDpQ6xBgBwQcK+6
         dsiHdvDkWMKzfa1TCgf058+4YH29cM5zEAAyqoBwAcYj49iGG168MV2ATJr3bFovJBTJ
         M6K0SvaWHiGqntParfYO9kS8eDJVvg2B8eo31AzoK8zfVrAIfnJ+1q2LE99CDdOE/rW7
         O2ir+BmK4uPWE4wA/J8WqMohw9dT7tdbQqZYAkKe2kl3ewYNEo6TH/889tY4xmgNdpUA
         ErS03kcyNyKD33mFC/DkqNU5U8gmSzPAToTS6iC+YFEEnjQW4I1yuCgNTGY5hxpiJB6F
         Pj3Q==
X-Gm-Message-State: AOAM5337VARZ9iYBNabmj2qvPQvyKuDLmujc5i/FO78zuHGefXIZ8AUR
        I2sF8Zc0WqBEf8+UsilfBx8Gact9j2qvzYh/h8Auq2swyH1tNhps
X-Google-Smtp-Source: ABdhPJzW9yOauKjjzhomDnHUvp+EhR8m1mOHilOLEKFtZXbIjIp+J6Y/gEPvSy7fr2fUTxHodnJtswL6BjpXmnUnhwY=
X-Received: by 2002:a05:6402:1488:: with SMTP id e8mr8796429edv.341.1626372668922;
 Thu, 15 Jul 2021 11:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com> <3610f5373bb12ea04e025bafbf8350f75c0dbf4b.1626371112.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <3610f5373bb12ea04e025bafbf8350f75c0dbf4b.1626371112.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 15 Jul 2021 14:10:33 -0400
Message-ID: <CA+CK2bCzn8BVOH2pB4=MPyyDN9KeoWRmQ=GYq25R1zDKibuEeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: KSM: fix data type
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 2:01 PM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> ksm_stable_node_chains_prune_millisecs is declared as int, but in
> stable__node_chains_prune_millisecs_store(), it can store values up to
> UINT_MAX. Change the variable type to unsigned int.
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
>  mm/ksm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 057d0c245bf4..2e4bd7662e52 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -259,7 +259,7 @@ static unsigned long ksm_stable_node_chains;
>  static unsigned long ksm_stable_node_dups;
>
>  /* Delay in pruning stale stable_node_dups in the stable_node_chains */
> -static int ksm_stable_node_chains_prune_millisecs = 2000;
> +static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
>
>  /* Maximum number of page slots sharing a stable node */
>  static int ksm_max_page_sharing = 256;
> @@ -3105,11 +3105,11 @@ stable_node_chains_prune_millisecs_store(struct kobject *kobj,
>                                          struct kobj_attribute *attr,
>                                          const char *buf, size_t count)
>  {
> -       unsigned long msecs;
> +       unsigned int msecs;
>         int err;
>
> -       err = kstrtoul(buf, 10, &msecs);
> -       if (err || msecs > UINT_MAX)
> +       err = kstrtouint(buf, 10, &msecs);
> +       if (err)
>                 return -EINVAL;
>
>         ksm_stable_node_chains_prune_millisecs = msecs;

LGTM, but I would merge the two patches together. They both update
types of sysfs tunnables in the same file.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>


> --
> 2.25.1
>
