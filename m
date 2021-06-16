Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32E13A8E34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFPBU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhFPBU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:20:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F22C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:18:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h12so863416pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=EIKXApFrEura5FRXpVV8f8e+7Zk3a0C0NOTcF/0+y38=;
        b=S9Eqp1OTVx7wOFdzu+drz73pOATwym8k07yNCe3JTGK+5r9YDftTW9eLntozF1aywI
         /tUIkVgoLUzXmWDSytLoRS87Di5Dd6vb+dXo5b63vJHT0UJ20gcDIV17Nhrig8qBtyL/
         hNNyeP3XczFotkj2Bi55+snKJY+zRDEA9aKOwOp2N6gobmxY1CAyueBF9EcTXkhqqM0a
         saeQ3DZO0Eb5Dq3C5XnTRkYdYg0z1V8kIxGhohe6K7JFnYc/mX+hXsfuLuCFdW1KVsMh
         TSKQ2LbyEzFUy+bwxudHvd8YPZp/yRz+WfYstELXunP+o4SlMpGdogetk/BmbHsBvU7M
         qdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=EIKXApFrEura5FRXpVV8f8e+7Zk3a0C0NOTcF/0+y38=;
        b=OfmCYFj76N7gjIzNZvx/6FFeR0FKiQXP/ikMNJlV+JUn+hClIkX2K8F3S8dfQRTc0F
         TYWuu2MjB6j/PclTXNa5kzAMou9AX81tUpfmT2q7b3+RP5grnjyW0rd7iSUQPRTk4E49
         TAkNptN5aaMs2ZEaTnlOxZz2+h4p2sgR7c19bHvojQRpfzUQT3iO85GzpmW7FRyiRsCq
         ZFmqSCcDRkeSQKAtXhaDT6I3jOfNV57G+vus+VL5lbgMbSuUJKwUWq64JMH5Tym9RuHb
         jMSP9jdOp7ZaakgcD5D8KWek1txS8csMyJGTBohFAEAbD8SDOJHshsQqByVzIQNgS2xb
         68Nw==
X-Gm-Message-State: AOAM5306O7dhTC+HZwX3jf10I5tn8q+zf1O8Zauhy9UdudtLmv0PEHkC
        qTmrHo7CMGyHJHi+teq8wEU=
X-Google-Smtp-Source: ABdhPJzPzY4tmFQv21hMXSBZ7dDmevVy8o24B5mTkxjvDGi4dChnQmPLE+DFdpZFTdvnOUslgbSwyA==
X-Received: by 2002:a62:1583:0:b029:2e9:dcb1:148e with SMTP id 125-20020a6215830000b02902e9dcb1148emr7119646pfv.0.1623806330636;
        Tue, 15 Jun 2021 18:18:50 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id v10sm319100pgb.46.2021.06.15.18.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 18:18:50 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:18:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?iso-8859-1?q?Such=E1nek?= <msuchanek@suse.de>
References: <20210611093959.821525-1-npiggin@gmail.com>
        <20210611093959.821525-2-npiggin@gmail.com>
        <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
        <1623722110.amu32mwaqs.astroid@bobo.none>
        <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
In-Reply-To: <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
MIME-Version: 1.0
Message-Id: <1623805495.qdikm5ks8v.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Jessica Yu's message of June 15, 2021 10:17 pm:
> +++ Nicholas Piggin [15/06/21 12:05 +1000]:
>>Excerpts from Jessica Yu's message of June 14, 2021 10:06 pm:
>>> +++ Nicholas Piggin [11/06/21 19:39 +1000]:
>>>>The elf_check_arch() function is used to test usermode binaries, but
>>>>kernel modules may have more specific requirements. powerpc would like
>>>>to test for ABI version compatibility.
>>>>
>>>>Add an arch-overridable function elf_check_module_arch() that defaults
>>>>to elf_check_arch() and use it in elf_validity_check().
>>>>
>>>>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>>[np: split patch, added changelog]
>>>>Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>---
>>>> include/linux/moduleloader.h | 5 +++++
>>>> kernel/module.c              | 2 +-
>>>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.=
h
>>>>index 9e09d11ffe5b..fdc042a84562 100644
>>>>--- a/include/linux/moduleloader.h
>>>>+++ b/include/linux/moduleloader.h
>>>>@@ -13,6 +13,11 @@
>>>>  * must be implemented by each architecture.
>>>>  */
>>>>
>>>>+// Allow arch to optionally do additional checking of module ELF heade=
r
>>>>+#ifndef elf_check_module_arch
>>>>+#define elf_check_module_arch elf_check_arch
>>>>+#endif
>>>
>>> Hi Nicholas,
>>>
>>> Why not make elf_check_module_arch() consistent with the other
>>> arch-specific functions? Please see module_frob_arch_sections(),
>>> module_{init,exit}_section(), etc in moduleloader.h. That is, they are
>>> all __weak functions that are overridable by arches. We can maybe make
>>> elf_check_module_arch() a weak symbol, available for arches to
>>> override if they want to perform additional elf checks. Then we don't
>>> have to have this one-off #define.
>>
>>
>>Like this? I like it. Good idea.
>=20
> Yeah! Also, maybe we can alternatively make elf_check_module_arch() a
> separate check entirely so that the powerpc implementation doesn't
> have to include that extra elf_check_arch() call. Something like this may=
be?

Yeah we can do that. Would you be okay if it goes via powerpc tree? If=20
yes, then we should get your Ack (or SOB because it seems to be entirely=20
your patch now :D)

Thanks,
Nick

>=20
> diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
> index 9e09d11ffe5b..2f9ebd593b4f 100644
> --- a/include/linux/moduleloader.h
> +++ b/include/linux/moduleloader.h
> @@ -39,6 +39,9 @@ bool module_init_section(const char *name);
>    */
>   bool module_exit_section(const char *name);
>=20
> +/* Arch may override to do additional checking of ELF header architectur=
e */
> +int elf_check_module_arch(Elf_Ehdr *hdr);
> +
>   /*
>    * Apply the given relocation to the (simplified) ELF.  Return -error
>    * or 0.
> diff --git a/kernel/module.c b/kernel/module.c
> index fdd6047728df..9963a979ed54 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2923,6 +2923,11 @@ static int validate_section_offset(struct load_inf=
o *info, Elf_Shdr *shdr)
>          return 0;
>   }
>=20
> +int __weak elf_check_module_arch(Elf_Ehdr *hdr)
> +{
> +       return 1;
> +}
> +
>   /*
>    * Sanity checks against invalid binaries, wrong arch, weird elf versio=
n.
>    *
> @@ -2941,6 +2946,7 @@ static int elf_validity_check(struct load_info *inf=
o)
>          if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) !=3D 0
>              || info->hdr->e_type !=3D ET_REL
>              || !elf_check_arch(info->hdr)
> +           || !elf_check_module_arch(info->hdr)
>              || info->hdr->e_shentsize !=3D sizeof(Elf_Shdr))
>                  return -ENOEXEC;
>  =20
>=20
>=20
