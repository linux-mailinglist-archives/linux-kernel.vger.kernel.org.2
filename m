Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2AB3EDF89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhHPV46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhHPV45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:56:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD7C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:56:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c24so37256161lfi.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INSZ2rU66F9gi18DmsqmtRCqv+cghRc4CXBXIsZask4=;
        b=Gn5ex9v2S3646sbEM7aF/fOdxwaguZ+V2nQywtRGmVOVYZ6c3qlRDJM71uKO1vTJPu
         y81B09nw2MadMAyYgGWfSLkPbO41LlZageOeRmQHRzelWUqXRnFiNTiqTZpvbWtDnnKC
         +6qNvDBu8iOhWleTkRlEo/hGpBwMvF+dCuMWUgxnfbtq6kjs5q7L4ZQjWXyZ02ti+pJi
         rzEdTzJRp4V49opprFPfO4jxIgdY1KUN8Y4uqTlgWgHo67TSorkxSEbI4Kv5YpSPjo1P
         exFa5ieZJ1NVEuAKz+rbbXPDNZOeGMGmnkzx/l9TA8hw9XAVH10hpZzL0xSGHTAQWYs0
         NzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INSZ2rU66F9gi18DmsqmtRCqv+cghRc4CXBXIsZask4=;
        b=cSgKUkP2us3xstKGxdICC2CyhbjxmRssrpMpdmixFgo8FQKl5kdxB+/D20YHXVGLWp
         PBgis6WHt/MWhiWTlAenv/VU5NPbWSnOOo48Bjlgwdx/8i/9iw6nJRr+J7yDv4bmUltO
         V8ZiBau+DSLG9QGe8GlNe9gkFiozIKKDWUnkeDCaBoGZjZvTA7IiHbmAWTCF3m+k4aZh
         JncJGizkcrHBLvjxsfiEcE1/qANagzWxtELhFpa7RTBanksG3JS15gggMxOD5v7GCX1f
         C8RH7FkF+tIa7sMggnn2iLqqldOxqSm6HM0+wDDDxe/hhhLTC7DmkGM/XTGoRCDTxpbs
         d4Hw==
X-Gm-Message-State: AOAM530AmEOqLIzBPSOyq08Z9qtw4WjoRmdMggUYPSlQjuUNwbawTBeb
        HciFLz5w5V33Ngc+h4f6fMzvyRgPQe/bCH856dxr1PnI/aP447WH
X-Google-Smtp-Source: ABdhPJzax+5D3ev/waix9QN4hf331/mD4fvHlfJ0jMfZ79tDnytRVRhhw+Fw+KUFwyaiHrUKp27ZQVd3RERUOJg1n7c=
X-Received: by 2002:a19:7603:: with SMTP id c3mr310360lff.543.1629150983095;
 Mon, 16 Aug 2021 14:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210816193041.1164125-1-nathan@kernel.org>
In-Reply-To: <20210816193041.1164125-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Aug 2021 14:56:11 -0700
Message-ID: <CAKwvOdnKnBPhvVM3CAf7im3TS5eSV+myQqd_X9oUN74o3NOu7Q@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: Remove unused variable cnt in ntfs_security_init()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> fs/ntfs3/fsntfs.c:1874:9: warning: variable 'cnt' set but not used
> [-Wunused-but-set-variable]
>         size_t cnt, off;
>                ^
> 1 warning generated.
>
> It is indeed unused so remove it.
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")

I went back to the original patches to see if this was ever used;
since v2 (when the ntfs3 driver was split up) it was not. I triple
checked the v1 as well.
v2: https://lore.kernel.org/lkml/caddbe41eaef4622aab8bac24934eed1@paragon-software.com/
v1: https://dl.paragon-software.com/ntfs3/ntfs3.patch
I don't think there's a logic error here.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  fs/ntfs3/fsntfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 92140050fb6c..c6599c514acf 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -1871,7 +1871,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
>         struct ATTRIB *attr;
>         struct ATTR_LIST_ENTRY *le;
>         u64 sds_size;
> -       size_t cnt, off;
> +       size_t off;
>         struct NTFS_DE *ne;
>         struct NTFS_DE_SII *sii_e;
>         struct ntfs_fnd *fnd_sii = NULL;
> @@ -1946,7 +1946,6 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
>         sbi->security.next_off =
>                 Quad2Align(sds_size - SecurityDescriptorsBlockSize);
>
> -       cnt = 0;
>         off = 0;
>         ne = NULL;
>
> @@ -1964,8 +1963,6 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
>                 next_id = le32_to_cpu(sii_e->sec_id) + 1;
>                 if (next_id >= sbi->security.next_id)
>                         sbi->security.next_id = next_id;
> -
> -               cnt += 1;
>         }
>
>         sbi->security.ni = ni;
>
> base-commit: 96b18047a7172037ff4206720f4e889670030b41
> --
> 2.33.0.rc2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210816193041.1164125-1-nathan%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
