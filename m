Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943AC3A7562
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFODuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhFODuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:50:40 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEDAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:48:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f84so18567994ybg.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yin680PxT32vvsFD3cgHVsiUYZwQgvezq1Xoe5O317c=;
        b=Gtt8sv2KPRSl3UIUPDmkHcCj5XNL9oJgV5f0w/jrE0nVN+X7LEPbj9GYDUSZUOLt59
         3+4MSm+kzX1CI1uGiVaMTwsYAjxaniKbGnZQBvQQOMCgjMcIrw7G40ZbTN8dxIyH2vTy
         dKjtCe62Q/S9r2ydzl4PIPvj4jNGchg1hh5t2ix/VFXfOdANxJNieil5BlOsOVxZpVrs
         AEthIhdk68OmQIK4voYsCn/fr+djO8sbdGu27V3Zh1eTSj0m0VNFDMbdYmK7lMVsSx9G
         mlSdeWF4kfTvsg+SO1jRk9voBPSf8IFk2Otha7XhpL6LcpMnVUXbiFCqO22Ss8eqkv4l
         Fl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yin680PxT32vvsFD3cgHVsiUYZwQgvezq1Xoe5O317c=;
        b=UzcJLwGPtoHtakkSQtmhEQoIqse1Nd/aQ5gtc0F/mCcolfdQB2UDvJ/tQNA0/FeTwP
         kXReEDH5pIr66lNkM90GoS6iBZP6WslmWPqpv96udxRWjVxLYKvQNYHvW4+MTtnMx65v
         GO+ObR8m0hRSq8EeMgJ5dwPI+ZIlsoIZEekCDDGMrYOXiZziWCQ/5OoVaDX4MIJ7izp6
         2VYDMrFdDCJfpow9mfxFDKK2lrTgR/WWd4SIL9ncFaUHM7os+xziJedTlWIiEO+aKSXh
         bU2PzR/pGOpfmhpCmJ9TV2XXfXg61/HzD4PwAVxKeuqYYvX/aquF8nMv/Pu3gTTz3cIH
         OVrw==
X-Gm-Message-State: AOAM532a2f3mWNhKvsm+FG+fDyjs2+Xo0KOdj2eDFsR3q40/r5u2Fl2j
        fsP7sUR5sFmmfdf0Q1F+E8hR8DNTsQTOLVWxU0U=
X-Google-Smtp-Source: ABdhPJw9ZI06p4bfDSpDF6e0BS6jWeKMJll3l4TO6xyULMQ8kEUfjDXChwtGw/ohDBpgxouXzBoBnVm+ngQlBvjB6Ek=
X-Received: by 2002:a25:607:: with SMTP id 7mr3224929ybg.343.1623728915277;
 Mon, 14 Jun 2021 20:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621516826.git.christophe.leroy@csgroup.eu> <d54c63dcac6d190e1cc0d2fe3259d6e621928cdf.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d54c63dcac6d190e1cc0d2fe3259d6e621928cdf.1621516826.git.christophe.leroy@csgroup.eu>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Tue, 15 Jun 2021 13:48:23 +1000
Message-ID: <CACzsE9qX3TT07QXBECdB4EJq70KGB0UPn3kfk3WfS-jTQgaAvQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] powerpc/inst: Refactor PPC32 and PPC64 versions
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:50 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> ppc_inst() ppc_inst_prefixed() ppc_inst_swab() can easily
> be made common to both PPC32 and PPC64.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/inst.h | 49 +++++++++------------------------
>  1 file changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
> index 32d318c3b180..e009e94e90b2 100644
> --- a/arch/powerpc/include/asm/inst.h
> +++ b/arch/powerpc/include/asm/inst.h
> @@ -60,9 +60,9 @@ static inline int ppc_inst_primary_opcode(struct ppc_inst x)
>         return ppc_inst_val(x) >> 26;
>  }
>
> -#ifdef CONFIG_PPC64
>  #define ppc_inst(x) ((struct ppc_inst){ .val = (x) })
>
> +#ifdef CONFIG_PPC64
>  #define ppc_inst_prefix(x, y) ((struct ppc_inst){ .val = (x), .suffix = (y) })
>
>  static inline u32 ppc_inst_suffix(struct ppc_inst x)
> @@ -70,57 +70,34 @@ static inline u32 ppc_inst_suffix(struct ppc_inst x)
>         return x.suffix;
>  }
>
> -static inline bool ppc_inst_prefixed(struct ppc_inst x)
> -{
> -       return ppc_inst_primary_opcode(x) == OP_PREFIX;
> -}
> +#else
> +#define ppc_inst_prefix(x, y) ppc_inst(x)
>
> -static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
> +static inline u32 ppc_inst_suffix(struct ppc_inst x)
>  {
> -       return ppc_inst_prefix(swab32(ppc_inst_val(x)), swab32(ppc_inst_suffix(x)));
> +       return 0;
>  }
>
> +#endif /* CONFIG_PPC64 */
> +
>  static inline struct ppc_inst ppc_inst_read(const unsigned int *ptr)
>  {
> -       u32 val, suffix;
> -
> -       val = *ptr;
> -       if ((val >> 26) == OP_PREFIX) {
> -               suffix = *(ptr + 1);
> -               return ppc_inst_prefix(val, suffix);
> -       } else {
> -               return ppc_inst(val);
> -       }
> +       if (IS_ENABLED(CONFIG_PPC64) && (*ptr >> 26) == OP_PREFIX)
> +               return ppc_inst_prefix(*ptr, *(ptr + 1));
> +       else
> +               return ppc_inst(*ptr);
>  }
>
> -#else
> -
> -#define ppc_inst(x) ((struct ppc_inst){ .val = x })
> -
> -#define ppc_inst_prefix(x, y) ppc_inst(x)
> -
>  static inline bool ppc_inst_prefixed(struct ppc_inst x)
>  {
> -       return false;
> -}
> -
> -static inline u32 ppc_inst_suffix(struct ppc_inst x)
> -{
> -       return 0;
> +       return IS_ENABLED(CONFIG_PPC64) && ppc_inst_primary_opcode(x) == OP_PREFIX;
>  }
>
>  static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
>  {
> -       return ppc_inst(swab32(ppc_inst_val(x)));
> -}
> -
> -static inline struct ppc_inst ppc_inst_read(const unsigned int *ptr)
> -{
> -       return ppc_inst(*ptr);
> +       return ppc_inst_prefix(swab32(ppc_inst_val(x)), swab32(ppc_inst_suffix(x)));
>  }
>
> -#endif /* CONFIG_PPC64 */
> -
>  static inline bool ppc_inst_equal(struct ppc_inst x, struct ppc_inst y)
>  {
>         if (ppc_inst_val(x) != ppc_inst_val(y))
> --
> 2.25.0
>
Reviewed by: Jordan Niethe <jniethe5@gmail.com>
