Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978D242C746
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbhJMRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbhJMRHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:07:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3545EC061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:05:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2757606pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xY9DoTRTQeO8rAjcA7cEMst5Qkxd33qpNMo59F4DyUM=;
        b=iwCvL2mU1aM3a61aqgh/v8gffKdnlRLHPAeavQ5VdbsWj62MxUwVhUULj7P/efUOeS
         WqLDE/qB+gLnqYapRiRgIw4b+ucDphj+2dHAwnxSdwWY5LvWqt2CFxD9SPYrEufZP0h0
         jLjKhnG9c18F180NAloooU75lTrLsJaQMD3v7z4BvuGRti3DYvBKJRNQE18Te49fOaf2
         QAWUmfFSM9iyAUW4dxfube7psjAEbzJY06bNUlrShoal85rK4blJVssXUE58Jxclja1j
         JheJB4baYN8UgZnjz9ZzSvZwwzQ8M3Nn3TrnuEQEdWX1LmaUDh3E1lCzrNgEDOwBCOXv
         dFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xY9DoTRTQeO8rAjcA7cEMst5Qkxd33qpNMo59F4DyUM=;
        b=7Q3KFkQp/rYmE6c23kc7n06y000QHZxfsEydV+Fup3cr7XwV6w4BxnM8Uuwf2gdWtp
         RO3TUU7RO5TST9T024Fv5QfFEe/QO992kqNhS34fqiFF46a/Dolw5iYpzPgSrVZ3LHpE
         e61AnEPuY7BvBzoR89ZtGIo05fkZJyUnH7udyZlsdLI1F9GWvY7Uq7xGw+sDOs7Rxqn+
         7bUWmmPLihiVt43genNHFnDdqPpT+NGbvf4IUvz515ZZbx7kSN3Mlov8ZA+Lz2sSvYBw
         ovmb4cZARqD8bnX6KNwUeAVU1WnD+jR+cgScBWmjkcQaVHGBFHPbkvAylonl5xdiK6tk
         hB/g==
X-Gm-Message-State: AOAM530coYgc/EPAzXm8JHduwLOOqyLWhSYAja3BytFRlUOZCEa22rCP
        sh+owWYXr604lF/uH3KKRmRiKWDHysxfgry7GtQMxpXK
X-Google-Smtp-Source: ABdhPJyucNsdOaQ6kPeHH2yYsRDmIih0ID5GLRc4Mo6y6jpeNXAu2AGfA9ZO/YiF9+vD4OyiNWVbSD8e5Hn1RW+rby4=
X-Received: by 2002:a17:902:a50d:b0:13d:8d71:aa91 with SMTP id
 s13-20020a170902a50d00b0013d8d71aa91mr424990plq.24.1634144741582; Wed, 13 Oct
 2021 10:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211013021011.515750-1-masahiroy@kernel.org>
In-Reply-To: <20211013021011.515750-1-masahiroy@kernel.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 14 Oct 2021 01:05:05 +0800
Message-ID: <CAEbi=3eqaH7wFKqssKUyWDz2UfJpFSh2VerAwyYp55xWpirVZg@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove unused BUILTIN_DTB from arch/nds32/Makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Alan Kao <alankao@andestech.com>, kclin@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E4=B8=89 10:10 =E5=AF=AB=E9=81=93=EF=BC=9A
>
> This is not used or exported.
>
> BUILTIN_DTB is locally defined and used in arch/nds32/boot/dts/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/nds32/Makefile | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
> index c17fc3a755c3..ee26e4df2fd0 100644
> --- a/arch/nds32/Makefile
> +++ b/arch/nds32/Makefile
> @@ -31,12 +31,6 @@ core-y                               +=3D arch/nds32/k=
ernel/ arch/nds32/mm/
>  core-$(CONFIG_FPU)              +=3D arch/nds32/math-emu/
>  libs-y                         +=3D arch/nds32/lib/
>
> -ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
> -BUILTIN_DTB :=3D y
> -else
> -BUILTIN_DTB :=3D n
> -endif
> -
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
>  KBUILD_CFLAGS   +=3D $(call cc-option, -EL)
>  KBUILD_AFLAGS   +=3D $(call cc-option, -EL)

loop in KC and Alan.
