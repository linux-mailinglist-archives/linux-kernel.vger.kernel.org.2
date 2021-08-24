Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984863F6083
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhHXOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:37:27 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54584 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbhHXOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:37:26 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 17OEaKGl002419;
        Tue, 24 Aug 2021 23:36:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 17OEaKGl002419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629815780;
        bh=LDUinWDYcMafcuwuZgx51MuB0hgd3uqfhfVl28Yz2lY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RUkn4WtQNHCHjC1wuJNUZqQnkEAJL1yPibNrflc0xi5Im/4265g1flrl1zhCOamt3
         qK9e9fy6Aq04g66YCsBiB3v21Oc1H02HKLDm2vtGmf70FE7amAnCwifTqL/ug9upZH
         Ve8yAhrV750gFSXkanOYQdg2+9C6ANeJjizHZXznXKZROEkr0z3TZt0qRyU56ylP3h
         DKGJ7WsMo4P8xb4mrOnBneeNLtJK+iym5SIIcmfw2H9kx5Ubxyl2l9jarjrjjJodq6
         2bJCCvskmESCKlz/grcyAeAZ6yM+8REdyBNNvmE6zVQ4Y6RrwgLY9XFOQBpiU9JJ7I
         uPAS4vDbF/5Qw==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so1922354pjb.3;
        Tue, 24 Aug 2021 07:36:20 -0700 (PDT)
X-Gm-Message-State: AOAM530dpJcXg4BIszCngMTT79tdxPEujDWunZXoH9MpEqveoi/WF2qq
        whsyIHmunOdd7KWX/trcXlqgBzSHd+ymaK69y0s=
X-Google-Smtp-Source: ABdhPJwPeLIdxB2QPnplhAcW5HIiHgTgytQq6nWt7NRNcAGuSUYBMYQujxv7cGwzuQznSO80JlJRaOqbTzK8TQsM2d4=
X-Received: by 2002:a17:90a:9314:: with SMTP id p20mr4838371pjo.87.1629815779802;
 Tue, 24 Aug 2021 07:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210811164312.187226-1-masahiroy@kernel.org>
In-Reply-To: <20210811164312.187226-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 Aug 2021 23:35:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRF6wRY4wC-K36v7k9MWMN0hDYC4=G=5LS0rfFeO4hAg@mail.gmail.com>
Message-ID: <CAK7LNARRF6wRY4wC-K36v7k9MWMN0hDYC4=G=5LS0rfFeO4hAg@mail.gmail.com>
Subject: Re: [PATCH] ia64: move core-y in arch/ia64/Makefile to arch/ia64/Kbuild
To:     linux-ia64@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 1:43 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use obj-y to clean up Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild.


>
>  arch/ia64/Kbuild   | 2 ++
>  arch/ia64/Makefile | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/ia64/Kbuild b/arch/ia64/Kbuild
> index a4e40e534e6a..e77cc76d228c 100644
> --- a/arch/ia64/Kbuild
> +++ b/arch/ia64/Kbuild
> @@ -1 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-y                          += kernel/ mm/
> +obj-$(CONFIG_IA64_SGI_UV)      += uv/
> diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
> index 467b7e7f967c..7e548c654a29 100644
> --- a/arch/ia64/Makefile
> +++ b/arch/ia64/Makefile
> @@ -47,8 +47,6 @@ KBUILD_CFLAGS += $(cflags-y)
>  head-y := arch/ia64/kernel/head.o
>
>  libs-y                         += arch/ia64/lib/
> -core-y                         += arch/ia64/kernel/ arch/ia64/mm/
> -core-$(CONFIG_IA64_SGI_UV)     += arch/ia64/uv/
>
>  drivers-y                      += arch/ia64/pci/ arch/ia64/hp/common/
>
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada
