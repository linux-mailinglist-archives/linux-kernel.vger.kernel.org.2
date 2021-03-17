Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36A33E5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCQBPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCQBPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:15:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F8AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 18:15:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k8so134959wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iyPMIIiYX2gRQHxhAlfUcnBGnSQ72BwV5saP3SRzVo=;
        b=aZhLb0DoEdTj8V7nkGEBiKlR/q02Yp2S39a90ayzyQPjYVraH+31gBwWQ3nS6c6CWa
         DUmqi0XRv7oiI0xCMNAtBOZ8zKa6g2quvJEld8DX9v0grmgoGFfh7HJxP1/o3sdVGi/i
         LjZbYTGPVWkIVIU2gxyCEgY0DtENXt4Gy28hSwS/tIxD3X8KKNDpq9BB5Q4jTaUh6OMs
         wxDw+X1TT0RhGmIgTtYOdLjD3Ih2YM1mSjPd3sgGFHTa4cMNYOfz5caUZbKxXQv/7+w9
         JNlQt/mVT1cVRmpCVas5JiCYcToMaik8Avqjb3Mk9IjR0cLqzyEIVRdWXmP73L63xaUc
         NIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iyPMIIiYX2gRQHxhAlfUcnBGnSQ72BwV5saP3SRzVo=;
        b=LqRFMJ8vkJ/1jd9vT5vo/Yq6wAwnOh0H68nh/d3NRZFKGsjwaxOG4Uj7/gBKoiKa3W
         gzyoIE2xkajOau2UQ0SctAp2BJu7ajnZXtfTWfWrJKxDui1K1s7oVV+ocU4DPxCUTtaI
         IYOjUIu4H7s76OH1/BmKFWD0SBkRcLM9haHTYA0PeGjPxpB11QXqkhbVZs9UviLGvjs9
         Sj29MFkN/e+BD/2xqxyH+8Udalnury5HRn7yyXbsmm9LExq05VjUdro5nLuRUWzgFF7Z
         r8ANezaIBm0estrTCFgWs5SHYknsJ9+Prsp84GB9hNMYXWWx1VH2m2SIyPpSiTII05vo
         sd2g==
X-Gm-Message-State: AOAM531BWHC4oEGoL9SVq7MOsRH5tI3dWbAKAVnvu2pJ+/HlZbrTpPHn
        TNOvGHjM6WivIsLw4xwaxwAiy1cB8nprgAEzgxEy/KLcSI4=
X-Google-Smtp-Source: ABdhPJxSXWdqHvTBbBjVrQtg2Rq0hKOxj/uYlBptrKBJWdibE9vJLY9v6DDZtdBO1S8+ogE1yH3KuLY3MmvPUbuOlN4=
X-Received: by 2002:adf:a59a:: with SMTP id g26mr1625251wrc.271.1615943706586;
 Tue, 16 Mar 2021 18:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210304174237.31945-1-bp@alien8.de> <20210304174237.31945-5-bp@alien8.de>
In-Reply-To: <20210304174237.31945-5-bp@alien8.de>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 16 Mar 2021 18:14:54 -0700
Message-ID: <CAP-5=fU2D_kmdaLFL7Azm31Czdfdze6EpKg7=uZ+ohbNnb7ssQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/21] x86/insn: Add an insn_decode() API
To:     Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 9:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Users of the instruction decoder should use this to decode instruction
> bytes. For that, have insn*() helpers return an int value to denote
> success/failure. When there's an error fetching the next insn byte and
> the insn falls short, return -ENODATA to denote that.
>
> While at it, make insn_get_opcode() more stricter as to whether what has
> seen so far is a valid insn and if not.
>
> Copy linux/kconfig.h for the tools-version of the decoder so that it can
> use IS_ENABLED().
>
> Also, cast the INSN_MODE_KERN dummy define value to (enum insn_mode)
> for tools use of the decoder because perf tool builds with -Werror and
> errors out with -Werror=sign-compare otherwise.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/include/asm/insn.h       |  24 +++-
>  arch/x86/lib/insn.c               | 216 +++++++++++++++++++++++------
>  tools/arch/x86/include/asm/insn.h |  24 +++-
>  tools/arch/x86/lib/insn.c         | 222 +++++++++++++++++++++++-------
>  tools/include/linux/kconfig.h     |  73 ++++++++++
>  5 files changed, 452 insertions(+), 107 deletions(-)
>  create mode 100644 tools/include/linux/kconfig.h
>
> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> index 93f84600ac2c..de9fe760c1e7 100644
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -132,13 +132,23 @@ struct insn {
>  #define X86_VEX_M_MAX  0x1f                    /* VEX3.M Maximum value */
>
>  extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
> -extern void insn_get_prefixes(struct insn *insn);
> -extern void insn_get_opcode(struct insn *insn);
> -extern void insn_get_modrm(struct insn *insn);
> -extern void insn_get_sib(struct insn *insn);
> -extern void insn_get_displacement(struct insn *insn);
> -extern void insn_get_immediate(struct insn *insn);
> -extern void insn_get_length(struct insn *insn);
> +extern int insn_get_prefixes(struct insn *insn);
> +extern int insn_get_opcode(struct insn *insn);
> +extern int insn_get_modrm(struct insn *insn);
> +extern int insn_get_sib(struct insn *insn);
> +extern int insn_get_displacement(struct insn *insn);
> +extern int insn_get_immediate(struct insn *insn);
> +extern int insn_get_length(struct insn *insn);
> +
> +enum insn_mode {
> +       INSN_MODE_32,
> +       INSN_MODE_64,
> +       /* Mode is determined by the current kernel build. */
> +       INSN_MODE_KERN,
> +       INSN_NUM_MODES,
> +};
> +
> +extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
>
>  /* Attribute will be determined after getting ModRM (for opcode groups) */
>  static inline void insn_get_attribute(struct insn *insn)
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index ed1e0335aa14..bb58004497f8 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -14,6 +14,9 @@
>  #include <asm/inat.h> /*__ignore_sync_check__ */
>  #include <asm/insn.h> /* __ignore_sync_check__ */
>
> +#include <linux/errno.h>
> +#include <linux/kconfig.h>
> +
>  #include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
>
>  #define leXX_to_cpu(t, r)                                              \
> @@ -112,8 +115,12 @@ static void insn_get_emulate_prefix(struct insn *insn)
>   * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
>   * to point to the (first) opcode.  No effect if @insn->prefixes.got
>   * is already set.
> + *
> + * * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_prefixes(struct insn *insn)
> +int insn_get_prefixes(struct insn *insn)
>  {
>         struct insn_field *prefixes = &insn->prefixes;
>         insn_attr_t attr;
> @@ -121,7 +128,7 @@ void insn_get_prefixes(struct insn *insn)
>         int i, nb;
>
>         if (prefixes->got)
> -               return;
> +               return 0;
>
>         insn_get_emulate_prefix(insn);
>
> @@ -231,8 +238,10 @@ void insn_get_prefixes(struct insn *insn)
>
>         prefixes->got = 1;
>
> +       return 0;
> +
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /**
> @@ -244,16 +253,25 @@ void insn_get_prefixes(struct insn *insn)
>   * If necessary, first collects any preceding (prefix) bytes.
>   * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
>   * is already 1.
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_opcode(struct insn *insn)
> +int insn_get_opcode(struct insn *insn)
>  {
>         struct insn_field *opcode = &insn->opcode;
> +       int pfx_id, ret;
>         insn_byte_t op;
> -       int pfx_id;
> +
>         if (opcode->got)
> -               return;
> -       if (!insn->prefixes.got)
> -               insn_get_prefixes(insn);
> +               return 0;
> +
> +       if (!insn->prefixes.got) {
> +               ret = insn_get_prefixes(insn);
> +               if (ret)
> +                       return ret;
> +       }
>
>         /* Get first opcode */
>         op = get_next(insn_byte_t, insn);
> @@ -268,9 +286,13 @@ void insn_get_opcode(struct insn *insn)
>                 insn->attr = inat_get_avx_attribute(op, m, p);
>                 if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
>                     (!inat_accept_vex(insn->attr) &&
> -                    !inat_is_group(insn->attr)))
> -                       insn->attr = 0; /* This instruction is bad */
> -               goto end;       /* VEX has only 1 byte for opcode */
> +                    !inat_is_group(insn->attr))) {
> +                       /* This instruction is bad */
> +                       insn->attr = 0;
> +                       return -EINVAL;
> +               }
> +               /* VEX has only 1 byte for opcode */
> +               goto end;
>         }
>
>         insn->attr = inat_get_opcode_attribute(op);
> @@ -281,13 +303,18 @@ void insn_get_opcode(struct insn *insn)
>                 pfx_id = insn_last_prefix_id(insn);
>                 insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
>         }
> -       if (inat_must_vex(insn->attr))
> -               insn->attr = 0; /* This instruction is bad */
> +
> +       if (inat_must_vex(insn->attr)) {
> +               /* This instruction is bad */
> +               insn->attr = 0;
> +               return -EINVAL;
> +       }
>  end:
>         opcode->got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /**
> @@ -297,15 +324,25 @@ void insn_get_opcode(struct insn *insn)
>   * Populates @insn->modrm and updates @insn->next_byte to point past the
>   * ModRM byte, if any.  If necessary, first collects the preceding bytes
>   * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_modrm(struct insn *insn)
> +int insn_get_modrm(struct insn *insn)
>  {
>         struct insn_field *modrm = &insn->modrm;
>         insn_byte_t pfx_id, mod;
> +       int ret;
> +
>         if (modrm->got)
> -               return;
> -       if (!insn->opcode.got)
> -               insn_get_opcode(insn);
> +               return 0;
> +
> +       if (!insn->opcode.got) {
> +               ret = insn_get_opcode(insn);
> +               if (ret)
> +                       return ret;
> +       }
>
>         if (inat_has_modrm(insn->attr)) {
>                 mod = get_next(insn_byte_t, insn);
> @@ -314,17 +351,22 @@ void insn_get_modrm(struct insn *insn)
>                         pfx_id = insn_last_prefix_id(insn);
>                         insn->attr = inat_get_group_attribute(mod, pfx_id,
>                                                               insn->attr);
> -                       if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
> -                               insn->attr = 0; /* This is bad */
> +                       if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
> +                               /* Bad insn */
> +                               insn->attr = 0;
> +                               return -EINVAL;
> +                       }
>                 }
>         }
>
>         if (insn->x86_64 && inat_is_force64(insn->attr))
>                 insn->opnd_bytes = 8;
> +
>         modrm->got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>
> @@ -338,11 +380,16 @@ void insn_get_modrm(struct insn *insn)
>  int insn_rip_relative(struct insn *insn)
>  {
>         struct insn_field *modrm = &insn->modrm;
> +       int ret;
>
>         if (!insn->x86_64)
>                 return 0;
> -       if (!modrm->got)
> -               insn_get_modrm(insn);
> +
> +       if (!modrm->got) {
> +               ret = insn_get_modrm(insn);
> +               if (ret)
> +                       return 0;
> +       }
>         /*
>          * For rip-relative instructions, the mod field (top 2 bits)
>          * is zero and the r/m field (bottom 3 bits) is 0x5.
> @@ -356,15 +403,25 @@ int insn_rip_relative(struct insn *insn)
>   *
>   * If necessary, first collects the instruction up to and including the
>   * ModRM byte.
> + *
> + * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
>   */
> -void insn_get_sib(struct insn *insn)
> +int insn_get_sib(struct insn *insn)
>  {
>         insn_byte_t modrm;
> +       int ret;
>
>         if (insn->sib.got)
> -               return;
> -       if (!insn->modrm.got)
> -               insn_get_modrm(insn);
> +               return 0;
> +
> +       if (!insn->modrm.got) {
> +               ret = insn_get_modrm(insn);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (insn->modrm.nbytes) {
>                 modrm = insn->modrm.bytes[0];
>                 if (insn->addr_bytes != 2 &&
> @@ -375,8 +432,10 @@ void insn_get_sib(struct insn *insn)
>         }
>         insn->sib.got = 1;
>
> +       return 0;
> +
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>
> @@ -387,15 +446,25 @@ void insn_get_sib(struct insn *insn)
>   * If necessary, first collects the instruction up to and including the
>   * SIB byte.
>   * Displacement value is sign-expanded.
> + *
> + * * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
>   */
> -void insn_get_displacement(struct insn *insn)
> +int insn_get_displacement(struct insn *insn)
>  {
>         insn_byte_t mod, rm, base;
> +       int ret;
>
>         if (insn->displacement.got)
> -               return;
> -       if (!insn->sib.got)
> -               insn_get_sib(insn);
> +               return 0;
> +
> +       if (!insn->sib.got) {
> +               ret = insn_get_sib(insn);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (insn->modrm.nbytes) {
>                 /*
>                  * Interpreting the modrm byte:
> @@ -437,9 +506,10 @@ void insn_get_displacement(struct insn *insn)
>         }
>  out:
>         insn->displacement.got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /* Decode moffset16/32/64. Return 0 if failed */
> @@ -538,20 +608,30 @@ static int __get_immptr(struct insn *insn)
>  }
>
>  /**
> - * insn_get_immediate() - Get the immediates of instruction
> + * insn_get_immediate() - Get the immediate in an instruction
>   * @insn:      &struct insn containing instruction
>   *
>   * If necessary, first collects the instruction up to and including the
>   * displacement bytes.
>   * Basically, most of immediates are sign-expanded. Unsigned-value can be
> - * get by bit masking with ((1 << (nbytes * 8)) - 1)
> + * computed by bit masking with ((1 << (nbytes * 8)) - 1)
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_immediate(struct insn *insn)
> +int insn_get_immediate(struct insn *insn)
>  {
> +       int ret;
> +
>         if (insn->immediate.got)
> -               return;
> -       if (!insn->displacement.got)
> -               insn_get_displacement(insn);
> +               return 0;
> +
> +       if (!insn->displacement.got) {
> +               ret = insn_get_displacement(insn);
> +               if (ret)
> +                       return ret;
> +       }
>
>         if (inat_has_moffset(insn->attr)) {
>                 if (!__get_moffset(insn))
> @@ -598,9 +678,10 @@ void insn_get_immediate(struct insn *insn)
>         }
>  done:
>         insn->immediate.got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /**
> @@ -609,13 +690,58 @@ void insn_get_immediate(struct insn *insn)
>   *
>   * If necessary, first collects the instruction up to and including the
>   * immediates bytes.
> - */
> -void insn_get_length(struct insn *insn)
> + *
> + * Returns:
> + *  - 0 on success
> + *  - < 0 on error
> +*/
> +int insn_get_length(struct insn *insn)
>  {
> +       int ret;
> +
>         if (insn->length)
> -               return;
> -       if (!insn->immediate.got)
> -               insn_get_immediate(insn);
> +               return 0;
> +
> +       if (!insn->immediate.got) {
> +               ret = insn_get_immediate(insn);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         insn->length = (unsigned char)((unsigned long)insn->next_byte
>                                      - (unsigned long)insn->kaddr);
> +
> +       return 0;
> +}
> +
> +/**
> + * insn_decode() - Decode an x86 instruction
> + * @insn:      &struct insn to be initialized
> + * @kaddr:     address (in kernel memory) of instruction (or copy thereof)
> + * @buf_len:   length of the insn buffer at @kaddr
> + * @m:         insn mode, see enum insn_mode
> + *
> + * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
> + */
> +int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m)
> +{
> +       int ret;
> +
> +/* #define INSN_MODE_KERN      -1 __ignore_sync_check__ mode is only valid in the kernel */
> +
> +       if (m == INSN_MODE_KERN)
> +               insn_init(insn, kaddr, buf_len, IS_ENABLED(CONFIG_X86_64));
> +       else
> +               insn_init(insn, kaddr, buf_len, m == INSN_MODE_64);
> +
> +       ret = insn_get_length(insn);
> +       if (ret)
> +               return ret;
> +
> +       if (insn_complete(insn))
> +               return 0;
> +
> +       return -EINVAL;
>  }
> diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
> index 7e1239aa7dd9..2fe19b1a8765 100644
> --- a/tools/arch/x86/include/asm/insn.h
> +++ b/tools/arch/x86/include/asm/insn.h
> @@ -132,13 +132,23 @@ struct insn {
>  #define X86_VEX_M_MAX  0x1f                    /* VEX3.M Maximum value */
>
>  extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
> -extern void insn_get_prefixes(struct insn *insn);
> -extern void insn_get_opcode(struct insn *insn);
> -extern void insn_get_modrm(struct insn *insn);
> -extern void insn_get_sib(struct insn *insn);
> -extern void insn_get_displacement(struct insn *insn);
> -extern void insn_get_immediate(struct insn *insn);
> -extern void insn_get_length(struct insn *insn);
> +extern int insn_get_prefixes(struct insn *insn);
> +extern int insn_get_opcode(struct insn *insn);
> +extern int insn_get_modrm(struct insn *insn);
> +extern int insn_get_sib(struct insn *insn);
> +extern int insn_get_displacement(struct insn *insn);
> +extern int insn_get_immediate(struct insn *insn);
> +extern int insn_get_length(struct insn *insn);
> +
> +enum insn_mode {
> +       INSN_MODE_32,
> +       INSN_MODE_64,
> +       /* Mode is determined by the current kernel build. */
> +       INSN_MODE_KERN,
> +       INSN_NUM_MODES,
> +};
> +
> +extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
>
>  /* Attribute will be determined after getting ModRM (for opcode groups) */
>  static inline void insn_get_attribute(struct insn *insn)
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index 1174c43b3944..be2b057f91d4 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -11,10 +11,13 @@
>  #else
>  #include <string.h>
>  #endif
> -#include "../include/asm/inat.h" /* __ignore_sync_check__ */
> -#include "../include/asm/insn.h" /* __ignore_sync_check__ */
> +#include <asm/inat.h> /*__ignore_sync_check__ */
> +#include <asm/insn.h> /* __ignore_sync_check__ */

Hi, this change is breaking non-x86 builds of perf for me in
tip.git/master. The reason being that non-x86 builds compile the
intel-pt-decoder, which includes this file, but don't have their
include paths set to find tools/arch/x86. I think we want to keep the
relative paths.

Thanks,
Ian

> -#include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
> +#include <linux/errno.h>
> +#include <linux/kconfig.h>
> +
> +#include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
>
>  #define leXX_to_cpu(t, r)                                              \
>  ({                                                                     \
> @@ -112,8 +115,12 @@ static void insn_get_emulate_prefix(struct insn *insn)
>   * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
>   * to point to the (first) opcode.  No effect if @insn->prefixes.got
>   * is already set.
> + *
> + * * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_prefixes(struct insn *insn)
> +int insn_get_prefixes(struct insn *insn)
>  {
>         struct insn_field *prefixes = &insn->prefixes;
>         insn_attr_t attr;
> @@ -121,7 +128,7 @@ void insn_get_prefixes(struct insn *insn)
>         int i, nb;
>
>         if (prefixes->got)
> -               return;
> +               return 0;
>
>         insn_get_emulate_prefix(insn);
>
> @@ -231,8 +238,10 @@ void insn_get_prefixes(struct insn *insn)
>
>         prefixes->got = 1;
>
> +       return 0;
> +
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /**
> @@ -244,16 +253,25 @@ void insn_get_prefixes(struct insn *insn)
>   * If necessary, first collects any preceding (prefix) bytes.
>   * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
>   * is already 1.
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_opcode(struct insn *insn)
> +int insn_get_opcode(struct insn *insn)
>  {
>         struct insn_field *opcode = &insn->opcode;
> +       int pfx_id, ret;
>         insn_byte_t op;
> -       int pfx_id;
> +
>         if (opcode->got)
> -               return;
> -       if (!insn->prefixes.got)
> -               insn_get_prefixes(insn);
> +               return 0;
> +
> +       if (!insn->prefixes.got) {
> +               ret = insn_get_prefixes(insn);
> +               if (ret)
> +                       return ret;
> +       }
>
>         /* Get first opcode */
>         op = get_next(insn_byte_t, insn);
> @@ -268,9 +286,13 @@ void insn_get_opcode(struct insn *insn)
>                 insn->attr = inat_get_avx_attribute(op, m, p);
>                 if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
>                     (!inat_accept_vex(insn->attr) &&
> -                    !inat_is_group(insn->attr)))
> -                       insn->attr = 0; /* This instruction is bad */
> -               goto end;       /* VEX has only 1 byte for opcode */
> +                    !inat_is_group(insn->attr))) {
> +                       /* This instruction is bad */
> +                       insn->attr = 0;
> +                       return -EINVAL;
> +               }
> +               /* VEX has only 1 byte for opcode */
> +               goto end;
>         }
>
>         insn->attr = inat_get_opcode_attribute(op);
> @@ -281,13 +303,18 @@ void insn_get_opcode(struct insn *insn)
>                 pfx_id = insn_last_prefix_id(insn);
>                 insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
>         }
> -       if (inat_must_vex(insn->attr))
> -               insn->attr = 0; /* This instruction is bad */
> +
> +       if (inat_must_vex(insn->attr)) {
> +               /* This instruction is bad */
> +               insn->attr = 0;
> +               return -EINVAL;
> +       }
>  end:
>         opcode->got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /**
> @@ -297,15 +324,25 @@ void insn_get_opcode(struct insn *insn)
>   * Populates @insn->modrm and updates @insn->next_byte to point past the
>   * ModRM byte, if any.  If necessary, first collects the preceding bytes
>   * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_modrm(struct insn *insn)
> +int insn_get_modrm(struct insn *insn)
>  {
>         struct insn_field *modrm = &insn->modrm;
>         insn_byte_t pfx_id, mod;
> +       int ret;
> +
>         if (modrm->got)
> -               return;
> -       if (!insn->opcode.got)
> -               insn_get_opcode(insn);
> +               return 0;
> +
> +       if (!insn->opcode.got) {
> +               ret = insn_get_opcode(insn);
> +               if (ret)
> +                       return ret;
> +       }
>
>         if (inat_has_modrm(insn->attr)) {
>                 mod = get_next(insn_byte_t, insn);
> @@ -314,17 +351,22 @@ void insn_get_modrm(struct insn *insn)
>                         pfx_id = insn_last_prefix_id(insn);
>                         insn->attr = inat_get_group_attribute(mod, pfx_id,
>                                                               insn->attr);
> -                       if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
> -                               insn->attr = 0; /* This is bad */
> +                       if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
> +                               /* Bad insn */
> +                               insn->attr = 0;
> +                               return -EINVAL;
> +                       }
>                 }
>         }
>
>         if (insn->x86_64 && inat_is_force64(insn->attr))
>                 insn->opnd_bytes = 8;
> +
>         modrm->got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>
> @@ -338,11 +380,16 @@ void insn_get_modrm(struct insn *insn)
>  int insn_rip_relative(struct insn *insn)
>  {
>         struct insn_field *modrm = &insn->modrm;
> +       int ret;
>
>         if (!insn->x86_64)
>                 return 0;
> -       if (!modrm->got)
> -               insn_get_modrm(insn);
> +
> +       if (!modrm->got) {
> +               ret = insn_get_modrm(insn);
> +               if (ret)
> +                       return 0;
> +       }
>         /*
>          * For rip-relative instructions, the mod field (top 2 bits)
>          * is zero and the r/m field (bottom 3 bits) is 0x5.
> @@ -356,15 +403,25 @@ int insn_rip_relative(struct insn *insn)
>   *
>   * If necessary, first collects the instruction up to and including the
>   * ModRM byte.
> + *
> + * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
>   */
> -void insn_get_sib(struct insn *insn)
> +int insn_get_sib(struct insn *insn)
>  {
>         insn_byte_t modrm;
> +       int ret;
>
>         if (insn->sib.got)
> -               return;
> -       if (!insn->modrm.got)
> -               insn_get_modrm(insn);
> +               return 0;
> +
> +       if (!insn->modrm.got) {
> +               ret = insn_get_modrm(insn);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (insn->modrm.nbytes) {
>                 modrm = insn->modrm.bytes[0];
>                 if (insn->addr_bytes != 2 &&
> @@ -375,8 +432,10 @@ void insn_get_sib(struct insn *insn)
>         }
>         insn->sib.got = 1;
>
> +       return 0;
> +
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>
> @@ -387,15 +446,25 @@ void insn_get_sib(struct insn *insn)
>   * If necessary, first collects the instruction up to and including the
>   * SIB byte.
>   * Displacement value is sign-expanded.
> + *
> + * * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
>   */
> -void insn_get_displacement(struct insn *insn)
> +int insn_get_displacement(struct insn *insn)
>  {
>         insn_byte_t mod, rm, base;
> +       int ret;
>
>         if (insn->displacement.got)
> -               return;
> -       if (!insn->sib.got)
> -               insn_get_sib(insn);
> +               return 0;
> +
> +       if (!insn->sib.got) {
> +               ret = insn_get_sib(insn);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (insn->modrm.nbytes) {
>                 /*
>                  * Interpreting the modrm byte:
> @@ -437,9 +506,10 @@ void insn_get_displacement(struct insn *insn)
>         }
>  out:
>         insn->displacement.got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /* Decode moffset16/32/64. Return 0 if failed */
> @@ -538,20 +608,30 @@ static int __get_immptr(struct insn *insn)
>  }
>
>  /**
> - * insn_get_immediate() - Get the immediates of instruction
> + * insn_get_immediate() - Get the immediate in an instruction
>   * @insn:      &struct insn containing instruction
>   *
>   * If necessary, first collects the instruction up to and including the
>   * displacement bytes.
>   * Basically, most of immediates are sign-expanded. Unsigned-value can be
> - * get by bit masking with ((1 << (nbytes * 8)) - 1)
> + * computed by bit masking with ((1 << (nbytes * 8)) - 1)
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error
>   */
> -void insn_get_immediate(struct insn *insn)
> +int insn_get_immediate(struct insn *insn)
>  {
> +       int ret;
> +
>         if (insn->immediate.got)
> -               return;
> -       if (!insn->displacement.got)
> -               insn_get_displacement(insn);
> +               return 0;
> +
> +       if (!insn->displacement.got) {
> +               ret = insn_get_displacement(insn);
> +               if (ret)
> +                       return ret;
> +       }
>
>         if (inat_has_moffset(insn->attr)) {
>                 if (!__get_moffset(insn))
> @@ -598,9 +678,10 @@ void insn_get_immediate(struct insn *insn)
>         }
>  done:
>         insn->immediate.got = 1;
> +       return 0;
>
>  err_out:
> -       return;
> +       return -ENODATA;
>  }
>
>  /**
> @@ -609,13 +690,58 @@ void insn_get_immediate(struct insn *insn)
>   *
>   * If necessary, first collects the instruction up to and including the
>   * immediates bytes.
> - */
> -void insn_get_length(struct insn *insn)
> + *
> + * Returns:
> + *  - 0 on success
> + *  - < 0 on error
> +*/
> +int insn_get_length(struct insn *insn)
>  {
> +       int ret;
> +
>         if (insn->length)
> -               return;
> -       if (!insn->immediate.got)
> -               insn_get_immediate(insn);
> +               return 0;
> +
> +       if (!insn->immediate.got) {
> +               ret = insn_get_immediate(insn);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         insn->length = (unsigned char)((unsigned long)insn->next_byte
>                                      - (unsigned long)insn->kaddr);
> +
> +       return 0;
> +}
> +
> +/**
> + * insn_decode() - Decode an x86 instruction
> + * @insn:      &struct insn to be initialized
> + * @kaddr:     address (in kernel memory) of instruction (or copy thereof)
> + * @buf_len:   length of the insn buffer at @kaddr
> + * @m:         insn mode, see enum insn_mode
> + *
> + * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
> + */
> +int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m)
> +{
> +       int ret;
> +
> +#define INSN_MODE_KERN (enum insn_mode)-1 /* __ignore_sync_check__ mode is only valid in the kernel */
> +
> +       if (m == INSN_MODE_KERN)
> +               insn_init(insn, kaddr, buf_len, IS_ENABLED(CONFIG_X86_64));
> +       else
> +               insn_init(insn, kaddr, buf_len, m == INSN_MODE_64);
> +
> +       ret = insn_get_length(insn);
> +       if (ret)
> +               return ret;
> +
> +       if (insn_complete(insn))
> +               return 0;
> +
> +       return -EINVAL;
>  }
> diff --git a/tools/include/linux/kconfig.h b/tools/include/linux/kconfig.h
> new file mode 100644
> index 000000000000..1555a0c4f345
> --- /dev/null
> +++ b/tools/include/linux/kconfig.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOOLS_LINUX_KCONFIG_H
> +#define _TOOLS_LINUX_KCONFIG_H
> +
> +/* CONFIG_CC_VERSION_TEXT (Do not delete this comment. See help in Kconfig) */
> +
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define __BIG_ENDIAN 4321
> +#else
> +#define __LITTLE_ENDIAN 1234
> +#endif
> +
> +#define __ARG_PLACEHOLDER_1 0,
> +#define __take_second_arg(__ignored, val, ...) val
> +
> +/*
> + * The use of "&&" / "||" is limited in certain expressions.
> + * The following enable to calculate "and" / "or" with macro expansion only.
> + */
> +#define __and(x, y)                    ___and(x, y)
> +#define ___and(x, y)                   ____and(__ARG_PLACEHOLDER_##x, y)
> +#define ____and(arg1_or_junk, y)       __take_second_arg(arg1_or_junk y, 0)
> +
> +#define __or(x, y)                     ___or(x, y)
> +#define ___or(x, y)                    ____or(__ARG_PLACEHOLDER_##x, y)
> +#define ____or(arg1_or_junk, y)                __take_second_arg(arg1_or_junk 1, y)
> +
> +/*
> + * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
> + * these only work with boolean and tristate options.
> + */
> +
> +/*
> + * Getting something that works in C and CPP for an arg that may or may
> + * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
> + * we match on the placeholder define, insert the "0," for arg1 and generate
> + * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
> + * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
> + * the last step cherry picks the 2nd arg, we get a zero.
> + */
> +#define __is_defined(x)                        ___is_defined(x)
> +#define ___is_defined(val)             ____is_defined(__ARG_PLACEHOLDER_##val)
> +#define ____is_defined(arg1_or_junk)   __take_second_arg(arg1_or_junk 1, 0)
> +
> +/*
> + * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
> + * otherwise. For boolean options, this is equivalent to
> + * IS_ENABLED(CONFIG_FOO).
> + */
> +#define IS_BUILTIN(option) __is_defined(option)
> +
> +/*
> + * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
> + * otherwise.
> + */
> +#define IS_MODULE(option) __is_defined(option##_MODULE)
> +
> +/*
> + * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
> + * code can call a function defined in code compiled based on CONFIG_FOO.
> + * This is similar to IS_ENABLED(), but returns false when invoked from
> + * built-in code when CONFIG_FOO is set to 'm'.
> + */
> +#define IS_REACHABLE(option) __or(IS_BUILTIN(option), \
> +                               __and(IS_MODULE(option), __is_defined(MODULE)))
> +
> +/*
> + * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
> + * 0 otherwise.
> + */
> +#define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
> +
> +#endif /* _TOOLS_LINUX_KCONFIG_H */
> --
> 2.29.2
>
