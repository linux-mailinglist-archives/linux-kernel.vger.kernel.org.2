Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF233A530
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhCNOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhCNOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 10:33:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 07:33:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ox4so46380310ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqQ7BWzs0leRC0mvm+I19KmZ7oC1YUe+0V+fLsVPHow=;
        b=CSqz1Z+qhr2AFvmFjC2pnfSPNn4YcayScF73cKhnFjoiESI4H+ihCQr9X4JAk2tHvh
         HwvYxw0zVuF2286U4yb7e/rNkfPyyh5jcp+cQXpRZ/Dqd4SWK6NFvptIiI7zTfKtuFSk
         91zBhOilifSO/aMEbkC5KrLlv35RcCH/KoSyNgKN2G+jmU+PzVoRbaYUnNwA/1J/AoIg
         nFmZUCe/wSecZ1ehh9TB5ZbCEzzOMlyNgjILB3/+sXGd2yxJRtu58oEBoSiKbp2oUHRh
         jdrKaT0mSuM1TxK/rh0KtrIrT4teSq3cE1RNoIKThzY/lenYGrZndZJnABo1CA5D1zy6
         bwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqQ7BWzs0leRC0mvm+I19KmZ7oC1YUe+0V+fLsVPHow=;
        b=Wcpccem09VKlhhZSNNujE9h9JX7Lm2egLQtyOn0sV6fqW7HnQgIM2zmqJWeKaVO2/z
         LYDBYR7Fd+v66E56xh50L9YgRoSE6jOW9vV+WO54Rjmbat0lLUCBFHYAi66EArsk0UvG
         a1krFr1P2eCTB9M9oiDbrt+bwuQGV77Llu34N9ALWpen7Ov/vGCDhTcWRdD8XbBFwaOj
         A7i2oxHeflC3k056NonG9ZbfNIZLOVdnhFIGA2EppREdNMPZLOKrck1M4vLL84NecYSC
         gdF4MGZtzSwnM/0O0WjArAcyykYhPWIPkxGH2bgheVojMqKMuulhczQ4h0T662LgqkPO
         IHfg==
X-Gm-Message-State: AOAM53243FYAN7/cJHDuvlbSXlfYwyI31siY+9lGk6UjPoBbRqqtuC9C
        SRu202Whw4ptlyM7V2lhaDd7TBNhuAnxhgD3ZRw=
X-Google-Smtp-Source: ABdhPJxgGpA4SfB0YnHTM5E9/RJ2E0gGVR8MoYLaLsEHXVfngatbugIpVyhG/nUF/Q3gN4JCE304QL+rkork6p0xCfs=
X-Received: by 2002:a17:906:7150:: with SMTP id z16mr18515701ejj.103.1615732419947;
 Sun, 14 Mar 2021 07:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210313122342.69995-1-masahiroy@kernel.org>
In-Reply-To: <20210313122342.69995-1-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 14 Mar 2021 07:33:28 -0700
Message-ID: <CAMo8Bf+4qs9O8XhCtbmNP22esuzXuxu3HRWtQbgOWX=hdTSrmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] xtensa: move CONFIG_CPU_*_ENDIAN defines to Kconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 4:24 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Move the definition of CONFIG_CPU_*_ENDIAN to Kconfig, the best place
> for CONFIG options.
>
> I slightly simplified the test code. You can use the -P option to suppress
> linemarker generation. The grep command is unneeded.
>
>   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -
>   # 1 "<stdin>"
>   # 1 "<built-in>"
>   # 1 "<command-line>"
>   # 1 "<stdin>"
>   1
>
>   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -P -
>   1
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>  - more cleanups
>
>  arch/xtensa/Kconfig                    | 6 ++++++
>  arch/xtensa/Makefile                   | 9 +--------
>  arch/xtensa/boot/Makefile              | 4 ----
>  arch/xtensa/boot/boot-elf/Makefile     | 6 +-----
>  arch/xtensa/boot/boot-redboot/Makefile | 6 +-----
>  5 files changed, 9 insertions(+), 22 deletions(-)

Thanks. I've made one change and applied both patches to my xtensa tree.

[...]

> diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> index cf0940708702..f43c731dec89 100644
> --- a/arch/xtensa/Makefile
> +++ b/arch/xtensa/Makefile
> @@ -52,14 +52,7 @@ ifneq ($(CONFIG_LD_NO_RELAX),)
>  KBUILD_LDFLAGS := --no-relax
>  endif
>
> -ifeq ($(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#"),1)
> -CHECKFLAGS += -D__XTENSA_EB__
> -KBUILD_CPPFLAGS += -DCONFIG_CPU_BIG_ENDIAN
> -endif
> -ifeq ($(shell echo __XTENSA_EL__ | $(CC) -E - | grep -v "\#"),1)
> -CHECKFLAGS += -D__XTENSA_EL__
> -KBUILD_CPPFLAGS += -DCONFIG_CPU_LITTLE_ENDIAN
> -endif
> +CHECKFLAGS += -D $(if $(CONFIG_CPU_BIG_ENDIAN),__XTENSA_EB__,__XTENSA_EL__)

I've removed the space between -D and the $(if ...) to make the result
look like the rest of -D options.

-- 
Thanks.
-- Max
